package com.wyest.pw.model;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Date;

import static com.wyest.pw.utils.PWUtils.*;

/**
 * User: Amit
 * Date: 6/14/13
 * Time: 7:35 PM
 */
@Entity
@XmlRootElement
@Table(name = "contact")
public class Contact implements Serializable {
    private static final long serialVersionUID = 139270534128715692L;

    private Long contactId;
    private String contactName;
    private String contactType;
    private String addressLine1;
    private String addressLine2;
    private String cityName;
    private String stateName;
    private String zipCode;
    private String country;
    private String phoneNo;
    private String cellPhoneNo;
    private String faxNo;
    private String email;
    private String password;
    private String loginType;
    private Date lastLoginDate;
    private Double latitude;
    private Double longitude;

    @Id
    @Column(name = "contact_id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getContactId() {
        return contactId;
    }

    public void setContactId(Long contactId) {
        this.contactId = contactId;
    }

    @Column(name = "contact_name")
    public String getContactName() {
        return contactName;
    }

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    @Column(name = "contact_type")
    public String getContactType() {
        return contactType;
    }

    public void setContactType(String contactType) {
        this.contactType = contactType;
    }

    @Column(name = "address_line_1")
    public String getAddressLine1() {
        return addressLine1;
    }

    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    @Column(name = "address_line_2")
    public String getAddressLine2() {
        return addressLine2;
    }

    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    @Column(name = "city_name")
    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    @Column(name = "state_name")
    public String getStateName() {
        return stateName;
    }

    public void setStateName(String stateName) {
        this.stateName = stateName;
    }

    @Column(name = "zip_code")
    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    @Column(name = "country")
    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    @Column(name = "phone_no")
    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    @Column(name = "cell_phone_no")
    public String getCellPhoneNo() {
        return cellPhoneNo;
    }

    public void setCellPhoneNo(String cellPhoneNo) {
        this.cellPhoneNo = cellPhoneNo;
    }

    @Column(name = "fax_no")
    public String getFaxNo() {
        return faxNo;
    }

    public void setFaxNo(String faxNo) {
        this.faxNo = faxNo;
    }

    @Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Column(name = "login_type")
    public String getLoginType() {
        return loginType;
    }

    public void setLoginType(String loginType) {
        this.loginType = loginType;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "last_login_date")
    public Date getLastLoginDate() {
        return lastLoginDate;
    }

    public void setLastLoginDate(Date lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }

    @Column(name = "lat")
    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    @Column(name = "lng")
    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    @Transient
    public String getFullAddress() {
        StringBuilder buffer = new StringBuilder();

        buffer.append(getAddressLine1());
        if(notEmpty(getAddressLine2())) {
            buffer.append(", ").append(getAddressLine2());
        }
        if(notEmpty(getCityName())) {
            buffer.append(", ").append(getCityName());
        }
        if(notEmpty(getStateName())) {
            buffer.append(", ").append(getStateName());
        }
        if(notEmpty(getZipCode())) {
            buffer.append(", ").append(getZipCode());
        }
        if(notEmpty(getCountry())) {
            buffer.append(", ").append(getCountry());
        }

        return buffer.toString();
    }

    public void clearAddress() {
        setAddressLine1(null);
        setAddressLine2(null);
        setCityName(null);
        setStateName(null);
        setZipCode(null);
        setCountry(null);
    }

    @Override
    public String toString() {
        return "ContactId=[" + getContactId() + "], ContactName=[" + getContactName()
                + "], ContactType=[" + getContactType() + "]";
    }
}
