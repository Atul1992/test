-- MySQL dump 10.13  Distrib 5.6.10, for Win64 (x86_64)
--
-- Host: localhost    Database: pwdev
-- ------------------------------------------------------
-- Server version	5.6.10

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_config`
--

DROP TABLE IF EXISTS `app_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_config` (
  `config_id` int(10) NOT NULL AUTO_INCREMENT,
  `key_name` varchar(45) NOT NULL,
  `value` varchar(100) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `updated_on` date DEFAULT NULL,
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_config`
--

LOCK TABLES `app_config` WRITE;
/*!40000 ALTER TABLE `app_config` DISABLE KEYS */;
INSERT INTO `app_config` VALUES (1,'app.stg','dev','2013-10-05','2013-10-06'),(2,'email.override','Y','2013-10-05',NULL),(3,'email.override.to','iamittyagi@gmail.com','2013-10-05',NULL),(4,'email.from','admin@innowatts.com','2013-10-05',NULL),(5,'server.url','http://192.99.6.97:8080/inno','2013-10-05',NULL),(6,'company.name','InnoWatts','2013-10-05',NULL),(7,'email.send','Y','2013-10-05',NULL),(8,'emails.stop','Y','2013-10-06','2013-10-06');
/*!40000 ALTER TABLE `app_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_account`
--

DROP TABLE IF EXISTS `business_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_account` (
  `business_account_id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) NOT NULL,
  `federal_tax_id` varchar(9) DEFAULT NULL,
  `billed_month` int(11) DEFAULT NULL,
  `billed_usage` int(11) DEFAULT NULL,
  `billed_peak_demand` int(11) DEFAULT NULL,
  `business_type_id` int(11) NOT NULL,
  `billing_contact_id` int(11) NOT NULL,
  PRIMARY KEY (`business_account_id`),
  KEY `fk_business_account_bus_type_id_idx` (`business_type_id`),
  KEY `fk_business_account_billing_contact_id_idx` (`billing_contact_id`),
  CONSTRAINT `fk_business_account_billing_contact_id` FOREIGN KEY (`billing_contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_business_account_bus_type_id` FOREIGN KEY (`business_type_id`) REFERENCES `business_type` (`business_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_account`
--

LOCK TABLES `business_account` WRITE;
/*!40000 ALTER TABLE `business_account` DISABLE KEYS */;
INSERT INTO `business_account` VALUES (1,'Naiara Inc','FED-1234',1,1000,NULL,1,3),(2,'Wyest Corporation','Fed-12345',6,1500,500,3,5),(3,'Amit Corporation','FED-98765',5,1000,125,2,19);
/*!40000 ALTER TABLE `business_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_account_service_address`
--

DROP TABLE IF EXISTS `business_account_service_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_account_service_address` (
  `bus_acc_service_address_id` int(11) NOT NULL AUTO_INCREMENT,
  `utility_account_no` varchar(100) DEFAULT NULL,
  `esi` varchar(45) DEFAULT NULL,
  `business_account_id` int(11) NOT NULL,
  `service_contact_id` int(11) NOT NULL,
  PRIMARY KEY (`bus_acc_service_address_id`),
  KEY `fk_bus_acct_serv_addr_bus_acct_id_idx` (`business_account_id`),
  KEY `fk_bus_acct_serv_addr_address_contact_id_idx` (`service_contact_id`),
  CONSTRAINT `fk_bus_acct_serv_addr_bus_account_id` FOREIGN KEY (`business_account_id`) REFERENCES `business_account` (`business_account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bus_acct_serv_addr_contact_id` FOREIGN KEY (`service_contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_account_service_address`
--

LOCK TABLES `business_account_service_address` WRITE;
/*!40000 ALTER TABLE `business_account_service_address` DISABLE KEYS */;
INSERT INTO `business_account_service_address` VALUES (1,'UTIL-1234','ESI-3456',1,4),(2,'12345678','99887765',2,6),(3,'UTIL-1234','ESI-1234',3,20);
/*!40000 ALTER TABLE `business_account_service_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_type`
--

DROP TABLE IF EXISTS `business_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_type` (
  `business_type_id` int(11) NOT NULL,
  `business_type_name` varchar(100) NOT NULL,
  PRIMARY KEY (`business_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_type`
--

LOCK TABLES `business_type` WRITE;
/*!40000 ALTER TABLE `business_type` DISABLE KEYS */;
INSERT INTO `business_type` VALUES (1,'Food'),(2,'Energy'),(3,'Information Technology'),(4,'Consulting');
/*!40000 ALTER TABLE `business_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_type` varchar(2) DEFAULT NULL COMMENT 'This will be used when we have multiple contacts for a REP or EDC, say Billing contact BI, AP for accounts payable, Admin AD. For user login this will be UL.',
  `address_line_1` varchar(100) DEFAULT NULL,
  `address_line_2` varchar(100) DEFAULT NULL,
  `city_name` varchar(45) DEFAULT NULL,
  `state_name` varchar(45) DEFAULT NULL,
  `zip_code` varchar(15) DEFAULT NULL,
  `phone_no` varchar(15) DEFAULT NULL,
  `cell_phone_no` varchar(15) DEFAULT NULL,
  `fax_no` varchar(15) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `login_type` char(1) DEFAULT NULL COMMENT 'The value of U indicates a End User or account, Value of S means system admin and value of A mean Agent or broker.',
  `password` varchar(45) DEFAULT NULL,
  `last_login_date` date DEFAULT NULL,
  `lat` decimal(12,7) DEFAULT NULL,
  `lng` decimal(12,7) DEFAULT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (1,NULL,'BI','30 S Victoriana Cir','Home','The Woodlands','TX','77389','832-205-1234','702-579-5127','832-205-1000','iamittyagi@me.com','US','U','amit1234',NULL,30.1014167,-95.5092470),(2,NULL,'SI','30 S Victoriana Cir','Home','The Woodlands','TX','77389',NULL,NULL,NULL,NULL,'US',NULL,NULL,NULL,30.1014167,-95.5092470),(3,NULL,'BI','1234 Koval Lane','Home','Katy','TX','77450','281-375-1478','281-789-4578','281-375-1000','nai_gf@hotmail.com','US','U','nai1234',NULL,29.7457034,-95.7405139),(4,'Naiara Freire','SI','3720 Test Lane','Store','Katy','TX','77450',NULL,NULL,NULL,NULL,'US',NULL,NULL,NULL,29.7457034,-95.7405139),(5,NULL,'BI','20022 Meadow Arbor','Home','Katy','TX','77450','281-579-1922','832-687-3021','281-579-1900','varun.garg@wyest.com','US','U','varun1234',NULL,29.7457034,-95.7405139),(6,'Varun Garg','SI','20022 Meadow Arbor','Home Office','Katy','TX','77450',NULL,NULL,NULL,NULL,'US',NULL,NULL,NULL,29.7457034,-95.7405139),(7,NULL,'LA','20022 Meadow Arbor','Home','Katy','TX','77450','281-579-1922','832-687-3021','281-579-1900',NULL,'US',NULL,NULL,NULL,29.7457034,-95.7405139),(8,'Amit Tyagi','AG','30 S Victoriana Cir','Home','The Woodlands','TX','77389','281-345-7890','702-579-5127','281-345-7000','amit@inno.com','US','S','amit1234',NULL,30.1014167,-95.5092470),(9,'Varun Garg','AG','20022 Meadow Dr','Home','Katy','TX','77384','123-456-7890','','','varun@inno.com','US','A','varun1234',NULL,29.8473416,-95.7060421),(10,NULL,'BI','30 S Victoriana Cir','Home','The Woodlands','TX','77389','(123) 123-1231','(123) 131-3123','(123) 123-1231','jesson@gmail.com','US','U','joy1234',NULL,30.1014167,-95.5092470),(11,NULL,'SR','30 S Victoriana Cir','Home','The Woodlands','TX','77389',NULL,NULL,NULL,NULL,'US',NULL,NULL,NULL,30.1014167,-95.5092470),(12,NULL,'BI','30 S Victoriana Cir','','The Woodlands','TX','77389-4774','(702) 579-5127','(702) 579-5127','(123) 131-2312','itsmeamit@gmail.com','US','U','amit1234',NULL,30.1441431,-95.5188331),(13,NULL,'SR','30 S Victoriana Cir','','The Woodlands','TX','77389-4774',NULL,NULL,NULL,NULL,'US',NULL,NULL,NULL,30.1441431,-95.5188331),(14,NULL,'BI','30 S Victor Ave','','Spring','TX','77389','1234234','124234','14214','nai@hotmail.com','US','U','nai1234',NULL,32.2664485,-101.4383134),(15,NULL,'SI','30 S Victor Ave','','Spring','TX','77389',NULL,NULL,NULL,NULL,'US',NULL,NULL,NULL,32.2664485,-101.4383134),(17,NULL,'BI','30 S Victoriana Cir','','The Woodlands','TX','77389','702-579-5127','702-579-5127','702-579-1000','amit_2@gmail.com','USA','U','amit1234',NULL,30.1441431,-95.5188331),(18,NULL,'SI','30 S Victoriana Cir','','The Woodlands','TX','77389',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL,30.1441431,-95.5188331),(19,NULL,'BI','30 S Victoriana Cir','','The Woodlands','TX','77389','702-579-5127','123-456-7890','123-456-7000','iamittyagi@gmail.com','USA','U','amit1234',NULL,30.1441431,-95.5188331),(20,'Amit Tyagi','SI','30 S Victoriana Cir','','The Woodlands','TX','77389',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL,30.1441431,-95.5188331);
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_load_profile`
--

DROP TABLE IF EXISTS `customer_load_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_load_profile` (
  `load_profile_id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(200) DEFAULT NULL,
  `file_received_date` date DEFAULT NULL,
  `file_type` varchar(45) DEFAULT NULL,
  `file_data` blob,
  `enrollment_id` int(11) DEFAULT NULL,
  `content_type` varchar(100) DEFAULT NULL,
  `file_size` mediumtext,
  `created_on` date NOT NULL,
  PRIMARY KEY (`load_profile_id`),
  KEY `fk_customer_load_profile_enrollment_id_idx` (`enrollment_id`),
  CONSTRAINT `fk_customer_load_profile_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollment` (`enrollment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_load_profile`
--

LOCK TABLES `customer_load_profile` WRITE;
/*!40000 ALTER TABLE `customer_load_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_load_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customized_quote`
--

DROP TABLE IF EXISTS `customized_quote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customized_quote` (
  `quote_id` int(11) NOT NULL AUTO_INCREMENT,
  `quote_requested_date` date DEFAULT NULL,
  `quote_response_date` date DEFAULT NULL,
  `accepted_date` date DEFAULT NULL,
  `accepted_by` varchar(45) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `enrollment_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`quote_id`),
  KEY `fk_cq_enrollment_id_idx` (`enrollment_id`),
  KEY `fk_cq_rep_products_id_idx` (`product_id`),
  CONSTRAINT `fk_cq_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollment` (`enrollment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cq_product_id` FOREIGN KEY (`product_id`) REFERENCES `rep_products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customized_quote`
--

LOCK TABLES `customized_quote` WRITE;
/*!40000 ALTER TABLE `customized_quote` DISABLE KEYS */;
/*!40000 ALTER TABLE `customized_quote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_consumption_act`
--

DROP TABLE IF EXISTS `daily_consumption_act`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily_consumption_act` (
  `consumption_act_id` int(11) NOT NULL AUTO_INCREMENT,
  `con_year` smallint(6) DEFAULT NULL,
  `con_month` smallint(6) DEFAULT NULL,
  `con_day` smallint(6) DEFAULT NULL,
  `hr1` decimal(10,2) DEFAULT NULL,
  `hr2` decimal(10,2) DEFAULT NULL,
  `hr3` decimal(10,2) DEFAULT NULL,
  `hr4` decimal(10,2) DEFAULT NULL,
  `hr5` decimal(10,2) DEFAULT NULL,
  `hr6` decimal(10,2) DEFAULT NULL,
  `hr7` decimal(10,2) DEFAULT NULL,
  `hr8` decimal(10,2) DEFAULT NULL,
  `hr9` decimal(10,2) DEFAULT NULL,
  `hr10` decimal(10,2) DEFAULT NULL,
  `hr11` decimal(10,2) DEFAULT NULL,
  `hr12` decimal(10,2) DEFAULT NULL,
  `hr13` decimal(10,2) DEFAULT NULL,
  `hr14` decimal(10,2) DEFAULT NULL,
  `hr15` decimal(10,2) DEFAULT NULL,
  `hr16` decimal(10,2) DEFAULT NULL,
  `hr17` decimal(10,2) DEFAULT NULL,
  `hr18` decimal(10,2) DEFAULT NULL,
  `hr19` decimal(10,2) DEFAULT NULL,
  `hr20` decimal(10,2) DEFAULT NULL,
  `hr21` decimal(10,2) DEFAULT NULL,
  `hr22` decimal(10,2) DEFAULT NULL,
  `hr23` decimal(10,2) DEFAULT NULL,
  `hr24` decimal(10,2) DEFAULT NULL,
  `equipment_id` int(11) NOT NULL,
  `last_updated_on` date DEFAULT NULL,
  `last_updated_by` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`consumption_act_id`),
  KEY `fk_daily_consumption_act_equipment1_idx` (`equipment_id`),
  CONSTRAINT `fk_daily_consumption_equipment1` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_consumption_act`
--

LOCK TABLES `daily_consumption_act` WRITE;
/*!40000 ALTER TABLE `daily_consumption_act` DISABLE KEYS */;
/*!40000 ALTER TABLE `daily_consumption_act` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_consumption_est`
--

DROP TABLE IF EXISTS `daily_consumption_est`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily_consumption_est` (
  `consumption_est_id` int(11) NOT NULL AUTO_INCREMENT,
  `con_year` smallint(6) DEFAULT NULL,
  `con_month` smallint(6) DEFAULT NULL,
  `con_day` smallint(6) DEFAULT NULL,
  `hr1` decimal(10,2) DEFAULT NULL,
  `hr2` decimal(10,2) DEFAULT NULL,
  `hr3` decimal(10,2) DEFAULT NULL,
  `hr4` decimal(10,2) DEFAULT NULL,
  `hr5` decimal(10,2) DEFAULT NULL,
  `hr6` decimal(10,2) DEFAULT NULL,
  `hr7` decimal(10,2) DEFAULT NULL,
  `hr8` decimal(10,2) DEFAULT NULL,
  `hr9` decimal(10,2) DEFAULT NULL,
  `hr10` decimal(10,2) DEFAULT NULL,
  `hr11` decimal(10,2) DEFAULT NULL,
  `hr12` decimal(10,2) DEFAULT NULL,
  `hr13` decimal(10,2) DEFAULT NULL,
  `hr14` decimal(10,2) DEFAULT NULL,
  `hr15` decimal(10,2) DEFAULT NULL,
  `hr16` decimal(10,2) DEFAULT NULL,
  `hr17` decimal(10,2) DEFAULT NULL,
  `hr18` decimal(10,2) DEFAULT NULL,
  `hr19` decimal(10,2) DEFAULT NULL,
  `hr20` decimal(10,2) DEFAULT NULL,
  `hr21` decimal(10,2) DEFAULT NULL,
  `hr22` decimal(10,2) DEFAULT NULL,
  `hr23` decimal(10,2) DEFAULT NULL,
  `hr24` decimal(10,2) DEFAULT NULL,
  `last_updated_on` date DEFAULT NULL,
  `last_updated_by` varchar(45) DEFAULT NULL,
  `equipment_id` int(11) NOT NULL,
  PRIMARY KEY (`consumption_est_id`),
  KEY `fk_daily_consumption_est_equipment1_idx` (`equipment_id`),
  CONSTRAINT `fk_daily_consumption_est_equipment1` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_consumption_est`
--

LOCK TABLES `daily_consumption_est` WRITE;
/*!40000 ALTER TABLE `daily_consumption_est` DISABLE KEYS */;
/*!40000 ALTER TABLE `daily_consumption_est` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deregulated_zone`
--

DROP TABLE IF EXISTS `deregulated_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deregulated_zone` (
  `zone_id` int(11) NOT NULL,
  `zone_name` varchar(45) NOT NULL,
  `average_rate` float DEFAULT NULL,
  `comm_average_rate` float DEFAULT NULL,
  PRIMARY KEY (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deregulated_zone`
--

LOCK TABLES `deregulated_zone` WRITE;
/*!40000 ALTER TABLE `deregulated_zone` DISABLE KEYS */;
INSERT INTO `deregulated_zone` VALUES (10,'Baytown',12.5,11.2),(20,'Galveston',12.5,11.5),(30,'Houston',15.6,15),(40,'Humble',12.4,12.4),(50,'Kingwood',11.5,10.2),(60,'Pasadena',11.4,10.3),(70,'Sugar Land',10.2,9.5),(80,'Arlington',12.6,12.3),(90,'Dallas',13.5,13.1),(100,'Fort Worth',13.5,13.1),(110,'Irving',13.9,13.5),(120,'Midland',14.5,14),(130,'Odessa',14.5,14.2),(140,'Plano',14.5,14.2),(150,'Richardson',14,13.8),(160,'Round Rock',14,13.9),(170,'Tyler',14,13.9),(180,'Waco',14.5,14.2),(190,'Brownsville',15.5,15.2),(200,'Corpus Christi',15.5,15.5),(210,'Harlingen',15.5,15.5),(220,'Larendo',15.6,15.4),(230,'McAllen',15.9,15.8),(240,'San Benito',15.9,15.9),(250,'Victoria',15.5,15.5),(260,'Abilene',16,16),(270,'Alpine',16.2,16.2),(280,'San Angelo',16.5,16.4),(290,'Vernon',16.5,16.5),(300,'Lewisville',17,17);
/*!40000 ALTER TABLE `deregulated_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edc_tdsp`
--

DROP TABLE IF EXISTS `edc_tdsp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edc_tdsp` (
  `edc_id` int(11) NOT NULL,
  `edc_name` varchar(45) NOT NULL,
  `default_email` varchar(100) DEFAULT NULL,
  `service_area` varchar(100) DEFAULT NULL,
  `service_phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`edc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edc_tdsp`
--

LOCK TABLES `edc_tdsp` WRITE;
/*!40000 ALTER TABLE `edc_tdsp` DISABLE KEYS */;
INSERT INTO `edc_tdsp` VALUES (100,'Centerpoint Energy','support@centerpointenergy.com','Reliant Service Area','800-332-7143'),(200,'TXU Electric Delivery','support@txuenergy.com','Dallas/ Ft. Worth Service Area','888-313-4747'),(300,'AEP South (CPL Retail Energy)','support@aepsouth.com','CPL - South Texas Service Area',' 866-223-8508'),(400,'AEP North (WTU Retail Energy)','support@aepnorth.com','WTU - West Texas Service Area','866-223-8500'),(500,'TNMP (First Choice Power)','support@tnmp.com','First Choice Power','888-866-7456');
/*!40000 ALTER TABLE `edc_tdsp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edc_tdsp_zone`
--

DROP TABLE IF EXISTS `edc_tdsp_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edc_tdsp_zone` (
  `edc_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL,
  PRIMARY KEY (`edc_id`,`zone_id`),
  KEY `fk_edc_tdsp_zone_zone_id_idx` (`zone_id`),
  KEY `fk_edc_tdsp_zone_edc_id_idx` (`edc_id`),
  CONSTRAINT `fk_edc_tdsp_zone_edc_id` FOREIGN KEY (`edc_id`) REFERENCES `edc_tdsp` (`edc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_edc_tdsp_zone_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `deregulated_zone` (`zone_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edc_tdsp_zone`
--

LOCK TABLES `edc_tdsp_zone` WRITE;
/*!40000 ALTER TABLE `edc_tdsp_zone` DISABLE KEYS */;
INSERT INTO `edc_tdsp_zone` VALUES (100,10),(100,20),(100,30),(100,40),(100,50),(100,60),(100,70),(200,80),(200,90),(200,100),(200,110),(200,120),(200,130),(200,140),(200,150),(200,160),(200,170),(200,180),(300,190),(300,200),(300,210),(300,220),(300,230),(300,240),(300,250),(400,260),(400,270),(400,280),(400,290),(500,300);
/*!40000 ALTER TABLE `edc_tdsp_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment`
--

DROP TABLE IF EXISTS `enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enrollment` (
  `enrollment_id` int(11) NOT NULL AUTO_INCREMENT,
  `smart_meter` char(1) DEFAULT NULL,
  `terms_and_conditions` char(1) DEFAULT NULL,
  `service_start_date_requested` date DEFAULT NULL,
  `service_start_date_confirmed` date DEFAULT NULL,
  `current_rate` double(10,2) DEFAULT NULL,
  `enrollment_type` char(1) NOT NULL COMMENT 'This can be ''M'' for matrix and ''C'' for customized',
  `customer_type` char(1) NOT NULL COMMENT 'This is to categorize customertypes. ''R'' for Residential and ''B'' for Business.',
  `loa_personal_first_name` varchar(50) DEFAULT NULL,
  `loa_personal_last_name` varchar(50) DEFAULT NULL,
  `loa_personal_title` varchar(50) DEFAULT NULL,
  `agent_email_id` varchar(100) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `residential_account_id` int(11) DEFAULT NULL,
  `business_account_id` int(11) DEFAULT NULL,
  `loa_contact_id` int(11) DEFAULT NULL,
  `loa_personal_contact_id` int(11) DEFAULT NULL,
  `preference_id` int(11) DEFAULT NULL,
  `customer_ip` varchar(25) DEFAULT NULL,
  `enrollment_date` datetime DEFAULT NULL,
  PRIMARY KEY (`enrollment_id`),
  KEY `fk_enrollment_status_id_idx` (`status_id`),
  KEY `fk_enromment_product_id_idx` (`product_id`),
  KEY `fk_enrollment_res_account_id_idx` (`residential_account_id`),
  KEY `fk_enrollment_business_account_id_idx` (`business_account_id`),
  KEY `fk_enrollment_loa_contact_id_idx` (`loa_contact_id`),
  KEY `fk_enrollment_loa_pers_contact_id_idx` (`loa_personal_contact_id`),
  KEY `fk_enrollment_enrollment_preferences1_idx` (`preference_id`),
  CONSTRAINT `fk_enrollment_business_account_id` FOREIGN KEY (`business_account_id`) REFERENCES `business_account` (`business_account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_enrollment_preferences1` FOREIGN KEY (`preference_id`) REFERENCES `enrollment_preferences` (`preference_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_loa_contact_id` FOREIGN KEY (`loa_contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_loa_personal_contact_id` FOREIGN KEY (`loa_personal_contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_product_id` FOREIGN KEY (`product_id`) REFERENCES `rep_products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_res_account_id` FOREIGN KEY (`residential_account_id`) REFERENCES `residential_account` (`residential_account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_status_id` FOREIGN KEY (`status_id`) REFERENCES `enrollment_status` (`status_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
INSERT INTO `enrollment` VALUES (1,'Y','Y','2013-09-30',NULL,16.90,'M','R',NULL,NULL,NULL,'nai_gf@hotmail.com',1,30,1,NULL,NULL,NULL,NULL,NULL,'2013-09-06 18:32:12'),(2,'N','Y','2013-10-15',NULL,NULL,'M','B',NULL,NULL,NULL,NULL,1,30,NULL,1,NULL,NULL,NULL,NULL,'2013-09-07 14:38:31'),(3,'N','Y','2013-10-30',NULL,NULL,'C','B','Varun','Garg','President',NULL,1,NULL,NULL,2,NULL,7,1,NULL,'2013-09-07 15:54:34'),(4,'Y','Y','2013-09-30',NULL,16.90,'M','R',NULL,NULL,NULL,'amit@inno.com',1,40,2,NULL,NULL,NULL,NULL,NULL,NULL),(5,'Y','Y','2013-09-30',NULL,15.00,'M','R',NULL,NULL,NULL,NULL,2,60,3,NULL,NULL,NULL,NULL,NULL,'2013-09-17 18:47:22'),(6,'Y','Y','2013-09-29',NULL,15.00,'M','R',NULL,NULL,NULL,NULL,1,10,4,NULL,NULL,NULL,NULL,NULL,'2013-09-20 11:36:43'),(7,'Y','Y','2013-10-20',NULL,15.00,'M','R',NULL,NULL,NULL,NULL,1,30,5,NULL,NULL,NULL,NULL,NULL,'2013-09-29 17:53:09'),(8,'N','Y','2013-11-14',NULL,NULL,'M','B',NULL,NULL,NULL,NULL,1,60,NULL,3,NULL,NULL,NULL,NULL,'2013-09-30 18:49:39');
/*!40000 ALTER TABLE `enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment_preferences`
--

DROP TABLE IF EXISTS `enrollment_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enrollment_preferences` (
  `preference_id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_interval` varchar(45) DEFAULT NULL,
  `energy_type` varchar(45) DEFAULT NULL,
  `product_term` varchar(45) DEFAULT NULL,
  `is_savings` char(1) DEFAULT NULL,
  `is_rewards_points` char(1) DEFAULT NULL,
  `is_customer_service` char(1) DEFAULT NULL,
  `is_smart_energy_solutions` char(1) DEFAULT NULL,
  `product_type_id` int(11) NOT NULL,
  `rep_id` int(11) NOT NULL,
  PRIMARY KEY (`preference_id`),
  KEY `fk_enrollment_preferences_product_type1_idx` (`product_type_id`),
  KEY `fk_enrollment_preferences_rep1_idx` (`rep_id`),
  CONSTRAINT `fk_enrollment_preferences_product_type1` FOREIGN KEY (`product_type_id`) REFERENCES `product_type` (`product_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_preferences_rep1` FOREIGN KEY (`rep_id`) REFERENCES `rep` (`rep_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment_preferences`
--

LOCK TABLES `enrollment_preferences` WRITE;
/*!40000 ALTER TABLE `enrollment_preferences` DISABLE KEYS */;
INSERT INTO `enrollment_preferences` VALUES (1,'Immediately',NULL,'12 months','Y','N','N','Y',2,1);
/*!40000 ALTER TABLE `enrollment_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment_status`
--

DROP TABLE IF EXISTS `enrollment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enrollment_status` (
  `status_id` int(11) NOT NULL,
  `status_desc` varchar(45) NOT NULL,
  `color_code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment_status`
--

LOCK TABLES `enrollment_status` WRITE;
/*!40000 ALTER TABLE `enrollment_status` DISABLE KEYS */;
INSERT INTO `enrollment_status` VALUES (1,'Pending','#000000'),(2,'Processing','#0000FF'),(3,'Completed','#008000'),(4,'Cancelled','#FF0000');
/*!40000 ALTER TABLE `enrollment_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment` (
  `equipment_id` int(11) NOT NULL,
  `equipment_name` varchar(100) DEFAULT NULL,
  `identifier` varchar(100) DEFAULT NULL,
  `manufacturer_serial_no` varchar(100) DEFAULT NULL,
  `equipment_ip_address` varchar(100) DEFAULT NULL,
  `equipment_mac` varchar(50) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `last_updated_on` date DEFAULT NULL,
  `last_updated_by` varchar(45) DEFAULT NULL,
  `parent_equipment_id` int(11) DEFAULT NULL,
  `facility_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`equipment_id`),
  KEY `fk_equipment_equipment1_idx` (`parent_equipment_id`),
  KEY `fk_equipment_facility1_idx` (`facility_id`),
  CONSTRAINT `fk_equipment_equipment1` FOREIGN KEY (`parent_equipment_id`) REFERENCES `equipment` (`equipment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipment_facility1` FOREIGN KEY (`facility_id`) REFERENCES `facility` (`facility_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'Main Meter','646466565','6575757757',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(2,'Sub meter area 1','777777','77878787878',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(3,'Sub meter area 2','7878787','788787878787',NULL,NULL,NULL,NULL,NULL,NULL,1,NULL),(4,'Main Meter Another subway','78767676','76667877887',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2);
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facility`
--

DROP TABLE IF EXISTS `facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility` (
  `facility_id` int(11) NOT NULL,
  `facility_name` varchar(100) DEFAULT NULL,
  `TDSP_congenstion_zone` varchar(100) DEFAULT NULL,
  `weather_station_code` varchar(100) DEFAULT NULL,
  `number_of_employees` int(11) DEFAULT NULL,
  `utility_price` decimal(10,2) DEFAULT NULL,
  `square_footage` int(11) DEFAULT NULL,
  `parent_facility_id` int(11) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `created_by` varchar(45) DEFAULT NULL,
  `last_updated_on` date DEFAULT NULL,
  `last_updated_by` varchar(45) DEFAULT NULL,
  `contact_id` int(11) NOT NULL,
  PRIMARY KEY (`facility_id`),
  KEY `fk_facility_facility_idx` (`parent_facility_id`),
  KEY `fk_facility_contact1_idx` (`contact_id`),
  CONSTRAINT `fk_facility_contact1` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_facility_facility` FOREIGN KEY (`parent_facility_id`) REFERENCES `facility` (`facility_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facility`
--

LOCK TABLES `facility` WRITE;
/*!40000 ALTER TABLE `facility` DISABLE KEYS */;
INSERT INTO `facility` VALUES (1,'Vegas Subway',NULL,NULL,8,11.00,900,NULL,NULL,NULL,NULL,NULL,2),(2,'Another Subway',NULL,NULL,9,11.00,10000,NULL,NULL,NULL,NULL,NULL,4);
/*!40000 ALTER TABLE `facility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_type`
--

DROP TABLE IF EXISTS `product_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_type` (
  `product_type_id` int(11) NOT NULL,
  `description` varchar(45) NOT NULL,
  PRIMARY KEY (`product_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_type`
--

LOCK TABLES `product_type` WRITE;
/*!40000 ALTER TABLE `product_type` DISABLE KEYS */;
INSERT INTO `product_type` VALUES (1,'Wind'),(2,'Natural Gas'),(3,'Wind with 20% Traditional');
/*!40000 ALTER TABLE `product_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rep`
--

DROP TABLE IF EXISTS `rep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rep` (
  `rep_id` int(11) NOT NULL,
  `rep_name` varchar(100) NOT NULL,
  PRIMARY KEY (`rep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rep`
--

LOCK TABLES `rep` WRITE;
/*!40000 ALTER TABLE `rep` DISABLE KEYS */;
INSERT INTO `rep` VALUES (1,'Reliant Energy'),(2,'Pennywise Power'),(3,'TXU Energy'),(4,'Reach Energy'),(5,'Amigo Energy'),(6,'APNA Energy'),(7,'Independence Energy'),(8,'Frontier Utilities'),(9,'Brillian Energy, LLC'),(10,'Source Power & Gas LLC'),(11,'Spark Energy');
/*!40000 ALTER TABLE `rep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rep_products`
--

DROP TABLE IF EXISTS `rep_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rep_products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `annual_mwh` decimal(10,0) DEFAULT NULL,
  `broker_fees` decimal(10,0) DEFAULT NULL,
  `rate` decimal(10,2) DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_to` date DEFAULT NULL,
  `special_offer` varchar(255) DEFAULT NULL,
  `product_code` varchar(45) DEFAULT NULL,
  `pricing_type` varchar(45) DEFAULT NULL,
  `contract_term` int(11) DEFAULT NULL,
  `wind_percentage` int(11) DEFAULT NULL,
  `deposit` decimal(10,0) DEFAULT NULL,
  `early_cancel_fees` decimal(10,0) DEFAULT NULL,
  `energy_facts_label_url` varchar(255) DEFAULT NULL,
  `energy_type` varchar(45) DEFAULT NULL,
  `monthly_charges` decimal(10,0) DEFAULT NULL,
  `switching_fees` decimal(10,0) DEFAULT NULL,
  `tos_path` varchar(255) DEFAULT NULL,
  `yraac_path` varchar(255) DEFAULT NULL,
  `residential_matrix` char(1) DEFAULT NULL,
  `commercial_matrix` char(1) DEFAULT NULL,
  `commercial_customized` char(1) DEFAULT NULL,
  `rep_id` int(11) NOT NULL,
  `edc_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `fk_rep_products_rep_id_idx` (`rep_id`),
  KEY `fk_rep_products_edc_id_idx` (`edc_id`),
  CONSTRAINT `fk_rep_products_edc_id` FOREIGN KEY (`edc_id`) REFERENCES `edc_tdsp` (`edc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rep_products_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `rep` (`rep_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rep_products`
--

LOCK TABLES `rep_products` WRITE;
/*!40000 ALTER TABLE `rep_products` DISABLE KEYS */;
INSERT INTO `rep_products` VALUES (10,'Summer Saver 10',1000,25,10.50,'2001-09-14','2014-09-14',NULL,NULL,'Variable',12,95,100,50,'http://www.piggywatts.com/energyfacts/10','Wind',0,0,NULL,NULL,'Y','Y','N',1,100),(20,'Energy Saver 20',1500,50,9.90,'2013-01-01','2015-12-31',NULL,NULL,'Variable',12,0,125,75,'http://www.pw.com/energyfacts/20','Natural Gas',0,0,NULL,NULL,'Y','Y','Y',1,100),(30,'PennyWise Power Plan',2000,0,9.50,'2013-06-01','2014-10-31',NULL,NULL,'Fixed',24,50,250,100,'http://www.pennywise.com/powerplan','Traditional with 20% Wind',0,0,NULL,NULL,'Y','Y','N',2,100),(40,'TXU Energy Saver\'s Edge 12',1000,0,10.40,'2013-01-01','2013-12-31',NULL,NULL,'Fixed',12,0,0,150,'http://www.txu.com/edge','Natural Gas',0,0,'',NULL,'Y','Y','N',3,200),(50,'TXU Energy Texas Choice 12',1000,0,14.30,'2013-06-01','2013-10-15',NULL,NULL,'Fixed',12,0,0,150,'http://www.txu.com/choice','Natural Gas',0,0,NULL,NULL,'Y','Y','N',3,200),(60,'Father\'s Day - 12 ',1500,0,9.30,'2013-06-01','2013-10-15',NULL,NULL,'Variable',12,0,0,125,NULL,'Traditional with 50% Wind',0,0,NULL,NULL,'Y','Y','N',5,100),(70,'Super Saver',NULL,NULL,10.20,'2013-07-06','2014-07-31',NULL,NULL,'Fixed',15,NULL,NULL,100,NULL,'Natural Gas',NULL,NULL,NULL,NULL,'N','N','Y',1,100),(71,'Energy Efficient',NULL,NULL,9.60,'2013-07-01','2015-07-09',NULL,NULL,'Variable',12,NULL,NULL,150,NULL,'Wind',NULL,NULL,NULL,NULL,'N','N','Y',2,100);
/*!40000 ALTER TABLE `rep_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `residential_account`
--

DROP TABLE IF EXISTS `residential_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `residential_account` (
  `residential_account_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `middle_name` varchar(45) DEFAULT NULL,
  `drivers_license_no` varchar(45) DEFAULT NULL,
  `ssn` varchar(11) DEFAULT NULL,
  `utility_account_no` varchar(45) DEFAULT NULL,
  `esi` varchar(45) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `billing_contact_id` int(11) NOT NULL,
  `service_contact_id` int(11) NOT NULL,
  PRIMARY KEY (`residential_account_id`),
  KEY `fk_res_account_billng_contact_id_idx` (`billing_contact_id`),
  KEY `fk_res_account_service_contact_id_idx` (`service_contact_id`),
  CONSTRAINT `fk_residential_account_billing_contact_id` FOREIGN KEY (`billing_contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_residential_account_service_contact_id` FOREIGN KEY (`service_contact_id`) REFERENCES `contact` (`contact_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residential_account`
--

LOCK TABLES `residential_account` WRITE;
/*!40000 ALTER TABLE `residential_account` DISABLE KEYS */;
INSERT INTO `residential_account` VALUES (1,'Amit','Tyagi','K','123456789','123-45-6789','UTIL-9999','ESI-8888','1977-05-04',1,2),(2,'Jesson','Joy','','1123123','123-34-5555','123123','12313123','2013-09-03',10,11),(3,'Amit','Tyagi','','123123123','123-12-3123','123123','12312312','2004-09-08',12,13),(4,'Naiara','Tyagi','F','1234214','1234234','1234234','123424','2013-09-02',14,15),(5,'Amit','Tyagi','','28123123','1234567890','UTIL-1234','ESI-1234','1977-05-04',17,18);
/*!40000 ALTER TABLE `residential_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zip_code`
--

DROP TABLE IF EXISTS `zip_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zip_code` (
  `zip_code_id` int(11) NOT NULL,
  `zip_code` varchar(45) NOT NULL,
  `city_name` varchar(45) DEFAULT NULL,
  `state_name` varchar(45) DEFAULT NULL,
  `state_code` varchar(5) DEFAULT NULL,
  `zip_code_4` varchar(4) DEFAULT NULL,
  `zone_id` int(11) NOT NULL,
  PRIMARY KEY (`zip_code_id`),
  KEY `fk_zip_code_zone_id_idx` (`zone_id`),
  CONSTRAINT `fk_zip_code_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `deregulated_zone` (`zone_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zip_code`
--

LOCK TABLES `zip_code` WRITE;
/*!40000 ALTER TABLE `zip_code` DISABLE KEYS */;
INSERT INTO `zip_code` VALUES (1,'77389','The Woodlands','Texas','TX','4774',30),(2,'77450','Katie','Texas','TX','4770',70),(3,'77384','Conroe','Texas','TX','1456',30),(4,'77380','Spring','Texas','TX','1234',30),(5,'75023','Plano','Texas','TX','1125',140),(6,'77389','The Woodlands','Texas','TX','4774',90);
/*!40000 ALTER TABLE `zip_code` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-10-06 15:44:47
