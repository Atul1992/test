package com.wyest.pw.model;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.io.Serializable;
import java.util.Date;

/**
 * User: Amit
 * Date: 6/1/13
 * Time: 4:29 PM
 */
@Entity
@XmlRootElement
@Table(name = "rep_products")
@NamedQueries({
        @NamedQuery(name = "RepProducts.findAll", query = "select r from RepProducts r order by r.productId"),
        @NamedQuery(name = "RepProducts.findAllByRep", query = "select r from RepProducts r where r.rep.repId = :repId order by r.productId"),
        @NamedQuery(name = "RepProducts.findAllByEdcTdsp", query = "select r from RepProducts r where r.edcTdsp.edcId = :edcId order by r.productId")
})
public class RepProducts implements Serializable {
    private static final long serialVersionUID = 2916598065817740563L;

    private Long productId;
    private String productName;
    private String productCode;
    private String pricingType;
    private String specialOffer;
    private String energyType;
    private String energyFactsLabelURL;
    private String commercialMatrix;
    private String commercialCustomized;
    private String residentialMatrix;
    private String tosPath;
    private String yraacPath;

    private Integer contractTerm;
    private Integer windPercentage;

    private Double rate;
    private Double deposit;
    private Double earlyCancelFees;
    private Double monthlyCharges;
    private Double annualMWH;
    private Double brokerFees;
    private Double switchingFees;

    private Date validFrom;
    private Date validTo;

    private Rep rep;
    private EdcTdsp edcTdsp;

    //transient
    private Double savingsPercentage;
    private boolean selected;
    private boolean disabled;

    @Id
    @Column(name = "product_id")
    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    @Column(name = "product_name")
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    @Column(name = "product_code")
    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    @Column(name = "pricing_type")
    public String getPricingType() {
        return pricingType;
    }

    public void setPricingType(String pricingType) {
        this.pricingType = pricingType;
    }

    @Column(name = "special_offer")
    public String getSpecialOffer() {
        return specialOffer;
    }

    public void setSpecialOffer(String specialOffer) {
        this.specialOffer = specialOffer;
    }

    @Column(name = "energy_type")
    public String getEnergyType() {
        return energyType;
    }

    public void setEnergyType(String energyType) {
        this.energyType = energyType;
    }

    @Column(name = "energy_facts_label_url")
    public String getEnergyFactsLabelURL() {
        return energyFactsLabelURL;
    }

    public void setEnergyFactsLabelURL(String energyFactsLabelURL) {
        this.energyFactsLabelURL = energyFactsLabelURL;
    }

    @Column(name = "commercial_matrix")
    public String getCommercialMatrix() {
        return commercialMatrix;
    }

    public void setCommercialMatrix(String commercialMatrix) {
        this.commercialMatrix = commercialMatrix;
    }

    @Column(name = "commercial_customized")
    public String getCommercialCustomized() {
        return commercialCustomized;
    }

    public void setCommercialCustomized(String commercialCustomized) {
        this.commercialCustomized = commercialCustomized;
    }

    @Column(name = "residential_matrix")
    public String getResidentialMatrix() {
        return residentialMatrix;
    }

    public void setResidentialMatrix(String residentialMatrix) {
        this.residentialMatrix = residentialMatrix;
    }

    @Column(name = "tos_path")
    public String getTosPath() {
        return tosPath;
    }

    public void setTosPath(String tosPath) {
        this.tosPath = tosPath;
    }

    @Column(name = "yraac_path")
    public String getYraacPath() {
        return yraacPath;
    }

    public void setYraacPath(String yraacPath) {
        this.yraacPath = yraacPath;
    }

    @Column(name = "contract_term")
    public Integer getContractTerm() {
        return contractTerm;
    }

    public void setContractTerm(Integer contractTerm) {
        this.contractTerm = contractTerm;
    }

    @Column(name = "wind_percentage")
    public Integer getWindPercentage() {
        return windPercentage;
    }

    public void setWindPercentage(Integer windPercentage) {
        this.windPercentage = windPercentage;
    }

    @Column(name = "rate")
    public Double getRate() {
        return rate;
    }

    public void setRate(Double rate) {
        this.rate = rate;
    }

    @Column(name = "deposit")
    public Double getDeposit() {
        return deposit;
    }

    public void setDeposit(Double deposit) {
        this.deposit = deposit;
    }

    @Column(name = "early_cancel_fees")
    public Double getEarlyCancelFees() {
        return earlyCancelFees;
    }

    public void setEarlyCancelFees(Double earlyCancelFees) {
        this.earlyCancelFees = earlyCancelFees;
    }

    @Column(name = "monthly_charges")
    public Double getMonthlyCharges() {
        return monthlyCharges;
    }

    public void setMonthlyCharges(Double monthlyCharges) {
        this.monthlyCharges = monthlyCharges;
    }

    @Column(name = "annual_mwh")
    public Double getAnnualMWH() {
        return annualMWH;
    }

    public void setAnnualMWH(Double annualMWH) {
        this.annualMWH = annualMWH;
    }

    @Column(name = "broker_fees")
    public Double getBrokerFees() {
        return brokerFees;
    }

    public void setBrokerFees(Double brokerFees) {
        this.brokerFees = brokerFees;
    }

    @Column(name = "switching_fees")
    public Double getSwitchingFees() {
        return switchingFees;
    }

    public void setSwitchingFees(Double switchingFees) {
        this.switchingFees = switchingFees;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "valid_from")
    public Date getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(Date validFrom) {
        this.validFrom = validFrom;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "valid_to")
    public Date getValidTo() {
        return validTo;
    }

    public void setValidTo(Date validTo) {
        this.validTo = validTo;
    }

    @ManyToOne
    @JoinColumn(name = "rep_id")
    public Rep getRep() {
        return rep;
    }

    public void setRep(Rep rep) {
        this.rep = rep;
    }

    @ManyToOne
    @JoinColumn(name = "edc_id")
    public EdcTdsp getEdcTdsp() {
        return edcTdsp;
    }

    public void setEdcTdsp(EdcTdsp edcTdsp) {
        this.edcTdsp = edcTdsp;
    }

    @Transient
    public Double getSavingsPercentage() {
        return savingsPercentage;
    }

    public void setSavingsPercentage(Double savingsPercentage) {
        this.savingsPercentage = savingsPercentage;
    }

    @XmlTransient
    @Transient
    public boolean isSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }

    @XmlTransient
    @Transient
    public boolean isDisabled() {
        return disabled;
    }

    public void setDisabled(boolean disabled) {
        this.disabled = disabled;
    }

    @Override
    public String toString() {
        return "ProductId=[" + getProductId() + "], ProductName=[" + getProductName() + "]";
    }
}
