package com.wyest.pw.rest;

import com.wyest.pw.model.ProductType;
import com.wyest.pw.model.Rep;
import com.wyest.pw.model.RepProducts;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ejb.Stateless;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

import static com.wyest.pw.utils.PWUtils.notEmpty;

/**
 * User: Amit
 * Date: 5/31/13
 * Time: 6:04 PM
 */
@Path("/reps")
@Stateless
@Produces({MediaType.APPLICATION_JSON})
public class RepService  extends BaseEntityService<Rep> {
    private static Logger log = LoggerFactory.getLogger(RepService.class);

    /**
     * Default constructor
     */
    public RepService() {
        super(Rep.class);
    }

    @GET
    @Path("/all")
    public List<Rep> getListOfReps() {
        log.info("getListOfReps() called");
        return entityManager.createNamedQuery("Rep.findAllReps", Rep.class).getResultList();
    }

    @GET
    @Path("/productTypes/all")
    public List<ProductType> getListOfProductTypes() {
        log.info("getListOfProductTypes() called");
        return entityManager.createNamedQuery("ProductType.findAll", ProductType.class).getResultList();
    }

    @GET
    @Path("/resp")
    public Response getReps() {
        log.info("getReps() called");
        List<Rep> repList = entityManager.createNamedQuery("Rep.findAllReps", Rep.class).getResultList();
        return Response.ok(repList).build();
    }

    @GET
    @Path("/products/all")
    public List<RepProducts> getListOfRepProducts() {
        log.info("getListOfRepProducts() called");
        List<RepProducts> repProductsList = entityManager.createNamedQuery("RepProducts.findAll", RepProducts.class).getResultList();
        if(repProductsList.isEmpty()) {
            log.info("No products found..");
        }

        log.info("Returning products. Total found [" + repProductsList.size() + "]");
        return repProductsList;
    }

    @GET
    @Path("/products/edc")
    public List<RepProducts> getListOfRepProductsForEdc(@QueryParam("id") Long edcId) {
        log.info("getListOfRepProductsForEdc() called. EDC/TDSP ID [" + edcId + "]");
        List<RepProducts> repProductsList = entityManager.createNamedQuery("RepProducts.findAllByEdcTdsp", RepProducts.class).setParameter("edcId", edcId).getResultList();
        if(repProductsList.isEmpty()) {
            log.info("No products found for EDC/TDSP [" + edcId + "]");
        } else {
            log.info("Total [" + repProductsList.size() + "] products found for EDC/TDSP [" + edcId + "]");
        }

        return repProductsList;
    }

    @GET
    @Path("/products/rep")
    public List<RepProducts> getListOfRepProductsForRep(@QueryParam("id") Long repId) {
        log.info("getListOfRepProductsForRep() called. RepId [" + repId + "]");
        List<RepProducts> repProductsList = entityManager.createNamedQuery("RepProducts.findAllByRep", RepProducts.class).setParameter("repId", repId).getResultList();
        if(repProductsList.isEmpty()) {
            log.info("No products found for RepId [" + repId + "]");
        } else {
            log.info("Total [" + repProductsList.size() + "] products found for RepId [" + repId + "]");
        }

        return repProductsList;
    }

    @Path("/createProduct")
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public RepProducts saveProduct(RepProducts product) {
        if(notEmpty(product)) {
            entityManager.persist(product);
            entityManager.flush();
        }

        return product;
    }
}
