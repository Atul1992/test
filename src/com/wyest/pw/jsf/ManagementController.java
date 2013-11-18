package com.wyest.pw.jsf;

import com.wyest.pw.ejb.ConfigBean;
import com.wyest.pw.ejb.EmailAsyncBean;
import com.wyest.pw.model.AppConfig;
import com.wyest.pw.model.Enrollment;
import com.wyest.pw.rest.EnrollmentService;
import com.wyest.pw.utils.Config;
import com.wyest.pw.utils.MessageUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.inject.Inject;
import java.util.ArrayList;
import java.util.List;

import static com.wyest.pw.utils.PWUtils.notEmpty;

/**
 * User: Amit
 * Date: 7/13/13
 * Time: 11:18 PM
 */
@ManagedBean
@ViewScoped
public class ManagementController {
    private static Logger log = LoggerFactory.getLogger(ManagementController.class);

    @Inject
    private EnrollmentService enrollmentResource;

    @Inject
    private EmailAsyncBean emailAsyncBean;

    @Inject
    ConfigBean configBean;

    private Long enrollmentId = 1L;
    private List<AppConfig> configList = new ArrayList<>();

    public ManagementController() {
        log.info("new instance created.");
        populateConfigs();
    }

    private void populateConfigs() {
        configList.clear();
        configList.addAll(Config.getAllConfigList());
    }

    public void sendEmail() {
        try {
            log.info("sendEmail called.");
            if (notEmpty(enrollmentId)) {
                Enrollment enrollment = enrollmentResource.getEnrollmentById(enrollmentId);
                emailAsyncBean.sendEmail(enrollment);
                MessageUtil.addInfoMessageWithoutKey("Email has been triggered! This this is an asynchronous process, check the log for any errors.");
            }
        } catch (Exception e) {
            MessageUtil.addErrorMessageWithoutKey("Email Error [" + e.getMessage() + "]");
            log.error("", e);
        }
    }

    public void editConfig(AppConfig appConfig) {
        appConfig.setUpdate(true);
    }

    public void cancelConfig(AppConfig appConfig) {
        try {
            log.info("cancelConfig called.");
            if (notEmpty(appConfig)) {
                AppConfig appConfigDB = configBean.getConfigById(appConfig.getConfigId());
                if(notEmpty(appConfigDB)) {
                    appConfig.setKeyName(appConfigDB.getKeyName());
                    appConfig.setValue(appConfigDB.getValue());
                }
                appConfig.setUpdate(false);
            }
        } catch (Exception e) {
            MessageUtil.addErrorMessageWithoutKey("Config cancel Error [" + e.getMessage() + "]");
            log.error("", e);
        }
    }

    public void updateConfig(AppConfig appConfig) {
        try {
            log.info("updateConfig called.");
            if (notEmpty(appConfig)) {
                configBean.updateConfig(appConfig);
                appConfig.setUpdate(false);
                List<AppConfig> configList = configBean.getAllConfigList();
                Config.loadProperties(configList);
                populateConfigs();
                MessageUtil.addInfoMessageWithoutKey("Configuration has been updated successfully.");
            }
        } catch (Exception e) {
            MessageUtil.addErrorMessageWithoutKey("Config update Error [" + e.getMessage() + "]");
            log.error("", e);
        }
    }

    public Long getEnrollmentId() {
        return enrollmentId;
    }

    public void setEnrollmentId(Long enrollmentId) {
        this.enrollmentId = enrollmentId;
    }

    public List<AppConfig> getConfigList() {
        return configList;
    }

    public void setConfigList(List<AppConfig> configList) {
        this.configList = configList;
    }
}
