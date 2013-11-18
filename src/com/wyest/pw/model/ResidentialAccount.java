package com.wyest.pw.model;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Date;

/**
 * User: Amit
 * Date: 6/16/13
 * Time: 6:59 PM
 */
@Entity
@XmlRootElement
@Table(name = "residential_account")
public class ResidentialAccount implements Serializable {
    private static final long serialVersionUID = 7780994245067596890L;

    private Long residentialAccountId;
    private String firstName;
    private String lastName;
    private String middleName;
    private String driversLicenseNo;
    private String SSN;
    private String utilityAccountNo;
    private String ESI;

    private Date birthDate;

    private Contact billingContact;
    private Contact serviceContact;

    // Transient
    private boolean sameBillingAndServiceAddress;

    @Id
    @Column(name = "residential_account_id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getResidentialAccountId() {
        return residentialAccountId;
    }

    public void setResidentialAccountId(Long residentialAccountId) {
        this.residentialAccountId = residentialAccountId;
    }

    @Column(name = "first_name")
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    @Column(name = "last_name")
    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    @Column(name = "middle_name")
    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    @Column(name = "drivers_license_no")
    public String getDriversLicenseNo() {
        return driversLicenseNo;
    }

    public void setDriversLicenseNo(String driversLicenseNo) {
        this.driversLicenseNo = driversLicenseNo;
    }

    @Column(name = "ssn")
    public String getSSN() {
        return SSN;
    }

    public void setSSN(String SSN) {
        this.SSN = SSN;
    }

    @Column(name = "utility_account_no")
    public String getUtilityAccountNo() {
        return utilityAccountNo;
    }

    public void setUtilityAccountNo(String utilityAccountNo) {
        this.utilityAccountNo = utilityAccountNo;
    }

    @Column(name = "esi")
    public String getESI() {
        return ESI;
    }

    public void setESI(String ESI) {
        this.ESI = ESI;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "birth_date")
    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "billing_contact_id", referencedColumnName = "contact_id")
    public Contact getBillingContact() {
        return billingContact;
    }

    public void setBillingContact(Contact billingContact) {
        this.billingContact = billingContact;
    }

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "service_contact_id", referencedColumnName = "contact_id")
    public Contact getServiceContact() {
        return serviceContact;
    }

    public void setServiceContact(Contact serviceContact) {
        this.serviceContact = serviceContact;
    }

    @XmlTransient
    @Transient
    public boolean isSameBillingAndServiceAddress() {
        return sameBillingAndServiceAddress;
    }

    public void setSameBillingAndServiceAddress(boolean sameBillingAndServiceAddress) {
        this.sameBillingAndServiceAddress = sameBillingAndServiceAddress;
    }

    @Transient
    public String getFullName() {
        StringBuilder name = new StringBuilder();
        name.append(getFirstName()).append(",");
        if(getMiddleName() != null) {
            name.append(" ").append(getMiddleName());
        }
        if(getLastName() != null) {
            name.append(" ").append(getLastName());
        }

        return name.toString();
    }

    @Override
    public String toString() {
        return "ResAccountId=" + getResidentialAccountId() + ", FirstName=" + getFirstName() + ", LastName=" + getLastName();
    }
}
