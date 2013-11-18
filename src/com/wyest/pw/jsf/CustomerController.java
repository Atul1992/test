package com.wyest.pw.jsf;

import com.wyest.pw.info.ContactInfo;
import com.wyest.pw.model.Enrollment;
import com.wyest.pw.model.RepProducts;
import com.wyest.pw.rest.EnrollmentService;
import com.wyest.pw.rest.RepService;
import com.wyest.pw.utils.FacesUtil;
import com.wyest.pw.utils.MessageUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.inject.Inject;
import java.util.ArrayList;
import java.util.List;

import static com.wyest.pw.utils.PWUtils.calculateSavingsPercentage;
import static com.wyest.pw.utils.PWUtils.notEmpty;

/**
 * User: Amit
 * Date: 6/22/13
 * Time: 4:52 PM
 */
@ManagedBean
@ViewScoped
public class CustomerController {
    private static Logger log = LoggerFactory.getLogger(CustomerController.class);
    private Enrollment enrollment;
    private List<RepProducts> repProductsList = new ArrayList<>();

    @Inject
    private EnrollmentService enrollmentResource;

    @Inject
    private RepService repResource;

    private ContactInfo contact;

    public CustomerController() {
        log.info("new instance created.");
    }

    @PostConstruct
    public void init() {
        log.info("init called.");
        ApplicationController applicationController = (ApplicationController) FacesUtil.getFromSession("applicationController");
        if (notEmpty(applicationController)) {
            contact = applicationController.getContact();
            if (contact != null) {
                log.info("Found End User contact [" + contact.getContactId() + "] in session");
                loadEnrollemnt();
            }
        }
    }

    private void loadEnrollemnt() {
        enrollment = enrollmentResource.getEnrollmentByContactId(contact);
        if (notEmpty(enrollment) && notEmpty(enrollment.getProduct())) {
            List<RepProducts> repProducts = repResource.getListOfRepProductsForEdc(enrollment.getProduct().getEdcTdsp().getEdcId());
            for (RepProducts product : repProducts) {
                if (!product.getProductId().equals(enrollment.getProduct().getProductId())) {
                    Double savingsPerc = calculateSavingsPercentage(enrollment.getProduct().getRate(), product.getRate());
                    product.setSavingsPercentage(savingsPerc);
                    repProductsList.add(product);
                }
            }
        }
    }

    public void updateProductAction(RepProducts product) {
        try {
            if (notEmpty(enrollment)) {
                enrollment.setProduct(product);
                enrollmentResource.updateProductOnEnrollment(enrollment);
                MessageUtil.addInfoMessageWithoutKey("Product updated successfully");
                loadEnrollemnt();
            }
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public Enrollment getEnrollment() {
        return enrollment;
    }

    public void setEnrollment(Enrollment enrollment) {
        this.enrollment = enrollment;
    }

    public List<RepProducts> getRepProductsList() {
        return repProductsList;
    }

    public void setRepProductsList(List<RepProducts> repProductsList) {
        this.repProductsList = repProductsList;
    }
}
