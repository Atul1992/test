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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_account`
--

LOCK TABLES `business_account` WRITE;
/*!40000 ALTER TABLE `business_account` DISABLE KEYS */;
INSERT INTO `business_account` VALUES (4,'Jarvantech Corp','FED-12345',NULL,NULL,NULL,1,27),(5,'Amit Inc','FED-33224',NULL,NULL,NULL,2,29),(6,'Wyest Corporation','FED-12345',NULL,NULL,NULL,1,32),(7,'Paleti LLC','FED-99999',NULL,NULL,NULL,2,37),(8,'New England Software Tech','FED-12345',NULL,NULL,NULL,3,40),(13,'Amit Corp','111111111',NULL,NULL,NULL,3,55),(14,'Test Corporation','11-111111',NULL,NULL,NULL,2,58),(15,'Baba Gump Company','12-333333',NULL,NULL,NULL,1,62),(22,'ABC Inc','FED-12345',1,1000,150,3,93),(30,'ABC Inc','FED-12345',1,1000,150,3,108),(31,'Amit Corp','Fed-12345',1,1500,125,2,110),(32,'Wyest Corp','123123',5,1500,175,3,120),(33,'Amit Corp','111111111',5,NULL,NULL,3,122),(35,'Naiara Inc','FED-12345',1,1000,275,4,128);
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_account_service_address`
--

