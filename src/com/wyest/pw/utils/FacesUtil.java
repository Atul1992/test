package com.wyest.pw.utils;

import javax.el.ExpressionFactory;
import javax.el.MethodExpression;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.event.MethodExpressionActionListener;
import java.io.IOException;

/**
 * User: Amit
 * Date: 6/22/13
 * Time: 10:55 AM
 */
public class FacesUtil {
    public static FacesContext getFacesContext() {
        return FacesContext.getCurrentInstance();
    }

    public static ExternalContext getExternalContext() {
        return getFacesContext().getExternalContext();
    }

    public static void putInSession(String key, Object obj) {
        getExternalContext().getSessionMap().put(key, obj);
    }

    public static Object getFromSession(String key) {
        return getExternalContext().getSessionMap().get(key);
    }

    public static void redirect(String url) throws IOException {
        getExternalContext().redirect(url);
    }

    public static MethodExpression createMethodExpression(String valueExpression, Class<?> expectedReturnType,
                                                          Class<?>[] expectedParamTypes) {
        FacesContext fc = getFacesContext();
        ExpressionFactory factory = fc.getApplication().getExpressionFactory();

        return factory.createMethodExpression(fc.getELContext(), valueExpression, expectedReturnType, expectedParamTypes);
    }

    public static MethodExpressionActionListener createMethodActionListener(String valueExpression, Class<?> expectedReturnType,
                                                                            Class<?>[] expectedParamTypes) {
        return new MethodExpressionActionListener(createMethodExpression(valueExpression, expectedReturnType,
                expectedParamTypes));
    }

}
