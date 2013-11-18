package com.wyest.pw.ejb;

import com.wyest.pw.model.AppConfig;
import com.wyest.pw.utils.Config;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.annotation.Resource;
import javax.ejb.*;
import javax.inject.Inject;
import java.util.Date;
import java.util.List;

/**
 * User: Amit
 * Date: 9/28/13
 * Time: 2:47 PM
 */
@Singleton
@Startup
public class AppConfigLoader {
    private static Logger log = LoggerFactory.getLogger(AppConfigLoader.class);
    private static String APP_CONFIG_TIMER = AppConfigLoader.class.getName();

    @Inject
    ConfigBean configBean;

    @Resource
    TimerService timerService;

    @PostConstruct
    public void loadConfig() {
        log.info(APP_CONFIG_TIMER + "->loadConfig() called");
        loadProperties();
        // Also schedule the timer so that propreties are refreshed at configured duration( currently every 2 minutes)
        Date startTime = new Date();
        ScheduleExpression scheduleExpression =
                new ScheduleExpression().hour("*").minute("*/2").start(startTime);
        timerService.createCalendarTimer(scheduleExpression, new TimerConfig(APP_CONFIG_TIMER, false));
        log.info(APP_CONFIG_TIMER + "->loadConfig() completed");
    }

    private void loadProperties() {
        List<AppConfig> configList = configBean.getAllConfigList();
        Config.loadProperties(configList);
    }

    @Timeout
    public void startProcess(Timer timer) {
        log.info("Started Timer [" + timer.getInfo() + "]");
        loadProperties();
        log.info("Timer [" + timer.getInfo() + "] finished");
    }

    private void cancelTimer() {
        log.info(APP_CONFIG_TIMER + "->cancelTimer called");
        if (timerService.getTimers() != null) {
            for (Timer timer : timerService.getTimers()) {
                if(APP_CONFIG_TIMER.equals(timer.getInfo())) {
                    log.info("Cancelling Timer [" + timer.getInfo() + "]");
                    timer.cancel();
                }
            }
        }
        log.info(APP_CONFIG_TIMER + "->cancelTimer completed");
    }

    @PreDestroy
    public void destroy() {
        log.info(APP_CONFIG_TIMER + "->destroy() called");
        cancelTimer();
        log.info(APP_CONFIG_TIMER + "->destroy() completed");
    }
}
