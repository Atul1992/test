package com.wyest.pw.model;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * User: Amit
 * Date: 6/1/13
 * Time: 3:48 PM
 */
@Entity
@XmlRootElement
@Table(name = "rep")
@NamedQuery(name = "Rep.findAllReps", query = "select r from Rep r order by r.repId")
public class Rep implements Serializable {
    private static final long serialVersionUID = -9095882305913108609L;

    private Long repId;
    private String repName;

//    private Set<RepProducts> products = new HashSet<>();
//    private List<RepProducts> productsList = new ArrayList<>();

    public Rep() {
    }

    @Id
    @Column(name = "rep_id")
    public Long getRepId() {
        return repId;
    }

    public void setRepId(Long repId) {
        this.repId = repId;
    }

    @Column(name = "rep_name")
    public String getRepName() {
        return repName;
    }

    public void setRepName(String repName) {
        this.repName = repName;
    }

//    @XmlTransient
//    @OneToMany(mappedBy = "rep")
//    public Set<RepProducts> getProducts() {
//        return products;
//    }
//
//    public void setProducts(Set<RepProducts> products) {
//        this.products = products;
//    }
//
//    @XmlTransient
//    @Transient
//    public List<RepProducts> getProductsList() {
//        return productsList;
//    }
//
//    public void setProductsList(List<RepProducts> productsList) {
//        this.productsList = productsList;
//    }

    @Override
    public String toString() {
        return "RepId=" + getRepId() + ", RepName=" + getRepName();
    }
}
