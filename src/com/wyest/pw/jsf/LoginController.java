package com.wyest.pw.jsf;

import com.wyest.pw.enums.LoginTypeEnum;
import com.wyest.pw.info.ContactInfo;
import com.wyest.pw.model.Contact;
import com.wyest.pw.rest.EnrollmentService;
import com.wyest.pw.utils.FacesUtil;
import com.wyest.pw.utils.MessageUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.inject.Inject;

import static com.wyest.pw.utils.PWUtils.isEmpty;
import static com.wyest.pw.utils.PWUtils.notEmpty;

/**
 * User: Amit
 * Date: 6/22/13
 * Time: 3:53 PM
 */
@ManagedBean
@ViewScoped
public class LoginController {
    private static Logger log = LoggerFactory.getLogger(LoginController.class);

    private String email;
    private String password;

    @Inject
    private EnrollmentService enrollmentResource;

    public LoginController() {
        log.info("new instance created.");
    }

    @PostConstruct
    public void init() {
        log.info("init called.");
    }

    public void loginAction() {
        log.info("loginAction called. Email [" + email + "], Password [" + password + "]");
        try {
            if (notEmpty(email) && notEmpty(password)) {
                Contact contactToValidate = new Contact();
                contactToValidate.setEmail(email);
                contactToValidate.setPassword(password);
                ContactInfo contact = enrollmentResource.validateEnrollment(contactToValidate);
                if (isEmpty(contact)) {
                    MessageUtil.addErrorMessageWithoutKey("User not found in the system. Please try again using proper credentials");
                } else {
                    if(!LoginTypeEnum.END_USER.getCode().equalsIgnoreCase(contact.getLoginType())) {
                        MessageUtil.addErrorMessageWithoutKey("Not a valid user");
                        return;
                    }
                    ApplicationController applicationController = (ApplicationController) FacesUtil.getFromSession("applicationController");
                    if(isEmpty(applicationController)) {
                        applicationController = new ApplicationController();
                        FacesUtil.putInSession("applicationController", applicationController);
                    }
                    applicationController.setContact(contact);
                    FacesUtil.redirect("customerHome.jsf");
                }
            }
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public void systemLoginAction() {
        log.info("systemLoginAction called. Email [" + email + "], Password [" + password + "]");
        try {
            if (notEmpty(email) && notEmpty(password)) {
                Contact contactToValidate = new Contact();
                contactToValidate.setEmail(email);
                contactToValidate.setPassword(password);
                ContactInfo contact = enrollmentResource.validateEnrollment(contactToValidate);
                if (isEmpty(contact)) {
                    MessageUtil.addErrorMessageWithoutKey("System User not found in the system. Please try again using proper credentials");
                } else {
                    if(!LoginTypeEnum.SYSTEM_ADMIN.getCode().equalsIgnoreCase(contact.getLoginType())) {
                        MessageUtil.addErrorMessageWithoutKey("Not a valid user");
                        return;
                    }
                    ApplicationController applicationController = (ApplicationController) FacesUtil.getFromSession("applicationController");
                    if(isEmpty(applicationController)) {
                        applicationController = new ApplicationController();
                        FacesUtil.putInSession("applicationController", applicationController);
                    }
                    applicationController.setContact(contact);
                    FacesUtil.redirect("systemAdminHome.jsf");
                }
            }
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public void agentLoginAction() {
        log.info("agentLoginAction called. Email [" + email + "], Password [" + password + "]");
        try {
            if (notEmpty(email) && notEmpty(password)) {
                Contact contactToValidate = new Contact();
                contactToValidate.setEmail(email);
                contactToValidate.setPassword(password);
                ContactInfo contact = enrollmentResource.validateEnrollment(contactToValidate);
                if (isEmpty(contact)) {
                    MessageUtil.addErrorMessageWithoutKey("Agent not found in the system. Please try again using proper credentials");
                } else {
                    if(!LoginTypeEnum.AGENT_BROKER.getCode().equalsIgnoreCase(contact.getLoginType())) {
                        MessageUtil.addErrorMessageWithoutKey("Not a valid user");
                        return;
                    }
                    ApplicationController applicationController = (ApplicationController) FacesUtil.getFromSession("applicationController");
                    if(isEmpty(applicationController)) {
                        applicationController = new ApplicationController();
                        FacesUtil.putInSession("applicationController", applicationController);
                    }
                    applicationController.setContact(contact);
                    FacesUtil.redirect("agentHome.jsf");
                }
            }
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
