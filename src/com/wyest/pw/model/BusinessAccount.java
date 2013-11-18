package com.wyest.pw.model;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * User: Amit
 * Date: 6/23/13
 * Time: 3:51 PM
 */
@Entity
@XmlRootElement
@Table(name = "business_account")
public class BusinessAccount implements Serializable {
    private static final long serialVersionUID = -6457711041925418680L;

    private Long businessAccountId;
    private String companyName;
    private String federalTaxId;
    private Integer billedMonth;
    private Integer billedUsage;
    private Integer billedPeakDemand;

    private BusinessType businessType;
    private Contact billingContact;

    private Set<BusinessAccountServiceAddress> serviceAddresses = new HashSet<>();
    private List<BusinessAccountServiceAddress> serviceAddressList = new ArrayList<>();

    @Id
    @Column(name = "business_account_id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getBusinessAccountId() {
        return businessAccountId;
    }

    public void setBusinessAccountId(Long businessAccountId) {
        this.businessAccountId = businessAccountId;
    }

    @Column(name = "company_name")
    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    @Column(name = "federal_tax_id")
    public String getFederalTaxId() {
        return federalTaxId;
    }

    public void setFederalTaxId(String federalTaxId) {
        this.federalTaxId = federalTaxId;
    }

    @Column(name = "billed_month")
    public Integer getBilledMonth() {
        return billedMonth;
    }

    public void setBilledMonth(Integer billedMonth) {
        this.billedMonth = billedMonth;
    }

    @Column(name = "billed_usage")
    public Integer getBilledUsage() {
        return billedUsage;
    }

    public void setBilledUsage(Integer billedUsage) {
        this.billedUsage = billedUsage;
    }

    @Column(name = "billed_peak_demand")
    public Integer getBilledPeakDemand() {
        return billedPeakDemand;
    }

    public void setBilledPeakDemand(Integer billedPeakDemand) {
        this.billedPeakDemand = billedPeakDemand;
    }

    @ManyToOne
    @JoinColumn(name = "business_type_id")
    public BusinessType getBusinessType() {
        return businessType;
    }

    public void setBusinessType(BusinessType businessType) {
        this.businessType = businessType;
    }

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "billing_contact_id", referencedColumnName = "contact_id")
    public Contact getBillingContact() {
        return billingContact;
    }

    public void setBillingContact(Contact billingContact) {
        this.billingContact = billingContact;
    }

    @OneToMany(mappedBy = "businessAccount", cascade = CascadeType.PERSIST, fetch = FetchType.EAGER)
    public Set<BusinessAccountServiceAddress> getServiceAddresses() {
        return serviceAddresses;
    }

    public void setServiceAddresses(Set<BusinessAccountServiceAddress> serviceAddresses) {
        this.serviceAddresses = serviceAddresses;
    }

    @Transient
    public List<BusinessAccountServiceAddress> getServiceAddressList() {
        return serviceAddressList;
    }

    public void setServiceAddressList(List<BusinessAccountServiceAddress> serviceAddressList) {
        this.serviceAddressList = serviceAddressList;
    }

    @Override
    public String toString() {
        return "BusinessAccountId [" + getBusinessAccountId() + "], CompanyName [" + getCompanyName() + "]";
    }
}
