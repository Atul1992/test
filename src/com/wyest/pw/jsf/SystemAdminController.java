package com.wyest.pw.jsf;

import com.wyest.pw.info.ContactInfo;
import com.wyest.pw.model.*;
import com.wyest.pw.rest.EnrollmentService;
import com.wyest.pw.rest.RepService;
import com.wyest.pw.rest.TdspService;
import com.wyest.pw.utils.FacesUtil;
import com.wyest.pw.utils.MessageUtil;
import org.primefaces.event.FileUploadEvent;
import org.primefaces.model.UploadedFile;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.inject.Inject;
import java.util.ArrayList;
import java.util.List;

import static com.wyest.pw.utils.PWUtils.isEmpty;
import static com.wyest.pw.utils.PWUtils.notEmpty;

/**
 * User: Amit
 * Date: 6/22/13
 * Time: 4:52 PM
 */
@ManagedBean
@ViewScoped
public class SystemAdminController {
    private static Logger log = LoggerFactory.getLogger(SystemAdminController.class);
    private Contact adminContact;

    @Inject
    private EnrollmentService enrollmentResource;

    @Inject
    private RepService repResource;

    @Inject
    private TdspService edcTdspResource;

    private List<EnrollmentStatus> statusList = new ArrayList<>();

    private Enrollment searchRequest;
    private CustomerLoadProfile customerLoadProfile = new CustomerLoadProfile();
    private CustomizedQuote custQuote = new CustomizedQuote();
    private List<Enrollment> searchResults = new ArrayList<>();

    private List<UploadedFile> uploadedFileList = new ArrayList<>();
    private List<EdcTdsp> edcTdspList = new ArrayList<>();
    private List<Rep> repList = new ArrayList<>();
    private List<RepProducts> repProductsList = new ArrayList<>();

    private Integer selectedTabIndex = 0;
    private Enrollment selectedEnrollment;

    public SystemAdminController() {
        log.info("new instance created.");
    }

    @PostConstruct
    public void init() {
        log.info("init called.");
        ApplicationController applicationController = (ApplicationController) FacesUtil.getFromSession("applicationController");
        if (notEmpty(applicationController)) {
            ContactInfo contact = applicationController.getContact();
            if (contact != null) {
                log.info("Found System admin contact [" + contact.getContactId() + "] in session");
                adminContact = enrollmentResource.getContactById(contact.getContactId());
                if (notEmpty(adminContact)) {
                    // init Enrollment
                    resetAction();
                    populateStatusList();
                    initCustomizedQuote();
                }
            }
        }
    }

    private void initCustomizedQuote() {
        custQuote = new CustomizedQuote();
        RepProducts product = new RepProducts();
        product.setRep(new Rep());
        product.setEdcTdsp(new EdcTdsp());
        custQuote.setProduct(product);
    }

