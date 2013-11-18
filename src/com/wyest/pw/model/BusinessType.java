package com.wyest.pw.model;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

/**
 * User: Amit
 * Date: 6/23/13
 * Time: 3:44 PM
 */
@Entity
@XmlRootElement
@Table(name = "business_type")
@NamedQuery(name = "BusinessType.findAll", query = "select b from BusinessType b order by b.businessTypeId")
public class BusinessType implements Serializable {
    private static final long serialVersionUID = 7467113330799920725L;

    private Long businessTypeId;
    private String businessTypeName;

    @Id
    @Column(name = "business_type_id", nullable = false)
    public Long getBusinessTypeId() {
        return businessTypeId;
    }

    public void setBusinessTypeId(Long businessTypeId) {
        this.businessTypeId = businessTypeId;
    }

    @Column(name = "business_type_name", nullable = false)
    public String getBusinessTypeName() {
        return businessTypeName;
    }

    public void setBusinessTypeName(String businessTypeName) {
        this.businessTypeName = businessTypeName;
    }

    @Override
    public String toString() {
        return "BusinessTypeId [" + getBusinessTypeId() + "], BusinessTypeName [" + getBusinessTypeName() + "]";
    }
}
