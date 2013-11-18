package com.wyest.pw.jsf;

import com.wyest.pw.info.ContactInfo;
import com.wyest.pw.enums.LoginTypeEnum;
import com.wyest.pw.utils.FacesUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

import static com.wyest.pw.utils.PWUtils.notEmpty;

/**
 * User: Amit
 * Date: 6/22/13
 * Time: 3:53 PM
 */
@ManagedBean
@SessionScoped
public class ApplicationController {
    private static Logger log = LoggerFactory.getLogger(ApplicationController.class);
    private ContactInfo contact;

    public ApplicationController() {
        log.info("new instance created.");
    }

    @PostConstruct
    public void init() {
        log.info("init called.");
    }

    public void logoutAction() {
        try {
            if (notEmpty(contact)) {
                String url = null;
                if(LoginTypeEnum.END_USER.getCode().equalsIgnoreCase(contact.getLoginType())) {
                    url = "login.jsf";
                }
                else if(LoginTypeEnum.SYSTEM_ADMIN.getCode().equalsIgnoreCase(contact.getLoginType())) {
                    url = "systemLogin.jsf";
                }
                else if(LoginTypeEnum.AGENT_BROKER.getCode().equalsIgnoreCase(contact.getLoginType())) {
                    url = "agentLogin.jsf";
                }
                contact = null;
                FacesUtil.redirect(url);
            }
        } catch (Exception e) {
            log.error("", e);
        }
    }

    public ContactInfo getContact() {
        return contact;
    }

    public void setContact(ContactInfo contact) {
        this.contact = contact;
    }
}
