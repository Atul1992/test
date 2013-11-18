package com.wyest.pw.rest;

import com.wyest.pw.model.DeRegulatedZone;
import com.wyest.pw.model.EdcTdsp;
import com.wyest.pw.model.ZipCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ejb.Stateless;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * User: Amit
 * Date: 8/10/13
 * Time: 6:11 PM
 */
@Path("/tdsp")
@Stateless
public class TdspService extends BaseEntityService<EdcTdsp> {
    private static Logger log = LoggerFactory.getLogger(TdspService.class);

    @Context
    UriInfo uriInfo;

    /**
     * Default constructor
     */
    public TdspService() {
        super(EdcTdsp.class);
    }

    @GET
    @Path("/zip/{zipCode}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<EdcTdsp> getTdspByZip(@PathParam("zipCode") String zipCode) {
        log.info("TdspService->getTdspByZip() called. ZipCode [" + zipCode + "]");
        List<EdcTdsp> edcTdspList = new ArrayList<>();

        List<DeRegulatedZone> zoneList = entityManager.createQuery("select distinct e.zone from ZipCode e " +
                "where e.zipCode = :zipCode", DeRegulatedZone.class).setParameter("zipCode", zipCode)
                .getResultList();
        if (!zoneList.isEmpty()) {
            Set<Long> edcIdList = new HashSet<>();
            for (DeRegulatedZone zone : zoneList) {
                for (EdcTdsp edcTdsp : zone.getEdcTdsps()) {
                    edcIdList.add(edcTdsp.getEdcId());
                }
            }
            if (!edcIdList.isEmpty()) {
                edcTdspList = entityManager.createQuery("select e from EdcTdsp e " +
                        "where e.edcId in :edcIds", EdcTdsp.class)
                        .setParameter("edcIds", edcIdList)
                        .getResultList();
            }
        }

        return edcTdspList;
    }

    @GET
    @Path("/all")
    public List<EdcTdsp> getListOfEdcTdsp() {
        log.info("EdcTdspResource->getListOfEdcTdsp() called");
        return entityManager.createNamedQuery("EdcTdsp.findAllEdcTdsps", EdcTdsp.class).getResultList();
    }

    @GET
    @Path("/zipCode")
    public List<EdcTdsp> findEdcTdspsForZipCode(@QueryParam("id") String zipCode) {
        log.info("EdcTdspResource->findEdcTdspsForZipCode() called. ZipCode [" + zipCode + "]");

        List<EdcTdsp> edcTdspList = new ArrayList<>();

        if (zipCode != null) {
            List<ZipCode> zipCodesList = entityManager.createQuery("select z from ZipCode z " +
                    "where z.zipCode = :zipCode", ZipCode.class)
                    .setParameter("zipCode", zipCode)
                    .getResultList();
            if (zipCodesList != null && zipCodesList.size() > 0) {
                for (ZipCode zip : zipCodesList) {
                    if (zip.getZone() != null) {
                        Set<EdcTdsp> edcTdspSet = zip.getZone().getEdcTdsps();
                        for(EdcTdsp edcTdsp : edcTdspSet) {
                            boolean containsInList = false;
                            for(EdcTdsp edcTdspInList : edcTdspList) {
                                if(edcTdspInList.getEdcId().equals(edcTdsp.getEdcId())) {
                                    containsInList = true;
                                    break;
                                }
                            }
                            if(!containsInList) {
                                edcTdspList.add(edcTdsp);
                            }
                        }
                    }
                }
            }
        }

        return edcTdspList;
    }

    @GET
    @Path("{id}")
    public EdcTdsp getEdcTdsp(@PathParam("id") Long edcId) {
        log.info("EdcTdspResource->getEdcTdsp() called. EdcId [" + edcId + "]");
        if(edcId < 0) {
            throw new WebApplicationException(Response.Status.BAD_REQUEST);
        }

        EdcTdsp edcTdsp = entityManager.find(EdcTdsp.class, edcId);
        if(edcTdsp == null) {
            throw new WebApplicationException(Response.Status.NOT_FOUND);
        }

        return edcTdsp;
    }
}
