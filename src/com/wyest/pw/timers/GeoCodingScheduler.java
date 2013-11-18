package com.wyest.pw.timers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.annotation.Resource;
import javax.ejb.*;
import javax.inject.Inject;
import java.util.Date;

/**
 * User: Amit
 * Date: 9/28/13
 * Time: 2:47 PM
 */
@Singleton
@Startup
public class GeoCodingScheduler {
    private static Logger log = LoggerFactory.getLogger(GeoCodingScheduler.class);
    private static String GEO_CODING_TIMER = GeoCodingScheduler.class.getName();

    @Resource
    TimerService timerService;

    @Inject
    GeoCodingSchedulerEJB geoCodingSchedulerEJB;

    @PostConstruct
    public void initTimer() {
        log.info(GEO_CODING_TIMER + "-> started and initializing the GeoCoding Process");
        // Scheduled to run every 10 minutes
        Date startTime = new Date();
        ScheduleExpression scheduleExpression =
                new ScheduleExpression().hour("*").minute("*/10").start(startTime);
        timerService.createCalendarTimer(scheduleExpression, new TimerConfig(GEO_CODING_TIMER, false));
    }

    @Timeout
    public void startProcess(Timer timer) {
        log.info("Started Timer [" + timer.getInfo() + "]");
        geoCodingSchedulerEJB.doPeriodicCheck();
        log.info("Timer [" + timer.getInfo() + "] finished");
    }

    private void cancelTimer() {
        log.info(GEO_CODING_TIMER + "->cancelTimer called");
        if (timerService.getTimers() != null) {
            for (Timer timer : timerService.getTimers()) {
                if(GEO_CODING_TIMER.equals(timer.getInfo())) {
                    log.info("Cancelling Timer [" + timer.getInfo() + "]");
                    timer.cancel();
                }
            }
        }
        log.info(GEO_CODING_TIMER + "->cancelTimer completed");
    }

    @PreDestroy
    public void destroy() {
        log.info(GEO_CODING_TIMER + "->destroy() called");
        cancelTimer();
        log.info(GEO_CODING_TIMER + "->destroy() completed");
    }
}
