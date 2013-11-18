package com.wyest.pw.model;

import com.wyest.pw.enums.CustomerTypeEnum;
import com.wyest.pw.enums.EnrollmentTypeEnum;
import com.wyest.pw.utils.PWUtils;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.*;

import static com.wyest.pw.utils.PWUtils.*;

/**
 * User: Amit
 * Date: 6/22/13
 * Time: 10:09 AM
 */
@Entity
@XmlRootElement
@Table(name = "enrollment")
public class Enrollment implements Serializable {
    private static final long serialVersionUID = 5569124932177537265L;

    private Long enrollmentId;
    private String enrollmentType;
    private String customerType;
    private String smartMeter;
    private String termsAndConditions;
    private String loaPersonalFirstName;
    private String loaPersonalLastName;
    private String loaPersonalTitle;
    private Double currentRate;
    private Date serviceStartDateRequested;
    private Date serviceStartDateConfirmed;
    private String customerIP;
    private Date enrollmentDate;

    private String agentEmail;

    private EnrollmentStatus status;
    private ResidentialAccount residentialAccount;
    private BusinessAccount businessAccount;
    private RepProducts product;
    private EnrollmentPreferences preferences;

    private Contact loaPersonalContact;

    private List<CustomerLoadProfile> loadProfileList = new ArrayList<>();
    private List<CustomizedQuote> customizedQuoteList = new ArrayList<>();

    @Id
    @Column(name = "enrollment_id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getEnrollmentId() {
        return enrollmentId;
    }

    public void setEnrollmentId(Long enrollmentId) {
        this.enrollmentId = enrollmentId;
    }

    @Column(name = "enrollment_type")
    public String getEnrollmentType() {
        return enrollmentType;
    }

    public void setEnrollmentType(String enrollmentType) {
        this.enrollmentType = enrollmentType;
    }

    @Column(name = "smart_meter")
    public String getSmartMeter() {
        return smartMeter;
    }

    public void setSmartMeter(String smartMeter) {
        this.smartMeter = smartMeter;
    }

    @Column(name = "terms_and_conditions")
    public String getTermsAndConditions() {
        return termsAndConditions;
    }

    public void setTermsAndConditions(String termsAndConditions) {
        this.termsAndConditions = termsAndConditions;
    }

    @Column(name = "loa_personal_first_name")
    public String getLoaPersonalFirstName() {
        return loaPersonalFirstName;
    }

    public void setLoaPersonalFirstName(String loaPersonalFirstName) {
        this.loaPersonalFirstName = loaPersonalFirstName;
    }

    @Column(name = "loa_personal_last_name")
    public String getLoaPersonalLastName() {
        return loaPersonalLastName;
    }

    public void setLoaPersonalLastName(String loaPersonalLastName) {
        this.loaPersonalLastName = loaPersonalLastName;
    }

    @Column(name = "loa_personal_title")
    public String getLoaPersonalTitle() {
        return loaPersonalTitle;
    }

    public void setLoaPersonalTitle(String loaPersonalTitle) {
        this.loaPersonalTitle = loaPersonalTitle;
    }

    @Column(name = "current_rate")
    public Double getCurrentRate() {
        return currentRate;
    }

    public void setCurrentRate(Double currentRate) {
        this.currentRate = currentRate;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "service_start_date_requested")
    public Date getServiceStartDateRequested() {
        return serviceStartDateRequested;
    }

    public void setServiceStartDateRequested(Date serviceStartDateRequested) {
        this.serviceStartDateRequested = serviceStartDateRequested;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "service_start_date_confirmed")
    public Date getServiceStartDateConfirmed() {
        return serviceStartDateConfirmed;
    }

    public void setServiceStartDateConfirmed(Date serviceStartDateConfirmed) {
        this.serviceStartDateConfirmed = serviceStartDateConfirmed;
    }

    @Column(name = "customer_ip")
    public String getCustomerIP() {
        return customerIP;
    }

