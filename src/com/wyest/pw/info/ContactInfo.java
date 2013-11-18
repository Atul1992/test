package com.wyest.pw.info;

import com.wyest.pw.enums.CustomerTypeEnum;
import com.wyest.pw.enums.LoginTypeEnum;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;

/**
 * User: Amit
 * Date: 9/7/13
 * Time: 10:59 AM
 */
@XmlRootElement
public class ContactInfo implements Serializable {
    private Long contactId;
    private String contactName;
    private String loginType;
    private String email;
    private boolean agent;

    public Long getContactId() {
        return contactId;
    }

    public void setContactId(Long contactId) {
        this.contactId = contactId;
    }

    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public String getLoginType() {
        return loginType;
    }

    public void setLoginType(String loginType) {
        this.loginType = loginType;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isAgent() {
        return LoginTypeEnum.AGENT_BROKER.getCode().equalsIgnoreCase(loginType);
    }

    @Override
    public String toString() {
        return "ContactId [" + contactId + "] ,LoginType [" + loginType + "], Email [" + email + "]";
    }
}
