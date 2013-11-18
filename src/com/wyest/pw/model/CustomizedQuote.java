package com.wyest.pw.model;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.Date;

/**
 * User: Amit
 * Date: 7/6/13
 * Time: 4:37 PM
 */
@Entity
@XmlRootElement
@Table(name = "customized_quote")
public class CustomizedQuote implements Serializable {
    private static final long serialVersionUID = 7598449374382598225L;

    private Long quoteId;
    private Date quoteRequestedDate;
    private Date quoteResponseDate;
    private Date acceptedDate;
    private Date createdOn;
    private String acceptedBy;

    private Enrollment enrollment;
    private RepProducts product;

    @Id
    @Column(name = "quote_id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getQuoteId() {
        return quoteId;
    }

    public void setQuoteId(Long quoteId) {
        this.quoteId = quoteId;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "quote_requested_date")
    public Date getQuoteRequestedDate() {
        return quoteRequestedDate;
    }

    public void setQuoteRequestedDate(Date quoteRequestedDate) {
        this.quoteRequestedDate = quoteRequestedDate;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "quote_response_date")
    public Date getQuoteResponseDate() {
        return quoteResponseDate;
    }

    public void setQuoteResponseDate(Date quoteResponseDate) {
        this.quoteResponseDate = quoteResponseDate;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "accepted_date")
    public Date getAcceptedDate() {
        return acceptedDate;
    }

    public void setAcceptedDate(Date acceptedDate) {
        this.acceptedDate = acceptedDate;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_on")
    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    @Column(name = "accepted_by")
    public String getAcceptedBy() {
        return acceptedBy;
    }

    public void setAcceptedBy(String acceptedBy) {
        this.acceptedBy = acceptedBy;
    }

    @ManyToOne
    @JoinColumn(name = "enrollment_id")
    public Enrollment getEnrollment() {
        return enrollment;
    }

    public void setEnrollment(Enrollment enrollment) {
        this.enrollment = enrollment;
    }

    @ManyToOne
    @JoinColumn(name = "product_id")
    public RepProducts getProduct() {
        return product;
    }

    public void setProduct(RepProducts product) {
        this.product = product;
    }

    @Override
    public String toString() {
        return "QuoteId=" + getQuoteId() + ", EnrollmentId=" + (getEnrollment() != null ? getEnrollment().getEnrollmentId() : "");
    }
}