    public void setCustomerIP(String customerIP) {
        this.customerIP = customerIP;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "enrollment_date")
    public Date getEnrollmentDate() {
        return enrollmentDate;
    }

    public void setEnrollmentDate(Date enrollmentDate) {
        this.enrollmentDate = enrollmentDate;
    }

    @Column(name = "agent_email_id")
    public String getAgentEmail() {
        return agentEmail;
    }

    public void setAgentEmail(String agentEmail) {
        this.agentEmail = agentEmail;
    }

    @ManyToOne
    @JoinColumn(name = "status_id")
    public EnrollmentStatus getStatus() {
        return status;
    }

    public void setStatus(EnrollmentStatus status) {
        this.status = status;
    }

    @ManyToOne
    @JoinColumn(name = "product_id")
    public RepProducts getProduct() {
        return product;
    }

    public void setProduct(RepProducts product) {
        this.product = product;
    }

    @OneToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "preference_id")
    public EnrollmentPreferences getPreferences() {
        return preferences;
    }

    public void setPreferences(EnrollmentPreferences preferences) {
        this.preferences = preferences;
    }

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "residential_account_id")
    public ResidentialAccount getResidentialAccount() {
        return residentialAccount;
    }

    public void setResidentialAccount(ResidentialAccount residentialAccount) {
        this.residentialAccount = residentialAccount;
    }

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "business_account_id")
    public BusinessAccount getBusinessAccount() {
        return businessAccount;
    }

    public void setBusinessAccount(BusinessAccount businessAccount) {
        this.businessAccount = businessAccount;
    }

    @Column(name = "customer_type")
    public String getCustomerType() {
        return customerType;
    }

    public void setCustomerType(String customerType) {
        this.customerType = customerType;
    }

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "loa_personal_contact_id", referencedColumnName = "contact_id")
    public Contact getLoaPersonalContact() {
        return loaPersonalContact;
    }

    public void setLoaPersonalContact(Contact loaPersonalContact) {
        this.loaPersonalContact = loaPersonalContact;
    }

    @Transient
    public boolean isSmartMeterBool() {
        return convertYorNToBoolean(smartMeter);
    }

    public void setSmartMeterBool(boolean smartMeterBool) {
        smartMeter = convertBooleanToYorN(smartMeterBool);
    }

    @Transient
    public boolean isTermsAndConditionsBool() {
        return convertYorNToBoolean(termsAndConditions);
    }

    public void setTermsAndConditionsBool(boolean termsAndConditionsBool) {
        termsAndConditions = convertBooleanToYorN(termsAndConditionsBool);
    }

    @Transient
    public boolean isResidential() {
        return CustomerTypeEnum.RESIDENTIAL.getCode().equals(customerType);
    }

    @Transient
    public boolean isCommercial() {
        return CustomerTypeEnum.COMMERCIAL.getCode().equals(customerType);
    }

    @Transient
    public boolean isMatrix() {
        return EnrollmentTypeEnum.MATRIX.getCode().equals(enrollmentType);
    }

    @Transient
    public boolean isCustomized() {
        return EnrollmentTypeEnum.CUSTOMIZED.getCode().equals(enrollmentType);
    }

    @Transient
    public String getServiceStartDateReqStr() {
        return PWUtils.convertDateToStr(serviceStartDateRequested);
    }

    @Transient
    public List<CustomerLoadProfile> getLoadProfileList() {
        return loadProfileList;
    }

    public void setLoadProfileList(List<CustomerLoadProfile> loadProfileList) {
        this.loadProfileList = loadProfileList;
    }

    @Transient
    public List<CustomizedQuote> getCustomizedQuoteList() {
        return customizedQuoteList;
    }

    public void setCustomizedQuoteList(List<CustomizedQuote> customizedQuoteList) {
        this.customizedQuoteList = customizedQuoteList;
    }

    @Override
    public String toString() {
        return "EnrollmentId=" + getEnrollmentId() + ", EnrollmentType=" + getEnrollmentType();
    }
}
