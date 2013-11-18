package com.wyest.pw.model;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;

/**
 * User: Amit
 * Date: 6/25/13
 * Time: 9:29 PM
 */
@Entity
@XmlRootElement
@JsonIgnoreProperties("businessAccount")
@Table(name = "business_account_service_address")
public class BusinessAccountServiceAddress implements Serializable {
    private static final long serialVersionUID = 1147008506415078657L;

    private Long busAcctServiceAddressId;
    private String utilityAccountNo;
    private String ESI;

    private BusinessAccount businessAccount;
    private Contact serviceContact;

    @Id
    @Column(name = "bus_acc_service_address_id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getBusAcctServiceAddressId() {
        return busAcctServiceAddressId;
    }

    public void setBusAcctServiceAddressId(Long busAcctServiceAddressId) {
        this.busAcctServiceAddressId = busAcctServiceAddressId;
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

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "business_account_id", referencedColumnName = "business_account_id")
    public BusinessAccount getBusinessAccount() {
        return businessAccount;
    }

    public void setBusinessAccount(BusinessAccount businessAccount) {
        this.businessAccount = businessAccount;
    }

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "service_contact_id", referencedColumnName = "contact_id")
    public Contact getServiceContact() {
        return serviceContact;
    }

    public void setServiceContact(Contact serviceContact) {
        this.serviceContact = serviceContact;
    }

    @Override
    public String toString() {
        return "BusAcctServiceAddressId [" + getBusAcctServiceAddressId()
                + "], UtilityAccountNo [" + getUtilityAccountNo() + "], ESI [" + getESI()
                + "], ServiceContactId [" + (getServiceContact() != null ? getServiceContact().getContactId() : "") + "]";
    }
}
