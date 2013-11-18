package com.wyest.pw.jsf;

import com.wyest.pw.info.ContactInfo;
import com.wyest.pw.model.*;
import com.wyest.pw.rest.EnrollmentService;
import com.wyest.pw.utils.FacesUtil;
import com.wyest.pw.utils.MessageUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.inject.Inject;
import java.util.ArrayList;
import java.util.List;

import static com.wyest.pw.utils.PWUtils.notEmpty;

/**
 * User: Amit
 * Date: 7/13/13
 * Time: 11:18 PM
 */
@ManagedBean
@ViewScoped
public class AgentController {
    private static Logger log = LoggerFactory.getLogger(AgentController.class);
    private Contact agentContact;

    @Inject
    private EnrollmentService enrollmentResource;

    private List<EnrollmentStatus> statusList = new ArrayList<>();
    private List<Enrollment> searchResults = new ArrayList<>();
    private Enrollment searchRequest;

    public AgentController() {
        log.info("new instance created.");
    }

    @PostConstruct
    public void init() {
        log.info("init called.");
        ApplicationController applicationController = (ApplicationController) FacesUtil.getFromSession("applicationController");
        if (notEmpty(applicationController)) {
            ContactInfo contact = applicationController.getContact();
            if (contact != null) {
                log.info("Found Agent contact [" + contact.getContactId() + "] in session");
                agentContact = enrollmentResource.getContactById(contact.getContactId());
                if (notEmpty(agentContact)) {
                    populateStatusList();
                    resetAction();
                }
            }
        }
    }

    private void populateStatusList() {
        try {
            statusList = enrollmentResource.getEnrollmentStatusList();
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public void searchEnrollments() {
        try {
            searchResults = enrollmentResource.searchEnrollments(searchRequest);
        } catch (Exception e) {
            log.error("", e);
            MessageUtil.addErrorMessageWithoutKey(e.getMessage());
        }
    }

    public void resetAction() {
        searchResults.clear();
        searchRequest = new Enrollment();
        searchRequest.setStatus(new EnrollmentStatus());
        searchRequest.setResidentialAccount(new ResidentialAccount());
        searchRequest.setBusinessAccount(new BusinessAccount());
        searchRequest.setAgentEmail(agentContact.getEmail());
        searchEnrollments();
    }

    public Contact getAgentContact() {
        return agentContact;
    }

    public void setAgentContact(Contact agentContact) {
        this.agentContact = agentContact;
    }

    public List<Enrollment> getSearchResults() {
        return searchResults;
    }

    public void setSearchResults(List<Enrollment> searchResults) {
        this.searchResults = searchResults;
    }

    public Enrollment getSearchRequest() {
        return searchRequest;
    }

    public void setSearchRequest(Enrollment searchRequest) {
        this.searchRequest = searchRequest;
    }

    public List<EnrollmentStatus> getStatusList() {
        return statusList;
    }

    public void setStatusList(List<EnrollmentStatus> statusList) {
        this.statusList = statusList;
    }
}
