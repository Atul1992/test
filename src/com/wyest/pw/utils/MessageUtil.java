package com.wyest.pw.utils;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import java.text.MessageFormat;
import java.util.ResourceBundle;

/**
 * User: Amit
 * Date: 6/22/13
 * Time: 10:55 AM
 */
public class MessageUtil {

	public static void addInfoMessage(String str) {
		FacesContext context = FacesContext.getCurrentInstance();
		ResourceBundle bundle = context.getApplication().getResourceBundle(context, "msg");
		String message = bundle.getString(str);
		context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, message, ""));
	}

	public static void addInfoMessage(String summary, String detail) {
		FacesContext context = FacesContext.getCurrentInstance();
		ResourceBundle bundle = context.getApplication().getResourceBundle(context, "msg");
		String message = bundle.getString(summary);
		context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, message, detail));
	}

    public static void addInfoMessage(String str, Object... args) {
        FacesContext context = FacesContext.getCurrentInstance();
        ResourceBundle bundle = context.getApplication().getResourceBundle(context, "msg");
        String message = bundle.getString(str);
        if (args != null) {
            message = MessageFormat.format(message, args);
        }
        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, message, ""));
    }

    public static void addInfoMessageWithoutKey(String summary) {
        FacesContext context = FacesContext.getCurrentInstance();
        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_INFO, summary, null));
    }

    public static void addErrorMessageWithoutKey(String summary) {
        FacesContext context = FacesContext.getCurrentInstance();
        context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, summary, null));
    }
}
