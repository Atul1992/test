-- ************ Master tables start ************

select * from zip_code;

select * from deregulated_zone;

select * from edc_tdsp;

select * from edc_tdsp_zone;

select * from rep;

select * from rep_products;

select * from product_type;

select * from enrollment_status;

select * from business_type;

-- ************ Master tables end ************

select * from app_config;

select * from contact;

select * from contact where lat is null or lng is null;

select * from contact where email like '%amit%' order by contact_id desc;

select * from contact where contact_type='BI' and login_type = 'A' order by contact_id desc;

select * from customer_load_profile;

select * from customized_quote;

select * from residential_account;

select * from business_account_service_address;

select * from business_account;

select * from enrollment order by enrollment_id desc;

select * from enrollment_preferences;

select * from facility;

select * from equipment;

select * from daily_consumption_act;

select * from daily_consumption_est;


-- Zones of TDSP/EDC
select 
    e.*, z.zone_name, z.average_rate, z.comm_average_rate
from
    edc_tdsp e,
    deregulated_zone z,
    edc_tdsp_zone map
where
    e.edc_id = map.edc_id
        and map.zone_id = z.zone_id
        and e.edc_id = 100
;

-- TDSP/EDC for a Zone; Eg for Houston
select 
    z.zone_id,
    z.zone_name,
    z.average_rate,
    z.comm_average_rate,
    e.edc_id, e.edc_name, 
	e.service_area, e.service_phone
from
    edc_tdsp e,
    deregulated_zone z,
    edc_tdsp_zone map
where
    e.edc_id = map.edc_id
        and map.zone_id = z.zone_id
        and z.zone_id = 30
;

-- TDSP for a zip code
select 
	zp.zip_code_id, zp.zip_code,
    z.zone_id,
    z.zone_name,
    z.average_rate,
    z.comm_average_rate,
    e.edc_id, e.edc_name, 
	e.service_area, e.service_phone
from
	zip_code zp,
    edc_tdsp e,
    deregulated_zone z,
    edc_tdsp_zone map
where
	zp.zone_id = z.zone_id
		and e.edc_id = map.edc_id
        and map.zone_id = z.zone_id
        and zp.zip_code = '77389'
;

