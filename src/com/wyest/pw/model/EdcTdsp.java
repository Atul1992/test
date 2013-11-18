package com.wyest.pw.model;

/**
 * User: Amit
 * Date: 6/01/13
 * Time: 11:38 AM
 */

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@XmlRootElement
@Table(name = "edc_tdsp")
@NamedQuery(name = EdcTdsp.FIND_ALL, query = "select e from EdcTdsp e order by e.edcName")
public class EdcTdsp implements Serializable {
    private static final long serialVersionUID = 320834024512394106L;

    public static final String FIND_ALL = "EdcTdsp.findAllEdcTdsps";

    private Long edcId;
    private String edcName;
    private String serviceArea;
    private String servicePhone;
    private String defaultEmail;

//    private Set<DeRegulatedZone> zones = new HashSet<DeRegulatedZone>();

    @Id
    @Column(name = "edc_id")
    public Long getEdcId() {
        return edcId;
    }

    public void setEdcId(Long edcId) {
        this.edcId = edcId;
    }

    @Column(name = "edc_name")
    public String getEdcName() {
        return edcName;
    }

    public void setEdcName(String edcName) {
        this.edcName = edcName;
    }

    @Column(name = "service_area")
    public String getServiceArea() {
        return serviceArea;
    }

    public void setServiceArea(String serviceArea) {
        this.serviceArea = serviceArea;
    }

    @Column(name = "service_phone")
    public String getServicePhone() {
        return servicePhone;
    }

    public void setServicePhone(String servicePhone) {
        this.servicePhone = servicePhone;
    }

    @Column(name = "default_email")
    public String getDefaultEmail() {
        return defaultEmail;
    }

    public void setDefaultEmail(String defaultEmail) {
        this.defaultEmail = defaultEmail;
    }

//    @ManyToMany(mappedBy = "edcTdsps", fetch = FetchType.EAGER)
//    public Set<DeRegulatedZone> getZones() {
//        return zones;
//    }
//
//    public void setZones(Set<DeRegulatedZone> zones) {
//        this.zones = zones;
//    }

    @Override
    public String toString() {
        return "EdcId=" + getEdcId() + ", EdcName=" + getEdcName()
                + ", EdcServiceArea=" + getServiceArea() + ", EdcServicePhone=" + getServicePhone()
                + ", EdcDefaultEmail=" + getDefaultEmail();
    }
}
