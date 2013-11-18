package com.wyest.pw.utils;

import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Collections;
import java.util.Date;
import java.util.HashSet;

/**
 * User: Amit
 * Date: 6/22/13
 * Time: 10:50 AM
 */
public class PWUtils {
    public static boolean isEmpty(Object obj) {
        if (obj == null) {
            return true;
        } else {
            if (obj instanceof String) {
                String str = (String) obj;
                return str.trim().length() == 0;
            } else if (obj instanceof Integer) {
                Integer intValue = (Integer) obj;
                return intValue.equals(0);
            } else if (obj instanceof Long) {
                Long longValue = (Long) obj;
                return longValue.equals(0L);
            } else if (obj instanceof Collection) {
                Collection collection = (Collection) obj;
                return collection.isEmpty();
            }
        }

        return false;
    }

    public static boolean notEmpty(Object obj) {
        return !isEmpty(obj);
    }

    public static boolean convertYorNToBoolean(String yesOrNo) {
        return "Y".equalsIgnoreCase(yesOrNo);
    }

    public static String convertBooleanToYorN(boolean value) {
        return value ? "Y" : "N";
    }

    public static Double calculateSavingsPercentage(Double currentRate, Double planRate) {
        return ((currentRate - planRate) * 100) / currentRate;
    }

    public static String convertDateToStr(Date d) {
        if(d == null) return "";

        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
        return sdf.format(d);
    }

    public static Collection<String> breakString(String strToBreak, String delimiter) {
        Collection<String> stringSet = new HashSet<>();
        if(notEmpty(strToBreak) && notEmpty(delimiter)) {
            String[] splits = strToBreak.split(delimiter);
            Collections.addAll(stringSet, splits);
        }

        return stringSet;
    }

    public static String getPaddedEnrollmentId(Long enrollmentId, String charToPad, int totalLength) {
        String paddedId = "";

        if(enrollmentId != null) {
            paddedId = String.valueOf(enrollmentId);
            int remainingLength = totalLength - paddedId.length();
            for(int i = 0; i < remainingLength; i++) {
                paddedId = charToPad + paddedId;
            }
        }

        return paddedId;
    }
}
