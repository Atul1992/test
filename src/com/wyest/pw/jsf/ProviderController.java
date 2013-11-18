package com.wyest.pw.jsf;

import com.wyest.pw.enums.*;
import com.wyest.pw.info.ContactInfo;
import com.wyest.pw.model.*;
import com.wyest.pw.rest.EnrollmentService;
import com.wyest.pw.rest.RepService;
import com.wyest.pw.rest.TdspService;
import com.wyest.pw.utils.FacesUtil;
import com.wyest.pw.utils.MessageUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.inject.Inject;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static com.wyest.pw.utils.PWUtils.calculateSavingsPercentage;
import static com.wyest.pw.utils.PWUtils.notEmpty;

/**
 * User: Amit
 * Date: 6/15/13
 * Time: 12:02 PM
 */
@ManagedBean
@ViewScoped
public class ProviderController {
    private static Logger log = LoggerFactory.getLogger(ProviderController.class);
    private final int MIN_STEP = 1;

    private int step = MIN_STEP;

    private String zipCode = "";
    private Date currentDate = new Date();
    private boolean copyAddress;

    private List<EdcTdsp> edcTdspList = new ArrayList<>();
    private List<BusinessType> businessTypeList = new ArrayList<>();
    private List<RepProducts> repProductsList = new ArrayList<>();
    private List<Rep> repList = new ArrayList<>();
    private List<ProductType> productTypeList = new ArrayList<>();
    private EdcTdsp selectedEdcTdsp;
    private RepProducts selectedProduct;
    private Long edcId;

    private Enrollment enrollment;
    private BusinessAccountServiceAddress businessAccountServiceAddress;

    private Contact agentLoginContact;

    @Inject
    private TdspService edcTdspResource;

    @Inject
    private RepService repResource;

    @Inject
    private EnrollmentService enrollmentResource;

    public ProviderController() {
        log.info("New instance created.");
    }

    @PostConstruct
    public void init() {
        log.info("init() called.");
        enrollment = new Enrollment();
        ApplicationController applicationController = (ApplicationController) FacesUtil.getFromSession("applicationController");
        if (notEmpty(applicationController)) {
            ContactInfo contact = applicationController.getContact();
            if (contact != null) {
                log.info("Found Agent contact [" + contact.getContactId() + "] in session");
                agentLoginContact = enrollmentResource.getContactById(contact.getContactId());
                if(notEmpty(agentLoginContact)) {
                    enrollment.setAgentEmail(agentLoginContact.getEmail());
                }
            }
        }
    }

    public void commercialResidentialAction(String customerType) {
        log.info("commercialResidentialAction() called. Customer Type [" + customerType + "]");
        enrollment.setCustomerType(customerType);
//        enrollment.setCurrentRate(15d);
        initializeAccount();
        if (notEmpty(zipCode)) {
            edcTdspList = edcTdspResource.findEdcTdspsForZipCode(zipCode);
            if (edcTdspList.size() == 1) {
                selectedEdcTdsp = edcTdspList.get(0);
                edcId = selectedEdcTdsp.getEdcId();
            }
        }
        incrementStep();
    }

    private void initializeAccount() {
        if(CustomerTypeEnum.RESIDENTIAL.getCode().equalsIgnoreCase(enrollment.getCustomerType())) {
            enrollment.setBusinessAccount(null);
            ResidentialAccount residentialAccount = new ResidentialAccount();
            residentialAccount.setBillingContact(new Contact());
            residentialAccount.getBillingContact().setContactType(ContactTypeEnum.BILLING.getCode());
            residentialAccount.getBillingContact().setLoginType(LoginTypeEnum.END_USER.getCode());
            residentialAccount.getBillingContact().setZipCode(zipCode);
            residentialAccount.setServiceContact(new Contact());
            residentialAccount.getServiceContact().setContactType(ContactTypeEnum.SERVICE.getCode());
            enrollment.setResidentialAccount(residentialAccount);
            enrollment.setStatus(new EnrollmentStatus(EnrollmentStatusEnum.PENDING.getId()));
//            addDummyContact(residentialAccount.getBillingContact());
        } else if (CustomerTypeEnum.COMMERCIAL.getCode().equalsIgnoreCase(enrollment.getCustomerType())) {
            enrollment.setResidentialAccount(null);
            BusinessAccount businessAccount = new BusinessAccount();
            businessAccount.setBusinessType(new BusinessType());
            businessAccount.setBillingContact(new Contact());
            businessAccount.getBillingContact().setContactType(ContactTypeEnum.BILLING.getCode());
            businessAccount.getBillingContact().setLoginType(LoginTypeEnum.END_USER.getCode());
            businessAccount.getBillingContact().setZipCode(zipCode);
            enrollment.setBusinessAccount(businessAccount);
            enrollment.setStatus(new EnrollmentStatus(EnrollmentStatusEnum.PENDING.getId()));
        }
    }

