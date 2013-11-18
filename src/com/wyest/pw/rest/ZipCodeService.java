package com.wyest.pw.rest;

import com.wyest.pw.model.ZipCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ejb.Stateless;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

/**
 * User: Amit
 * Date: 5/31/13
 * Time: 6:04 PM
 */
@Path("/zipCodes")
@Stateless
@Produces({MediaType.APPLICATION_JSON})
public class ZipCodeService extends BaseEntityService<ZipCode> {
    private static Logger log = LoggerFactory.getLogger(ZipCodeService.class);

    /**
     * Default constructor
     */
    public ZipCodeService() {
        super(ZipCode.class);
    }

    @GET
    @Path("/all")
    public List<ZipCode> getListOfZipCodes() {
        log.info("ZipCodeResource->listZipCodes() called");
        return entityManager.createNamedQuery("ZipCode.findAllZipCodes", ZipCode.class).getResultList();
    }

    @GET
    @Path("/zipCode")
    public ZipCode getZipCode(@QueryParam("id") Long zipCodeId) {
        log.info("ZipCodeResource->getZipCode() called. EdcId [" + zipCodeId + "]");
        if(zipCodeId < 0) {
            throw new WebApplicationException(Response.Status.BAD_REQUEST);
        }

        ZipCode zipCode = entityManager.find(ZipCode.class, zipCodeId);
        if(zipCode == null) {
            throw new WebApplicationException(Response.Status.NOT_FOUND);
        }

        return zipCode;
    }
}
