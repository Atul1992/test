package com.wyest.pw.enums;

/**
 * User: Amit
 * Date: 9/7/13
 * Time: 1:42 PM
 */
public enum CustomerTypeEnum {
    RESIDENTIAL ("R"),
    COMMERCIAL ("B")
    ;

    private String code;

    private CustomerTypeEnum(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }
}
