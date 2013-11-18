package com.wyest.pw.ejb;

import com.wyest.pw.enums.ContactTypeEnum;
import com.wyest.pw.enums.LoginTypeEnum;
import com.wyest.pw.model.Contact;
import com.wyest.pw.model.Enrollment;
import com.wyest.pw.utils.AppConstants;
import com.wyest.pw.utils.Config;
import com.wyest.pw.utils.EmailHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ejb.Asynchronous;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.Collections;
import java.util.List;

/**
 * User: Amit
 * Date: 9/30/13
 * Time: 6:41 PM
 */
@Stateless
public class EmailAsyncBean {
    private static Logger log = LoggerFactory.getLogger(EmailAsyncBean.class);

    @PersistenceContext(unitName = "PiggyWattsPU")
    protected EntityManager em;

    @Asynchronous
    @TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
    public void sendEmail(Enrollment enrollment) {
        log.info("sendEmail called. Enrollment [" + enrollment + "]");
        String stopEmails = Config.getProperty(AppConstants.STOP_EMAILS);
        if(AppConstants.YES.equalsIgnoreCase(stopEmails)) {
            log.info("Email has been set to be stopped in the app_config table. " +
                    "Update the value of 'email.stop' property to 'Y' if you want to start sending emails.");
            return;
        }

        try {
            // Find all the admin emails
            List<Contact> adminList = em.createQuery("select e from Contact e " +
                    "where upper(e.loginType) = :loginType", Contact.class)
                    .setParameter("loginType", LoginTypeEnum.SYSTEM_ADMIN.getCode()).getResultList();
            EmailHelper.sendEnrollmentEmail(enrollment, adminList);
        } catch (Exception e) {
            log.error("Error during email sending.", e);
        }

        log.info("sendEmail completed. Enrollment [" + enrollment + "]");
    }
}
