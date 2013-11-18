package com.wyest.pw.enums;

/**
 * User: Amit
 * Date: 6/22/13
 * Time: 3:10 PM
 *
 * The value of U indicates a End User or account, Value of S means system admin and value of A mean Agent or broker
 */
public enum LoginTypeEnum {
    END_USER ("U"),
    SYSTEM_ADMIN ("S"),
    AGENT_BROKER ("A")
    ;

    private String code;

    private LoginTypeEnum(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }
}
