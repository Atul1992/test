package com.wyest.pw.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.InputStream;
import java.util.Properties;

/**
 * User: Amit
 * Date: 9/29/13
 * Time: 11:02 AM
 */
public class PropertyFileLoader {
    private static Logger log = LoggerFactory.getLogger(PropertyFileLoader.class);

    public synchronized Properties getProperties(String fileName) {
        Properties properties = new Properties();
        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream(fileName)) {
            properties.load(inputStream);
        } catch (Exception e) {
            log.error("Error loading file [" + fileName + "]", e);
        }

        return properties;
    }
}
