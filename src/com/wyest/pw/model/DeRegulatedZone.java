package com.wyest.pw.model;

/**
 * User: Amit
 * Date: 5/31/13
 * Time: 8:02 PM
 */

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

@Entity
@XmlRootElement
@Table(name = "deregulated_zone")
public class DeRegulatedZone implements Serializable {
    private static final long serialVersionUID = -4932959463463697223L;

    private Long zoneId;
    private String zoneName;
    private Double averageRate;
    private Double commonAverageRate;

    private Set<EdcTdsp> edcTdsps = new HashSet<>();

    @Id
    @Column(name = "zone_id")
    public Long getZoneId() {
        return zoneId;
    }

    public void setZoneId(Long zoneId) {
        this.zoneId = zoneId;
    }

    @Column(name = "zone_name")
    public String getZoneName() {
        return zoneName;
    }

    public void setZoneName(String zoneName) {
        this.zoneName = zoneName;
    }

    @Column(name = "average_rate")
    public Double getAverageRate() {
        return averageRate;
    }

    public void setAverageRate(Double averageRate) {
        this.averageRate = averageRate;
    }

    @Column(name = "comm_average_rate")
    public Double getCommonAverageRate() {
        return commonAverageRate;
    }

    public void setCommonAverageRate(Double commonAverageRate) {
        this.commonAverageRate = commonAverageRate;
    }

    @XmlTransient
    @ManyToMany()
    @JoinTable(name = "edc_tdsp_zone",
            joinColumns = @JoinColumn(name = "zone_id"),
            inverseJoinColumns = @JoinColumn(name = "edc_id"))
    public Set<EdcTdsp> getEdcTdsps() {
        return edcTdsps;
    }

    public void setEdcTdsps(Set<EdcTdsp> edcTdsps) {
        this.edcTdsps = edcTdsps;
    }

    @Override
    public String toString() {
        return "ZoneId=" + getZoneId() + ", ZoneName=" + getZoneName();
    }

}