LOCK TABLES `business_account_service_address` WRITE;
/*!40000 ALTER TABLE `business_account_service_address` DISABLE KEYS */;
INSERT INTO `business_account_service_address` VALUES (1,'123123123','ESI-4567890',5,26),(2,'12345678','ESI-123456',5,28),(3,'45785236','ESI-12345678',4,30),(4,'45785237','ESI-12345679',6,31),(5,'123123','123123123',6,33),(6,'ACCT-34523456','ESI-11223344',7,34),(7,'ACCT-34523456','ESI-11223344',7,35),(8,'33333333','ESI-999999',7,38),(9,'1122334455','ESI-999999',8,41),(13,'123123123','345345345',13,56),(14,'','',14,59),(15,'12312312','34534534',15,63),(16,'UTIL-123456','ESI-3344556',30,109),(17,'UTIL-11111','ESI-22222',31,111),(18,'13123','12313123',32,121),(19,'123123123','345345345',33,123),(21,'UTIL-1234','ESI-1234',35,129);
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
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (1,'Amit Tyagi','BI','30 S Victoriana Cir',NULL,'The Woodlands','Texas','77389-4774','','(702) 579-5127',NULL,'amit@pw.com','USA','S','admin',NULL),(2,'Varun Garg','BI','20022 Meadow Arbor',NULL,'Katy','Texas','77450','(832) 687-3021','(281) 579-1922',NULL,'varun@pw.com','USA','S','admin',NULL),(3,'Amit Tyagi','BI','30 S Victorian Cir',NULL,'The Woodlands','Texas','77389-4774','(832) 296-5578','(702) 579-5127',NULL,'amit@inno.com','USA','A','amit',NULL),(4,'Varun Garg','BI','20022 Meadow Arbor',NULL,'Katy','TX','77450','(832) 687-3021','(281) 579-1922',NULL,'varun@inno.com','USA','A','varun',NULL),(11,NULL,'BI','1200 Timerloch Pl.','Office','The Woodlands','Texas','77380-1225','(832) 296-5578','(702) 579-5127','(832) 636-1122','amit.tyagi1@gmail.com','USA','U','test1234',NULL),(12,NULL,'SR','30 S Victoriana Cir','Home','Spring','Texas','77389-4774',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(13,NULL,'BI','1111 Pest Street','','Houston','Texas','77450-1145','(832) 456-7895','','','varun.garg@wyest.com','USA','U','test1234',NULL),(14,NULL,'SR','1111 Pest Street','','Houston','Texas','77450-1145',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(15,NULL,'BI','30 S Victoriana Cir','Creekside Park Village','The Woodlands','Texas','77380-1456','(832) 145-7895','(281) 296-4589','','nai_gf@hotmail.com','USA','U','test1234',NULL),(16,NULL,'SR','30 S Victoriana Cir','Creekside Park Village','The Woodlands','Texas','77380-1456',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(17,NULL,'BI','3200 Research Forest Dr.','','The Woodlands','Texas','77830-4856','(821) 789-4562','(281) 789-4563','','jesson.joy@gmail.com','USA','U','test1234',NULL),(18,NULL,'SR','3200 Research Forest Dr.','','The Woodlands','Texas','77830-4856',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(26,'First','SR','5346 I-45 Interstate','Near Home Depot','Spring','Texas','77382-8569',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(27,'','BI','27211 Blue Cedar Lane','','Spring','Texas','77450-1245',NULL,NULL,NULL,'mahesh@jarvantech.com','USA','U','mahesh',NULL),(28,'Second','SR','1123 College Park Dr','Near Railway Crossing','Conroe','Texas','77384-5588',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(29,NULL,'BI','30 S Victoriana Cir','Creekside Park','The Woodlands','Texas','77389-4774','(832) 296-7852','(702) 579-5127','(832) 111-2222','amit@hotmail.com','USA','U','amit1234',NULL),(30,'Conroe Subway','SR','3720 College Park Dr.','Near LoanStar College','Conroe','Texas','77384-1562',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(31,'Vegas Subway','SR','1800 Tropicana Ave','Near I-55N','Las Vegas','Nevada','89123-8956',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(32,NULL,'BI','30 West Inc','Home','Conroe','Texas','77384-1245','(832) 296-5578','(702) 579-5127','(832) 636-1122','varun@wyest.com','USA','U','varun',NULL),(33,'Varun Garg','SR','30 West Drive','','Katy','Texas','77450',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(34,NULL,'SR','1234 Katy Fwy','Second Location','Katy','Texas','77445',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(35,NULL,'SR','3200 College Park Dr.','First Location','Conroe','Texas','77384-1234',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(36,NULL,'LA','30 West Inc','Office','Katy','Texas','77450','(832) 456-7891','(832) 457-8124',NULL,NULL,'USA',NULL,NULL,NULL),(37,NULL,'BI','30 S Victoriana Cir','Home','The Woodlands','Texas','77384-4774','(832) 154-5678','(832) 457-8956','(832) 444-4444','siva@gmail.com','USA','U','siva1234',NULL),(38,'Naiara Tyagi','SR','3720 College Park Dr','First Location','Conroe','Texas','77382',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(39,NULL,'LA','30 S Victoriana Cir','Home','The Woodlands','Texas','77384-4774','(832) 154-5678','(832) 457-8956',NULL,NULL,'USA',NULL,NULL,NULL),(40,NULL,'BI','2121 Spring Creek','Suite #206','Plano','Texas','75023','(832) 111-1111','(832) 555-5555','(832) 777-7777','ksl@yahoo.com','USA','U','test1234',NULL),(41,'Kalyana Laskhman','SR','2121 Spring Creek','Suite #206','Plano','Texas','75023',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(42,NULL,'BI','58 Mohawk Path Dr','','The Woodlands','TX','77389','(281) 292-1493','(832) 755-5321','','sam@gmail.com','USA','U','test1234',NULL),(43,NULL,'SR','58 Mohawk Path Dr','','The Woodlands','TX','77389',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(55,NULL,'BI','30 Koval Lane','','Conroe','Texas','77389-4775','(832) 111-1111','(832) 222-2222','(832) 333-3333','atyagi@gmail.com','USA','U','atyagi',NULL),(56,'Amit Tyagi','SR','3900 Vegas Street','','Las Vegas','Nevada','89123-4774',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(57,NULL,'LA','30 Koval Lane','','Conroe','Texas','77389-4775','(823) 555-5555','(832) 666-6666',NULL,NULL,'USA',NULL,NULL,NULL),(58,NULL,'BI','30 S Victoriana Cir','','The Woodlands','TX','77384-4774','(832) 111-1111','(832) 222-2222','(832) 333-3333','at@gmail.com','USA','U','at',NULL),(59,'Amit Tyagi','SR','30 S Victoriana Cir','','The Woodlands','TX','77389-4774',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(60,NULL,'BI','100 Tom Hank Street','','Los Angeles','CA','77889-4578','(832) 111-1111','(832) 456-6666','(832) 455-5555','customer@gmail.com','USA','U','customer',NULL),(61,NULL,'SR','100 Tom Hank Street','','Los Angeles','CA','77889-4578',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(62,NULL,'BI','1000 Baba Gump Street','','Irvine','CA','77389-1245','(832) 555-5555','(832) 666-6666','(832) 777-7777','customer2@gmail.com','USA','U','customer2',NULL),(63,'Tom Sawyer','SR','1200 Baba Gump Street','','Irvine','CA','77389-1245',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(64,NULL,'BI','2121 Bank Street','','Plano','TX','75023-1245','(713) 111-1111','(713) 222-2222','(713) 333-3333','diva@yahoo.com','USA','U','diva',NULL),(65,NULL,'SR','2121 Bank Street','','Plano','TX','75023-1245',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(73,NULL,'BI','30 S Victoriana Cir','Home','The Woodlands','TX','77389','123123',NULL,NULL,'amit1@gmail.com','USA','U','amit1234',NULL),(74,NULL,'SI','30 S Victoriana Cir','Office','The Woodlands','TX','77389',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(75,NULL,'BI','30 S Victoriana Cir','Home','Spring','TX','77389-4774','1231234567',NULL,NULL,'nai2@hotmail.com','USA','U','amit1234',NULL),(76,NULL,'SI','30 S Victoriana Cir','Office','Spring','TX','77389-4774',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(77,NULL,'BI','1234 Pascal Ln','Home','Conroe','TX','77382','1231234567',NULL,NULL,'nai3@yahoo.com','USA','U','pass1234',NULL),(78,NULL,'SI','1234 Pascal Ln','Home','Conroe','TX','77382',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(93,NULL,'BI','30 S Victoriana Cir','Home','Spring','TX','77384','832-1111-2222','832-1111-2223','832-1111-2200','itsmeamit@yahoo.com','USA','U','amit1234',NULL),(108,NULL,'BI','30 S Victoriana Cir','Home','Spring','TX','77384','832-1111-2222','832-1111-2223','832-1111-2200','itsme@yahoo.com','USA','U','amit1234',NULL),(109,'Naiara Tyagi','SI','30 S Victoriana Cir','Office','Spring','TX','77384',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(110,NULL,'BI','1234 Amit Lane','Home','Conroe','TX','77389','832-222-2233','832-222-2244','832-222-2000','amit1234@gmail.com','USA','U','amit1234',NULL),(111,'Amit Tyagi','SI','1250 Amit Lane','Office','Conroe','TX','77389',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(112,NULL,'BI','30 S Victoriana Cir','Home','Spring','TX','77389','832-296-9067',NULL,NULL,'iamittyagi2@gmail.com','USA','U','amit1234',NULL),(113,NULL,'SI','30 S Victoriana Cir','Office','Spring','TX','77389',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(114,NULL,'BI','30 S Victoriana Cir','Home','Spring','TX','77389','234-234-2342',NULL,NULL,'test1234@gmail.com','USA','U','test1234',NULL),(115,NULL,'SI','30 S Victoriana Cir','Home','Spring','TX','77389',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(116,NULL,'BI','1234 West Lane','Home','Katy','TX','77450','123-23-34',NULL,NULL,'varun1234@wyest.com','USA','U','varun1234',NULL),(117,NULL,'SI','1234 West Lane','Home','Katy','TX','77450',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(118,NULL,'BI','1234 Kirby Dr','Home','Katy','TX','77450','123123123',NULL,NULL,'varun2233@gmail.com','USA','U','varun1234',NULL),(119,NULL,'SI','1234 Kirby Dr','Home','Katy','TX','77450',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(120,NULL,'BI','1234 Westheimer Lane','Home','Houston','TX','77450','123123','123123','123123','vgarg@wyest.com','USA','U','varun1234',NULL),(121,'Varun Garg','SI','1234 Westheimer Lane','Home','Houston','TX','77450',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(122,NULL,'BI','30 Koval Lane','','Conroe','Texas','77389-4775','(832) 111-1111','(832) 222-2222','(832) 333-3333','amit5555@gmail.com','USA','U','atyagi',NULL),(123,'Amit Tyagi','SR','3900 Vegas Street','','Las Vegas','Nevada','89123-4774',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(124,NULL,'LA','30 Koval Lane','','Conroe','Texas','77389-4775','(823) 555-5555','(832) 666-6666',NULL,NULL,'USA',NULL,NULL,NULL),(128,NULL,'BI','30 S Victoriana Cir','Home','The Woodlands','TX','77389','123-456-7890','123-456-7880','123-456-9988','nai@gmail.com','USA','U','nai1234',NULL),(129,'Naiara Freire','SI','30 S Victoriana Cir','Home','The Woodlands','TX','77389',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL),(130,NULL,'LA','30 S Victoriana Cir','Home','The Woodlands','TX','77389','123','456','789',NULL,'USA',NULL,NULL,NULL),(131,NULL,'BI','1234 Koval Lane','Home','Katy','TX','77450','281-34-5678',NULL,NULL,'joy@gmail.com','USA','U','joy',NULL),(132,NULL,'SI','1234 Koval Lane','Home','Katy','TX','77450',NULL,NULL,NULL,NULL,'USA',NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_load_profile`
--

LOCK TABLES `customer_load_profile` WRITE;
/*!40000 ALTER TABLE `customer_load_profile` DISABLE KEYS */;
INSERT INTO `customer_load_profile` VALUES (7,'data.xlsx','2013-07-06','Spread Sheet','PK\0\0\0\0\0!\0|lòl\0\0†\0\0\0[Content_Types].xml ¢(†\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Ãî]K√0ÜÔˇC…≠4Ÿ&à»∫]¯q©ÁàÕÈ\Zñ&!\'õ€ø˜4˚@§nz”–Êú˜}í4ÔpºjL∂ÑÄ⁄ŸÇıyèe`Kß¥ùÏm˙îﬂ≤£¥J\Zg°`k@6]^ßkòQ∑≈Ç’1˙;!∞¨°ë»ùK3ïçåÙ\Zf¬Àr.g Ωﬁç(ùç`c[\r6\Z>@%&fè+˙º!	`êe˜õ¬÷´`“{£KâT,≠˙Êío8u¶\Z¨µ«+¬`¢”°ù˘Ÿ`€˜B[¥Çl\"C|ñ\raàï.ÃﬂùõÛ√\"îÆ™t	 ïãÜvÄ£ ÷\0±1<çºë⁄Ó∏¯ßbiËü§]_>ëcO8Æˇà#“ˇ\"=$IÊ»`\\¿3Øv#zÃπñ‘kîg¯™}àÉÓ—$8èî(NﬂÖ]d¥›π\'!Q√>4∫.ﬂﬁë“Ët√o∑⁄ºS†:ºE ◊—\'\0\0\0ˇˇ\0PK\0\0\0\0\0!\0µU0#ı\0\0\0L\0\0\0_rels/.rels ¢(†\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0åíœN√0∆ÔHºC‰˚ÍnH°•ªLHª!T¿$Óµç£$@˜ˆÑÇJc€—ˆÁœ?[ﬁÓÊiTb/N√∫(A±3b{◊jx≠üV†b\"gi«\ZéaW›ﬁl_x§îõb◊˚®≤ãã\Z∫î¸#b4OÒÏr•ë0Q ah—ì®e‹îÂ=ÜøP-<’¡j{™>˙<˘≤∑4Mox/Ê}bóNå@û;ÀvÂCf©œ€®öBÀIÉÛú”…˚\"cû&⁄\\OÙˇ∂8q\"Kâ–H‡Û<ﬂäs@ÎÎÅ.üh©¯ΩŒ<‚ßÑ·Md¯a¡≈T_\0\0\0ˇˇ\0PK\0\0\0\0\0!\0ﬁ	˝(\0\0‘\0\0\Z\0xl/_rels/workbook.xml.rels ¢(†\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ºìœj√0∆ÔÉΩÉ—}qíneî:ΩåAØ[˜\0&Q‚–ƒ6ñˆ\'o?ìC∫@….°É$¸}?–ß˝·ßÔƒjùUê%)¥•´Z€(¯8Ω><É ÷∂“ù≥®`@ÇCq∑√Ns¸D¶ı$¢ä%ÜŸÔ§§“`Ø)qmú‘.Ùöc\ZÈuy÷\r <M∑2¸’Äb¶)éïÇp¨6 NÉèŒˇkª∫nK|qÂgèñØX»oŒd9äÍ– +òZ$«…&âƒ Ø√‰7Ü…ó`≤√dK0€5a»ËÄ’;áòB∫¨j÷^ÇyZÜá.Ü~\nçıí˝„öˆO	/Óc)«w⁄áú›bÒ\0\0ˇˇ\0PK\0\0\0\0\0!\0Í“SCk\0\0É\0\0\0\0\0xl/workbook.xmlåRÀn¬0ºWÍ?Xæ\'&Eë UmU.R)ú›xC,;≤\rÅøÔ∆àá‘zÚ>&≥3£LgáFì=8Ø¨…i:H(SZ©Ã&ß_À∑á1%>#Ö∂rzOg≈˝›¥≥n˚mÌñ ÅÒ9≠Ch\'å˘≤ÜF¯Åm¡‡¶≤Æ[∑aæu §ØB£OíkÑ2Ùƒ0qˇ·∞U•Jx±ÂÆN$¥(ﬂ◊™ı¥òVJ√Í‰àà∂˝\rÍ>hJ¥·U™\02ßèÿ⁄ÆÉå∑küwJ„ˆiò)+.&é k\0∑pj/ #&EâÑJÏtX¢·Û=úÛåÛQˇmŒJAÁØ4}Kke§Ìr 3˚xÓ“%uqµV2‘HïçØ≥wPõ:‰tú§IœŒnËc§x&æƒDøü}Ã(2ŒÊh	k7QX∏πL{Ü_h~É∆˙ÇÊ¢á7h¨/Ëòã‰(©∫ƒ˙\'ä‡úßÒ:;ˇ?≈\0\0\0ˇˇ\0PK\0\0\0\0\0!\0˚b•mî\0\0ß\0\0\0\0\0xl/theme/theme1.xmlÏYOo€6øÿw tom\'∂uäÿ±õ≠MƒnáiôñXS¢@“I}⁄„Ä√∫aóªÌ0l+–ªtü&[á≠˙ˆHJ≤ÀK“÷’áD\"|ˇﬂ„#uı⁄Éà°C\"$Âq€´]Æzàƒ>”8h{wÜ˝Kí\n«cÃxL⁄ﬁúHÔ⁄÷˚Ô]≈õ*$A∞>ñõ∏ÌÖJ%õïäÙaÀÀ<!1ÃM∏à∞ÇWT∆›àU÷™’f%¬4ˆPå# {{2°>ACM“€ à˜º∆JÍüâÅ&Mú;û÷4BŒeó	tàY€>c~4$îáñ\n&⁄^’¸º ÷’\nﬁL1µbma]ﬂ¸“uÈÇÒtÕ¡(gZÎ◊[Wvr˙¿‘2Æ◊Îu{µúû`ﬂM≠,Eöı˛F≠ì—,ÄÏ„2ÌnµQ≠ª¯˝ı%ô[ùNß—Je±D\r»>÷ó’f}{Õ¡ê≈7ñıŒv∑€tdÒÕ%|ˇJ´YwÒ2\ZOó–⁄°˝~J=áL8€-Öo\0|£ö¬(àÜ<∫4ã	è’™Xã}.˙\0–@Üçëö\'dÇ}à‚.éFÇbÕ\0o\\ò±Cæ\\\Z“ºêÙMT€˚0¡êzØûˇÍ˘SÙÍ˘ì„áœé˛t¸Ë—Ò√--g·.éÉ‚¬óﬂ~ˆÁ◊£?û~ÛÚÒÂxYƒˇ˙√\'ø¸¸y92h!—ã/ü¸ˆÏ…ãØ>˝˝ª«%mÅGE¯êFD¢[‰t3Üq%\'#qæ√SgÅv	Èû\n‡≠9fe∏qçwW@Ò(^ü›wdÑb¶h	Áa‰\0˜8g.J\rpCÛ*Xx8ãÉrÊbVƒ`|X∆ªãc«µΩYU3J«ˆ›ê8bÓ3+êò(§Á¯îêÌÓQÍÿuè˙ÇK>QËELKM2§#\'êãvi~ôóÈÆvl≥wu8+”zá∫HHÃJÑÊòÒ:û)ïë‚à\r~´∞L»¡\\¯E\\O*t@GΩ1ë≤lÕm˙ú~CΩ*u˚õG.R(:-£ys^DÓi7ƒQRÜ–8,b?êSQåˆπ*ÉÔq7CÙ;¯«+›}ó«›ßÇ;4pDZàûôâ_^\'‹âﬂ¡úM01UJ∫S©#\Zˇ]ŸfÍ∂ÂÆl∑Ωmÿƒ íg˜D±^Ö˚ñË<ã˜	d≈ÚıÆBø´–ﬁ[_°WÂÚ≈◊ÂE)Ü*≠€kõŒ;ZŸxO(c5g‰¶4Ω∑Ñ\rh‹áAΩŒ:I~KBx‘ô\\ ∞YÉWQBú@ﬂ^Û4ë@¶§â.·ºhÜKik<Ù˛ û6˙b+áƒjèèÌ∫Œé9#U`Œ¥£uM‡¨Ã÷Ø§DA∑◊aV”Bùô[Õàfä¢√-WYõÿúÀ¡‰πj0ò[:˝Xπ	«~Õ\ZŒ;òë±∂ªıQÊ„ÖãtëÒò§>“z/˚®fúî≈ í\"Z˙Ïxä’\n‹ZöÏp;ãìäÏÍ+ÿeﬁ{/eºP;ôé,.&\'ã—Q€k5÷\ZÚq“ˆ&pTÜ«(ØK›Lb¿}ìØÑ\r˚SìŸd˘¬õ≠L17	jp˚aÌæ§∞S!’ñ°\r\r3ïÜ\0ã5\'+ˇZÃzQ\nîT£≥I±æ¡ØIvt]K&‚´¢≥#⁄vˆ5-•|¶àÑ„#4b3qÄ¡˝:TAü1ïp„a*Ç~ÅÎ9mm3ÂÁ4Èäóbg«1KBúñ[ù¢Y&[∏)HπÊ≠ ËV*ªQÓ¸™òîø Uäa¸?SEÔ\'p±>÷·vX`§3•Ìq°BU(	©ﬂ–8ò⁄—Wº0\rAw‘Êø á˙øÕ9K√§5ú$’\rê†∞©P≤e…Dﬂ)ƒjÈﬁeI≤îêâ®Ç∏2±bè»!aC]õzo˜P°n™IZÓd¸πÔiç›‰ÛÕ©d˘ﬁks‡üÓ|l2ÉRn6\rMfˇ\\ƒº=XÏ™vΩYûÌΩEEÙƒ¢Õ™gYÃ\n[A+M˚◊·ú[≠≠XK\ZØ52·¿ãÀ\Z√`ﬁ%pëÑÙÿˇ®ô˝‡°7‘!?Ä⁄ä‡˚Ö&aQ}…6HH;8Ç∆…⁄`“§¨i”÷I[-€¨/∏”Õ˘û0∂ñÏ,˛>ß±ÛÊÃeÁ‰‚E\Z;µ∞ck;∂“‘‡Ÿì)\nCìÏ ccæî?fÒ—}pÙ|6ò1%M0¡ß*Å°áò<Ä‰∑Õ“≠ø\0\0\0ˇˇ\0PK\0\0\0\0\0!\0~¡äÂ`\0\0t\0\0\0\0\0xl/worksheets/sheet2.xmlåí¡j√0ÜÔÉΩÉÒΩq⁄≠€\ZíîA)Îa0∆∂ª„(âil€]€∑üíê2Ë•7	Iü˝r∫>ôñ˝ÇÛ\Zm∆ÁQÃXÖ•∂u∆øø∂≥Œ|ê∂î-Z»¯<_Á˜wÈ›ﬁ7\0Å¡˙å7!tâ^5`§è∞Kï\nùëÅRWﬂ9êÂ0dZ±à„\'a§∂|$$ÓVïV∞Au0`√q– @˙}£;?—å∫g§€∫ôB”¢–≠Á ôQ…Æ∂Ëd—“ﬁß˘£T{HÆF+á´NåBØw^âï Rûñö6Ëmg™åøŒπ»”¡ú\rGˇ/fΩ◊‚æ/Ï å«}´∏Í›^8VB%m¯ƒ„Ë∫	tÿ%iÔWH Ûº\"Ô-ñóG72H¢v≤ÜwÈjm=k°\Z∫û9s#&é(ÿı≥œÑ,04S÷–uÅÆGúUàaJzµóˇíˇ\0\0ˇˇ\0PK\0\0\0\0\0!\0~¡äÂ`\0\0t\0\0\0\0\0xl/worksheets/sheet3.xmlåí¡j√0ÜÔÉΩÉÒΩq⁄≠€\ZíîA)Îa0∆∂ª„(âil€]€∑üíê2Ë•7	Iü˝r∫>ôñ˝ÇÛ\Zm∆ÁQÃXÖ•∂u∆øø∂≥Œ|ê∂î-Z»¯<_Á˜wÈ›ﬁ7\0Å¡˙å7!tâ^5`§è∞Kï\nùëÅRWﬂ9êÂ0dZ±à„\'a§∂|$$ÓVïV∞Au0`√q– @˙}£;?—å∫g§€∫ôB”¢–≠Á ôQ…Æ∂Ëd—“ﬁß˘£T{HÆF+á´NåBØw^âï Rûñö6Ëmg™åøŒπ»”¡ú\rGˇ/fΩ◊‚æ/Ï å«}´∏Í›^8VB%m¯ƒ„Ë∫	tÿ%iÔWH Ûº\"Ô-ñóG72H¢v≤ÜwÈjm=k°\Z∫û9s#&é(ÿı≥œÑ,04S÷–uÅÆGúUàaJzµóˇíˇ\0\0ˇˇ\0PK\0\0\0\0\0!\0ê|ﬂÄ“\0\0∏\0\0\0\0\0xl/worksheets/sheet1.xmlîì¡n€0ÜÔˆÇÓµÏ$]W√q—’(÷√Ä°[wWd⁄\"âû§$Õ€è∂#mwËn¢I}¸˘”*nû≠a{A£[Û,I9ß∞÷Æ]Ûßü˜ü9Q∫Z\Zt∞ÊG¸¶¸¯°8†ﬂÜ 2\"∏∞Ê]å}.DPXÏ¡Q¶Aoe§–∑\"Ùd=^≤F,“Ùì∞R;>rˇ6çVP°⁄YpqÇx02í˛–È>úhVΩg•ﬂÓ˙Ö∂\'ƒFè#î3´Úá÷°óCs?g+©NÏ1xÉ∑ZyÿƒÑpb˙vÊkq-àTµ¶	€ôáfÕo≥ºZrQ£?ø4¬ŸôEπ˘TÑö÷ƒŸ`ˇq;>–ßîàa,àREΩá;0Ü¿+⁄‡Ô©«jh ÊÁÁS∑˚qaﬂ=´°ë;Òt€Ej{I>‰ı±Ç†h‘8Y\\Œ≤+eYx<0Z&©Ω~ç,\'\rˇæYj®Ω•bÇöb_¶Öÿì4ı7˜Â<óΩÃ›ùÁ/s’yn9Á…õ5.ˇG#œ\ZWØxì©”¸Ωl·õÙ≠vÅhFìÆ8ÛìãiBÁà˝`›9∫¡—û¢é^ê!iB›\Zƒx\nÜ≈ÕoÆ¸\0\0ˇˇ\0PK\0\0\0\0\0!\0õ\\6\"æ\0\0\0\0\0\0\0\0xl/sharedStrings.xmldè—J1Eﬂˇ!Ã{õµPI“a†ÌÑÕÿ63kfVÍﬂõ\"\"‘«sÓΩ◊Æu6üÿ§0yx⁄`ê&NÖ.ŒßqÛF4Rä3z¯BÅCx|p\"j˙ñƒCV]^≠ï)cç≤Â©\'Ô‹j‘éÌbeiìdD≠≥›\r√≥≠±òâWR{0+ïèﬂ~98)¡iKuVÉ≥7Ò#è81•{{ •˝ì#ØMÛ}ı»çbøê¢∆ø‘ˆW·\0\0ˇˇ\0PK\0\0\0\0\0!\0î7·ÌG\0\0Ï\0\0\r\0\0\0xl/styles.xml§î_ã€0¿ﬂ˚∆Ô©”¨›öí‰†Ìn„†Ï’Mú‘úˇ€Èöç}˜…Iö∂‹√˜K≤¸≥$KIŒR†3ñkï‚È$ƒà©\\\\U)˛æﬂå¨£™†B+ñ‚ñY¸ê}¸êX◊\n∂;2Ê îMÒ—πzIàÕèLR;—5S∞Sj#©’Tƒ÷Ü—¬˙CRê(?Iπ¬=a)ÛˇÅHj^õ:»µ¨©„.∏k;F2_>UJzÍy:£˘Ö›)oíÁF[]∫	‡à.Kû≥∑Q∆$&@ íR+gQÆÂ†VÄˆ7,_ï˛©∂~À{Ø,±ø–â\n∞L1…í\\mêÉ @`ùEQ…zè5¸`∏w+©‰¢ÌÕë7t≈¸$á‘ºë¯8Ü≈¬!.ƒU‰\0Cñ@u3j\n\Z‰}[√ı\n≤«t~ˇÆmß—¸Ê\0È.ÃíÉ64ŒµSñV:‘ÍËWßk¯¥sPÂ,)8≠¥¢D“CF“…ô;ﬂ\\? ;ˆπD™ë[ÈûäCõ˙\"\\DHd{^Øx˛-≠gøãŒÂ=à7aﬂ=^è¸{ß¯õüù3 –°·¬quÏ“fqæñ Ù/‡|g˜ªó≤C%\nV“F∏˝∏ô‚´¸ïºë—Ëı¬O⁄uà_Âﬁ+ˆw∞≥{∂–^∞¢∆ˇ~\\}â7è€(XÑ´E0˚ƒÊA<_mÇ˘lΩ⁄l∂qÖÎ?7Éˆé1Î~YÉµ¥Ü—…)ÓÆ∂ﬂ(œæ—∫±\"6<˚%	b«ﬂTˆ\0\0ˇˇ\0PK\0\0\0\0\0!\0√*~ì\0\0G\0\0\0docProps/app.xml ¢(†\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0úìOo€0≈Ôˆ›9I1Å¨bH7Ù∞aí∂gU¶c°≤dà¨ëÏ”è∂ëƒŸüKo$ﬂ√√Oî§Óçœ:HËb(ƒ|ñãÇç•˚B<Óæ›|í	•Ò1@!éÄ‚N¸†6)∂ê»f∞5Qªím\rç¡ÀÅï*¶∆∑i/cU9˜—æ5H.Ú¸ìÑA(°ºiœÅbL\\uÙﬁ–2⁄ûüv«ñÅµ˙“∂ﬁYC|J˝√Ÿ1Vî}=XJNE≈t[∞o…—QÁJN[µµ∆√öÉue<ÇíóÅz\0”/mc\\B≠:Zu`)¶›/^€Bd/°«)Dgí3Å´∑çÕP˚)ÈÁò^± Tí\r„p(ßﬁiÌnır0pqmÏFÆwé<‡œjc˝Éx9%Fﬁg€ÛÕß|g“AZ¸_\ZIßß\Z≈|≠c”öpd·\\}w·€]º7ßK∏™mmî|o\'˝2Pºˇ‰˚êum¬ ìÁo°2O„ø–Û€YæÃ˘5LfJ^~Ä˛\r\0\0ˇˇ\0PK\0\0\0\0\0!\0Aﬁ\'@\0\0Q\0\0\0docProps/core.xml ¢(†\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0|íQK√0ÖﬂˇC…{ötì∫Ö∂ï=9¨(æÖ‰n+6iH¢›˛Ωiª’Üêó‹sÓwO.…VUG?`]’Ë%1Eh—»JÔrÙVÆÒEŒs-y›h»—Z∑7ô0L4^lc¿˙\n\\H⁄1ar¥˜ﬁ0BúÿÉ‚.ƒmc˜·jwƒpÒ≈w@fî¶DÅÁí{N: 6#ùêRåHÛmÎ Å\ZhÔH\'‰œÎ¡*wµ°W&NU˘£	o:≈ù≤•ƒ—}p’hl€6nÁ}åê?!õÁ◊˛©∏“›Æ†\"ìÇ	‹7∂»»ÙWsÁ7a«€\n‰√1ËWjRÙq»(`C‹≥Ú>|*◊®ËvàÈ\'iI)Îœg7Ú¢ø4‘iøƒdéÈ=¶iô,ÿ›íÕ“	Òr_~Ç‚\0\0ˇˇ\0PK-\0\0\0\0\0\0!\0|lòl\0\0†\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0[Content_Types].xmlPK-\0\0\0\0\0\0!\0µU0#ı\0\0\0L\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0•\0\0_rels/.relsPK-\0\0\0\0\0\0!\0ﬁ	˝(\0\0‘\0\0\Z\0\0\0\0\0\0\0\0\0\0\0\0\0À\0\0xl/_rels/workbook.xml.relsPK-\0\0\0\0\0\0!\0Í“SCk\0\0É\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r	\0\0xl/workbook.xmlPK-\0\0\0\0\0\0!\0˚b•mî\0\0ß\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0•\n\0\0xl/theme/theme1.xmlPK-\0\0\0\0\0\0!\0~¡äÂ`\0\0t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0j\0\0xl/worksheets/sheet2.xmlPK-\0\0\0\0\0\0!\0~¡äÂ`\0\0t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0xl/worksheets/sheet3.xmlPK-\0\0\0\0\0\0!\0ê|ﬂÄ“\0\0∏\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ñ\0\0xl/worksheets/sheet1.xmlPK-\0\0\0\0\0\0!\0õ\\6\"æ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0û\0\0xl/sharedStrings.xmlPK-\0\0\0\0\0\0!\0î7·ÌG\0\0Ï\0\0\r\0\0\0\0\0\0\0\0\0\0\0\0\0é\0\0xl/styles.xmlPK-\0\0\0\0\0\0!\0√*~ì\0\0G\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\Z\0\0docProps/app.xmlPK-\0\0\0\0\0\0!\0Aﬁ\'@\0\0Q\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0…\0\0docProps/core.xmlPK\0\0\0\0\0\0\0\0@\0\0\0\0',11,'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','8802','2013-07-06'),(8,'hello.txt','2013-07-05','Flat File','This is an test file for uploading..\r\n',11,'text/plain','38','2013-07-06');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customized_quote`
--

LOCK TABLES `customized_quote` WRITE;
/*!40000 ALTER TABLE `customized_quote` DISABLE KEYS */;
INSERT INTO `customized_quote` VALUES (2,'2013-07-02','2013-07-06',NULL,NULL,'2013-07-06',0,0),(3,'2013-07-02','2013-07-06',NULL,NULL,'2013-07-06',0,0);
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
  `current_rate` double(10,0) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
INSERT INTO `enrollment` VALUES (4,'Y','Y','2013-06-28',NULL,15,'M','R',NULL,NULL,NULL,NULL,2,50,5,NULL,NULL,NULL,NULL),(5,'Y','Y','2013-06-28',NULL,16,'M','R',NULL,NULL,NULL,NULL,4,60,6,NULL,NULL,NULL,NULL),(6,'Y','Y','2013-07-15',NULL,13,'M','R',NULL,NULL,NULL,NULL,1,10,7,NULL,NULL,NULL,NULL),(7,'Y','Y','2013-06-28',NULL,16,'M','R',NULL,NULL,NULL,NULL,1,20,8,NULL,NULL,NULL,NULL),(9,NULL,'Y','2013-07-15',NULL,15,'M','B',NULL,NULL,NULL,NULL,1,60,NULL,4,NULL,NULL,NULL),(10,NULL,'Y','2013-07-10',NULL,15,'M','B',NULL,NULL,NULL,NULL,3,30,NULL,5,NULL,NULL,NULL),(11,NULL,'Y','2013-07-24',NULL,15,'C','B','Varun','Garg','Manager',NULL,1,20,NULL,6,NULL,36,NULL),(12,NULL,'Y','2013-08-30',NULL,15,'C','B','Siva','Paleti','IT Supervisor',NULL,1,NULL,NULL,7,NULL,39,NULL),(13,NULL,'Y','2013-07-31',NULL,16,'M','B',NULL,NULL,NULL,NULL,1,50,NULL,8,NULL,NULL,NULL),(14,'Y','Y','2013-07-16',NULL,10,'M','R',NULL,NULL,NULL,NULL,1,60,9,NULL,NULL,NULL,NULL),(16,NULL,'Y','2013-07-31',NULL,18,'C','B','Amit','Tyagi','Manager',NULL,1,NULL,NULL,13,NULL,57,1),(17,NULL,'Y','2013-07-31',NULL,19,'M','B',NULL,NULL,NULL,NULL,1,10,NULL,14,NULL,NULL,NULL),(18,'Y','Y','2013-07-24',NULL,18,'M','R',NULL,NULL,NULL,'amit@inno.com',1,60,10,NULL,NULL,NULL,NULL),(19,NULL,'Y','2013-07-31',NULL,16,'M','B',NULL,NULL,NULL,'amit@inno.com',1,40,NULL,15,NULL,NULL,NULL),(20,'N','Y','2013-08-15',NULL,18,'M','R',NULL,NULL,NULL,'amit@inno.com',1,40,11,NULL,NULL,NULL,NULL),(21,'N','Y','2013-08-30',NULL,15,'M','R',NULL,NULL,NULL,NULL,1,20,14,NULL,NULL,NULL,NULL),(22,'Y','Y','2013-08-31',NULL,14,'M','R',NULL,NULL,NULL,NULL,1,10,15,NULL,NULL,NULL,NULL),(23,'Y','Y','2013-08-20',NULL,17,'M','R',NULL,NULL,NULL,NULL,1,50,16,NULL,NULL,NULL,NULL),(24,'N','Y','2013-09-17',NULL,NULL,'M','B',NULL,NULL,NULL,NULL,1,50,NULL,22,NULL,NULL,NULL),(25,'N','Y','2013-09-17',NULL,NULL,'M','B',NULL,NULL,NULL,NULL,1,50,NULL,30,NULL,NULL,NULL),(26,'N','Y','2013-09-29',NULL,NULL,'M','B',NULL,NULL,NULL,NULL,1,71,NULL,31,NULL,NULL,NULL),(27,'Y','Y',NULL,NULL,15,'M','R',NULL,NULL,NULL,NULL,1,30,17,NULL,NULL,NULL,NULL),(28,'Y','Y','2013-09-14',NULL,16,'M','R',NULL,NULL,NULL,NULL,1,71,18,NULL,NULL,NULL,NULL),(29,'N','Y','2013-09-19',NULL,18,'M','R',NULL,NULL,NULL,NULL,1,30,19,NULL,NULL,NULL,NULL),(30,'Y','Y','2013-09-19',NULL,14,'M','R',NULL,NULL,NULL,NULL,1,20,20,NULL,NULL,NULL,NULL),(31,'N','Y','1970-05-05',NULL,NULL,'M','B',NULL,NULL,NULL,NULL,1,30,NULL,32,NULL,NULL,NULL),(32,NULL,'Y','2013-07-30',NULL,18,'C','B','Amit','Tyagi','Manager',NULL,1,NULL,NULL,33,NULL,124,2),(34,'N','Y','2013-09-25',NULL,NULL,'M','B','Naiara','','HR Manager',NULL,1,NULL,NULL,35,NULL,130,4),(35,'Y','Y','2013-09-25',NULL,NULL,'M','R',NULL,NULL,NULL,NULL,1,10,21,NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment_preferences`
--

LOCK TABLES `enrollment_preferences` WRITE;
/*!40000 ALTER TABLE `enrollment_preferences` DISABLE KEYS */;
INSERT INTO `enrollment_preferences` VALUES (1,'Immediately',NULL,'12 months','Y','Y','Y','Y',2,1),(2,'Immediately',NULL,'12 months','Y','Y','Y','Y',2,1),(4,'Immediately',NULL,'6 months','Y','Y','N','N',1,1);
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
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `name` varchar(50) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `mediaItem_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `FK403827A28772A4E` (`mediaItem_id`),
  KEY `FK403827A9D6DF788` (`category_id`),
  CONSTRAINT `FK403827A28772A4E` FOREIGN KEY (`mediaItem_id`) REFERENCES `mediaitem` (`id`),
  CONSTRAINT `FK403827A9D6DF788` FOREIGN KEY (`category_id`) REFERENCES `eventcategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Get ready to rock your night away with this megaconcert extravaganza from 10 of the biggest rock stars of the 80\'s','Rock concert of the decade',1,1),(2,'This critically acclaimed masterpiece will take you on an emotional rollercoaster the likes of which you\'ve never experienced.','Shane\'s Sock Puppets',2,2),(3,'A friendly replay of the famous World Cup final.','Brazil vs. Italy',4,6),(4,'Show your colors in Friday Night Lights! Come see the Red Hot Scorpions put the sting on the winners of Sunday\'s Coastal Quarterfinals for all state bragging rights. Fans entering the stadium in team color face paint will receive a $5 voucher redeemable with any on-site vendor. Body paint in lieu of clothing will not be permitted for this family friendly event.','All State Football Championship',4,7),(5,'Every tennis enthusiast will want to see Wimbledon legend Chris Lewis as he meets archrival Deuce Wild in the quarterfinals of one of the top U.S. tournaments. Finals are already sold out, so do not miss your chance to see the real action in play on the eve of the big day!','Chris Lewis Quarterfinals',4,11),(6,'Join your fellow crew junkies and snarky, self-important collegiate know-it-alls from the nations snobbiest schools to see which team is in fact the fastest show on oars. (Or, if you like, just purchase a ticket and sport a t-shirt from your local community college just to tick them off -- this event promises to be SO much fun!)','Crew You',4,12),(7,'What else is there to say? There\'s snow and sun and the bravest (or craziest) guys ever to strap two feet to a board and fly off a four-story ramp of ice and snow. Who would not want to see how aerial acrobatics are being redefined by the world\'s top adrenaline junkies?','Extreme Snowboarding Finals',4,13),(8,'Hear the sounds that have the critics abuzz. Be one of the first American audiences to experience Portuguese phenomenon Arrhythmia play all the tracks from their recently-released \'Graffiti\' -- the show includes a cameo with world-famous activist and graffiti artist Bansky.','Arrhythmia: Graffiti',1,8),(9,'That\'s right -- they\'ve blown into town! Join the annual tri-state Battle of the Brass Bands and watch them \'gild\' the winning band\'s Most Valuable Blower (MVB) -- don\'t worry (and don\'t inhale!); it\'s only spray paint!  Vote for your best band and revel in a day of high-energy rhythms!','Battle of the Brass Bands',1,9),(10,'Sit center stage as Harlequin Ayes gives another groundbreaking theater performance in the critically acclaimed Carnival Comes to Town, a monologue re-enactment of one-woman\'s despair at not being chosen to join the carnival she\'s spent her entire life preparing for.','Carnival Comes to Town',2,10),(11,'Get in touch with the stunning staccato and your inner Andalusian -- and put on your dancing shoes even if you\'re just in the audience! It\'s down to this one night of competition for the eight mesmerizing couples from around the globe that made it this far. Purchase VIP tickets to experience the competition and revel in the after-hours cabaret party with the world\'s most alluring dancers!','Flamenco Finale',2,14),(12,'It\'s one night only for this once-in-a-lifetime concert-in-the-round with Grammy winning folk and blues legend Jesse Lewis. Entirely stripped of elaborate recording production, Lewis\' music stands entirely on its own and has audiences raving it\'s his best work ever. With limited seating this final concert, don\'t dare to miss this classic you can tell your grandkids about when they develop some real taste in music.','Jesse Lewis Unplugged',1,15),(13,'Make way for Puccini\'s opera in three acts and wear waterproof mascara for the dramatic tearjerker of the season. Let the voice of renowned soprano Rosino Storchio and tenor Giovanni Zenatello envelop you under the stars while you sob quietly into your handkerchief! Wine and hard liquor will be available during intermission and after the show for those seeking to drown their sorrows.','Madame Butterfly',2,16),(14,'Join in the region\'s largest and most revered demonstration of one of the most mocked arts forms of all time. Stand in stunned silence while the masters of Mime Mania thrill with dramatic gestures that far surpass the now pass√© \"Woman in a Glass Box.\" See the famous, \"I have 10 fingers, don\'t make me give you one!\" and other favorites and be sure to enjoy the post-show silent auction.','Mime Mania!',2,17),(15,'This show is for all those who traded in Hemingway for the poetry of the Doors, but really can\'t remember why.  Come see a dead ringer for Jim Morrison and let the despair envelop your soul as he quotes from his tragic mentor, \"I believe in a prolonged derangement of the senses in order to obtain the unknown.\" But be advised: Leave your ganja at home, or leave with the Po-Po','Almost (Mostly) Morrison',1,18),(16,'Join your fellow ballet enthusiasts for the National Ballet Company\'s presentation of Tutu Tchai, a tribute to Pyotr Tchaikovsky\'s and the expressive intensity revealed in his three most famous ballets: The Nutcracker, Swan Lake, and The Sleeping Beauty.','Tutu Tchai',2,19),(17,'They\'re out to prove it\'s not all about the fights! Join your favorite members of the Canadian Women\'s Hockey League as they compete for the title \"Queen of the Slap Shot.\" Commonly believed to be hockey\'s toughest shot to execute, the speed and accuracy of slap shots will be measured on the ice. Fan participation and response will determine any ties. Proceeds will benefit local area domestic violence shelters.','Slap Shot',4,20),(18,'Your votes are in and the teams are assembled and coming to a stadium near you! Join Brendan \'Biceps\' Owen and the rest of the NBA\'s leading players for this blockbuster East versus West all-star game. Who will join the rarefied air with past MVP greats like Shaquille O\'Neal, LeBron James, and Kobe Bryant? Don\'t wait to see the highlights when you can experience it live!','Giants of the Game',4,21),(19,'You may not be at a British seaside but you heard right! Bring your family to witness a new twist on this traditional classic dating back to the 1600s ... only this time, Mr. Punch (and his stick) have met \"The 1%.\" Cheer (or jeer) from the crowd when you think Punch should use his stick on Mr. 1%. Fans agree, \"It\'s the best way to release your outrage at the wealthiest 1% without  being arrested!\".','Punch and Judy (with a Twist)',2,22);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventcategory`
--

DROP TABLE IF EXISTS `eventcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventcategory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventcategory`
--

LOCK TABLES `eventcategory` WRITE;
/*!40000 ALTER TABLE `eventcategory` DISABLE KEYS */;
INSERT INTO `eventcategory` VALUES (5,'Comedy'),(1,'Concert'),(3,'Musical'),(4,'Sporting'),(2,'Theatre');
/*!40000 ALTER TABLE `eventcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mediaitem`
--

DROP TABLE IF EXISTS `mediaitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mediaitem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mediaType` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mediaitem`
--

LOCK TABLES `mediaitem` WRITE;
/*!40000 ALTER TABLE `mediaitem` DISABLE KEYS */;
INSERT INTO `mediaitem` VALUES (1,'IMAGE','http://dl.dropbox.com/u/65660684/640px-Weir%2C_Bob_(2007)_2.jpg'),(2,'IMAGE','http://dl.dropbox.com/u/65660684/640px-Carnival_Puppets.jpg'),(3,'IMAGE','http://dl.dropbox.com/u/65660684/640px-Opera_House_with_Sydney.jpg'),(4,'IMAGE','http://dl.dropbox.com/u/65660684/640px-Roy_Thomson_Hall_Toronto.jpg'),(5,'IMAGE','http://dl.dropbox.com/u/65660684/640px-West-stand-bmo-field.jpg'),(6,'IMAGE','http://dl.dropbox.com/u/65660684/640px-Brazil_national_football_team_training_at_Dobsonville_Stadium_2010-06-03_13.jpg'),(7,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/AllStateFootballChampionship.png'),(8,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/ARhythmia.png'),(9,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/BattleoftheBrassBands.png'),(10,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/CarnivalComestoTown.png'),(11,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/ChrisLewisQuarterfinals.png'),(12,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/CrewYou.png'),(13,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/ExtremeSnowboardingFinals.png'),(14,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/FlamencoFinale.png'),(15,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/JesseLewisUnplugged.png'),(16,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/MadameButterfly.png'),(17,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/MimeMania.png'),(18,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/MorrisonCover.png'),(19,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/TutuTchai.png'),(20,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/SlapShot.png'),(21,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/Giantsofthegame.png'),(22,'IMAGE','http://dl.dropbox.com/u/8625587/ticketmonster/Punch%26Judy.png');
/*!40000 ALTER TABLE `mediaitem` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residential_account`
--

LOCK TABLES `residential_account` WRITE;
/*!40000 ALTER TABLE `residential_account` DISABLE KEYS */;
INSERT INTO `residential_account` VALUES (5,'Amit','Tyagi','K','28134256','123-45-7889','9874561230','11223344','1977-05-05',11,12),(6,'Varun','Garg','','7567857','111-11-1111','123123','123123','2013-06-05',13,14),(7,'Naiara','Tyagi','G','557788995','123-45-7895','UTIL-12345678','121212121','1989-03-11',15,16),(8,'Jesson','Joy','','281347896','381-78-5823','UT-789456123','ESI-1245689','2012-05-15',17,18),(9,'Sandeep','Ghosh','K','28145789','123-45-7895','','ESI-28129214','2003-07-03',42,43),(10,'Tom','Hank','','12456789','123-45-6789','33445566','ESI-12345','2004-07-07',60,61),(11,'Kalyana','Lakshman','','1111111111','444-44-4444','9988776655','ESI-11223344','1983-07-06',64,65),(14,'Amit','Tyagi','','123123','1231234','123123123','1234134','1977-05-04',73,74),(15,'Naiara','Tyagi','F','123123','123123123','123123','123123','1989-11-02',75,76),(16,'Nai','Tyagi','','1234','1234','1234','1234','2013-08-17',77,78),(17,'Amit','Tyagi','K','28134890','','UTIL-1234','ESI-1234','1977-05-04',112,113),(18,'Amit','Tyagi','K','2123123123','','UTIL-123123','ESI-123123','1977-05-04',114,115),(19,'Varun','Garg','K','123123','123123','123123','qwrwqerwer','1975-03-03',116,117),(20,'Varun','Garg','K','123123','123123','12123','123123','1980-05-04',118,119),(21,'Jesson','Tyagi','','28123748','','UTL-12345','ESI-12345','1978-05-04',131,132);
/*!40000 ALTER TABLE `residential_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `section` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `numberOfRows` int(11) NOT NULL,
  `rowCapacity` int(11) NOT NULL,
  `venue_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`venue_id`),
  KEY `FKD8A816C5ED55AD2E` (`venue_id`),
  CONSTRAINT `FKD8A816C5ED55AD2E` FOREIGN KEY (`venue_id`) REFERENCES `venue` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (1,'Premier platinum reserve','A',20,100,1),(2,'Premier gold reserve','B',20,100,1),(3,'Premier silver reserve','C',30,100,1),(4,'General','D',40,100,1),(5,'Front left','S1',50,50,2),(6,'Front centre','S2',50,50,2),(7,'Front right','S3',50,50,2),(8,'Rear left','S4',50,50,2),(9,'Rear centre','S5',50,50,2),(10,'Rear right','S6',50,50,2),(11,'Balcony','S7',1,30,2),(12,'Premier platinum reserve','A',40,100,3),(13,'Premier gold reserve','B',40,100,3),(14,'Premier silver reserve','C',30,200,3),(15,'General','D',80,200,3);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `price` float NOT NULL,
  `ticketCategory_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK954D572C84282A46` (`ticketCategory_id`),
  CONSTRAINT `FK954D572C84282A46` FOREIGN KEY (`ticketCategory_id`) REFERENCES `ticketcategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticketcategory`
--

DROP TABLE IF EXISTS `ticketcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticketcategory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `description` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticketcategory`
--

LOCK TABLES `ticketcategory` WRITE;
/*!40000 ALTER TABLE `ticketcategory` DISABLE KEYS */;
INSERT INTO `ticketcategory` VALUES (1,'Adult'),(2,'Child 0-14yrs');
/*!40000 ALTER TABLE `ticketcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venue`
--

DROP TABLE IF EXISTS `venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `capacity` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `mediaItem_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `FK4EB7A4F28772A4E` (`mediaItem_id`),
  CONSTRAINT `FK4EB7A4F28772A4E` FOREIGN KEY (`mediaItem_id`) REFERENCES `mediaitem` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venue`
--

LOCK TABLES `venue` WRITE;
/*!40000 ALTER TABLE `venue` DISABLE KEYS */;
INSERT INTO `venue` VALUES (1,'Toronto','Canada','60 Simcoe Street',11000,'Roy Thomson Hall is the home of the Toronto Symphony Orchestra and the Toronto Mendelssohn Choir.','Roy Thomson Hall',4),(2,'Sydney','Australia','Bennelong point',15030,'The Sydney Opera House is a multi-venue performing arts centre in Sydney, New South Wales, Australia','Sydney Opera House',3),(3,'Toronto','Canada','170 Princes Boulevard',30000,'BMO Field is a Canadian soccer stadium located in Exhibition Place in the city of Toronto.','BMO Field',5);
/*!40000 ALTER TABLE `venue` ENABLE KEYS */;
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

-- Dump completed on 2013-09-01 17:11:48
