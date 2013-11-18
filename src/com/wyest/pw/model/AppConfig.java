package com.wyest.pw.model;

import com.wyest.pw.utils.PWUtils;

import javax.persistence.*;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.*;

/**
 * User: Amit
 * Date: 6/23/13
 * Time: 3:51 PM
 */
@Entity
@XmlRootElement
@Table(name = "app_config")
public class AppConfig implements Serializable {
    private Long configId;
    private String keyName;
    private String value;
    private Date createdOn;
    private Date updatedOn;

    private boolean update;

    @Id
    @Column(name = "config_id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Long getConfigId() {
        return configId;
    }

    public void setConfigId(Long configId) {
        this.configId = configId;
    }

    @Column(name = "key_name")
    public String getKeyName() {
        return keyName;
    }

    public void setKeyName(String keyName) {
        this.keyName = keyName;
    }

    @Column(name = "value")
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_on")
    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_on")
    public Date getUpdatedOn() {
        return updatedOn;
    }

    public void setUpdatedOn(Date updatedOn) {
        this.updatedOn = updatedOn;
    }

    @Transient
    public boolean isUpdate() {
        return update;
    }

    public void setUpdate(boolean update) {
        this.update = update;
    }

    @Override
    public String toString() {
        return "ConfigId [" + getConfigId() + "], KeyName [" + getKeyName()
                + "], Value [" + getValue() + "], CreatedOn [" + PWUtils.convertDateToStr(getCreatedOn()) + "]";
    }
}
