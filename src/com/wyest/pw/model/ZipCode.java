package com.wyest.pw.model;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

/**
 * User: Amit
 * Date: 5/31/13
 * Time: 1:35 PM
 */
@Entity
@XmlRootElement
@Table(name = "zip_code")
@NamedQuery(name = "ZipCode.findAllZipCodes", query = "select z from ZipCode z order by z.zipCode")
public class ZipCode implements Serializable {
    private static final long serialVersionUID = 2230641756979478449L;

    private Long zipCodeId;
    private String zipCode;
    private String cityName;
    private String stateName;
    private String stateCode;
    private String zipCode4;

    private DeRegulatedZone zone;

    public ZipCode() {
    }

    @Id
    @Column(name = "zip_code_id")
    public Long getZipCodeId() {
        return zipCodeId;
    }

    public void setZipCodeId(Long zipCodeId) {
        this.zipCodeId = zipCodeId;
    }

    @Column(name = "zip_code")
    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
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

    @Column(name = "state_code")
    public String getStateCode() {
        return stateCode;
    }

    public void setStateCode(String stateCode) {
        this.stateCode = stateCode;
    }

    @Column(name = "zip_code_4")
    public String getZipCode4() {
        return zipCode4;
    }

    public void setZipCode4(String zipCode4) {
        this.zipCode4 = zipCode4;
    }

    @ManyToOne
    @JoinColumn(name = "zone_id")
    public DeRegulatedZone getZone() {
        return zone;
    }

    public void setZone(DeRegulatedZone zone) {
        this.zone = zone;
    }

    @Override
    public String toString() {
        return "ZipCodeId=" + getZipCodeId() + ", ZipCode=" + getZipCode() + ", StateCode=" + getStateCode();
    }
}
