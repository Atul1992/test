package com.wyest.pw.enums;

/**
 * User: Amit
 * Date: 6/22/13
 * Time: 12:48 PM
 */
public enum ContactTypeEnum {
    BILLING ("BI"),
    SERVICE ("SR"),
    LOA ("LA")
    ;

    private String code;

    private ContactTypeEnum(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }
}
