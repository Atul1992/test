package com.wyest.pw.utils;

import com.wyest.pw.info.EnrollmentInfo;
import com.wyest.pw.model.Enrollment;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.Serializable;
import java.io.StringWriter;
import java.util.Properties;

/**
 * User: Amit
 * Date: 9/29/13
 * Time: 10:34 AM
 */
public class VelocityHelper implements Serializable {
    private static Logger log = LoggerFactory.getLogger(VelocityHelper.class);

    public static final String TMPL_BASE_DIR = "/templates/";
    public static final String VELOCITY_PROP_FILE = "velocity.properties";

    private static final VelocityHelper instance = new VelocityHelper();
    private VelocityEngine ve;

    /**
     * Singleton
     */
    private VelocityHelper() {
        init();
    }

    public static VelocityHelper getInstance() {
        return instance;
    }

    private void init() {
        log.info("Initializing the VelocityEngine");
        PropertyFileLoader loader = new PropertyFileLoader();
        Properties props = loader.getProperties(VELOCITY_PROP_FILE);

        ve = new VelocityEngine();
        try {
			ve.init(props);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        log.info("VelocityEngine initialized successfully.");
    }

    public String getEnrollmentTemplate(EnrollmentInfo enrollment) throws Exception {
        return getTemplate(enrollment, "enrollmentTemplate.vm");
    }

    public String getAgentEnrollmentTemplate(EnrollmentInfo enrollment) throws Exception {
        return getTemplate(enrollment, "enrollmentAgentTemplate.vm");
    }

    public String getAdminEnrollmentTemplate(EnrollmentInfo enrollment) throws Exception {
        return getTemplate(enrollment, "enrollmentAdminTemplate.vm");
    }

    private String getTemplate(EnrollmentInfo enrollment, String templateName) throws Exception {
        VelocityContext context = new VelocityContext();
        context.put("enrollment", enrollment);

        return getTemplateAsStr(context, templateName);
    }

    private String getTemplateAsStr(VelocityContext context, String templateName) throws Exception {
        Template template = ve.getTemplate(TMPL_BASE_DIR + templateName);

        StringWriter w = new StringWriter();
        template.merge(context, w);
        w.close();

        return w.toString();
    }
}
