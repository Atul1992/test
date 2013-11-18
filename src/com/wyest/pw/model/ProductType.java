package com.wyest.pw.model;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

/**
 * User: Amit
 * Date: 7/11/13
 * Time: 10:14 PM
 */
@Entity
@XmlRootElement
@Table(name = "product_type")
@NamedQuery(name = "ProductType.findAll", query = "select r from ProductType r order by r.productTypeId")
public class ProductType implements Serializable {
    private static final long serialVersionUID = -5528283349407752222L;

    private Long productTypeId;
    private String description;

    public ProductType() {
    }

    @Id
    @Column(name = "product_type_id")
    public Long getProductTypeId() {
        return productTypeId;
    }

    public void setProductTypeId(Long productTypeId) {
        this.productTypeId = productTypeId;
    }

    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "ProductTypeId=" + getProductTypeId() + ", Description=" + getDescription();
    }
}
