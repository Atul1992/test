-- Delete all data

delete from customer_load_profile;

delete from customized_quote;

delete from enrollment;

delete from residential_account;

delete from business_account_service_address;

delete from business_account;

delete from enrollment_preferences;

delete from contact;

-- Reset auto increments

alter table contact auto_increment = 1;

alter table customer_load_profile auto_increment = 1;

alter table customized_quote auto_increment = 1;

alter table enrollment_preferences auto_increment = 1;

alter table residential_account auto_increment = 1;

alter table business_account_service_address auto_increment = 1;

alter table business_account auto_increment = 1;

alter table enrollment auto_increment = 1;
