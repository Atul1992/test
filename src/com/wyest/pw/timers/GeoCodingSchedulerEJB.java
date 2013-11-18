package com.wyest.pw.timers;

import com.wyest.pw.model.Contact;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URLEncoder;
import java.util.List;

import static com.wyest.pw.utils.PWUtils.notEmpty;

/**
 * This timer reads the data from the Contact table
 * and fills the Lat/Long information if missing
 * <p/>
 * User: Amit
 * Date: 9/28/13
 * Time: 9:20 AM
 */
@Stateless
public class GeoCodingSchedulerEJB {
    private static Logger log = LoggerFactory.getLogger(GeoCodingSchedulerEJB.class);

    @PersistenceContext(unitName = "PiggyWattsPU")
    protected EntityManager em;

    public GeoCodingSchedulerEJB() {
        log.info("GeoCodingSchedulerEJB->constructed");
    }

    public void doPeriodicCheck() {
        log.info("GeoCodingSchedulerEJB->doPeriodicCheck() started.");
        startJob();
        log.info("GeoCodingSchedulerEJB->doPeriodicCheck() completed.");
    }

    private void startJob() {
        log.info("Fetching the contact to update the latitude/longitude");
        // Only pull the records where latitiue or longitude is missing
        List<Contact> contactList = em.createQuery("select e from Contact e " +
                "where e.latitude is null or e.longitude is null", Contact.class).getResultList();
        log.info("Total [" + contactList.size() + "] contacts found with missing LATITUTE or LONGITUDE");
        if (notEmpty(contactList)) {
            for (Contact contact : contactList) {
                log.info("Working on Contact with ContactID [" + contact.getContactId() + "], FullAddress [" + contact.getFullAddress() + "]");
                String address = contact.getFullAddress();
                try {
                    DefaultHttpClient httpClient = new DefaultHttpClient();
                    String encodedAddress = URLEncoder.encode(address, "UTF-8");
                    String url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + encodedAddress + "&sensor=false";
                    log.info("Calling Google API service. End Point [" + url + "]");
                    HttpGet httpGet = new HttpGet(url);
                    HttpResponse response = httpClient.execute(httpGet);
                    log.info("Call Status [" + response.getStatusLine().getStatusCode() + "]");
                    if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                        HttpEntity entity = response.getEntity();
                        InputStream content = entity.getContent();
                        try (BufferedReader reader = new BufferedReader(new InputStreamReader(content))) {
                            updateLatLongOnContact(reader, contact);
                            em.merge(contact);
                            em.flush();
                        }
                    } else {
                        log.info("Call FAILED");
                    }
                } catch (Exception e) {
                    log.error("Call fail for Address [" + address + "]", e);
                }
            }
        }
    }

    private void updateLatLongOnContact(Reader reader, Contact contact) throws Exception {
        JSONParser parser = new JSONParser();
        Object obj = parser.parse(reader);
        JSONObject jsonObject = (JSONObject) obj;
        if (jsonObject != null) {
            JSONArray results = (JSONArray) jsonObject.get("results");
            if (results != null && results.size() > 0) {
                JSONObject firstElement = (JSONObject) results.get(0);
                if (firstElement != null) {
                    JSONObject geometryObject = (JSONObject) firstElement.get("geometry");
                    if (geometryObject != null) {
                        JSONObject locationObject = (JSONObject) geometryObject.get("location");
                        if (locationObject != null) {
                            Double lat = (Double) locationObject.get("lat");
                            Double lng = (Double) locationObject.get("lng");
                            log.info("For Address [" + contact.getFullAddress() + "], Lat [" + lat + "], Lng [" + lng + "]");
                            contact.setLatitude(lat);
                            contact.setLongitude(lng);
                        }
                    }
                }
            }
        }
    }
}
