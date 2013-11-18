package com.wyest.pw.model;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.Date;

/**
 * User: Amit
 * Date: 7/6/13
 * Time: 12:57 PM
 */
@Entity
@XmlRootElement
@JsonIgnoreProperties("enrollment")
@Table(name = "customer_load_profile")
public class CustomerLoadProfile implements Serializable {
    private static final long serialVersionUID = -3442299989370875521L;

    private Long loadProfileId;
    private String fileName;
    private String fileType;
    private String contentType;
    private Long fileSize;
    private Date fileReceivedDate;
    private Date createdOn;
    private byte[] fileData;

    private Enrollment enrollment;

    @Id
    @Column(name = "load_profile_id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getLoadProfileId() {
        return loadProfileId;
    }

    public void setLoadProfileId(Long loadProfileId) {
        this.loadProfileId = loadProfileId;
    }

    @Column(name = "file_name")
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    @Column(name = "file_type")
    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    @Column(name = "content_type")
    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    @Column(name = "file_size")
    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "file_received_date")
    public Date getFileReceivedDate() {
        return fileReceivedDate;
    }

    public void setFileReceivedDate(Date fileReceivedDate) {
        this.fileReceivedDate = fileReceivedDate;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_on")
    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    @Lob
    @Column(name = "file_data")
    public byte[] getFileData() {
        return fileData;
    }

    public void setFileData(byte[] fileData) {
        this.fileData = fileData;
    }

    @ManyToOne
    @JoinColumn(name = "enrollment_id")
    public Enrollment getEnrollment() {
        return enrollment;
    }

    public void setEnrollment(Enrollment enrollment) {
        this.enrollment = enrollment;
    }

    @Override
    public String toString() {
        return "LoadProfileId=" + getLoadProfileId() + ", FileType=" + getFileType()
                + ", EnrollmentId=" + (getEnrollment() != null ? getEnrollment().getEnrollmentId() : "");
    }
}
