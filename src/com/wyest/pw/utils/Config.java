package com.wyest.pw.utils;

import com.wyest.pw.model.AppConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * User: Amit
 * Date: 10/5/13
 * Time: 3:28 PM
 */
public class Config implements Serializable {
    private static Logger log = LoggerFactory.getLogger(Config.class);

    private static Map<String, String> configMap = new HashMap<>();
    private static List<AppConfig> allConfigList = new ArrayList<>();

    // No constructor allowed
    private Config() {}

    public static String getProperty(String propertyName) {
        return configMap.get(propertyName);
    }

    public static void loadProperties(List<AppConfig> configList) {
        log.info("Config->loadProperties() started");
        configMap.clear();
        allConfigList.clear();
        allConfigList.addAll(configList);
        for(AppConfig appConfig : configList) {
            configMap.put(appConfig.getKeyName(), appConfig.getValue());
        }
        printProperties(configList);
        log.info("Config->loadProperties() completed");
    }

    public static void printProperties(List<AppConfig> configList) {
        log.info("Total Config Items [" + configMap.size() + "]");
        for(AppConfig config : configList) {
            log.info(config.toString());
        }
    }

    public static Map<String, String> getConfigMap() {
        return configMap;
    }

    public static List<AppConfig> getAllConfigList() {
        return allConfigList;
    }
}
