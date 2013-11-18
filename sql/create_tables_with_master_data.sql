-- MySQL dump 10.13  Distrib 5.5.32, for Win64 (x86)
--
-- Host: localhost    Database: pwdev
-- ------------------------------------------------------
-- Server version	5.5.32-log

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_account`
--

LOCK TABLES `business_account` WRITE;
/*!40000 ALTER TABLE `business_account` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_account_service_address`
--

LOCK TABLES `business_account_service_address` WRITE;
/*!40000 ALTER TABLE `business_account_service_address` DISABLE KEYS */;
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
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment_preferences`
--

LOCK TABLES `enrollment_preferences` WRITE;
/*!40000 ALTER TABLE `enrollment_preferences` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residential_account`
--

LOCK TABLES `residential_account` WRITE;
/*!40000 ALTER TABLE `residential_account` DISABLE KEYS */;
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

-- Dump completed on 2013-09-06 16:03:09
