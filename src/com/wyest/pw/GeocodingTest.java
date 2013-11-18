package com.wyest.pw;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

/**
 * User: Amit
 * Date: 9/28/13
 * Time: 11:51 AM
 */
public class GeocodingTest {
    public static void main(String[] args) {
        List<String> addressList = new ArrayList<>();
//        addressList.add("30 S Victoriana Cir, Home, The Woodlands, TX 77389");
//        addressList.add("20022 Meadow Dr, Home, Katy, TX, 77384, US");
//        addressList.add("3720 College Park Dr., Apt 18105, The Woodlands, TX, 77384, US");
//        addressList.add("58 Mohawk Path Dr, The Woodlands, TX, 77389, US");
        addressList.add("100 Tom Hank Street, Los Angeles, CA, 77889-4578, USA");
        if (addressList.size() > 0) {
            for (String address : addressList) {
                try {
                    DefaultHttpClient httpClient = new DefaultHttpClient();
                    String encodedAddress = URLEncoder.encode(address, "UTF-8");
                    String url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + encodedAddress + "&sensor=false";
                    System.out.println("Calling Google API service. End Point [" + url + "]");
                    HttpGet httpGet = new HttpGet(url);
                    HttpResponse response = httpClient.execute(httpGet);
                    System.out.println("Call Status [" + response.getStatusLine().getStatusCode() + "]");
                    if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                        HttpEntity entity = response.getEntity();
                        InputStream content = entity.getContent();
                        try (BufferedReader reader = new BufferedReader(new InputStreamReader(content))) {
                            printLatLong(reader);
                        }
                    } else {
                        System.out.println("Call FAILED");
                    }
                } catch (Exception e) {
                    System.err.println("Call fail for Address [" + address + "]");
                }
            }
        }
    }

    private static void printLatLong(Reader reader) throws Exception {
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
                            System.out.println("Lat [" + lat + "], Lng [" + lng + "]");
                        }
                    }
                }
            }
        }
    }
}
