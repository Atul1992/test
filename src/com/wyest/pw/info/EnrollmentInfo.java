package com.wyest.pw.info;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

/**
 * User: Amit
 * Date: 9/29/13
 * Time: 3:04 PM
 */
@XmlRootElement
public class EnrollmentInfo implements Serializable {
    private String enrollmentId;
    private String email;
    private String customerOrCompanyName;
    private String address;
    private String phoneNo;
    private String agentEmail;
    private String serviceStartDateRequested;
    private String serverURL;

    private boolean residential;
    private boolean commercial;
    private boolean userAgent;

    private boolean emailOverridden;
    private String overriddenReceiver;
    private String originalReceivers;

    public String getEnrollmentId() {
        return enrollmentId;
    }

    public void setEnrollmentId(String enrollmentId) {
        this.enrollmentId = enrollmentId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCustomerOrCompanyName() {
        return customerOrCompanyName;
    }

    public void setCustomerOrCompanyName(String customerOrCompanyName) {
        this.customerOrCompanyName = customerOrCompanyName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getAgentEmail() {
        return agentEmail;
    }

    public void setAgentEmail(String agentEmail) {
        this.agentEmail = agentEmail;
    }

    public String getServiceStartDateRequested() {
        return serviceStartDateRequested;
    }

    public void setServiceStartDateRequested(String serviceStartDateRequested) {
        this.serviceStartDateRequested = serviceStartDateRequested;
    }

    public String getServerURL() {
        return serverURL;
    }

    public void setServerURL(String serverURL) {
        this.serverURL = serverURL;
    }

    public boolean isResidential() {
        return residential;
    }

    public void setResidential(boolean residential) {
        this.residential = residential;
    }

    public boolean isCommercial() {
        return commercial;
    }

    public void setCommercial(boolean commercial) {
        this.commercial = commercial;
    }

    public boolean isUserAgent() {
        return userAgent;
    }

    public void setUserAgent(boolean userAgent) {
        this.userAgent = userAgent;
    }

    public boolean isEmailOverridden() {
        return emailOverridden;
    }

    public void setEmailOverridden(boolean emailOverridden) {
        this.emailOverridden = emailOverridden;
    }

    public String getOverriddenReceiver() {
        return overriddenReceiver;
    }

    public void setOverriddenReceiver(String overriddenReceiver) {
        this.overriddenReceiver = overriddenReceiver;
    }

    public String getOriginalReceivers() {
        return originalReceivers;
    }

    public void setOriginalReceivers(String originalReceivers) {
        this.originalReceivers = originalReceivers;
    }

    @Override
    public String toString() {
        return "EnrollmentId [" + getEnrollmentId() + ", Email [" + getEmail() + "]";
    }
}
