package com.wyest.pw.rest;

import com.wyest.pw.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ejb.Stateless;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * User: Amit
 * Date: 8/1/13
 * Time: 9:07 PM
 */
@Path("/products")
@Stateless
public class ProductService extends BaseEntityService<RepProducts> {
    private static Logger log = LoggerFactory.getLogger(TdspService.class);

    /**
     * Default constructor
     */
    public ProductService() {
        super(RepProducts.class);
    }

    @GET
    @Path("/zip/{zipCode}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<RepProducts> getProductsByZip(@PathParam("zipCode") String zipCode) {
        log.info("ProductService->getProductsByZip() called. ZipCode [" + zipCode + "]");
        List<RepProducts> productsList = new ArrayList<>();

        List<DeRegulatedZone> zoneList = entityManager.createQuery("select distinct e.zone from ZipCode e " +
                "where e.zipCode = :zipCode", DeRegulatedZone.class).setParameter("zipCode", zipCode)
                .getResultList();
        if(!zoneList.isEmpty()) {
            Set<Long> edcIdList = new HashSet<>();
            for(DeRegulatedZone zone: zoneList) {
                for(EdcTdsp edcTdsp : zone.getEdcTdsps()) {
                    edcIdList.add(edcTdsp.getEdcId());
                }
            }
            if(!edcIdList.isEmpty()) {
                productsList = entityManager.createQuery("select e from RepProducts e " +
                        "where e.edcTdsp.edcId in :edcIds", RepProducts.class)
                        .setParameter("edcIds", edcIdList)
                        .getResultList();
            }
        }

        return productsList;
    }

    /**
     * <p>
     *     A method for retrieving individual entity instances.
     * </p>
     * @param id entity id
     * @return
     */
    @GET
    @Path("/{id:[0-9][0-9]*}")
    @Produces(MediaType.APPLICATION_JSON)
    public RepProducts getSingleInstance(@PathParam("id") Long id) {
        return entityManager.find(RepProducts.class, id);
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/productTypes")
    public List<ProductType> getAllProductTypes() {
        return entityManager.createNamedQuery("ProductType.findAll", ProductType.class).getResultList();
    }
}
