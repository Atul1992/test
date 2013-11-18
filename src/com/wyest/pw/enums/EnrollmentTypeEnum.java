package com.wyest.pw.enums;

/**
 * User: Amit
 * Date: 6/22/13
 * Time: 12:48 PM
 */
public enum EnrollmentTypeEnum {
    MATRIX ("M"),
    CUSTOMIZED ("C"),
    ;

    private String code;

    private EnrollmentTypeEnum(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }
}
