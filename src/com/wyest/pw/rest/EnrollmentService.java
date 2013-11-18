package com.wyest.pw.rest;

import com.wyest.pw.ejb.EmailAsyncBean;
import com.wyest.pw.enums.LoginTypeEnum;
import com.wyest.pw.info.ContactInfo;
import com.wyest.pw.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ejb.Stateless;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.Date;
import java.util.List;

import static com.wyest.pw.utils.PWUtils.isEmpty;
import static com.wyest.pw.utils.PWUtils.notEmpty;

/**
 * User: Amit
 * Date:08/18/13
 * Time: 11:42 AM
 */
@Path("/enroll")
@Stateless
public class EnrollmentService extends BaseEntityService<Enrollment> {
    private static Logger log = LoggerFactory.getLogger(EnrollmentService.class);

    @Inject
    EmailAsyncBean emailAsyncBean;

    /**
     * Default constructor
     */
    public EnrollmentService() {
        super(Enrollment.class);
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/customer")
    public Enrollment createEnrollment(Enrollment enrollment) {
        log.info("createEnrollment called. Enrollment [" + enrollment + "]");
        if(isEmpty(enrollment)) {
            throw new WebApplicationException(Response.Status.BAD_REQUEST);
        }

        //TODO: verify all requried params here

        // this verify for duplicate email addresses
        Contact billingContact = null;
        if(notEmpty(enrollment.getResidentialAccount())) {
            billingContact = enrollment.getResidentialAccount().getBillingContact();
        } else if (notEmpty(enrollment.getBusinessAccount())) {
            billingContact = enrollment.getBusinessAccount().getBillingContact();
        }
        if(billingContact != null && notEmpty(billingContact.getEmail())) {
            List<Contact> contact = entityManager.createQuery("select e from Contact e " +
                    "where e.email = :email", Contact.class)
                    .setParameter("email", billingContact.getEmail())
                    .getResultList();
            if(contact.size() > 0) {
                throw new WebApplicationException(Response.Status.CONFLICT);
            }
        }

        if(notEmpty(enrollment.getBusinessAccount()) && notEmpty(enrollment.getBusinessAccount().getServiceAddresses())) {
            for(BusinessAccountServiceAddress serviceAddress : enrollment.getBusinessAccount().getServiceAddresses()) {
                serviceAddress.setBusinessAccount(enrollment.getBusinessAccount());
            }
        }

        enrollment.setEnrollmentDate(new Date());
        entityManager.persist(enrollment);
        entityManager.flush();

        emailAsyncBean.sendEmail(enrollment);

        log.info("createEnrollment completed. Enrollment [" + enrollment + "]");
        return enrollment;
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/agent")
    public ContactInfo createAgent(Contact contact) {
        log.info("createAgentcalled. Contact [" + contact + "]");
        if(isEmpty(contact)) {
            throw new WebApplicationException(Response.Status.BAD_REQUEST);
        }

        // this verify for duplicate email addresses
        List<Contact> contactList = entityManager.createQuery("select e from Contact e " +
                "where e.email = :email", Contact.class)
                .setParameter("email", contact.getEmail())
                .getResultList();
        if(contactList.size() > 0) {
            throw new RestServiceException(Response.Status.CONFLICT);
        }

        entityManager.persist(contact);
        entityManager.flush();

        return getContactInfo(contact);
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/customer/enrollment/{enrollmentId}")
    public Enrollment getEnrollmentById(@PathParam("enrollmentId") Long enrollmentId) {
        Enrollment enrollment;

        if(isEmpty(enrollmentId)) {
            throw new WebApplicationException(Response.Status.BAD_REQUEST);
        }

        enrollment = entityManager.find(Enrollment.class, enrollmentId);
        if(notEmpty(enrollment) && notEmpty(enrollment.getBusinessAccount())) {
//            Set<BusinessAccountServiceAddress> serviceAddressSet = enrollment.getBusinessAccount().getServiceAddresses();
//            if(notEmpty(serviceAddressSet)) {
//                for(BusinessAccountServiceAddress serviceAddress : serviceAddressSet) {
//                    enrollment.getBusinessAccount().getServiceAddressList().add(serviceAddress);
//                }
//            }
//            enrollment.getCustomizedQuoteList().addAll(enrollment.getCustomizedQuoteSet());
//            enrollment.getLoadProfileList().addAll(enrollment.getLoadProfileSet());
        }

        return enrollment;
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/customer/get")
    public Enrollment getEnrollmentByContactId(ContactInfo contact) {
        log.info("getEnrollmentByContactId called. Data passed to method call: " + contact + "");

        Enrollment enrollment = null;

        if(isEmpty(contact) && notEmpty(contact.getContactId())) {
            throw new WebApplicationException(Response.Status.BAD_REQUEST);
        }

        List<ResidentialAccount> residentialAccountList = entityManager.createQuery("select e from ResidentialAccount e " +
                "where e.billingContact.contactId = :contactId", ResidentialAccount.class)
                .setParameter("contactId", contact.getContactId()).getResultList();
        if(residentialAccountList.size() > 0) {
            List<Enrollment> enrollmentList = entityManager.createQuery("select e from Enrollment e " +
                    "where e.residentialAccount.residentialAccountId = :id", Enrollment.class)
                    .setParameter("id", residentialAccountList.get(0).getResidentialAccountId()).getResultList();
            if(enrollmentList.size() > 0) {
                enrollment = enrollmentList.get(0);
            }
        } else {
            List<BusinessAccount> businessAccountList = entityManager.createQuery("select e from BusinessAccount e " +
                    "where e.billingContact.contactId = :contactId", BusinessAccount.class)
                    .setParameter("contactId", contact.getContactId()).getResultList();
            if(businessAccountList.size() > 0) {
                List<Enrollment> enrollmentList = entityManager.createQuery("select e from Enrollment e " +
                        "where e.businessAccount.businessAccountId = :id", Enrollment.class)
                        .setParameter("id", businessAccountList.get(0).getBusinessAccountId()).getResultList();
                if(enrollmentList.size() > 0) {
                    enrollment = enrollmentList.get(0);
                }
            }
        }

        return enrollment;
    }

    @Path("/enduser")
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public Long validateEnrollment(@QueryParam("email") String email, @QueryParam("pwd") String password) {
        Long enrollmentId = null;

        if(isEmpty(email) || isEmpty(password)) {
            throw new WebApplicationException(Response.Status.BAD_REQUEST);
        }

        if(notEmpty(email) && notEmpty(password)) {
            List<Contact> contactList = entityManager.createQuery("select e from Contact e " +
                    "where e.email = :email and e.password = :pwd and e.loginType = :loginType", Contact.class)
                    .setParameter("email", email)
                    .setParameter("pwd", password)
                    .setParameter("loginType", LoginTypeEnum.END_USER.getCode())
                    .getResultList();
            if(contactList.isEmpty()) {
                throw new WebApplicationException(Response.Status.UNAUTHORIZED);
            }

            Contact billingContact = contactList.get(0);
            Enrollment enrollment = null;
            List<ResidentialAccount> residentialAccountsList = entityManager.createQuery("select e from ResidentialAccount e " +
                    "where e.billingContact.contactId = :billingContactId", ResidentialAccount.class)
                    .setParameter("billingContactId", billingContact.getContactId())
                    .getResultList();
            if(residentialAccountsList.size() > 0) {
                ResidentialAccount residentialAccount = residentialAccountsList.get(0);
                if(notEmpty(residentialAccount)) {
                    List<Enrollment> enrollmentList = entityManager.createQuery("select e from Enrollment e " +
                            "where e.residentialAccount.residentialAccountId = :accountId", Enrollment.class)
                            .setParameter("accountId", residentialAccount.getResidentialAccountId())
                            .getResultList();
                    enrollment = enrollmentList.get(0);
                }
            } else {
                List<BusinessAccount> businessAccountsList = entityManager.createQuery("select e from BusinessAccount e " +
                        "where e.billingContact.contactId = :billingContactId", BusinessAccount.class)
                        .setParameter("billingContactId", billingContact.getContactId())
                        .getResultList();
                if(businessAccountsList.size() > 0) {
                    BusinessAccount businessAccount = businessAccountsList.get(0);
                    if(notEmpty(businessAccount)) {
                        List<Enrollment> enrollmentList = entityManager.createQuery("select e from Enrollment e " +
                                "where e.businessAccount.businessAccountId = :accountId", Enrollment.class)
                                .setParameter("accountId", businessAccount.getBusinessAccountId())
                                .getResultList();
                        enrollment = enrollmentList.get(0);
                    }
                }
            }
            if(enrollment != null) {
                enrollmentId = enrollment.getEnrollmentId();
            }
        }

        return enrollmentId;
    }


    @POST
    @Produces(MediaType.APPLICATION_JSON)
    @Consumes(MediaType.APPLICATION_JSON)
    @Path("/customer/validate")
    public ContactInfo validateEnrollment(Contact contact) {
        log.info("validateEnrollment called");
        if (isEmpty(contact)) {
            throw new WebApplicationException(Response.Status.BAD_REQUEST);
        }
        log.info("validateEnrollment call params. Email [" + contact.getEmail()
                + "], Password [" + contact.getPassword() + "]");
        if (isEmpty(contact.getEmail()) || isEmpty(contact.getPassword())) {
            throw new WebApplicationException(Response.Status.NOT_ACCEPTABLE);
        }

        List<Contact> contactList = entityManager.createQuery("select e from Contact e " +
                "where e.email = :email and e.password = :password ", Contact.class)
                .setParameter("email", contact.getEmail())
                .setParameter("password", contact.getPassword())
                .getResultList();
        if (contactList.size() == 0) {
            throw new WebApplicationException(Response.Status.UNAUTHORIZED);
        }

        // Make copy of Contact as we don't need to pass all the information
        ContactInfo validatedContact = getContactInfo(contactList.get(0));

        log.info("validateEnrollment call succeed.");

        return validatedContact;
    }

    private ContactInfo getContactInfo(Contact contact) {
        ContactInfo validatedContact = new ContactInfo();
        validatedContact.setContactId(contact.getContactId());
        validatedContact.setEmail(contact.getEmail());
        validatedContact.setLoginType(contact.getLoginType());
        validatedContact.setContactName(contact.getContactName());
        return validatedContact;
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/businessTypes")
    public List<BusinessType> getAllBusinessTypes() {
        return entityManager.createNamedQuery("BusinessType.findAll", BusinessType.class).getResultList();
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/reps")
    public List<Rep> getAllReps() {
        log.info("getListOfReps() called");
        return entityManager.createNamedQuery("Rep.findAllReps", Rep.class).getResultList();
    }

    @GET
    @Path("/getStatusList")
    @Produces(MediaType.APPLICATION_JSON)
    public List<EnrollmentStatus> getEnrollmentStatusList() {
        return entityManager.createNamedQuery("EnrollmentStatus.findAll", EnrollmentStatus.class).getResultList();
    }

    @GET
    @Path("/contact/get/{contactId}")
    public Contact getContactById(@PathParam("contactId") Long contactId) {
        if(isEmpty(contactId)) {
            throw new WebApplicationException(Response.Status.BAD_REQUEST);
        }

        return entityManager.find(Contact.class, contactId);
    }

    @GET
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/search")
    public List<Enrollment> searchEnrollments(Enrollment searchRequest) {
        StringBuilder sql = new StringBuilder("select e from Enrollment e where 1=1\n");
        if(notEmpty(searchRequest)) {
            if(notEmpty(searchRequest.getStatus()) && notEmpty(searchRequest.getStatus().getStatusId())) {
                sql.append("and e.status.statusId = ").append(searchRequest.getStatus().getStatusId());
            }
            if(notEmpty(searchRequest.getEnrollmentType())) {
                sql.append("and e.enrollmentType = '").append(searchRequest.getEnrollmentType()).append("'");
            }
            if(notEmpty(searchRequest.getCustomerType())) {
                sql.append("and e.customerType = '").append(searchRequest.getCustomerType()).append("'");
            }
            if(notEmpty(searchRequest.getAgentEmail())) {
                sql.append("and e.agentEmail = '").append(searchRequest.getAgentEmail()).append("'");
            }
        }

        List<Enrollment> resultList =  entityManager.createQuery(sql.toString(), Enrollment.class).getResultList();
        if(isEmpty(searchRequest.getAgentEmail())) {
            for(Enrollment enrollment : resultList) {
                List<CustomerLoadProfile> loadProfileList =
                        entityManager.createQuery("select e from CustomerLoadProfile e " +
                                "where e.enrollment.enrollmentId = :enrollmentId", CustomerLoadProfile.class)
                                .setParameter("enrollmentId", enrollment.getEnrollmentId()).getResultList();
                enrollment.getLoadProfileList().addAll(loadProfileList);
                List<CustomizedQuote> customizedQuoteList =
                        entityManager.createQuery("select e from CustomizedQuote e " +
                                "where e.enrollment.enrollmentId = :enrollmentId", CustomizedQuote.class)
                                .setParameter("enrollmentId", enrollment.getEnrollmentId()).getResultList();
                enrollment.getCustomizedQuoteList().addAll(customizedQuoteList);
            }
        }

        return resultList;
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/createCustomerLoadProfile")
    public CustomerLoadProfile saveCustomerLoadProfile(CustomerLoadProfile customerLoadProfile) {
        if(notEmpty(customerLoadProfile)) {
            customerLoadProfile.setCreatedOn(new Date());
            entityManager.persist(customerLoadProfile);
            entityManager.flush();
        }

        return customerLoadProfile;
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/createCustomizedQuote")
    public CustomizedQuote saveCustomizedQuote(CustomizedQuote custQuote) {
        if(notEmpty(custQuote)) {
            custQuote.setCreatedOn(new Date());
            entityManager.persist(custQuote);
            entityManager.flush();
        }

        return custQuote;
    }

    public void updateProductOnEnrollment(Enrollment enrollment) {
        if(notEmpty(enrollment)) {
            Enrollment enrollmentDB = entityManager.find(Enrollment.class, enrollment.getEnrollmentId());
            if(notEmpty(enrollmentDB)) {
                enrollmentDB.setProduct(enrollment.getProduct());
                entityManager.merge(enrollmentDB);
                entityManager.flush();
            }
        }
    }
}