    public void matrixEnrollmentAction(String enrollmentType) {
        log.info("matrixEnrollmentAction() called. Enrollment Type [" + enrollmentType + "]");
        repProductsList.clear();
        repList.clear();
        productTypeList.clear();
        enrollment.setLoaPersonalContact(null);
        enrollment.setLoaPersonalFirstName(null);
        enrollment.setLoaPersonalLastName(null);
        enrollment.setLoaPersonalTitle(null);
        enrollment.setEnrollmentType(enrollmentType);
        enrollment.setPreferences(null);
        businessAccountServiceAddress = null;
        for (EdcTdsp edcTdsp : edcTdspList) {
            if (edcTdsp.getEdcId().equals(edcId)) {
                selectedEdcTdsp = edcTdsp;
                break;
            }
        }
        if (notEmpty(selectedEdcTdsp)) {
            if(EnrollmentTypeEnum.MATRIX.getCode().equalsIgnoreCase(enrollmentType)) {
                repProductsList = repResource.getListOfRepProductsForEdc(selectedEdcTdsp.getEdcId());
                for (RepProducts repProducts : repProductsList) {
                    repProducts.setSavingsPercentage(calculateSavingsPercentage(enrollment.getCurrentRate(), repProducts.getRate()));
                }
            } else if (EnrollmentTypeEnum.CUSTOMIZED.getCode().equalsIgnoreCase(enrollmentType)) {
                if(CustomerTypeEnum.COMMERCIAL.getCode().equals(enrollment.getCustomerType())) {
                    businessTypeList = enrollmentResource.getAllBusinessTypes();
                }
                businessAccountServiceAddress = new BusinessAccountServiceAddress();
                businessAccountServiceAddress.setServiceContact(new Contact());
                businessAccountServiceAddress.getServiceContact().setContactType(ContactTypeEnum.SERVICE.getCode());
                enrollment.setLoaPersonalContact(new Contact());
                enrollment.getLoaPersonalContact().setContactType(ContactTypeEnum.LOA.getCode());
                EnrollmentPreferences enrollmentPreferences = new EnrollmentPreferences();
                enrollmentPreferences.setProductType(new ProductType());
                enrollmentPreferences.setRep(new Rep());
                enrollment.setPreferences(enrollmentPreferences);
                repList = repResource.getListOfReps();
                productTypeList = repResource.getListOfProductTypes();
            }
        }
        incrementStep();
    }

    public void customerRegistrationAction(RepProducts product) {
        log.info("customerRegistrationAction() called. Selected Product [" + product + "]");
        selectedProduct = product;
        enrollment.setProduct(product);
        if(CustomerTypeEnum.COMMERCIAL.getCode().equals(enrollment.getCustomerType())) {
            businessTypeList = enrollmentResource.getAllBusinessTypes();
        }
        incrementStep();
    }