    private void populateStatusList() {
        try {
            statusList = enrollmentResource.getEnrollmentStatusList();
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public void searchEnrollments() {
        try {
            searchResults = enrollmentResource.searchEnrollments(searchRequest);
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public void resetAction() {
        searchResults.clear();
        searchRequest = new Enrollment();
        searchRequest.setStatus(new EnrollmentStatus());
        searchRequest.setResidentialAccount(new ResidentialAccount());
        searchRequest.setBusinessAccount(new BusinessAccount());
    }

    public void openUploadDialog(Enrollment enrollment) {
        customerLoadProfile = new CustomerLoadProfile();
        customerLoadProfile.setEnrollment(enrollment);
        uploadedFileList.clear();
    }

    public void handleFileUpload(FileUploadEvent event) {
        uploadedFileList.add(event.getFile());
    }

    public void uploadFile() {
        try {
            boolean pass = true;
            if (isEmpty(customerLoadProfile.getFileReceivedDate())) {
                MessageUtil.addErrorMessageWithoutKey("File Received Date: is required");
                pass = false;
            }
            if (isEmpty(customerLoadProfile.getFileType())) {
                MessageUtil.addErrorMessageWithoutKey("File Type: is required");
                pass = false;
            }
            if (pass) {
                for (UploadedFile uploadFile : uploadedFileList) {
                    byte[] data = uploadFile.getContents();
                    if (notEmpty(customerLoadProfile)) {
                        customerLoadProfile.setFileName(uploadFile.getFileName());
                        customerLoadProfile.setFileData(data);
                        customerLoadProfile.setContentType(uploadFile.getContentType());
                        customerLoadProfile.setFileSize(uploadFile.getSize());
                    }
                    customerLoadProfile = enrollmentResource.saveCustomerLoadProfile(customerLoadProfile);
                    if (notEmpty(customerLoadProfile) && notEmpty(customerLoadProfile.getLoadProfileId())) {
                        MessageUtil.addInfoMessageWithoutKey("File [" + uploadFile.getFileName() + "] uploaded successfully..");
                    }
                }

                searchEnrollments();
            }
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public void openCustomizedResponseDialog(Enrollment enrollment) {
        try {
            selectedTabIndex = 0;
            initCustomizedQuote();
            custQuote.setEnrollment(enrollment);
            String zipCode = "";
            if (enrollment.isResidential()) {
                zipCode = enrollment.getResidentialAccount().getBillingContact().getZipCode();
            } else if (enrollment.isCommercial()) {
                zipCode = enrollment.getBusinessAccount().getBillingContact().getZipCode();
            }
            if (notEmpty(zipCode) && zipCode.length() > 5) {
                zipCode = zipCode.substring(0, 5);
            }
            edcTdspList = edcTdspResource.findEdcTdspsForZipCode(zipCode);
            repList = repResource.getListOfReps();
            repProductsList.clear();
            for (EdcTdsp edcTdsp : edcTdspList) {
                List<RepProducts> edcProductsList = repResource.getListOfRepProductsForEdc(edcTdsp.getEdcId());
                for (RepProducts repProducts : edcProductsList) {
                    if (repProducts.getCommercialCustomized().equalsIgnoreCase("Y")) {
                        repProductsList.add(repProducts);
                    }
                }
            }
            for (RepProducts repProducts : repProductsList) {
                for (CustomizedQuote customizedQuote : enrollment.getCustomizedQuoteList()) {
                    if (repProducts.getProductId().equals(customizedQuote.getProduct().getProductId())) {
                        repProducts.setDisabled(true);
                    }
                }
            }
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public void saveProductAndAddToCustomerProfile() {
        try {
            if (notEmpty(custQuote) && notEmpty(custQuote.getProduct())) {
                custQuote.getProduct().setResidentialMatrix("N");
                custQuote.getProduct().setCommercialMatrix("N");
                custQuote.getProduct().setCommercialCustomized("Y");

                RepProducts newProduct = repResource.saveProduct(custQuote.getProduct());
                if (notEmpty(newProduct)) {
                    custQuote.setProduct(newProduct);
                    custQuote = enrollmentResource.saveCustomizedQuote(custQuote);
                    if (notEmpty(custQuote) && notEmpty(custQuote.getQuoteId())) {
                        MessageUtil.addInfoMessageWithoutKey("Customized Quote [" + custQuote.getQuoteId() + "] created successfully..");
                        searchEnrollments();
                    }
                }
            }
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public void saveExistingProductAndAddToCustomerProfile() {
        try {
            if (notEmpty(repProductsList)) {
                for (RepProducts repProducts : repProductsList) {
                    if (repProducts.isSelected()) {
                        CustomizedQuote customizedQuote = new CustomizedQuote();
                        customizedQuote.setProduct(repProducts);
                        customizedQuote.setEnrollment(custQuote.getEnrollment());
                        customizedQuote.setQuoteRequestedDate(custQuote.getQuoteRequestedDate());
                        customizedQuote.setQuoteResponseDate(custQuote.getQuoteResponseDate());

                        customizedQuote = enrollmentResource.saveCustomizedQuote(customizedQuote);
                        if (notEmpty(customizedQuote) && notEmpty(customizedQuote.getQuoteId())) {
                            MessageUtil.addInfoMessageWithoutKey("Customized Quote [" + customizedQuote.getQuoteId() + "] created successfully..");
                        }
                    }
                }
                searchEnrollments();
            }
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public void openViewFileDialog(Enrollment enrollment) {
        selectedEnrollment = enrollment;
    }

    public Contact getAdminContact() {
        return adminContact;
    }

    public void setAdminContact(Contact adminContact) {
        this.adminContact = adminContact;
    }

    public Enrollment getSearchRequest() {
        return searchRequest;
    }

    public void setSearchRequest(Enrollment searchRequest) {
        this.searchRequest = searchRequest;
    }

    public CustomerLoadProfile getCustomerLoadProfile() {
        return customerLoadProfile;
    }

    public void setCustomerLoadProfile(CustomerLoadProfile customerLoadProfile) {
        this.customerLoadProfile = customerLoadProfile;
    }

    public List<EnrollmentStatus> getStatusList() {
        return statusList;
    }

    public void setStatusList(List<EnrollmentStatus> statusList) {
        this.statusList = statusList;
    }

    public List<Enrollment> getSearchResults() {
        return searchResults;
    }

    public void setSearchResults(List<Enrollment> searchResults) {
        this.searchResults = searchResults;
    }

    public CustomizedQuote getCustQuote() {
        return custQuote;
    }

    public void setCustQuote(CustomizedQuote custQuote) {
        this.custQuote = custQuote;
    }

    public List<EdcTdsp> getEdcTdspList() {
        return edcTdspList;
    }

    public void setEdcTdspList(List<EdcTdsp> edcTdspList) {
        this.edcTdspList = edcTdspList;
    }

    public List<Rep> getRepList() {
        return repList;
    }

    public void setRepList(List<Rep> repList) {
        this.repList = repList;
    }

    public List<RepProducts> getRepProductsList() {
        return repProductsList;
    }

    public void setRepProductsList(List<RepProducts> repProductsList) {
        this.repProductsList = repProductsList;
    }

    public Integer getSelectedTabIndex() {
        return selectedTabIndex;
    }

    public void setSelectedTabIndex(Integer selectedTabIndex) {
        this.selectedTabIndex = selectedTabIndex;
    }

    public Enrollment getSelectedEnrollment() {
        return selectedEnrollment;
    }

    public void setSelectedEnrollment(Enrollment selectedEnrollment) {
        this.selectedEnrollment = selectedEnrollment;
    }
}
