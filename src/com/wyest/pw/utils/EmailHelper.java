package com.wyest.pw.utils;

import com.wyest.pw.info.EnrollmentInfo;
import com.wyest.pw.model.Contact;
import com.wyest.pw.model.Enrollment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.mail.internet.InternetAddress;
import java.util.*;

import static com.wyest.pw.utils.PWUtils.*;

/**
 * User: Amit
 * Date: 9/29/13
 * Time: 10:49 AM
 */
public class EmailHelper {
    private static Logger log = LoggerFactory.getLogger(EmailHelper.class);

    public static void sendEnrollmentEmail(Enrollment enrollment, List<Contact> adminList) throws Exception {
        if(enrollment == null || isEmpty(enrollment.getEnrollmentId())) {
            throw new Exception("Enrollment can't be found .Details [" + enrollment + "]");
        }

        Contact contact = null;
        if(enrollment.isResidential()) {
            contact = enrollment.getResidentialAccount().getBillingContact();
        } else if (enrollment.isCommercial()) {
            contact = enrollment.getBusinessAccount().getBillingContact();
        }

        if(contact == null) {
            throw new Exception("Contact can't be found for Enrollment with ID [" + enrollment.getEnrollmentId());
        }
        if(contact.getEmail() == null) {
            throw new Exception("Contact Email can't be found. Email [" + contact.getEmail());
        }

        // Decide to whom email has to be sent
        boolean sendEmailToCustomer = false;
        boolean sendEmailToAgent = false;
        boolean sendEmailToAdmin = false;

        if(enrollment.isResidential()) {
            sendEmailToCustomer = true;
            sendEmailToAdmin = true;
            if(notEmpty(enrollment.getAgentEmail())) {
                sendEmailToAgent = true;
            }
        } else if(enrollment.isCommercial()) {
            if(enrollment.isMatrix()) {
                sendEmailToCustomer = true;
                sendEmailToAdmin = true;
                if(notEmpty(enrollment.getAgentEmail())) {
                    sendEmailToAgent = true;
                }
            } else if (enrollment.isCustomized()) {
                sendEmailToAdmin = true;
                if(notEmpty(enrollment.getAgentEmail())) {
                    sendEmailToAgent = true;
                }
            }
        }

        EnrollmentInfo enrollmentInfo = getEnrollmentInfo(enrollment, contact);

        if(sendEmailToCustomer) {
            sendEmailToCustomer(enrollment, contact, enrollmentInfo);
        }
        if(sendEmailToAgent) {
            sendEmailToAgent(enrollment, enrollmentInfo);
        }
        if(sendEmailToAdmin) {
            sendEmailToAdmin(enrollment, enrollmentInfo, adminList);
        }
    }

    private static void sendEmailToCustomer(Enrollment enrollment, Contact contact,
                                            EnrollmentInfo enrollmentInfo) throws Exception {
        String subject = generateEmailSubject(enrollment, false);
        log.debug("Email Subject [" + subject + "]");

        Set<String> toEmails = new HashSet<>();

        // Check if override flag is set
        String emailOverride = Config.getProperty(AppConstants.EMAIL_OVERRIDE);
        if(AppConstants.YES.equalsIgnoreCase(emailOverride)) {
            enrollmentInfo.setEmailOverridden(true);
            String overrideEmailsTo = Config.getProperty(AppConstants.EMAIL_OVERRIDE_TO);
            enrollmentInfo.setOverriddenReceiver(overrideEmailsTo);
            enrollmentInfo.setOriginalReceivers(contact.getEmail());
            toEmails.addAll(PWUtils.breakString(overrideEmailsTo, ",;"));
        } else {
            toEmails.add(contact.getEmail());
        }

        String emailContent = VelocityHelper.getInstance().getEnrollmentTemplate(enrollmentInfo);
        log.debug("Email Content:");
        log.debug(emailContent);
        if(emailContent == null) {
            throw new Exception("Email content is not generated via Velocity so unable to send email.");
        }

        sendEmail(toEmails, subject, emailContent);
    }

    private static void sendEmailToAgent(Enrollment enrollment, EnrollmentInfo enrollmentInfo) throws Exception {
        String subject = generateEmailSubject(enrollment, true);
        log.debug("Email Subject [" + subject + "]");

        Set<String> toEmails = new HashSet<>();

        // Check if override flag is set
        String emailOverride = Config.getProperty(AppConstants.EMAIL_OVERRIDE);
        if(AppConstants.YES.equalsIgnoreCase(emailOverride)) {
            enrollmentInfo.setEmailOverridden(true);
            String overrideEmailsTo = Config.getProperty(AppConstants.EMAIL_OVERRIDE_TO);
            enrollmentInfo.setOverriddenReceiver(overrideEmailsTo);
            enrollmentInfo.setOriginalReceivers(enrollment.getAgentEmail());
            toEmails.addAll(PWUtils.breakString(overrideEmailsTo, ",;"));
        } else {
            toEmails.add(enrollment.getAgentEmail());
        }

        String emailContent = VelocityHelper.getInstance().getAgentEnrollmentTemplate(enrollmentInfo);
        log.debug("Email Content:");
        log.debug(emailContent);
        if(emailContent == null) {
            throw new Exception("Email content is not generated via Velocity so unable to send email.");
        }

        sendEmail(toEmails, subject, emailContent);
    }

