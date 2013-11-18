package com.wyest.pw.enums;

/**
 * User: Amit
 * Date: 6/22/13
 * Time: 10:30 AM
 */
public enum EnrollmentStatusEnum {
    OPEN (1L),
    PENDING (2L),
    PROCESSING (3L),
    COMPLETED (4L)
    ;

    Long id;
    private EnrollmentStatusEnum(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }
}
