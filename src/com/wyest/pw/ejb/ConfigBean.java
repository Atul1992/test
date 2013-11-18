package com.wyest.pw.ejb;

import com.wyest.pw.model.AppConfig;
import com.wyest.pw.utils.PWUtils;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.Date;
import java.util.List;

/**
 * User: Amit
 * Date: 10/6/13
 * Time: 12:27 PM
 */
@Stateless
public class ConfigBean {
    @PersistenceContext(unitName = "PiggyWattsPU")
    protected EntityManager em;

    public List<AppConfig> getAllConfigList() {
        return em.createQuery("select e from AppConfig e " +
                "order by e.configId", AppConfig.class).getResultList();
    }

    public void updateConfig(AppConfig appConfig) {
        if(PWUtils.notEmpty(appConfig) && PWUtils.notEmpty(appConfig.getConfigId())) {
            AppConfig appConfigDB = em.find(AppConfig.class, appConfig.getConfigId());
            if(PWUtils.notEmpty(appConfigDB)) {
                appConfigDB.setValue(appConfig.getValue());
                appConfigDB.setUpdatedOn(new Date());
                em.merge(appConfigDB);
                em.flush();
            }
        }
    }

    public AppConfig getConfigById(Long configId) {
        return em.find(AppConfig.class, configId);
    }
}
