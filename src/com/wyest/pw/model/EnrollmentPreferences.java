package com.wyest.pw.model;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

import static com.wyest.pw.utils.PWUtils.convertBooleanToYorN;
import static com.wyest.pw.utils.PWUtils.convertYorNToBoolean;

/**
 * User: Amit
 * Date: 7/11/13
 * Time: 10:18 PM
 */
@Entity
@XmlRootElement
@JsonIgnoreProperties("preferences")
@Table(name = "enrollment_preferences")
public class EnrollmentPreferences implements Serializable {
    private static final long serialVersionUID = -2329249152053847900L;
    private Long preferenceId;
    private String enerygyType;
    private String customerService;
    private String rewardPoints;
    private String savings;
    private String smartEnergySolutions;
    private String notificationInterval;
    private String productTerm;

    private ProductType productType;
    private Rep rep;

    @Id
    @Column(name = "preference_id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getPreferenceId() {
        return preferenceId;
    }

    public void setPreferenceId(Long preferenceId) {
        this.preferenceId = preferenceId;
    }

    @Column(name = "energy_type")
    public String getEnerygyType() {
        return enerygyType;
    }

    public void setEnerygyType(String enerygyType) {
        this.enerygyType = enerygyType;
    }

    @Column(name = "is_customer_service")
    public String getCustomerService() {
        return customerService;
    }

    public void setCustomerService(String customerService) {
        this.customerService = customerService;
    }

    @Column(name = "is_rewards_points")
    public String getRewardPoints() {
        return rewardPoints;
    }

    public void setRewardPoints(String rewardPoints) {
        this.rewardPoints = rewardPoints;
    }

    @Column(name = "is_savings")
    public String getSavings() {
        return savings;
    }

    public void setSavings(String savings) {
        this.savings = savings;
    }

    @Column(name = "is_smart_energy_solutions")
    public String getSmartEnergySolutions() {
        return smartEnergySolutions;
    }

    public void setSmartEnergySolutions(String smartEnergySolutions) {
        this.smartEnergySolutions = smartEnergySolutions;
    }

    @Column(name = "notification_interval")
    public String getNotificationInterval() {
        return notificationInterval;
    }

    public void setNotificationInterval(String notificationInterval) {
        this.notificationInterval = notificationInterval;
    }

    @Column(name = "product_term")
    public String getProductTerm() {
        return productTerm;
    }

    public void setProductTerm(String productTerm) {
        this.productTerm = productTerm;
    }

    @ManyToOne
    @JoinColumn(name = "product_type_id")
    public ProductType getProductType() {
        return productType;
    }

    public void setProductType(ProductType productType) {
        this.productType = productType;
    }

    @ManyToOne
    @JoinColumn(name = "rep_id")
    public Rep getRep() {
        return rep;
    }

    public void setRep(Rep rep) {
        this.rep = rep;
    }

    @Transient
    public boolean isSavingsBool() {
        return convertYorNToBoolean(savings);
    }

    public void setSavingsBool(boolean savingsBool) {
        savings = convertBooleanToYorN(savingsBool);
    }

    @Transient
    public boolean isRewardsPointsBool() {
        return convertYorNToBoolean(rewardPoints);
    }

    public void setRewardsPointsBool(boolean rewardPointsBool) {
        rewardPoints = convertBooleanToYorN(rewardPointsBool);
    }

    @Transient
    public boolean isCustomerServiceBool() {
        return convertYorNToBoolean(customerService);
    }

    public void setCustomerServiceBool(boolean customerServiceBool) {
        customerService = convertBooleanToYorN(customerServiceBool);
    }

    @Transient
    public boolean isSmartEnergySolutionsBool() {
        return convertYorNToBoolean(smartEnergySolutions);
    }

    public void setSmartEnergySolutionsBool(boolean smartEnergySolutionsBool) {
        smartEnergySolutions = convertBooleanToYorN(smartEnergySolutionsBool);
    }

    @Override
    public String toString() {
        return "PreferenceId=" + getPreferenceId();
    }

}
