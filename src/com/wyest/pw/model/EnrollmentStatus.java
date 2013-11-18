package com.wyest.pw.model;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

/**
 * User: Amit
 * Date: 6/16/13
 * Time: 1:53 PM
 */
@Entity
@XmlRootElement
@Table(name = "enrollment_status")
@NamedQuery(name = "EnrollmentStatus.findAll", query = "select e from EnrollmentStatus e order by e.statusId")
public class EnrollmentStatus implements Serializable {
    private static final long serialVersionUID = -3855745327117709768L;

    private Long statusId;
    private String statusDescription;
    private String colorCode;

    public EnrollmentStatus() {}

    public EnrollmentStatus(Long statusId) {
        this.statusId = statusId;
    }

    public EnrollmentStatus(Long statusId, String statusDescription) {
        this.statusId = statusId;
        this.statusDescription = statusDescription;
    }

    @Id
    @Column(name = "status_id", nullable = false)
    public Long getStatusId() {
        return statusId;
    }

    public void setStatusId(Long statusId) {
        this.statusId = statusId;
    }

    @Column(name = "status_desc")
    public String getStatusDescription() {
        return statusDescription;
    }

    public void setStatusDescription(String statusDescription) {
        this.statusDescription = statusDescription;
    }

    @Column(name = "color_code")
    public String getColorCode() {
        return colorCode;
    }

    public void setColorCode(String colorCode) {
        this.colorCode = colorCode;
    }

    @Override
    public String toString() {
        return "StatusId=" + getStatusId() + ", StatusDesc=" + getStatusDescription();
    }
}
