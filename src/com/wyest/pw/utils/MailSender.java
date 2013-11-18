package com.wyest.pw.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import java.util.Date;

import static com.wyest.pw.utils.PWUtils.notEmpty;

/**
 * User: Amit
 * Date: 9/29/13
 * Time: 11:07 AM
 */
public class MailSender {
    private static Logger log = LoggerFactory.getLogger(MailSender.class);

    private static final String mailer = "JavaMailer";
    private static final String MAIL_JNDI = "java:jboss/mail/InnoWatts";

    public void sendEmail(InternetAddress from, InternetAddress[] recTO,
                          InternetAddress[] recCC, String subject, String message) throws MessagingException {
        this.sendEmail(from, recTO, recCC, subject, message, new String[]{}, new String[]{});
    }

    public void sendEmail(InternetAddress from, InternetAddress[] recTO,
                          InternetAddress[] recCC, String subject,
                          String message, String[] fileNames, String[] putFileNames) throws MessagingException {
        try {
            if (recTO == null || recTO.length == 0) {
                throw new MessagingException("Cannot Send Email as no \"TO\" recipient(s) found");
            }

            Context initial = new InitialContext();
            Session session = (Session) initial.lookup(MAIL_JNDI);
            log.debug("Found mail session " + session);

            Message msg = new MimeMessage(session);

            msg.setFrom(from);
            msg.setRecipients(Message.RecipientType.TO, recTO);
            if (notEmpty(recCC)) {
                msg.setRecipients(Message.RecipientType.CC, recCC);
            }
            msg.setSubject(subject);

            msg.setHeader("X-Mailer", mailer);
            msg.setSentDate(new Date(System.currentTimeMillis()));

            if (fileNames != null && fileNames.length > 0) {
                Multipart mp = new MimeMultipart();
                MimeBodyPart mbpMessage = new MimeBodyPart();
                mbpMessage.setDataHandler(new DataHandler(message, "text/html"));
                mp.addBodyPart(mbpMessage);
                for (int i = 0; i < fileNames.length; i++) {
                    // mbpMessage.setText(message);
                    String fileName = fileNames[i];
                    String putFileName = putFileNames[i];
                    if (fileName != null && !fileName.trim().equals("")) {
                        MimeBodyPart mbpFile = new MimeBodyPart();
                        // attach the file to the message
                        FileDataSource fds = new FileDataSource(fileName);
                        mbpFile.setDataHandler(new DataHandler(fds));
                        if ((putFileName != null) && (!putFileName.trim().equals(""))) {
                            mbpFile.setFileName(putFileName);
                        } else {
                            mbpFile.setFileName(getFileName(fileName));
                        }
                        mp.addBodyPart(mbpFile);
                    }
                }

                msg.setContent(mp);
            } else {
                msg.setDataHandler(new DataHandler(message, "text/html"));
            }

            try {
                Transport.send(msg);
            } catch (SendFailedException e) {
                try {
                    Transport.send(msg, e.getValidUnsentAddresses());
                } catch (SendFailedException e2) {
                    log.error("There was an error trying to send email in the second block:", e);
                }
                log.error("The following was the send mail error:", e);
            }

            log.debug("Mail sent");
        } catch (NamingException e) {
            if (log.isDebugEnabled())
                log.error("", e);
            log.error("The naming context was not found:" + e.getMessage());
            throw new MessagingException("The naming context was not found:" + e.getMessage());
        }
    }

    private String getFileName(String fileName) {
        String fn;
        int indx = fileName.indexOf("/");
        int indx2 = fileName.indexOf("\\");
        if (indx > -1) {
            fn = fileName.substring(indx + 1, fileName.length());
            indx = fn.indexOf("/");
            while (indx > -1) {
                fn = fn.substring(indx + 1, fn.length());
                indx = fn.indexOf("/");
            }
        } else if (indx2 > -1) {
            fn = fileName.substring(indx + 1, fileName.length());
            indx = fn.indexOf("\\");
            while (indx > -1) {
                fn = fn.substring(indx + 1, fn.length());
                indx = fn.indexOf("\\");
            }
        } else {
            fn = fileName;
        }
        return fn;
    }
}