    public void createAccountAction() {
        log.info("createAccountAction() called.");
        try {
            if (notEmpty(enrollment)) {
                if(enrollment.getBusinessAccount() != null) {
                    for(BusinessAccountServiceAddress ba : enrollment.getBusinessAccount().getServiceAddressList()) {
                        enrollment.getBusinessAccount().getServiceAddresses().add(ba);
                    }
                }
                enrollment = enrollmentResource.createEnrollment(enrollment);
                incrementStep();
                // TODO: find a better way to handle this later
                if(step == 4) {
                    incrementStep();
                }
            }
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public void openServiceAddressDialog() {
        log.info("openServiceAddressDialog() called");
        businessAccountServiceAddress = new BusinessAccountServiceAddress();
        businessAccountServiceAddress.setServiceContact(new Contact());
        businessAccountServiceAddress.getServiceContact().setContactType(ContactTypeEnum.SERVICE.getCode());
    }

    public void addServiceAddressAction() {
        log.info("addServiceAddressAction() called");
        enrollment.getBusinessAccount().getServiceAddressList().add(businessAccountServiceAddress);
        businessAccountServiceAddress.setBusinessAccount(enrollment.getBusinessAccount());
    }

    public void removeServiceAddressAction(BusinessAccountServiceAddress businessAccountServiceAddress) {
        enrollment.getBusinessAccount().getServiceAddressList().remove(businessAccountServiceAddress);
    }

    public void copyAddressAction() {
        Contact billingContact = enrollment.getResidentialAccount().getBillingContact();
        Contact serviceContact = enrollment.getResidentialAccount().getServiceContact();
        if (copyAddress) {
            copyAddress(serviceContact, billingContact);
        } else {
            if(notEmpty(serviceContact)) {
                serviceContact.clearAddress();
            }
        }
    }

    private void copyAddress(Contact toContact, Contact fromContact) {
        if(notEmpty(toContact) && notEmpty(fromContact)) {
            toContact.setAddressLine1(fromContact.getAddressLine1());
            toContact.setAddressLine2(fromContact.getAddressLine2());
            toContact.setCityName(fromContact.getCityName());
            toContact.setStateName(fromContact.getStateName());
            toContact.setZipCode(fromContact.getZipCode());
            toContact.setCountry(fromContact.getCountry());
        }
    }
//    public void copyFromBillingAddressAction(Contact copyToContact) {
//        Contact billingContact = null;
//        if(CUSTOMER_RESIDENTIAL.equalsIgnoreCase(enrollment.getCustomerType())) {
//            billingContact = enrollment.getResidentialAccount().getBillingContact();
//        } else if (CUSTOMER_BUSINESS.equalsIgnoreCase(enrollment.getCustomerType())) {
//            billingContact = enrollment.getBusinessAccount().getBillingContact();
//        }
//        if(billingContact != null && copyToContact != null) {
//            copyToContact.setAddressLine1(billingContact.getAddressLine1());
//            copyToContact.setAddressLine2(billingContact.getAddressLine2());
//            copyToContact.setCityName(billingContact.getCityName());
//            copyToContact.setStateName(billingContact.getStateName());
//            copyToContact.setZipCode(billingContact.getZipCode());
//            copyToContact.setCountry(billingContact.getCountry());
//        }
//    }


//    private void addDummyData() {
//        if(enrollment.getBusinessAccount() != null) {
//            BusinessAccount businessAccount = enrollment.getBusinessAccount();
//
//            Contact billingContact = businessAccount.getBillingContact();
//            billingContact.setAddressLine1("30 S Victoriana Cir");
//            billingContact.setAddressLine2("Home");
//            billingContact.setCityName("The Woodlands");
//            billingContact.setStateName("Texas");
//            billingContact.setZipCode("77389-4774");
//            billingContact.setCountry("USA");
//            billingContact.setEmail("varun@wyest.com");
//            billingContact.setPassword("test1234");
//            billingContact.setPhoneNo("(832) 296-5578");
//            billingContact.setCellPhoneNo("(702) 579-5127");
//            billingContact.setFaxNo("(832) 636-1122");
//
//            businessAccount.setCompanyName("Wyest Corporation");
//            BusinessType businessType = new BusinessType();
//            businessType.setBusinessTypeId(3L);
//            businessAccount.setBusinessType(businessType);
//            businessAccount.setFederalTaxId("FED-12345");
//
//            BusinessAccountServiceAddress serviceAddress = new BusinessAccountServiceAddress();
//            serviceAddress.setUtilityAccountNo("ACCT-34523456");
//            serviceAddress.setESI("ESI-11223344");
//            Contact serviceContact = new Contact();
//            serviceContact.setAddressLine1("3200 College Park Dr.");
//            serviceContact.setAddressLine2("First Location");
//            serviceContact.setCityName("Conroe");
//            serviceContact.setStateName("Texas");
//            serviceContact.setZipCode("77384-1234");
//            serviceContact.setCountry("USA");
//            serviceAddress.setServiceContact(serviceContact);
//            serviceAddress.setBusinessAccount(businessAccount);
//            businessAccount.getServiceAddresses().add(serviceAddress);
//        }
//    }

    private void incrementStep() {
        log.info("incrementStep called. Current Step [" + step + "]");
        int MAX_STEP = 5;
        if (step < MAX_STEP) {
            step++;
        }
        log.info("incrementStep End. Next Step [" + step + "]");
    }

    public void decrementStep() {
        if (step > MIN_STEP) {
            step--;
            if(step == 2) {
                enrollment.setEnrollmentType(null);
            } else if (step == 1) {
                enrollment.setCustomerType(null);
            }
        }
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public Date getCurrentDate() {
        return currentDate;
    }

    public void setCurrentDate(Date currentDate) {
        this.currentDate = currentDate;
    }

    public boolean isCopyAddress() {
        return copyAddress;
    }

    public void setCopyAddress(boolean copyAddress) {
        this.copyAddress = copyAddress;
    }

    public int getStep() {
        return step;
    }

    public void setStep(int step) {
        this.step = step;
    }

    public Long getEdcId() {
        return edcId;
    }

    public void setEdcId(Long edcId) {
        this.edcId = edcId;
    }

    public EdcTdsp getSelectedEdcTdsp() {
        return selectedEdcTdsp;
    }

    public void setSelectedEdcTdsp(EdcTdsp selectedEdcTdsp) {
        this.selectedEdcTdsp = selectedEdcTdsp;
    }

    public List<EdcTdsp> getEdcTdspList() {
        return edcTdspList;
    }

    public void setEdcTdspList(List<EdcTdsp> edcTdspList) {
        this.edcTdspList = edcTdspList;
    }

    public List<RepProducts> getRepProductsList() {
        return repProductsList;
    }

    public void setRepProductsList(List<RepProducts> repProductsList) {
        this.repProductsList = repProductsList;
    }

    public Enrollment getEnrollment() {
        return enrollment;
    }

    public void setEnrollment(Enrollment enrollment) {
        this.enrollment = enrollment;
    }

    public RepProducts getSelectedProduct() {
        return selectedProduct;
    }

    public void setSelectedProduct(RepProducts selectedProduct) {
        this.selectedProduct = selectedProduct;
    }

    public BusinessAccountServiceAddress getBusinessAccountServiceAddress() {
        return businessAccountServiceAddress;
    }

    public void setBusinessAccountServiceAddress(BusinessAccountServiceAddress businessAccountServiceAddress) {
        this.businessAccountServiceAddress = businessAccountServiceAddress;
    }

    public List<BusinessType> getBusinessTypeList() {
        return businessTypeList;
    }

    public void setBusinessTypeList(List<BusinessType> businessTypeList) {
        this.businessTypeList = businessTypeList;
    }

    public List<Rep> getRepList() {
        return repList;
    }

    public void setRepList(List<Rep> repList) {
        this.repList = repList;
    }

    public List<ProductType> getProductTypeList() {
        return productTypeList;
    }

    public void setProductTypeList(List<ProductType> productTypeList) {
        this.productTypeList = productTypeList;
    }

    public Contact getAgentLoginContact() {
        return agentLoginContact;
    }

    public void setAgentLoginContact(Contact agentLoginContact) {
        this.agentLoginContact = agentLoginContact;
    }
}