    private static void sendEmailToAdmin(Enrollment enrollment, EnrollmentInfo enrollmentInfo, List<Contact> adminList) throws Exception {
        String subject = generateEmailSubject(enrollment, false);
        log.debug("Email Subject [" + subject + "]");

        Set<String> toEmails = new HashSet<>();

        // Check if override flag is set

        List<String> adminEmailsList = new ArrayList<>();
        for(Contact contact : adminList) {
            if(notEmpty(contact) && notEmpty(contact.getEmail())) {
                adminEmailsList.add(contact.getEmail());
            }
        }

        String adminEmails = adminEmailsList.toString();
        String emailOverride = Config.getProperty(AppConstants.EMAIL_OVERRIDE);
        if(AppConstants.YES.equalsIgnoreCase(emailOverride)) {
            enrollmentInfo.setEmailOverridden(true);
            String overrideEmailsTo = Config.getProperty(AppConstants.EMAIL_OVERRIDE_TO);
            enrollmentInfo.setOverriddenReceiver(overrideEmailsTo);
            enrollmentInfo.setOriginalReceivers(adminEmails);
            toEmails.addAll(PWUtils.breakString(overrideEmailsTo, ",;"));
        } else {
            if(isEmpty(adminEmailsList)) {
                log.info("Emails can't be send to admin as there is no Admin Contact found in the system");
                return;
            }
            toEmails.addAll(new HashSet<>(adminEmailsList));
        }

        String emailContent = VelocityHelper.getInstance().getAdminEnrollmentTemplate(enrollmentInfo);
        log.debug("Email Content:");
        log.debug(emailContent);
        if(emailContent == null) {
            throw new Exception("Email content is not generated via Velocity so unable to send email.");
        }

        sendEmail(toEmails, subject, emailContent);
    }

    private static String generateEmailSubject(Enrollment enrollment, boolean isAgent) {
        StringBuilder subject = new StringBuilder();
        subject.append(Config.getProperty(AppConstants.COMPANY_NAME)).append(" ");
        if(isAgent && notEmpty(enrollment.getAgentEmail())) {
            subject.append("Agent ");
        }
        subject.append("Enrollment - ");
        if(enrollment.isResidential()) {
            subject.append("Residential");
        } else if (enrollment.isCommercial()) {
            subject.append("Commercial");
            if(enrollment.isMatrix()) {
                subject.append(" Matrix");
            } else if (enrollment.isCustomized()) {
                subject.append(" Customized");
            }
        }

        return subject.toString();
    }

    private static EnrollmentInfo getEnrollmentInfo(Enrollment enrollment, Contact contact) {
        EnrollmentInfo enrollmentInfo = new EnrollmentInfo();
        enrollmentInfo.setEnrollmentId(getPaddedEnrollmentId(enrollment.getEnrollmentId(), "0", 5));
        enrollmentInfo.setEmail(contact.getEmail());
        enrollmentInfo.setPhoneNo(contact.getPhoneNo());
        enrollmentInfo.setAddress(contact.getFullAddress());
        if(notEmpty(enrollment.getAgentEmail())) {
            enrollmentInfo.setAgentEmail(enrollment.getAgentEmail());
            enrollmentInfo.setUserAgent(true);
        }
        enrollmentInfo.setServiceStartDateRequested(convertDateToStr(enrollment.getServiceStartDateRequested()));
        enrollmentInfo.setResidential(enrollment.isResidential());
        enrollmentInfo.setCommercial(enrollment.isCommercial());
        enrollmentInfo.setServerURL(Config.getProperty(AppConstants.SERVER_URL));
        if(enrollment.isResidential()) {
            enrollmentInfo.setCustomerOrCompanyName(enrollment.getResidentialAccount().getFullName());
        } else if (enrollment.isCommercial()) {
            enrollmentInfo.setCustomerOrCompanyName(enrollment.getBusinessAccount().getCompanyName());
        }

        return enrollmentInfo;
    }

    public static void sendEmail(Collection<String> emailsToList, String subject, String message) throws Exception {
        // From address
        String fromEmail = getFromEmail();
        InternetAddress fromAddress = new InternetAddress(fromEmail);
        // To address
        InternetAddress[] toAddress = getToAddress(emailsToList);

        new MailSender().sendEmail(fromAddress, toAddress, null, subject, message);
    }

    private static String getFromEmail() {
        return Config.getProperty(AppConstants.EMAIL_FROM);
    }

    private static InternetAddress[] getToAddress(Collection<String> emailsToList) throws Exception {
        InternetAddress[] toAddress = new InternetAddress[emailsToList.size()];
        int i = 0;
        for (String email : emailsToList) {
            toAddress[i++] = new InternetAddress(email);
        }

        return toAddress;
    }
}
