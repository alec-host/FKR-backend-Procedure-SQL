-- MySQL dump 10.13  Distrib 8.0.26, for Linux (x86_64)
--
-- Host: localhost    Database: db_betting_moniter
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `db_betting_moniter`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_betting_moniter` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_betting_moniter`;

--
-- Table structure for table `bookmaker`
--

DROP TABLE IF EXISTS `bookmaker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookmaker` (
  `_ID` int NOT NULL AUTO_INCREMENT,
  `PayBill` varchar(6) NOT NULL,
  `PayBillOwner` varchar(20) DEFAULT 'NiL',
  `AssigneeName` varchar(40) DEFAULT 'NiL',
  `Country` varchar(50) DEFAULT 'NiL',
  `DateCreated` datetime DEFAULT NULL,
  `DateModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IsArchived` int DEFAULT '0',
  PRIMARY KEY (`_ID`),
  UNIQUE KEY `PayBill` (`PayBill`),
  KEY `IsArchived` (`IsArchived`),
  FULLTEXT KEY `Country` (`Country`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmaker`
--

LOCK TABLES `bookmaker` WRITE;
/*!40000 ALTER TABLE `bookmaker` DISABLE KEYS */;
INSERT INTO `bookmaker` VALUES (1,'641394','Safaricom','Betvantage','kenya','2019-09-03 09:31:39','2019-09-03 09:31:39',0);
/*!40000 ALTER TABLE `bookmaker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `govttaxinformation`
--

DROP TABLE IF EXISTS `govttaxinformation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `govttaxinformation` (
  `_ID` int NOT NULL AUTO_INCREMENT,
  `TaxOnDeposit` double(7,2) NOT NULL DEFAULT '0.00',
  `TaxOnReward` double(7,2) NOT NULL DEFAULT '0.00',
  `Country` varchar(80) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `DateModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `CreatedBy` varchar(15) DEFAULT NULL,
  `ModifiedBy` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`_ID`),
  UNIQUE KEY `Country` (`Country`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `govttaxinformation`
--

LOCK TABLES `govttaxinformation` WRITE;
/*!40000 ALTER TABLE `govttaxinformation` DISABLE KEYS */;
INSERT INTO `govttaxinformation` VALUES (1,5.00,20.00,'kenya','2019-09-03 09:32:15','2019-09-03 09:32:15',NULL,NULL);
/*!40000 ALTER TABLE `govttaxinformation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mno`
--

DROP TABLE IF EXISTS `mno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mno` (
  `_ID` int NOT NULL AUTO_INCREMENT,
  `MNO` varchar(25) NOT NULL,
  `Country` varchar(50) NOT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `DateModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IsDeleted` int DEFAULT '0',
  PRIMARY KEY (`_ID`),
  KEY `IsDeleted` (`IsDeleted`),
  FULLTEXT KEY `Country` (`Country`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mno`
--

LOCK TABLES `mno` WRITE;
/*!40000 ALTER TABLE `mno` DISABLE KEYS */;
INSERT INTO `mno` VALUES (1,'Safaricom','kenya','2019-09-03 09:30:20','2019-09-03 09:30:20',0),(2,'Airtel Kenya','kenya','2019-09-19 09:50:58','2019-09-19 09:50:58',0),(3,'Telkom Kenya','kenya','2019-09-19 10:44:21','2019-09-19 10:44:21',0),(4,'test','botswana','2019-09-19 12:06:01','2019-09-19 12:06:01',0);
/*!40000 ALTER TABLE `mno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revenuelog`
--

DROP TABLE IF EXISTS `revenuelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `revenuelog` (
  `_ID` int NOT NULL AUTO_INCREMENT,
  `Bookmaker` varchar(40) NOT NULL DEFAULT 'NiL',
  `BillNumber` varchar(10) NOT NULL,
  `StakeAmount` double(7,2) DEFAULT '0.00',
  `TaxOnDeposit` double(7,2) DEFAULT '0.00',
  `TaxOnReward` double(7,2) DEFAULT '0.00',
  `MNO` varchar(25) DEFAULT NULL,
  `Country` varchar(25) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `DateModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IsArchieved` int DEFAULT '0',
  PRIMARY KEY (`_ID`,`Bookmaker`),
  KEY `IsArchieved` (`IsArchieved`),
  FULLTEXT KEY `Country` (`Country`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revenuelog`
--

LOCK TABLES `revenuelog` WRITE;
/*!40000 ALTER TABLE `revenuelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `revenuelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statssummary`
--

DROP TABLE IF EXISTS `statssummary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statssummary` (
  `_ID` int NOT NULL AUTO_INCREMENT,
  `NoOfMobileOperator` int DEFAULT '0',
  `NoOfBookmaker` int DEFAULT '0',
  `TotalStake` double(7,2) DEFAULT '0.00',
  `TotalTax` double(7,2) DEFAULT '0.00',
  `DateCreated` datetime DEFAULT NULL,
  `DateModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IsDeleted` int DEFAULT '0',
  PRIMARY KEY (`_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statssummary`
--

LOCK TABLES `statssummary` WRITE;
/*!40000 ALTER TABLE `statssummary` DISABLE KEYS */;
INSERT INTO `statssummary` VALUES (1,1,0,0.00,0.00,'2019-09-19 12:06:00','2019-09-19 12:06:00',0);
/*!40000 ALTER TABLE `statssummary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statssummary_archive`
--

DROP TABLE IF EXISTS `statssummary_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statssummary_archive` (
  `_ID` int NOT NULL AUTO_INCREMENT,
  `NoOfMobileOperator` int DEFAULT '0',
  `NoOfBookmaker` int DEFAULT '0',
  `TotalStake` double(7,2) DEFAULT '0.00',
  `TotalTax` double(7,2) DEFAULT '0.00',
  `DateCreated` datetime DEFAULT NULL,
  `DateModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IsDeleted` int DEFAULT '0',
  PRIMARY KEY (`_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statssummary_archive`
--

LOCK TABLES `statssummary_archive` WRITE;
/*!40000 ALTER TABLE `statssummary_archive` DISABLE KEYS */;
/*!40000 ALTER TABLE `statssummary_archive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_betting_moniter'
--

--
-- Current Database: `db_betvantage`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_betvantage` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_betvantage`;

--
-- Table structure for table `tbl_access_outh`
--

DROP TABLE IF EXISTS `tbl_access_outh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_access_outh` (
  `_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `ConsumerSecret` varchar(50) NOT NULL,
  `ConsumerKey` varchar(50) NOT NULL,
  `Token` varchar(50) DEFAULT NULL,
  `DateCreated` datetime DEFAULT CURRENT_TIMESTAMP,
  `DateModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IsDeleted` int DEFAULT '0',
  PRIMARY KEY (`_ID`),
  UNIQUE KEY `Name` (`Name`),
  KEY `is_deleted` (`IsDeleted`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_access_outh`
--

LOCK TABLES `tbl_access_outh` WRITE;
/*!40000 ALTER TABLE `tbl_access_outh` DISABLE KEYS */;
INSERT INTO `tbl_access_outh` VALUES (1,'betvantage','JMNLwQufYBkPjd2zRAHcIbo1mUKF6h7l','4XRVbjPEkUoyYMWu','G8FdDOqnZxMkCuc74Pf12jWUiv5p','2019-03-20 09:04:48','2019-03-20 09:15:28',0);
/*!40000 ALTER TABLE `tbl_access_outh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_betconstruct`
--

DROP TABLE IF EXISTS `tbl_betconstruct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_betconstruct` (
  `_ID` int NOT NULL AUTO_INCREMENT,
  `TransID` varchar(25) NOT NULL,
  `TransTime` varchar(18) NOT NULL,
  `TransAmount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `BusinessShortCode` varchar(8) NOT NULL,
  `BillRefNumber` varchar(25) DEFAULT NULL,
  `MSISDN` varchar(15) NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `MiddleName` varchar(45) NOT NULL,
  `LastName` varchar(45) NOT NULL,
  `DateCreated` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ResponseStatus` varchar(50) DEFAULT NULL,
  `IsPulled` int DEFAULT '0',
  PRIMARY KEY (`_ID`),
  UNIQUE KEY `TransID` (`TransID`),
  KEY `MSISDN` (`MSISDN`),
  KEY `IsPulled` (`IsPulled`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_betconstruct`
--

LOCK TABLES `tbl_betconstruct` WRITE;
/*!40000 ALTER TABLE `tbl_betconstruct` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_betconstruct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_client_outh`
--

DROP TABLE IF EXISTS `tbl_client_outh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_client_outh` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `consumer_key` varchar(50) NOT NULL,
  `consumer_secret` varchar(50) NOT NULL,
  `token` varchar(50) NOT NULL DEFAULT '0',
  `short_code` varchar(6) NOT NULL,
  `token_lifespan` varchar(10) NOT NULL DEFAULT '3599',
  `date_created` datetime NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_registered` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `consumer_key` (`consumer_key`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_client_outh`
--

LOCK TABLES `tbl_client_outh` WRITE;
/*!40000 ALTER TABLE `tbl_client_outh` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_client_outh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_mpesa_transaction_log`
--

DROP TABLE IF EXISTS `tbl_mpesa_transaction_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_mpesa_transaction_log` (
  `_ID` int NOT NULL AUTO_INCREMENT,
  `TransID` varchar(25) NOT NULL,
  `TransTime` varchar(50) NOT NULL,
  `TransAmount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `BusinessShortCode` varchar(6) NOT NULL,
  `BillRefNumber` varchar(50) DEFAULT 'account',
  `MSISDN` varchar(15) NOT NULL,
  `FirstName` varchar(100) NOT NULL,
  `MiddleName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  `OrgAccountBalance` varchar(50) DEFAULT NULL,
  `InvoiceNumber` varchar(50) DEFAULT NULL,
  `ThirdPartyTransID` varchar(50) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `DateModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IsArchived` int DEFAULT '0',
  PRIMARY KEY (`_ID`),
  UNIQUE KEY `trx_ref` (`TransID`),
  KEY `IndxMobile` (`MSISDN`),
  KEY `IndxArchived` (`IsArchived`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_mpesa_transaction_log`
--

LOCK TABLES `tbl_mpesa_transaction_log` WRITE;
/*!40000 ALTER TABLE `tbl_mpesa_transaction_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_mpesa_transaction_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_betconstruct` AFTER INSERT ON `tbl_mpesa_transaction_log` FOR EACH ROW BEGIN
	INSERT 
	INTO 
	tbl_betconstruct
	(
		`TransID`,
		`TransTime`,
		`TransAmount`,
		`BusinessShortCode`,
		`BillRefNumber`,
		`MSISDN`,
		`FirstName`,
		`MiddleName`,
		`LastName`
	) 
	VALUES
	(
		NEW.TransID,
		NEW.TransTime,
		NEW.TransAmount,
		NEW.BusinessShortCode,
		NEW.BillRefNumber,
		NEW.MSISDN,
		NEW.FirstName,
		NEW.MiddleName,
		NEW.LastName
	);
	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'db_betvantage'
--
/*!50003 DROP PROCEDURE IF EXISTS `sProcRecordMpesaTransactionLogs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcRecordMpesaTransactionLogs`(
	IN `MSISDN` VARCHAR(18),
	IN `TRX_NO` VARCHAR(50),
	IN `AMOUNT` DECIMAL(8,2),
	IN `FNAME` VARCHAR(50),
	IN `SNAME` VARCHAR(50),
	IN `LNAME` VARCHAR(50),
	IN `TRANSDATE` VARCHAR(30),
	IN `SHORTCODE` VARCHAR(15),
	IN `REFNO` VARCHAR(30),
	IN `INVNO` VARCHAR(50),
	IN `BALANCE` VARCHAR(15),
	IN `THIRDPARTYID` VARCHAR(50)
)
BEGIN

IF(TRIM(MSISDN) != "" || TRIM(TRX_NO) != "" || TRIM(AMOUNT) != "" || TRIM(FNAME) != "" || TRIM(SHORTCODE) != "") THEN

	SET @qry = CONCAT( "INSERT ",
	                   "INTO ",
			   "`tbl_mpesa_transaction_log` ",
			   "(`MSISDN`,`TransID`,`TransAmount`,`FirstName`,`MiddleName`,`LastName`,TransTime,
                             `BusinessShortCode`,`BillRefNumber`,`InvoiceNumber`,`OrgAccountBalance`,`ThirdPartyTransID`,`DateCreated`) ",
			   "VALUES ",
		           "('",MSISDN,"','",TRX_NO,"','",AMOUNT,"','",FNAME,"','",SNAME,"','",LNAME,"','",TRANSDATE,"',
                             '",SHORTCODE,"','",REFNO,"','",INVNO,"','",BALANCE,"','",THIRDPARTYID,"','",NOW(),"') ",
			   "ON DUPLICATE KEY UPDATE ",
			   "`DateModified` = '",NOW(),"'");

						 
	PREPARE stmt FROM @qry;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
	
	
	
	SELECT CONCAT('{"RESULT":"SUCCESS","MESSAGE":"Log has been recorded."}') AS message;
END IF;



SET @qry = NULL;
SET MSISDN = NULL;
SET TRX_NO = NULL;
SET AMOUNT = NULL;
SET FNAME = NULL;
SET SNAME = NULL;
SET LNAME = NULL;
SET TRANSDATE = NULL;
SET SHORTCODE = NULL;
SET REFNO  = NULL;
SET INVNO  = NULL;
SET BALANCE = NULL;
SET THIRDPARTYID = NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `db_betvantage_promo`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_betvantage_promo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_betvantage_promo`;

--
-- Table structure for table `tbl_group`
--

DROP TABLE IF EXISTS `tbl_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_group` (
  `_id` tinyint NOT NULL AUTO_INCREMENT,
  `channel` varchar(25) NOT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_group`
--

LOCK TABLES `tbl_group` WRITE;
/*!40000 ALTER TABLE `tbl_group` DISABLE KEYS */;
INSERT INTO `tbl_group` VALUES (1,'loan'),(2,'grain');
/*!40000 ALTER TABLE `tbl_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_heap`
--

DROP TABLE IF EXISTS `tbl_heap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_heap` (
  `msisdn` varchar(15) NOT NULL,
  UNIQUE KEY `msisdn_unik` (`msisdn`),
  KEY `msisdn` (`msisdn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_heap`
--

LOCK TABLES `tbl_heap` WRITE;
/*!40000 ALTER TABLE `tbl_heap` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_heap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_setup`
--

DROP TABLE IF EXISTS `tbl_setup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_setup` (
  `id` int NOT NULL AUTO_INCREMENT,
  `promotion_name` varchar(50) NOT NULL,
  `message` varchar(500) NOT NULL,
  `channel` varchar(25) NOT NULL,
  `lower` int DEFAULT '0',
  `upper` int DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `campaign_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `processed` int DEFAULT '1',
  `locked` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `processed` (`processed`),
  KEY `lower` (`lower`),
  KEY `upper` (`upper`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_setup`
--

LOCK TABLES `tbl_setup` WRITE;
/*!40000 ALTER TABLE `tbl_setup` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_setup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_setup_temp`
--

DROP TABLE IF EXISTS `tbl_setup_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_setup_temp` (
  `id` tinyint NOT NULL AUTO_INCREMENT,
  `rec_id` varchar(10) DEFAULT NULL,
  `promotion_name` varchar(25) NOT NULL,
  `message` varchar(420) NOT NULL,
  `channel` varchar(25) NOT NULL,
  `campaign_date` datetime DEFAULT NULL,
  `is_processed` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `is_processed` (`is_processed`),
  KEY `rec_id` (`rec_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_setup_temp`
--

LOCK TABLES `tbl_setup_temp` WRITE;
/*!40000 ALTER TABLE `tbl_setup_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_setup_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_subscription`
--

DROP TABLE IF EXISTS `tbl_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_subscription` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(15) NOT NULL,
  `channel` varchar(25) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `roll_count` int DEFAULT '0',
  `is_active` int DEFAULT '1',
  PRIMARY KEY (`_id`),
  UNIQUE KEY `msisdn_unik` (`msisdn`),
  KEY `is_active` (`is_active`),
  KEY `msisdn` (`msisdn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_subscription`
--

LOCK TABLES `tbl_subscription` WRITE;
/*!40000 ALTER TABLE `tbl_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_temp`
--

DROP TABLE IF EXISTS `tbl_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_temp` (
  `msisdn` varchar(15) NOT NULL,
  `is_processed` int DEFAULT '0',
  KEY `msisdn` (`msisdn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_temp`
--

LOCK TABLES `tbl_temp` WRITE;
/*!40000 ALTER TABLE `tbl_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_betvantage_promo'
--

--
-- Current Database: `db_betvantage_wallet`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_betvantage_wallet` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_betvantage_wallet`;

--
-- Table structure for table `misc`
--

DROP TABLE IF EXISTS `misc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `misc` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Msisdn` varchar(15) DEFAULT NULL,
  `Message` varchar(420) DEFAULT NULL,
  `IsArchived` int DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `misc`
--

LOCK TABLES `misc` WRITE;
/*!40000 ALTER TABLE `misc` DISABLE KEYS */;
/*!40000 ALTER TABLE `misc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_account_summary`
--

DROP TABLE IF EXISTS `tbl_account_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_account_summary` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `account_name` varchar(25) NOT NULL,
  `running_bal` double(15,2) DEFAULT '0.00',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `account_name` (`account_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_account_summary`
--

LOCK TABLES `tbl_account_summary` WRITE;
/*!40000 ALTER TABLE `tbl_account_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_account_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_configuration`
--

DROP TABLE IF EXISTS `tbl_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_configuration` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `bonus_rate` decimal(15,4) DEFAULT '0.0000',
  `bonus_level` decimal(15,4) DEFAULT '0.0000',
  `inmobia_income_rate` decimal(15,4) DEFAULT '0.0000',
  `partner_income_rate` decimal(15,4) DEFAULT '0.0000',
  `jackpot_rate` decimal(15,4) DEFAULT '0.0000',
  `jackpot_win_level` decimal(15,4) DEFAULT '0.0000',
  `language` int DEFAULT '0' COMMENT 'en - 0, fr - 1',
  PRIMARY KEY (`_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_configuration`
--

LOCK TABLES `tbl_configuration` WRITE;
/*!40000 ALTER TABLE `tbl_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_deposit_log`
--

DROP TABLE IF EXISTS `tbl_deposit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_deposit_log` (
  `deposit_id` int NOT NULL AUTO_INCREMENT,
  `transaction_refno` varchar(80) NOT NULL,
  `msisdn` varchar(18) NOT NULL,
  `client_name` varchar(100) DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`deposit_id`),
  UNIQUE KEY `transaction_refno` (`transaction_refno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_deposit_log`
--

LOCK TABLES `tbl_deposit_log` WRITE;
/*!40000 ALTER TABLE `tbl_deposit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_deposit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_expense_trx`
--

DROP TABLE IF EXISTS `tbl_expense_trx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_expense_trx` (
  `trx_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(18) NOT NULL,
  `cr` double(15,2) DEFAULT '0.00',
  `dr` double(15,2) DEFAULT '0.00',
  `particular` varchar(100) DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`trx_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_expense_trx`
--

LOCK TABLES `tbl_expense_trx` WRITE;
/*!40000 ALTER TABLE `tbl_expense_trx` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_expense_trx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_fee_log`
--

DROP TABLE IF EXISTS `tbl_fee_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_fee_log` (
  `fee_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(15) NOT NULL,
  `particulars` varchar(100) NOT NULL,
  `dr` decimal(7,2) NOT NULL DEFAULT '0.00',
  `cr` decimal(7,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(7,2) NOT NULL DEFAULT '0.00',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`fee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_fee_log`
--

LOCK TABLES `tbl_fee_log` WRITE;
/*!40000 ALTER TABLE `tbl_fee_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_fee_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_income_trx`
--

DROP TABLE IF EXISTS `tbl_income_trx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_income_trx` (
  `trx_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(18) NOT NULL,
  `cr` double(15,2) DEFAULT '0.00',
  `dr` double(15,2) DEFAULT '0.00',
  `particular` varchar(100) DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`trx_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_income_trx`
--

LOCK TABLES `tbl_income_trx` WRITE;
/*!40000 ALTER TABLE `tbl_income_trx` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_income_trx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_incoming_sms`
--

DROP TABLE IF EXISTS `tbl_incoming_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_incoming_sms` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MSISDN` varchar(15) NOT NULL,
  `Message` varchar(480) DEFAULT NULL,
  `ShortCode` varchar(7) NOT NULL,
  `LinkID` varchar(50) DEFAULT NULL,
  `DateCreated` datetime DEFAULT NULL,
  `DateModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IsProcessed` int DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `IsProcessed` (`IsProcessed`),
  KEY `MSISDN` (`MSISDN`),
  KEY `ShortCode` (`ShortCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_incoming_sms`
--

LOCK TABLES `tbl_incoming_sms` WRITE;
/*!40000 ALTER TABLE `tbl_incoming_sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_incoming_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_outgoing_sms`
--

DROP TABLE IF EXISTS `tbl_outgoing_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_outgoing_sms` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Destination` varchar(15) NOT NULL,
  `Message` varchar(1000) DEFAULT NULL,
  `Source` varchar(7) NOT NULL,
  `Status` varchar(100) NOT NULL DEFAULT '0',
  `DateCreated` datetime DEFAULT NULL,
  `DateModified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IsProcessed` int DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `IsProcessed` (`IsProcessed`),
  KEY `Destination` (`Destination`),
  KEY `Source` (`Source`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_outgoing_sms`
--

LOCK TABLES `tbl_outgoing_sms` WRITE;
/*!40000 ALTER TABLE `tbl_outgoing_sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_outgoing_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_stake_collection_trx`
--

DROP TABLE IF EXISTS `tbl_stake_collection_trx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_stake_collection_trx` (
  `trx_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(18) NOT NULL,
  `cr` double(15,2) DEFAULT '0.00',
  `dr` double(15,2) DEFAULT '0.00',
  `particular` varchar(100) DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`trx_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_stake_collection_trx`
--

LOCK TABLES `tbl_stake_collection_trx` WRITE;
/*!40000 ALTER TABLE `tbl_stake_collection_trx` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_stake_collection_trx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_system_configuration`
--

DROP TABLE IF EXISTS `tbl_system_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_system_configuration` (
  `mpesa_deposit` decimal(10,2) DEFAULT '0.00',
  `mpesa_withdrawal` decimal(10,2) DEFAULT '0.00',
  `registration_bonus` decimal(10,2) DEFAULT '0.00',
  `jackpot_bonus` decimal(10,2) DEFAULT '0.00',
  `excise_duty` decimal(10,2) DEFAULT '0.00',
  `house_income` decimal(10,2) DEFAULT '0.00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_system_configuration`
--

LOCK TABLES `tbl_system_configuration` WRITE;
/*!40000 ALTER TABLE `tbl_system_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_system_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_system_log`
--

DROP TABLE IF EXISTS `tbl_system_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_system_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(18) NOT NULL,
  `particular` varchar(100) DEFAULT NULL,
  `date_date` datetime DEFAULT NULL,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_system_log`
--

LOCK TABLES `tbl_system_log` WRITE;
/*!40000 ALTER TABLE `tbl_system_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_system_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_wallet`
--

DROP TABLE IF EXISTS `tbl_wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_wallet` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MSISDN` varchar(17) NOT NULL,
  `ClientId` varchar(50) DEFAULT NULL,
  `FirstName` varchar(80) DEFAULT 'User',
  `MiddleName` varchar(80) DEFAULT 'Unspecified',
  `LastName` varchar(80) DEFAULT 'Unspecified',
  `Language` varchar(10) DEFAULT 'en',
  `PromotionNotificationFlag` int DEFAULT '0',
  `StakeCountTracker` int DEFAULT '0',
  `LastActivity` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DateCreated` datetime DEFAULT NULL,
  `DateModified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IsLocked` int DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `msisdn` (`MSISDN`),
  KEY `IsLocked` (`IsLocked`),
  KEY `INDEX_MSISDN` (`MSISDN`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_wallet`
--

LOCK TABLES `tbl_wallet` WRITE;
/*!40000 ALTER TABLE `tbl_wallet` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_wallet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_wallet_ext`
--

DROP TABLE IF EXISTS `tbl_wallet_ext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_wallet_ext` (
  `_ID` int NOT NULL AUTO_INCREMENT,
  `MSISDN` varchar(18) NOT NULL,
  `Balance` decimal(10,2) DEFAULT '0.00',
  `Bonus` decimal(10,2) DEFAULT '0.00',
  `Password` varchar(100) NOT NULL,
  PRIMARY KEY (`_ID`),
  UNIQUE KEY `msisdn` (`MSISDN`),
  KEY `Password` (`Password`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_wallet_ext`
--

LOCK TABLES `tbl_wallet_ext` WRITE;
/*!40000 ALTER TABLE `tbl_wallet_ext` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_wallet_ext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_wallet_trx`
--

DROP TABLE IF EXISTS `tbl_wallet_trx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_wallet_trx` (
  `trx_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(18) NOT NULL,
  `cr` double(15,2) DEFAULT '0.00',
  `dr` double(15,2) DEFAULT '0.00',
  `particulars` varchar(100) DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`trx_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_wallet_trx`
--

LOCK TABLES `tbl_wallet_trx` WRITE;
/*!40000 ALTER TABLE `tbl_wallet_trx` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_wallet_trx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_withdrawal_log`
--

DROP TABLE IF EXISTS `tbl_withdrawal_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_withdrawal_log` (
  `withdrawal_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(15) NOT NULL,
  `particulars` varchar(100) NOT NULL,
  `dr` decimal(7,2) NOT NULL DEFAULT '0.00',
  `cr` decimal(7,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(7,2) NOT NULL DEFAULT '0.00',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_archived` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`withdrawal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_withdrawal_log`
--

LOCK TABLES `tbl_withdrawal_log` WRITE;
/*!40000 ALTER TABLE `tbl_withdrawal_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_withdrawal_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_betvantage_wallet'
--
/*!50003 DROP PROCEDURE IF EXISTS `sProcActivateWallet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcActivateWallet`(
	IN `MSISDN` VARCHAR(50),
	IN `PASSWD` VARCHAR(50))
BEGIN
	
	
	
	
	
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;	
	IF(TRIM(MSISDN) <> "") THEN
		
		
		
		SET @STMT_1 = CONCAT("SELECT ",
		                     "COUNT(`MSISDN`) ",
				     "INTO ",
				     "@EXIST ",
				     "FROM ",
				     "`tbl_wallet` ",
				     "WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		IF(@EXIST = "0") THEN	
			SET @STMT_2 = CONCAT("INSERT ",
			                     "INTO ",
					     "`tbl_wallet` ",
					     "(`uid`,`msisdn`,`password`,`date_created`) ",
			                     "VALUES ",
					     "('",uuid_short(),"','",TRIM(MSISDN),"','",TRIM(PASSWD),"','",NOW(),"') ",
			                     "ON DUPLICATE KEY ",
					     "UPDATE `date_modified` = '",NOW(),"'");
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
		ELSE
			
			
			
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Already registered"}';
			SELECT @JSON_O AS _JSON;			
		END IF;	
		
		
		
		SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Registration successful"}';
		SELECT @JSON_O AS _JSON;				
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:MSISDN|PASSWORD needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	
	
	
	COMMIT;
	
	
	
	SET @EXIST  = NULL;
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @JSON_O = NULL;
	SET MSISDN  = NULL;
	SET PASSWD  = NULL;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcCheckoutOperation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcCheckoutOperation`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DOUBLE(15,2)
)
BEGIN
	
	
	
	
	
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	
	
	
	START TRANSACTION;	
	IF(TRIM(MSISDN) != "" OR TRIM(AMOUNT) != "") THEN
		
		
		
		SET @STMT_1 = CONCAT("SELECT "
		                     "`balance`,`reference_no` ",
		                     "INTO ",
		                     "@WALLET_BAL, @REFERENCE ",	
				     "FROM ",
				     "`tbl_wallet` ",							
				     "WHERE ",
				     "`is_active` = '1' AND `is_suspended` = '0'	AND `msisdn` = '",TRIM(MSISDN),"'"); 						                   
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		IF(@WALLET_BAL >= AMOUNT) THEN
			
			
			
			SET @STMT_2 = CONCAT("INSERT ",
			                     "INTO ",
					     "`tbl_mpesa_receipt` ",
					     "(`msisdn`,`amount`,`reference_no`,`date_created`) ",
					     "VALUES ",
					     "('",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",@REFERENCE,"','",NOW(),"') ",
					     "ON DUPLICATE KEY ",
				             "UPDATE ",
					     "`date_created` = '",NOW(),"'");                    
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @STMT_3 = CONCAT("UPDATE ",
			                     "`tbl_wallet` ",
					     "SET ",
					     "`balance` = (`balance` - '",AMOUNT,"'),`date_modified` = '",NOW(),"' ",
					     "WHERE ",
					     "`is_active` = '1' AND `is_suspended` = '0' AND `msisdn`= '",TRIM(MSISDN),"'");                    
			PREPARE QUERY FROM @STMT_3;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Withdraw Complete"}';
			SELECT @JSON_O AS _JSON;
		ELSE
			
			
			
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Insufficient Balance:."}';
			SELECT @JSON_O AS _JSON;	
		END IF;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:MSISDN|AMOUNT needs to be SET."}';
		SELECT @JSON_O AS _JSON;	
	END IF;
	
	
	
	COMMIT;
	
	
	
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @REFERENCE = NULL;
	SET @WALLET_BAL = NULL;
	SET MSISDN = NULL;
	SET AMOUNT = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcLoanDispatch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcLoanDispatch`(
	IN `REFERENCE_NO` VARCHAR(50),
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT_REQUESTED` DOUBLE(15,2),
	IN `AMOUNT_DISBURSED` DOUBLE(15,2),
	IN `REPAYMENT_AMOUNT` DOUBLE(15,2),
	IN `INTEREST_AMOUNT` DOUBLE(15,2),
	IN `DURATION_IN_DAYS` VARCHAR(5),
	IN `NOTIFICATION_1` VARCHAR(2)
)
BEGIN
	
	
	
	
	
	
	
	
	
	
	DECLARE RUNNING_BAL DOUBLE(15,2);
	DECLARE PARTICULARS TEXT;
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	
	
	
	START TRANSACTION;
	
	
	
	IF(TRIM(REFERENCE_NO) != "" OR TRIM(MSISDN) != "" OR TRIM(AMOUNT_REQUESTED) != "" OR TRIM(AMOUNT_DISBURSED) != "" OR TRIM(REPAYMENT_AMOUNT) != "" OR TRIM(DURATION_IN_DAYS) != "" OR TRIM(NOTIFICATION_1) != "") THEN
		
		
		
		SET @STMT_0 = CONCAT("SELECT ",
		                     "COUNT(`uid`),`balance` ",
				     "INTO ",
				     "@HAS_ACCOUNT,@BALANCE ",
				     "FROM ",
				     "`tbl_wallet` ",
				     "WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"'");
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		IF(@HAS_ACCOUNT > "0") THEN
			
			
			
			SET @REPAYMENT_DATE = DATE_ADD(NOW(), INTERVAL (DURATION_IN_DAYS * 24) HOUR);
			
			
			
			SET @NOTIFICATION_DATE = DATE_ADD(@REPAYMENT_DATE, INTERVAL (NOTIFICATION_1 * -1) HOUR); 
			
			
			
			SET @STMT_1 = CONCAT("INSERT ",
			                     "INTO ",
			                     "`tbl_debtor` ",
			                     "(`reference_no`,`msisdn`,`amount_requested`,`amount_disbursed`,`repayment_amount`,`interest_amount`,`date_created`,`expected_repayment_date`,`repayment_date`,`next_notification_date`) ",
			                     "VALUES ",
			                     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT_REQUESTED),"','",TRIM(AMOUNT_DISBURSED),"','",TRIM(REPAYMENT_AMOUNT),"','",TRIM(INTEREST_AMOUNT),"','",NOW(),"','",@REPAYMENT_DATE,"','",@REPAYMENT_DATE,"','",@NOTIFICATION_DATE,"') ",
			                     "ON DUPLICATE KEY ",
			                     "UPDATE `date_modified` = '",NOW(),"'");	
			PREPARE QUERY FROM @STMT_1;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET PARTICULARS = 'MONEY MOVED TO CLIENT WALLET A/C.';
			
			
			
			SET @STMT_2 = CONCAT("INSERT ",
			                     "INTO ",
					     "`tbl_wallet_transaction` ",
					     "(`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
					     "VALUES ",
					     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT_REQUESTED),"','",TRIM(AMOUNT_DISBURSED),"','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET PARTICULARS = 'LOAN PROCESSING FEE CHARGED.';
			
			
			
			SET @STMT_4 = CONCAT("INSERT ",
			                     "INTO ",
					     "`tbl_wallet_transaction` ",
					     "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
					     "VALUES ",
					     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",(TRIM(AMOUNT_REQUESTED)-TRIM(AMOUNT_DISBURSED)),"','0.00','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_4;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET RUNNING_BAL = (@BALANCE + AMOUNT_DISBURSED);
			
			
			
			SET @STMT_5 = CONCAT("UPDATE ",
			                     "`tbl_wallet` ",
					     "SET ",
					     "`balance` = '",TRIM(RUNNING_BAL),"', `date_modified` = '",NOW(),"' ",
					     "WHERE ",
					     "`msisdn` = '",TRIM(MSISDN),"'");
			PREPARE QUERY FROM @STMT_5;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET PARTICULARS = 'MONEY MOVED FROM UTY TO CLIENT WALLET A/C.';			
			
			
			
			SET @STMT_6 = CONCAT("INSERT ",
			                     "INTO ",
					     "`tbl_transaction` ",
					     "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
					     "VALUES ",
					     "('0','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT_DISBURSED),"','0.00','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_6;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;			
			
			
			
			SET @STMT_7 = CONCAT("UPDATE ",
			                     "`tbl_loan_payout` ",
				             "SET ",
					     "`is_processed` = '1', `date_modified` = '",NOW(),"' ",
					     "WHERE ",
					     "`reference_no` = '",TRIM(REFERENCE_NO),"' AND `msisdn` = '",TRIM(MSISDN),"'");	   
			PREPARE QUERY FROM @STMT_7;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @JSON_O = CONCAT('{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"LOAN DISPATCHED TO ACCOUNT:',MSISDN,'"}');
			SELECT @JSON_O AS _JSON;									
		ELSE
			
			
			
			SET @JSON_O = CONCAT('{"ERROR":"1","RESULT":"FAIL","MESSAGE":"ACCOUNT DOES NOT EXIST:',MSISDN,'"}');
			SELECT @JSON_O AS _JSON;			
		END IF;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"0","RESULT":"FAIL","MESSAGE":"Params:REFERENCE_NO|MSISDN|AMOUNT_REQUESTED|AMOUNT_DISBURSED|REPAYMENT_AMOUNT needs to be SET."}';
		SELECT @JSON_O AS _JSON;	
	END IF;
	
	
	
	COMMIT;
	
	
	
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @JSON_O = NULL;
	SET @BALANCE = NULL;
	SET @HAS_ACCOUNT = NULL;
	SET @REPAYMENT_DATE = NULL;
	SET @NOTIFICATION_DATE = NULL;
	SET MSISDN  = NULL;
	SET PARTICULARS = NULL;
	SET RUNNING_BAL = NULL;
	SET REFERENCE_NO  = NULL;
	SET AMOUNT_REQUESTED = NULL;
	SET AMOUNT_DISBURSED = NULL;
	SET REPAYMENT_AMOUNT = NULL;
	SET DURATION_IN_DAYS = NULL;
	SET NOTIFICATION_1 = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProqClientAuthentication` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientAuthentication`(
	IN `MSISDN` VARCHAR(15),
	IN `PIN` VARCHAR(10)
)
BEGIN
	IF(TRIM(MSISDN) = "" || TRIM(PIN) = "") THEN
		
		
		
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid input","OPERATION":"Authentication","INFO":"0,0,0,0,0,0"}') AS json_result;
	ELSE
		SET @qry = CONCAT("SELECT ", 
                        "A.`FirstName`,A.`Language`,A.`PromotionNotificationFlag`,B.`Balance`,B.`Bonus`,A.`StakeCountTracker` ",
                        "INTO ",
                        "@FNAME,@LANG,@FLAG,@BAL,@BONUS,@STAKE_CNT_TRACKER "
                        "FROM ",
						      "`tbl_wallet` A ",
                        "INNER JOIN ",
                        "`tbl_wallet_ext` B ",
                        "ON ",
                        "A.`MSISDN` = B.`MSISDN` ",
                        "WHERE ",
                        "A.`MSISDN` = '",TRIM(MSISDN),"' AND B.`Password` ='",TRIM(PIN),"'");
						
		PREPARE stmt_1 FROM @qry;
		EXECUTE stmt_1;
		DEALLOCATE PREPARE stmt_1;
		
		
		
		IF(@FNAME IS NOT NULL && @LANG IS NOT NULL && @FLAG IS NOT NULL && @BAL IS NOT NULL && @BONUS IS NOT NULL && @STAKE_CNT_TRACKER IS NOT NULL) THEN
			SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Authentication","INFO":"',CONCAT(@FNAME,",",@LANG,",",@FLAG,",",@BAL,",",@BONUS,",",@STAKE_CNT_TRACKER),'"}') AS json_result;
		ELSE
			SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid MSISDN or Pin","OPERATION":"Authentication","INFO":"0,0,0,0,0,0"}') AS json_result;
		END IF;													
	END IF;



SET @qry = NULL;
SET @FNAME = NULL;
SET @LANG = NULL;
SET @FLAG = NULL;
SET @BAL = NULL;
SET @BONUS = NULL;
SET @STAKE_CNT_TRACKER = NULL;	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProqClientBalance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientBalance`(
	IN `MSISDN` VARCHAR(50),
	IN `PIN` VARCHAR(50)
)
BEGIN



IF(TRIM(MSISDN) = "" || TRIM(PIN) = "") THEN
	
	
	
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid input","OPERATION":"Check Balance","BALANCE":"0.00","BONUS":"0.00"}') AS json_result;
ELSE
	SET @qry = CONCAT("SELECT ",
	                  "B.Balance,B.Bonus ",
							"INTO ",
							"@BAL,@BONUS " 
						   "FROM ",
						   "tbl_wallet A ",
						   "INNER JOIN ",
						   "tbl_wallet_ext B ",
						   "ON ",
							"A.MSISDN=B.MSISDN ",
						   "WHERE ",
						   "A.MSISDN = '",TRIM(MSISDN),"' AND B.Password = '",TRIM(PIN),"' AND A.IsLocked = '0'"); 
											  				   
	PREPARE stmt_1 FROM @qry;
	EXECUTE stmt_1;
	DEALLOCATE PREPARE stmt_1;	

	IF(@BAL IS NOT NULL && @BONUS IS NOT NULL) THEN
		
		
		
		SELECT CONCAT('{"RESULT":"1","MESSAGE":"Success","OPERATION":"Check Balance","BALANCE":"',@BAL,'","BONUS":"',@BONUS,'"}') AS json_result;
	ELSE
		
		
		
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Wallet account does not EXIST","OPERATION":"Check Balance","BALANCE":"0.00","BONUS":"0.00"}') AS json_result;
	END IF;						   
END IF;



SET @qry = NULL;
SET MSISDN = NULL;
SET PIN = NULL;
SET @BAL = NULL;
SET @BONUS = NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProqClientPlaceBet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientPlaceBet`(
	IN `MSISDN` VARCHAR(15),
	IN `BET_AMOUNT` DECIMAL(10,2)
)
BEGIN
	IF(TRIM(MSISDN) = "" || TRIM(BET_AMOUNT) = "") THEN
		
		
		
		SELECT CONCAT('{"RESULT":"0","MESSAGE","Unsuccessful - Invalid Input","OPERATION":"Place a Bet"}') AS json_result;
	ELSE
		
		
		
	   SET @qry = CONCAT("SELECT ",
		                  "COUNT(A.`MSISDN`), B.`Balance` ",
							   "INTO ",
								"@USER_MSISDN, @CURRENT_BAL ",
								"FROM ",
								"`tbl_wallet` A ",
								"INNER JOIN ",
								"`tbl_wallet_ext` B ", 
								"ON ",
								"A.`MSISDN`=B.`MSISDN` ",
								"WHERE ",
								"A.`MSISDN` = '",TRIM(MSISDN),"'");
		PREPARE stmt FROM @qry;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt; 
		
		
		
	   IF(@USER_MSISDN > "0") THEN
	   	IF(@CURRENT_BAL >= BET_AMOUNT) THEN
				SET @qry1 = CONCAT("UPDATE ",
				                   "`tbl_wallet` A ",
				                   "INNER JOIN ",
										 "`tbl_wallet_ext` B ",
									  	 "ON ",
										 "A.MSISDN = B.MSISDN ",
										 "SET ",
										 "A.`StakeCountTracker` = (A.`StakeCountTracker` + 1),",
										 "B.`Balance` = (B.`Balance` - '",TRIM(BET_AMOUNT),"'),",
										 "A.`DateModified` = '",NOW(),"'",
									  	 "WHERE ",
										 "A.`MSISDN` = '",TRIM(MSISDN),"' AND A.`IsLocked` = '0'");									
				PREPARE stmt_0 FROM @qry1;
				EXECUTE stmt_0;
				DEALLOCATE PREPARE stmt_0;
				
				
				
				SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Place a Bet"}') AS json_result;
			ELSE
				
				
				
				SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Insufficient Balance","OPERATION":"Place a Bet"}') AS json_result;			
			END IF;
		ELSE
			
			
			
			SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Account does not Exist.","OPERATION":"Place a Bet"}') AS json_result;	
		END IF;
	END IF;
	
	
	
	SET @qry = NULL;
	SET MSISDN = NULL;
	SET BET_AMOUNT = NULL;
	SET @USER_MSISDN = NULL;
	SET @CURRENT_BAL = NULL;	
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProqClientRegister` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientRegister`(
	IN `MSISDN` VARCHAR(50),
	IN `CLIENT_ID` VARCHAR(50)
)
BEGIN

	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
  	BEGIN
	    ROLLBACK;
	    RESIGNAL;
	END;
	
	IF(TRIM(MSISDN) = "" || TRIM(CLIENT_ID) = "") THEN
		
		
		
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid Input","OPERATION":"Register User"}') AS json_result;
	ELSE
	
	   START TRANSACTION;
	   
	   SET @qry  = CONCAT("SELECT ",
		                   "COUNT(A.MSISDN) ",
								 "INTO ",
								 "@MSISDN_FOUND ",
								 "FROM ",
								 "tbl_wallet A ",
								 "INNER JOIN ",
								 "tbl_wallet_ext B ", 
								 "ON ",
								 "A.MSISDN=B.MSISDN ",
								 "WHERE ",
								 "A.MSISDN = '",TRIM(MSISDN),"'");
								
		PREPARE stmt_0 FROM @qry;
		EXECUTE stmt_0;
		DEALLOCATE PREPARE stmt_0; 
		
		
		
		IF(@MSISDN_FOUND = "0") THEN
			SET @qry2 = CONCAT("INSERT INTO tbl_wallet(`MSISDN`,`ClientId`,`DateCreated`,`LastActivity`) VALUES('",TRIM(MSISDN),"','",TRIM(CLIENT_ID),"','",NOW(),"','",NOW(),"') ");
			PREPARE stmt_1 FROM @qry2;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1; 
			
			SET @qry3 = CONCAT("INSERT INTO tbl_wallet_ext(`MSISDN`,`Password`) VALUES('",TRIM(MSISDN),"','0')");
			PREPARE stmt_2 FROM @qry3;
			EXECUTE stmt_2;
			DEALLOCATE PREPARE stmt_2; 
			
			
			
			SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Register User"}') AS json_result;
		ELSE
			
			
			
			SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - User Exist","OPERATION":"Register User"}') AS json_result;							
		END IF;
		
		COMMIT;	
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProqClientUtiliseBonus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientUtiliseBonus`(
	IN `MSISDN` VARCHAR(15),
	IN `BONUS` DECIMAL(10,2)
)
BEGIN
	IF(TRIM(MSISDN) = "" || TRIM(BONUS) = "") THEN
		
		
		
		SELECT CONCAT('{"RESULT":"0","MESSAGE","Unsuccessful - Invalid Input","OPERATION":"Utilise Bonus"}') AS json_result;
	ELSE
	
	
	
   SET @qry1 = CONCAT("SELECT ",
	                   "COUNT(A.MSISDN), B.Bonus ",
							 "INTO ",
							 "@MSISDN_XFOUND, @BONUS_BAL ",
							 "FROM ",
							 "tbl_wallet A ",
							 "INNER JOIN ",
							 "tbl_wallet_ext B ", 
							 "ON ",
							 "A.MSISDN=B.MSISDN ",
							 "WHERE ",
							 "A.MSISDN = '",TRIM(MSISDN),"'");
							 
	PREPARE stmt_0 FROM @qry1;
	EXECUTE stmt_0;
	DEALLOCATE PREPARE stmt_0; 
	
	
	
   IF(@MSISDN_XFOUND > "0") THEN
   	IF(@BONUS_BAL >= BONUS) THEN
			SET @qry2 = CONCAT("UPDATE ",
			                   "tbl_wallet A ",
			                   "INNER JOIN ",
									 "tbl_wallet_ext B ",
								  	 "ON ",
									 "A.MSISDN = B.MSISDN ",
									 "SET ",
									 "B.Bonus = (B.Bonus - '",TRIM(BONUS),"'),",
									 "A.DateModified = '",NOW(),"'",
								  	 "WHERE ",
									 "A.MSISDN = '",TRIM(MSISDN),"' AND A.IsLocked = '0'");									
			PREPARE stmt_1 FROM @qry2;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1;
			
			
			
			SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Utilise Bonus"}') AS json_result;
		ELSE
			
			
			
			SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Insufficient Bonus","OPERATION":"Utilise Bonus"}') AS json_result;			
		END IF;
	ELSE
		
		
		
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Account does not Exist.","OPERATION":"Utilise Bonus"}') AS json_result;	
	END IF;
END IF;



SET @qry = NULL;
SET MSISDN = NULL;
SET BONUS = NULL;
SET @MSISDN_XFOUND = NULL;
SET @BONUS_BAL = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProqClientWithdraw` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientWithdraw`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DECIMAL(10,2)
)
BEGIN
IF(TRIM(MSISDN) = "" || TRIM(AMOUNT) = "") THEN
	
	
	
	SELECT CONCAT('{"RESULT":"0","MESSAGE","Unsuccessful - Invalid Input","OPERATION":"Withdraw E-Cash"}') AS json_result;
ELSE
	
	
	
   SET @qry1 = CONCAT("SELECT ",
	                   "COUNT(A.MSISDN), B.Balance ",
							 "INTO ",
							 "@MSISDN_FOUND, @WALLET_BAL ",
							 "FROM ",
							 "tbl_wallet A ",
							 "INNER JOIN ",
							 "tbl_wallet_ext B ", 
							 "ON ",
							 "A.MSISDN=B.MSISDN ",
							 "WHERE ",
							 "A.MSISDN = '",TRIM(MSISDN),"'");
	PREPARE stmt_0 FROM @qry1;
	EXECUTE stmt_0;
	DEALLOCATE PREPARE stmt_0; 
	
	
	
   IF(@MSISDN_FOUND > "0") THEN
   	IF(@WALLET_BAL >= AMOUNT) THEN
			SET @qry2 = CONCAT("UPDATE ",
			                   "tbl_wallet A ",
			                   "INNER JOIN ",
									 "tbl_wallet_ext B ",
								  	 "ON ",
									 "A.MSISDN = B.MSISDN ",
									 "SET ",
									 "B.Balance = (B.Balance - '",TRIM(AMOUNT),"'),",
									 "A.DateModified = '",NOW(),"'",
								  	 "WHERE ",
									 "A.MSISDN = '",TRIM(MSISDN),"' AND A.IsLocked = '0'");									
			PREPARE stmt_1 FROM @qry2;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1;
			
			
			
			SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Withdraw E-Cash"}') AS json_result;
		ELSE
			
			
			
			SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Insufficient Balance","OPERATION":"Withdraw E-Cash"}') AS json_result;			
		END IF;
	ELSE
		
		
		
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Account does not Exist.","OPERATION":"Withdraw E-Cash"}') AS json_result;	
	END IF;
END IF;



SET @qry = NULL;
SET MSISDN = NULL;
SET AMOUNT = NULL;
SET @MSISDN_FOUND = NULL;
SET @WALLET_BAL = NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProqHandleInboundSms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqHandleInboundSms`(
	IN `_Source` VARCHAR(50),
	IN `_Message` VARCHAR(450),
	IN `_Destination` VARCHAR(50),
	IN `_LinkID` VARCHAR(50)

)
BEGIN
	IF(TRIM(_Source) = "" || TRIM(_Message) = "" || TRIM(_Destination) = "" || TRIM(_LinkID) = "") THEN
		
		
		
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid Input","OPERATION":"Queue Message"}') AS json_result;
	ELSE
		SET @qry = CONCAT("INSERT ",
		                  "INTO  ",
								"`tbl_incoming_sms` ",
								"(`MSISDN`,`Message`,`ShortCode`,`LinkID`,`DateCreated`) ",
								"VALUES ",
								"('",TRIM(_Source),"','",TRIM(_Message),"','",TRIM(_Destination),"','",TRIM(_LinkID),"','",NOW(),"')");
		PREPARE stmt_1 FROM @qry;
		EXECUTE stmt_1;
		DEALLOCATE PREPARE stmt_1; 
		
		
		
		SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Queue Message","PAYLOAD":{"phone":"',TRIM(_Source),'","message":"',TRIM(_Message),'","linkid":"',TRIM(_LinkID),'"}}') AS json_result;		
	END IF;



SET @qry = NULL;
SET _Source = NULL;
SET _Message = NULL;
SET _Destination = NULL;
SET _LinkID = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProqHandleOutboundSms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqHandleOutboundSms`(
	IN `_Destination` VARCHAR(15),
	IN `_Source` VARCHAR(10),
	IN `_Message` VARCHAR(480)
)
BEGIN
	IF(TRIM(_Destination) = "" || TRIM(_Source) = "" || TRIM(_Message) = "") THEN
		
		
		
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid Input","OPERATION":"Queue Message"}') AS json_result;
	ELSE
		SET @qry = CONCAT("INSERT ",
		                  "INTO  ",
								"`tbl_outgoing_sms` ",
								"(`Destination`,`Source`,`Message`,`DateCreated`) ",
								"VALUES ",
								"('",TRIM(_Destination),"','",TRIM(_Source),"','",TRIM(_Message),"','",NOW(),"')");
		PREPARE stmt_1 FROM @qry;
		EXECUTE stmt_1;
		DEALLOCATE PREPARE stmt_1; 
		
		
		
		SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Queue Message"}') AS json_result;		
	END IF;



SET @qry = NULL;
SET _Destination = NULL;
SET _Source = NULL;
SET _Message = NULL;	

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProqLogWalletMoneyMovement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqLogWalletMoneyMovement`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DECIMAL(7,2),
	IN `FLAG` CHAR(5)
)
BEGIN
	IF(TRIM(MSISDN) = "" || TRIM(AMOUNT) = "" || TRIM(FLAG) = "") THEN
		
		
		
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid Input","OPERATION":"Wallet monies movement"}') AS json_result;
	ELSE
		
		
		
		SET @qry = CONCAT("SELECT ", 
		                  "COUNT(A.MSISDN), ",
			               "IFNULL(B.Balance,0.00) ",
			               "INTO ",
			               "@EXIST_WM,@BALANCE_WM ",
			               "FROM ",
			               "`tbl_wallet` A ",
			               "INNER JOIN ",
			               "`tbl_wallet_ext` B ",
			               "ON ",
			               "A.MSISDN=B.MSISDN ",
			               "WHERE "
			               "A.MSISDN = '",TRIM(MSISDN),"' AND A.IsLocked = '0'");
									
			PREPARE stmt_1 FROM @qry;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1;
			
			
			
			IF(@EXIST_WM > "0")THEN
				IF(UPPER(TRIM(FLAG)) = "CR") THEN
					
					
					
					SET @TX_DETAILS = CONCAT("'","Deposit of ",TRIM(AMOUNT),"'");				
					
					
					
					SET @NEW_BALANCE = (@BALANCE_WM + AMOUNT);
					
					
					
					SET @qry = CONCAT("INSERT ",
					                  "INTO ",
									      "`tbl_withdrawal_log` ",
									      "(`msisdn`,`particulars`,`cr`,`balance`) ",
									      "VALUES ",
									      "(",TRIM(MSISDN),",",@TX_DETAILS,",",TRIM(AMOUNT),",",@NEW_BALANCE,")");
					PREPARE stmt_1 FROM @qry;
					EXECUTE stmt_1;
					DEALLOCATE PREPARE stmt_1;
					
					
					
					SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Wallet monies movement"}') AS json_result;											      
				ELSE
					
					
					
					SET @TX_DETAILS = CONCAT("'","Withdrawal of ",TRIM(AMOUNT),"'");					
					
					
					
					SET @NEW_BALANCE = (@BALANCE_WM - AMOUNT);
					
					
					
					SET @qry = CONCAT("INSERT ",
					                  "INTO ",
									      "`tbl_withdrawal_log` ",
									      "(`msisdn`,`particulars`,`dr`,`balance`) ",
									      "VALUES ",
									      "(",TRIM(MSISDN),",",@TX_DETAILS,",",TRIM(AMOUNT),",",@NEW_BALANCE,")");
					PREPARE stmt_1 FROM @qry;
					EXECUTE stmt_1;
					DEALLOCATE PREPARE stmt_1; 		
					
					
					
					SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Wallet monies movement"}') AS json_result;
				END IF;
			ELSE
				
				
				
				SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful: Customer Not Found","OPERATION":"Wallet monies movement"}') AS json_result;			
			END IF;
	END IF;
	
	
	
	SET @qry         = NULL;
	SET @EXIST_WM    = NULL;
	SET @BALANCE_WM  = NULL;
	SET @NEW_BALANCE = NULL;
	SET @TX_DETAILS  = NULL;
	SET MSISDN       = NULL;
	SET AMOUNT       = NULL;		

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProqLogWithdrawalFee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqLogWithdrawalFee`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DECIMAL(7,2),
	IN `FEE` DECIMAL(7,2)
)
BEGIN
	IF(TRIM(MSISDN) = "" || TRIM(AMOUNT) = "" || TRIM(FEE) = "") THEN
		
		
		
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid Input","OPERATION":"Log Fees"}') AS json_result;
	ELSE
		
		
		
		SET @qry = CONCAT("SELECT COUNT(`fee_id`) INTO @EXIST_WF FROM `tbl_fee_log` WHERE `is_archived` = '0'");
		PREPARE stmt_0 FROM @qry;
		EXECUTE stmt_0;
		DEALLOCATE PREPARE stmt_0;	
		
		SET @PARTICULARS = CONCAT("Fees ",TRIM(FEE)," Earned from ",TRIM(AMOUNT)," from TX initiated by: ",TRIM(MSISDN));
		
		select @PARTICULARS;
		
		
		
		IF(@EXIST_WF = "0") THEN			
			
			
			
			SET @qry = CONCAT("INSERT ",
			                  "INTO ",
							      "`tbl_fee_log` ",
							      "(`msisdn`,`particulars`,`cr`,`balance`) ",
							      "VALUES ",
							      "(",TRIM(MSISDN),",","'",@PARTICULARS,"'",",","'",TRIM(FEE),"'",",","'",TRIM(FEE),"'",")");
			PREPARE stmt_1 FROM @qry;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1;
		ELSE
			
			
			
			SET @qry = CONCAT("SELECT `balance` INTO @PREVIOUS_BALANCE FROM `tbl_fee_log` ORDER BY `fee_id` DESC LIMIT 1");
			PREPARE stmt_1 FROM @qry;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1;						
			
			
			
			SET @FEE_COLLECTION = (@PREVIOUS_BALANCE + FEE);
			
			
			
			SET @qry = CONCAT("INSERT ",
			                  "INTO ",
							      "`tbl_fee_log` ",
							      "(`msisdn`,`particulars`,`cr`,`balance`) ",
							      "VALUES ",
							      "(",TRIM(MSISDN),",","'",@PARTICULARS,"'",",","'",TRIM(FEE),"'",",","'",TRIM(@FEE_COLLECTION),"'",")");
			PREPARE stmt_2 FROM @qry;
			EXECUTE stmt_2;
			DEALLOCATE PREPARE stmt_2;							
		END IF;
		
		
		
		SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Wallet monies movement"}') AS json_result;
	END IF;
	
	
	
	SET @qry              = NULL;
	SET @EXIST_WF         = NULL;
	SET @FEE_COLLECTION   = NULL;
	SET @PREVIOUS_BALANCE = NULL;
	SET FEE               = NULL;
	SET MSISDN            = NULL;
	SET AMOUNT            = NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `db_freknur_general`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_freknur_general` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_freknur_general`;

--
-- Table structure for table `tbl_activity_log`
--

DROP TABLE IF EXISTS `tbl_activity_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_activity_log` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(15) DEFAULT NULL,
  `activity` varchar(420) DEFAULT NULL,
  `time_stamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `flag` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `msisdn` (`msisdn`),
  KEY `flag` (`flag`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_activity_log`
--

LOCK TABLES `tbl_activity_log` WRITE;
/*!40000 ALTER TABLE `tbl_activity_log` DISABLE KEYS */;
INSERT INTO `tbl_activity_log` VALUES (1,'4915224043369','FREKNUR TOKEN WORTH: 0.0100 HAS BEEN BOUGHT.','2022-10-06 09:51:33',0),(2,'4915224043369','A LOAN REQUEST OF 2500 HAS BEEN MADE.','2022-10-06 09:55:40',0),(3,'4915224043369','UNSECURED LOAN: AMOUNT OF 2450.0 HAS BEEN MOVED TO CLIENT WALLET A/C. REPAYMENT AMOUNT: 3125.0','2022-10-06 09:55:41',0),(4,'4915224043369','PURCHASE OF 10.00 TGP DIGITAL ASSETS @ COST OF 191.2 HAS BEEN MADE.','2022-10-11 09:12:18',0),(5,'4915224043369','FREKNUR TOKEN WORTH: 0.0100 HAS BEEN BOUGHT.','2022-10-11 09:12:18',0),(6,'254707132162','FREKNUR TOKEN WORTH: 0.0100 HAS BEEN BOUGHT.','2022-10-11 12:19:14',0),(7,'254707132162','PURCHASE OF 1.00 TGP DIGITAL ASSETS @ COST OF 19.12 HAS BEEN MADE.','2022-10-11 13:25:14',0),(8,'4915224043369','FREKNUR TOKEN WORTH: 0.0100 HAS BEEN BOUGHT.','2022-10-11 15:10:46',0),(9,'4915224043369','FREKNUR TOKEN WORTH: 0.0100 HAS BEEN BOUGHT.','2022-10-11 15:11:51',0),(10,'4915224043369','FREKNUR TOKEN WORTH: 0.0100 HAS BEEN BOUGHT.','2022-10-11 15:13:36',0),(11,'4915224043369','PURCHASE OF 10.00 CMC DIGITAL ASSETS @ COST OF 100 HAS BEEN MADE.','2022-10-11 15:13:36',0),(12,'4915224043369','INTENTION TO SELL 2.00 CMC SHARE[S] @ COST OF 50.00 THROUGH THE ALTERNATIVE MARKET.','2022-10-11 15:15:25',0),(13,'254707132162','INTENTION TO SELL 1.00 TGP SHARE[S] @ COST OF 500.00 THROUGH THE ALTERNATIVE MARKET.','2022-10-12 13:24:05',0),(14,'254707132162','A SELL REQUEST HAS BEEN WITHDRAWN BY OWNER.','2022-10-12 13:24:43',0),(15,'254707132162','INTENTION TO SELL 1.00 TGP SHARE[S] @ COST OF 57.00 THROUGH THE ALTERNATIVE MARKET.','2022-10-12 13:26:12',0),(16,'254707132162','A SELL REQUEST HAS BEEN WITHDRAWN BY OWNER.','2022-10-12 13:27:14',0),(17,'254707132162','INTENTION TO SELL 1.00 TGP SHARE[S] @ COST OF 18.75 THROUGH THE ALTERNATIVE MARKET.','2022-10-12 13:28:43',0),(18,'254707132162','A SELL REQUEST HAS BEEN WITHDRAWN BY OWNER.','2022-10-12 13:30:47',0),(19,'254707132162','INTENTION TO SELL 1.00 TGP SHARE[S] @ COST OF 18.75 THROUGH THE ALTERNATIVE MARKET.','2022-10-12 14:53:53',0),(20,'254707132162','A SELL REQUEST HAS BEEN WITHDRAWN BY OWNER.','2022-10-12 14:54:36',0),(21,'254707132162','INTENTION TO SELL 1.00 TGP SHARE[S] @ COST OF 18.75 THROUGH THE ALTERNATIVE MARKET.','2022-10-13 08:08:18',0),(22,'254707132162','A SELL REQUEST HAS BEEN WITHDRAWN BY OWNER.','2022-10-13 08:21:08',0),(23,'254707132162','INTENTION TO SELL 1.00 TGP SHARE[S] @ COST OF 25.0 THROUGH THE ALTERNATIVE MARKET.','2022-10-13 08:21:10',0),(24,'254707132162','A SELL REQUEST HAS BEEN WITHDRAWN BY OWNER.','2022-10-13 08:21:45',0),(25,'254707132162','INTENTION TO SELL 1.00 TGP SHARE[S] @ COST OF 800.00 THROUGH THE ALTERNATIVE MARKET.','2022-10-18 09:00:00',0),(26,'254707132162','A SELL REQUEST HAS BEEN WITHDRAWN BY OWNER.','2022-10-18 09:00:22',0);
/*!40000 ALTER TABLE `tbl_activity_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_debtor`
--

DROP TABLE IF EXISTS `tbl_debtor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_debtor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(50) DEFAULT NULL,
  `msisdn` varchar(15) NOT NULL,
  `amount_requested` double(15,2) DEFAULT '0.00',
  `amount_disbursed` double(15,2) DEFAULT '0.00',
  `repayment_amount` double(15,2) DEFAULT '0.00',
  `interest_amount` double(9,2) DEFAULT '0.00',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `expected_repayment_date` datetime DEFAULT NULL,
  `repayment_date` datetime DEFAULT NULL,
  `notification_count` int DEFAULT '0',
  `next_notification_date` datetime DEFAULT NULL,
  `is_repaid` int DEFAULT '0' COMMENT '1-Repaid|0-Unpaid',
  `is_archived` int DEFAULT '0' COMMENT '1-Archived|0-Not Archive',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_unik` (`reference_no`),
  KEY `reference_no` (`reference_no`),
  KEY `msisdn` (`msisdn`),
  KEY `is_repaid` (`is_repaid`),
  KEY `is_archived` (`is_archived`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_debtor`
--

LOCK TABLES `tbl_debtor` WRITE;
/*!40000 ALTER TABLE `tbl_debtor` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_debtor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_defaulter`
--

DROP TABLE IF EXISTS `tbl_defaulter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_defaulter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(15) NOT NULL,
  `loan_amount` double(15,2) DEFAULT '0.00',
  `amount_repaid` double(15,2) DEFAULT '0.00',
  `cummulative_interest` double(15,2) DEFAULT '0.00',
  `expected_repayment_date` datetime DEFAULT NULL,
  `notification_date` datetime DEFAULT NULL,
  `date_repaid` datetime DEFAULT NULL,
  `roll_count` int DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `msisdn` (`msisdn`),
  KEY `is_archived` (`is_archived`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_defaulter`
--

LOCK TABLES `tbl_defaulter` WRITE;
/*!40000 ALTER TABLE `tbl_defaulter` DISABLE KEYS */;
INSERT INTO `tbl_defaulter` VALUES (1,'4915224043369',3125.00,0.00,0.00,'2022-10-16 12:55:41','2023-08-16 08:55:42',NULL,0,'2022-10-16 08:55:42',NULL,0);
/*!40000 ALTER TABLE `tbl_defaulter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_loan_collateral`
--

DROP TABLE IF EXISTS `tbl_loan_collateral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_loan_collateral` (
  `_id` tinyint NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(15) NOT NULL,
  `loan_amount` double(15,2) NOT NULL DEFAULT '0.00',
  `portfolio_worth` decimal(15,8) DEFAULT '0.00000000',
  `collateral_percentage` decimal(15,8) DEFAULT '0.00000000',
  `is_processed` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  UNIQUE KEY `msisdn` (`msisdn`),
  KEY `is_reverted` (`is_processed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_loan_collateral`
--

LOCK TABLES `tbl_loan_collateral` WRITE;
/*!40000 ALTER TABLE `tbl_loan_collateral` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_loan_collateral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_loan_payout`
--

DROP TABLE IF EXISTS `tbl_loan_payout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_loan_payout` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(50) NOT NULL,
  `msisdn` varchar(15) NOT NULL,
  `amount` double(15,2) DEFAULT '0.00',
  `collateral_percentage` double(15,2) DEFAULT '0.00',
  `approved_by` varchar(25) DEFAULT NULL,
  `status` int DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT NULL,
  `has_collateral` int DEFAULT '0',
  `is_processed` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_unik` (`reference_no`),
  KEY `msisdn` (`msisdn`),
  KEY `is_processed` (`is_processed`),
  KEY `request_id` (`reference_no`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_loan_payout`
--

LOCK TABLES `tbl_loan_payout` WRITE;
/*!40000 ALTER TABLE `tbl_loan_payout` DISABLE KEYS */;
INSERT INTO `tbl_loan_payout` VALUES (1,'LNR-JX4IIS5QOY','4915224043369',2500.00,0.00,'admin',0,'2022-10-06 12:55:40','2022-10-06 09:55:41',0,1);
/*!40000 ALTER TABLE `tbl_loan_payout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_loan_repayment`
--

DROP TABLE IF EXISTS `tbl_loan_repayment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_loan_repayment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(15) NOT NULL,
  `amount` double(15,2) DEFAULT '0.00',
  `transaction_no` varchar(25) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_processed` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_no` (`transaction_no`),
  KEY `trxunik` (`transaction_no`),
  KEY `msisdn` (`msisdn`),
  KEY `is_processed` (`is_processed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_loan_repayment`
--

LOCK TABLES `tbl_loan_repayment` WRITE;
/*!40000 ALTER TABLE `tbl_loan_repayment` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_loan_repayment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_loan_request`
--

DROP TABLE IF EXISTS `tbl_loan_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_loan_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(50) DEFAULT NULL COMMENT 'loan request reference',
  `msisdn` varchar(50) NOT NULL COMMENT 'loanee identifier',
  `amount` double(15,2) DEFAULT '0.00',
  `collateral_percentage` double(15,2) DEFAULT '0.00',
  `task_flag` varchar(1) DEFAULT '0',
  `requested_by` varchar(50) DEFAULT NULL,
  `approved_by` varchar(50) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `has_collateral` int NOT NULL DEFAULT '0',
  `is_processed` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `msisdn_unik` (`msisdn`),
  UNIQUE KEY `ref_no` (`reference_no`),
  KEY `is_processed` (`is_processed`),
  KEY `msisdn` (`msisdn`),
  KEY `has_collateral` (`has_collateral`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_loan_request`
--

LOCK TABLES `tbl_loan_request` WRITE;
/*!40000 ALTER TABLE `tbl_loan_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_loan_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_loan_temp_list`
--

DROP TABLE IF EXISTS `tbl_loan_temp_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_loan_temp_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(15) DEFAULT NULL,
  `loan_amount` double(15,2) DEFAULT '0.00',
  `interest` double(15,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_loan_temp_list`
--

LOCK TABLES `tbl_loan_temp_list` WRITE;
/*!40000 ALTER TABLE `tbl_loan_temp_list` DISABLE KEYS */;
INSERT INTO `tbl_loan_temp_list` VALUES (1,'4915224043369',3125.00,625.00);
/*!40000 ALTER TABLE `tbl_loan_temp_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_message_template`
--

DROP TABLE IF EXISTS `tbl_message_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_message_template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` varchar(150) NOT NULL,
  `category` varchar(50) NOT NULL,
  `flag` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `flag` (`flag`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_message_template`
--

LOCK TABLES `tbl_message_template` WRITE;
/*!40000 ALTER TABLE `tbl_message_template` DISABLE KEYS */;
INSERT INTO `tbl_message_template` VALUES (1,'Dear {0}, Your loan of {1} is due on {2}. Please arrange to settle the Outstanding Loan.','LOAN_ALERT',0),(2,'Dear {0}, Your loan of {1} has accrued interest of {2}. Total Outstanding Loan: {3}.','DEFAULTER_ALERT',0);
/*!40000 ALTER TABLE `tbl_message_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_mpesa_receipt`
--

DROP TABLE IF EXISTS `tbl_mpesa_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_mpesa_receipt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(50) NOT NULL DEFAULT '0',
  `msisdn` varchar(15) NOT NULL,
  `amount` double(15,2) DEFAULT '0.00',
  `status` varchar(2500) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_unik` (`reference_no`),
  KEY `msisdn` (`msisdn`),
  KEY `is_archived` (`is_archived`),
  KEY `reference_no` (`reference_no`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_mpesa_receipt`
--

LOCK TABLES `tbl_mpesa_receipt` WRITE;
/*!40000 ALTER TABLE `tbl_mpesa_receipt` DISABLE KEYS */;
INSERT INTO `tbl_mpesa_receipt` VALUES (1,'CSHO-C5F6069E','254707132162',10.00,NULL,'2022-09-23 17:05:26','2022-09-23 14:05:26',0),(2,'CSHO-32F6B51E','254707132162',10.00,NULL,'2022-09-23 17:08:29','2022-09-23 14:08:29',0);
/*!40000 ALTER TABLE `tbl_mpesa_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_notification`
--

DROP TABLE IF EXISTS `tbl_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_notification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` varchar(50) NOT NULL,
  `msisdn` varchar(15) NOT NULL,
  `message` varchar(750) NOT NULL,
  `category` varchar(25) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_downloaded` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  KEY `msisdn` (`msisdn`),
  KEY `is_downloaded` (`is_downloaded`),
  KEY `category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_notification`
--

LOCK TABLES `tbl_notification` WRITE;
/*!40000 ALTER TABLE `tbl_notification` DISABLE KEYS */;
INSERT INTO `tbl_notification` VALUES (1,'e11a8769-3c98-11ec-b4e0-42010aa40002','393519688608','I have made an offer to purchase your EQTY share(s) for 12.83 per unit. The offer expires in 3hours.','SYS_ALERT','2021-11-03 14:26:25','2021-11-03 11:26:25',0),(2,'d543249a-3d62-11ec-b4e0-42010aa40002','254722563707','Dear Customer, Your loan of 1150.00 is due on 2021-11-04 22:32:03. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2021-11-04 14:32:03','2021-11-04 11:32:03',0),(3,'d5cdcfcf-3d62-11ec-b4e0-42010aa40002','254722563707','Dear Customer, Your loan of 1150.00 is due on 2021-11-04 22:32:03. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2021-11-04 14:32:04','2021-11-04 11:32:04',0),(4,'989e9133-3d73-11ec-b4e0-42010aa40002','254722563707','Dear Customer, Your loan of 1150.00 is due on 2021-11-04 22:32:03. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2021-11-04 16:32:03','2021-11-04 13:32:03',0),(5,'5c25a747-3d84-11ec-b4e0-42010aa40002','254722563707','Dear Customer, Your loan of 1150.00 is due on 2021-11-04 22:32:03. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2021-11-04 18:32:03','2021-11-04 15:32:03',0),(6,'07c3c49f-4147-11ec-b4e0-42010aa40002','393519688608','I have made an offer to purchase your EQTY share(s) for 14.17 per unit. The offer expires in 3hours.','SYS_ALERT','2021-11-09 13:23:07','2021-11-09 10:23:07',0),(7,'2149c68e-41a8-11ec-b4e0-42010aa40002','393519688608','I have made an offer to purchase your EQTY share(s) for 14.17 per unit. The offer expires in 3hours.','SYS_ALERT','2021-11-10 00:58:11','2021-11-09 21:58:11',0),(8,'f14445e9-41aa-11ec-b4e0-42010aa40002','254711000000','I have made an offer to purchase your EQTY share(s) for 14.17 per unit. The offer expires in 3hours.','SYS_ALERT','2021-11-10 01:18:18','2021-11-09 22:18:18',0),(9,'0f76a56c-41b0-11ec-b4e0-42010aa40002','254711000000','I have made an offer to purchase your EQTY share(s) for 14.17 per unit. The offer expires in 3hours.','SYS_ALERT','2021-11-10 01:54:57','2021-11-09 22:54:57',0),(10,'7831b509-41b0-11ec-b4e0-42010aa40002','254722563707','I have made an offer to purchase your EQTY share(s) for 14.17 per unit. The offer expires in 3hours.','SYS_ALERT','2021-11-10 01:57:52','2021-11-09 22:57:52',0),(11,'598b9f16-42d6-11ec-b4e0-42010aa40002','254722563707','I have made an offer to purchase your SMRT share(s) for 21.08 per unit. The offer expires in 3hours.','SYS_ALERT','2021-11-11 13:01:33','2021-11-11 10:01:33',0),(12,'b7b16706-44ec-11ec-b4e0-42010aa40002','254720726071','Dear Customer, Your loan of 625.00 is due on 2021-11-14 12:46:42. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2021-11-14 04:46:42','2021-11-14 01:46:42',0),(13,'b82e8de9-44ec-11ec-b4e0-42010aa40002','254720726071','Dear Customer, Your loan of 625.00 is due on 2021-11-14 12:46:42. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2021-11-14 04:46:43','2021-11-14 01:46:43',0),(14,'7b12ea89-44fd-11ec-b4e0-42010aa40002','254720726071','Dear Customer, Your loan of 625.00 is due on 2021-11-14 12:46:42. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2021-11-14 06:46:42','2021-11-14 03:46:42',0),(15,'3e83ef5f-450e-11ec-b4e0-42010aa40002','254720726071','Dear Customer, Your loan of 625.00 is due on 2021-11-14 12:46:42. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2021-11-14 08:46:42','2021-11-14 05:46:42',0),(16,'44cae99c-af58-11ec-b4e0-42010aa40002','254720726071','I have made an offer to purchase your EQTY share(s) for 9.69 per unit. The offer expires in 3hours.','SYS_ALERT','2022-03-29 15:03:38','2022-03-29 12:03:38',0),(17,'57573621-b92f-11ec-b4e0-42010aa40002','393519688608','Dear Customer, Your loan of 899.86 is due on 2022-04-11 11:35:52. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-04-11 03:35:52','2022-04-11 00:35:52',0),(18,'57d462b9-b92f-11ec-b4e0-42010aa40002','393519688608','Dear Customer, Your loan of 899.86 is due on 2022-04-11 11:35:52. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-04-11 03:35:52','2022-04-11 00:35:52',0),(19,'1b46ae12-b940-11ec-b4e0-42010aa40002','393519688608','Dear Customer, Your loan of 899.86 is due on 2022-04-11 11:35:52. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-04-11 05:35:52','2022-04-11 02:35:52',0),(20,'dec55e09-b950-11ec-b4e0-42010aa40002','393519688608','Dear Customer, Your loan of 899.86 is due on 2022-04-11 11:35:52. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-04-11 07:35:52','2022-04-11 04:35:52',0),(21,'ae8379b5-c1e1-11ec-b4e0-42010aa40002','254707132162','Dear Customer, Your loan of 625.00 is due on 2022-04-22 13:12:38. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-04-22 05:12:38','2022-04-22 02:12:38',0),(22,'af01230b-c1e1-11ec-b4e0-42010aa40002','254707132162','Dear Customer, Your loan of 625.00 is due on 2022-04-22 13:12:38. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-04-22 05:12:38','2022-04-22 02:12:38',0),(23,'724021b1-c1f2-11ec-b4e0-42010aa40002','254707132162','Dear Customer, Your loan of 625.00 is due on 2022-04-22 13:12:38. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-04-22 07:12:38','2022-04-22 04:12:38',0),(24,'35d9dd1a-c203-11ec-b4e0-42010aa40002','254707132162','Dear Customer, Your loan of 625.00 is due on 2022-04-22 13:12:38. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-04-22 09:12:38','2022-04-22 06:12:38',0),(25,'9eb3868d-cc40-11ec-b4e0-42010aa40002','393519688608','Dear Customer, Your loan of 3642.50 is due on 2022-05-05 17:57:25. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-05-05 09:57:25','2022-05-05 06:57:25',0),(26,'9f312673-cc40-11ec-b4e0-42010aa40002','393519688608','Dear Customer, Your loan of 3642.50 is due on 2022-05-05 17:57:25. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-05-05 09:57:26','2022-05-05 06:57:26',0),(27,'62386687-cc51-11ec-b4e0-42010aa40002','393519688608','Dear Customer, Your loan of 3642.50 is due on 2022-05-05 17:57:25. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-05-05 11:57:25','2022-05-05 08:57:25',0),(28,'25d7e9fa-cc62-11ec-b4e0-42010aa40002','393519688608','Dear Customer, Your loan of 3642.50 is due on 2022-05-05 17:57:25. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-05-05 13:57:25','2022-05-05 10:57:25',0),(29,'b7ae9ea6-e27b-11ec-aa9d-42010aa40002','393519688608','I have made an offer to purchase your KCB share(s) for 13.95 per unit. The offer expires in 3hours.','SYS_ALERT','2022-06-02 16:55:53','2022-06-02 13:55:53',0),(30,'b9685b26-e27b-11ec-aa9d-42010aa40002','254722563707','I have made an offer to purchase your KCB share(s) for 13.95 per unit. The offer expires in 3hours.','SYS_ALERT','2022-06-02 16:55:56','2022-06-02 13:55:56',0),(31,'2ca2c575-09d2-11ed-aa9d-42010aa40002','4915224043369','I have made an offer to purchase your HFCK share(s) for 16.96 per unit. The offer expires in 3hours.','SYS_ALERT','2022-07-22 18:23:01','2022-07-22 15:23:01',0),(32,'1d001664-0d95-11ed-aa9d-42010aa40002','254722563707','I have made an offer to purchase your EQTY share(s) for 29.07 per unit. The offer expires in 3hours.','SYS_ALERT','2022-07-27 13:16:00','2022-07-27 10:16:00',0),(33,'09b60105-202a-11ed-aa9d-42010aa40002','4915224043369','Dear Customer, Your loan of 990.25 is due on 2022-08-20 12:47:24. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-08-20 04:47:24','2022-08-20 01:47:24',0),(34,'0a2ce794-202a-11ed-aa9d-42010aa40002','4915224043369','Dear Customer, Your loan of 990.25 is due on 2022-08-20 12:47:24. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-08-20 04:47:24','2022-08-20 01:47:24',0),(35,'cd6d7c39-203a-11ed-aa9d-42010aa40002','4915224043369','Dear Customer, Your loan of 990.25 is due on 2022-08-20 12:47:24. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-08-20 06:47:24','2022-08-20 03:47:24',0),(36,'90e5e2df-204b-11ed-aa9d-42010aa40002','4915224043369','Dear Customer, Your loan of 990.25 is due on 2022-08-20 12:47:24. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-08-20 08:47:24','2022-08-20 05:47:24',0),(37,'e4fe001b-221c-11ed-aa9d-42010aa40002','491522404336','I have made an offer to purchase your HFCK share(s) for 13.57 per unit. The offer expires in 3hours.','SYS_ALERT','2022-08-22 16:18:21','2022-08-22 13:18:21',0),(38,'54e341fa-225d-11ed-aa9d-42010aa40002','4915224043369','I have made an offer to purchase your HFCK share(s) for 13.57 per unit. The offer expires in 3hours.','SYS_ALERT','2022-08-22 23:59:36','2022-08-22 20:59:36',0),(39,'82ffd9a3-22b9-11ed-aa9d-42010aa40002','4915224043369','I have made an offer to purchase your HFCK share(s) for 13.57 per unit. The offer expires in 3hours.','SYS_ALERT','2022-08-23 10:59:28','2022-08-23 07:59:28',0),(40,'9765be96-2c66-11ed-aa9d-42010aa40002','254722563707','Dear CUSTOMER, Your loan of 1150.00 has accrued interest of 2.4. Total Outstanding Loan: 1152.4.','DEFAULTER_ALERT','2022-09-04 18:31:05','2022-09-04 15:31:05',0),(41,'79869366-33f0-11ed-aa9d-42010aa40002','254720726071','Dear CUSTOMER, Your loan of 625.00 has accrued interest of 1.3. Total Outstanding Loan: 626.3.','DEFAULTER_ALERT','2022-09-14 08:45:44','2022-09-14 05:45:44',0),(42,'a3a6289f-4cf5-11ed-aa9d-42010aa40002','4915224043369','Dear Customer, Your loan of 3125.00 is due on 2022-10-16 12:55:41. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-10-16 04:55:41','2022-10-16 01:55:41',0),(43,'a41c4e5e-4cf5-11ed-aa9d-42010aa40002','4915224043369','Dear Customer, Your loan of 3125.00 is due on 2022-10-16 12:55:41. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-10-16 04:55:42','2022-10-16 01:55:42',0),(44,'66fcb0eb-4d06-11ed-aa9d-42010aa40002','4915224043369','Dear Customer, Your loan of 3125.00 is due on 2022-10-16 12:55:41. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-10-16 06:55:41','2022-10-16 03:55:41',0),(45,'2ad9313f-4d17-11ed-aa9d-42010aa40002','4915224043369','Dear Customer, Your loan of 3125.00 is due on 2022-10-16 12:55:41. Please arrange to settle the Outstanding Loan.','LOAN_ALERT','2022-10-16 08:55:41','2022-10-16 05:55:41',0);
/*!40000 ALTER TABLE `tbl_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_owner_portfolio_temp_list`
--

DROP TABLE IF EXISTS `tbl_owner_portfolio_temp_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_owner_portfolio_temp_list` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) NOT NULL,
  `asset_id` varchar(20) NOT NULL,
  `asset_acronym` varchar(20) NOT NULL,
  `number_of_asset` decimal(15,8) DEFAULT '0.00000000',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` int DEFAULT '0',
  `lock` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `msisdn_indx` (`msisdn`),
  KEY `asset_id_indx` (`asset_id`),
  KEY `is_active_indx` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_owner_portfolio_temp_list`
--

LOCK TABLES `tbl_owner_portfolio_temp_list` WRITE;
/*!40000 ALTER TABLE `tbl_owner_portfolio_temp_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_owner_portfolio_temp_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_rejected_loan`
--

DROP TABLE IF EXISTS `tbl_rejected_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_rejected_loan` (
  `_id` tinyint NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `date_created` varchar(1000) DEFAULT NULL,
  `flag` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `flag` (`flag`),
  KEY `msisdn` (`msisdn`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_rejected_loan`
--

LOCK TABLES `tbl_rejected_loan` WRITE;
/*!40000 ALTER TABLE `tbl_rejected_loan` DISABLE KEYS */;
INSERT INTO `tbl_rejected_loan` VALUES (1,'254707132162','a','2021-11-20 01:47:11',0),(2,'254707132162','uu','2021-11-20 01:48:51',0),(3,'254707132162','s','2021-11-20 01:50:57',0),(4,'254707132162','ddd','2021-11-20 02:01:00',0),(5,'254707132162','ff','2022-03-06 20:19:37',0),(6,'254707132162','not applicable','2022-04-03 15:44:02',0),(7,'254707132162','rejected','2022-04-03 15:47:11',0),(8,'254519688608','not a subscriber','2022-04-03 18:20:37',0),(9,'254707132162','mmmm','2022-05-09 23:04:02',0),(10,'254707132162','sss','2022-06-14 13:19:11',0),(11,'254707132162',',,,,','2022-06-14 17:48:38',0),(12,'4915224043369','client request','2022-06-21 14:56:06',0),(13,'254707132162','has not credit rating info','2022-06-28 11:01:00',0),(14,'254707132162','mnmnm','2022-06-28 11:11:46',0),(15,'254707132162','cccc','2022-06-28 11:26:56',0),(16,'254707132162','sss','2022-06-28 11:32:46',0),(17,'254707132162','REASON FOR REJECTION - missing electronic copy of the National ID','2022-07-07 16:20:36',0),(18,'254707132162','kndjklsadlas','2022-07-12 17:59:10',0),(19,'254707132162','jfshjfhjdshjhjs test zero','2022-07-12 18:02:59',0),(20,'254707132162','test rejected','2022-07-12 18:07:14',0),(21,'254707132162','dddd','2022-07-12 18:09:22',0),(22,'254707132162','nmcxnmncm','2022-07-12 18:12:02',0),(23,'254707132162','ddd','2022-07-12 18:15:47',0),(24,'254707132162','www','2022-07-12 18:18:17',0),(25,'4915224043369','too few apps','2022-07-13 17:37:50',0),(26,'4915224043369','dont trust ya','2022-07-27 12:34:38',0);
/*!40000 ALTER TABLE `tbl_rejected_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_temp`
--

DROP TABLE IF EXISTS `tbl_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_temp` (
  `_id` bigint NOT NULL AUTO_INCREMENT,
  `_action` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`_id`)
) ENGINE=MEMORY AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_temp`
--

LOCK TABLES `tbl_temp` WRITE;
/*!40000 ALTER TABLE `tbl_temp` DISABLE KEYS */;
INSERT INTO `tbl_temp` VALUES (1,'4915224043369'),(2,'4915224043369'),(3,'4915224043369'),(4,'4915224043369'),(5,'4915224043369'),(6,'4915224043369'),(7,'4915224043369'),(8,'4915224043369'),(9,'4915224043369');
/*!40000 ALTER TABLE `tbl_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_transaction`
--

DROP TABLE IF EXISTS `tbl_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_code` varchar(50) NOT NULL,
  `reference_no` varchar(50) NOT NULL,
  `msisdn` varchar(15) NOT NULL,
  `cr` decimal(15,8) DEFAULT '0.00000000',
  `dr` decimal(15,8) DEFAULT '0.00000000',
  `balance` decimal(15,8) DEFAULT '0.00000000',
  `narration` text,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `msisdn` (`msisdn`),
  KEY `reference_no` (`reference_no`),
  KEY `account_id` (`account_code`),
  KEY `is_archived` (`is_archived`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_transaction`
--

LOCK TABLES `tbl_transaction` WRITE;
/*!40000 ALTER TABLE `tbl_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_wallet_transaction`
--

DROP TABLE IF EXISTS `tbl_wallet_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_wallet_transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(50) NOT NULL,
  `msisdn` varchar(15) NOT NULL,
  `cr` decimal(15,8) DEFAULT '0.00000000',
  `dr` decimal(15,8) DEFAULT '0.00000000',
  `balance` decimal(15,8) DEFAULT '0.00000000',
  `narration` text NOT NULL,
  `date_created` datetime DEFAULT NULL COMMENT 'transaction_date',
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `msisdn` (`msisdn`),
  KEY `is_archived` (`is_archived`),
  KEY `reference_no` (`reference_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_wallet_transaction`
--

LOCK TABLES `tbl_wallet_transaction` WRITE;
/*!40000 ALTER TABLE `tbl_wallet_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_wallet_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_freknur_general'
--

--
-- Current Database: `db_freknur_inventory`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_freknur_inventory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_freknur_inventory`;

--
-- Table structure for table `tbl_inventory`
--

DROP TABLE IF EXISTS `tbl_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_inventory` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `item_uid` varchar(50) NOT NULL,
  `item_name` varchar(65) NOT NULL,
  `item_image` varchar(250) DEFAULT 'no_image',
  `qty_in` int DEFAULT '0',
  `qty_out` int DEFAULT '0',
  `unit_price` decimal(15,2) DEFAULT '0.00',
  `date_created` datetime NOT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_available` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  UNIQUE KEY `item_uid` (`item_uid`),
  KEY `is_available` (`is_available`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_inventory`
--

LOCK TABLES `tbl_inventory` WRITE;
/*!40000 ALTER TABLE `tbl_inventory` DISABLE KEYS */;
INSERT INTO `tbl_inventory` VALUES (1,'26362','TEST_!','no_image',100000,0,156.00,'2021-04-29 19:15:46','2021-04-29 16:15:46',0),(2,'80010','TEST_!','no_image',100000,0,156.00,'2021-04-29 19:16:12','2021-04-29 16:16:12',0),(3,'93817','TEST_1','no_image',10000,0,145.00,'2021-04-29 19:16:30','2021-04-29 16:16:30',0),(4,'23777','TEST_1','no_image',10000,0,145.00,'2021-04-29 19:17:28','2021-04-29 16:17:28',0),(5,'24436','TEST_23','no_image',300,0,217.00,'2021-04-29 19:40:57','2021-04-29 16:40:57',0),(6,'24677','TEST_1','no_image',10000,0,145.00,'2021-04-29 20:34:33','2021-04-29 17:34:33',0),(7,'24622','TEST_1','no_image',10000,0,145.00,'2021-04-29 20:34:39','2021-04-29 17:34:39',0),(8,'10987','TEST_1','no_image',10000,0,145.00,'2021-04-29 20:38:51','2021-04-29 17:38:51',0),(9,'84594','TEST_1','no_image',10000,0,145.00,'2021-04-29 20:55:05','2021-04-29 17:55:05',0),(10,'13847','TEST_5','no_image',2300,0,10000.00,'2021-04-29 20:55:45','2021-04-29 17:55:45',0),(11,'20272','TEST_1','no_image',10000,0,145.00,'2021-04-29 21:01:29','2021-04-29 18:01:29',0),(12,'17971','TEST_1','no_image',10000,0,145.00,'2021-04-29 21:04:24','2021-04-29 18:04:24',0),(13,'10152','TEST_1','no_image',10000,0,145.00,'2021-04-29 21:16:00','2021-04-29 18:16:00',0),(14,'16397','TEST_1','no_image',10000,0,145.00,'2021-04-29 21:18:13','2021-04-29 18:18:13',0),(15,'22866','TEST_1','no_image',10000,0,145.00,'2021-04-29 21:20:01','2021-04-29 18:20:01',0),(16,'45575','TEST_1','no_image',10000,0,145.00,'2021-04-29 21:21:26','2021-04-29 18:21:26',0),(17,'20113','TEST_1','no_image',10000,0,145.00,'2021-04-29 21:24:57','2021-04-29 18:24:57',0),(18,'22322','NIMMM','https://api.betvantage.ke/freknur/dashboard/table/image_files/user.png',2000,0,10.00,'2021-04-29 21:25:37','2021-06-30 16:29:46',0),(19,'24964','TEST_1','https://api.betvantage.ke/freknur/dashboard/table/image_files/Freknur_Logo.PNG',10000,0,145.00,'2021-04-29 21:28:33','2021-06-30 16:16:39',0),(20,'16124','TEST_1','https://api.betvantage.ke/freknur/dashboard/table/inventory.php/image_files/Freknur_Logo.PNG',10000,0,145.00,'2021-04-29 21:28:40','2021-06-30 16:03:46',0),(21,'25167','TST12345','https://api.betvantage.ke/freknur/dashboard/table/inventory.php/image_files/Freknur_Logo.PNG',40000,0,5600.00,'2021-04-29 21:50:26','2021-06-30 16:02:11',0),(22,'14531','TEST!\"£a','https://api.betvantage.ke/freknur/dashboard/table/inventory.php/image_files/Freknur_Logo.PNG',6700,0,123.00,'2021-04-29 21:54:56','2021-06-30 15:58:21',0),(23,'10977','yeoeoeo','https://api.freknur.com/dashboard/table/image_files/rating.png',1344,0,132.00,'2021-04-29 23:15:39','2021-09-22 22:33:45',0),(24,'12577','TEST_1','https://api.freknur.com/dashboard/table/image_files/Freknur_Logo.PNG',10000,0,145.00,'2021-04-30 00:25:46','2021-09-10 10:43:25',0),(25,'11086','TEST_1','https://api.freknur.com/dashboard/table/image_files/rating.png',10000,0,145.00,'2021-04-30 00:30:42','2021-08-11 13:29:35',0),(26,'71658','TEST_1','https://api.freknur.com/dashboard/table/image_files/user.png',10000,0,145.00,'2021-04-30 00:33:44','2021-07-28 22:12:23',0),(27,'26333','TYESAA','https://api.freknur.com/dashboard/table/image_files/Freknur_Logo.PNG',120,0,230.00,'2021-04-30 00:34:21','2021-07-28 12:53:34',0),(28,'16775','jam','https://api.freknur.com/dashboard/table/image_files/user.png',1000,0,105.00,'2021-07-02 23:09:25','2021-07-14 16:43:15',0),(29,'24413','test_aug_11','no_image',10,0,5.50,'2021-08-11 13:35:07','2021-08-11 10:35:08',0),(30,'54496','TEST_2233','no_image',1000,0,150.00,'2021-10-25 22:53:18','2021-10-25 19:53:18',0);
/*!40000 ALTER TABLE `tbl_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_sales`
--

DROP TABLE IF EXISTS `tbl_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_sales` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `product_uid` varchar(50) NOT NULL,
  `qty` int DEFAULT '0',
  `total` decimal(15,2) DEFAULT '0.00',
  `date_created` datetime NOT NULL,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `product_uid` (`product_uid`),
  KEY `is_archived` (`is_archived`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_sales`
--

LOCK TABLES `tbl_sales` WRITE;
/*!40000 ALTER TABLE `tbl_sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_freknur_inventory'
--

--
-- Current Database: `db_freknur_investment`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_freknur_investment` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_freknur_investment`;

--
-- Table structure for table `tbl_account`
--

DROP TABLE IF EXISTS `tbl_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_code` varchar(20) NOT NULL,
  `account_name` varchar(50) DEFAULT NULL,
  `balance` decimal(15,8) DEFAULT '0.00000000',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_unik` (`account_code`),
  KEY `bank_id` (`account_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_account`
--

LOCK TABLES `tbl_account` WRITE;
/*!40000 ALTER TABLE `tbl_account` DISABLE KEYS */;
INSERT INTO `tbl_account` VALUES (1,'WRK','WORKING',5000000.00000000,'2021-03-12 00:43:31','2021-03-11 21:43:31'),(2,'INC','INCOMING',429.33000000,'2021-03-12 00:43:31','2022-10-11 15:13:36'),(3,'FEE','GOVT_TAX',4.36000000,'2021-03-12 00:43:31','2022-10-11 15:13:36');
/*!40000 ALTER TABLE `tbl_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_alternate_market_bid`
--

DROP TABLE IF EXISTS `tbl_alternate_market_bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_alternate_market_bid` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `asset_id` varchar(80) NOT NULL,
  `msisdn` varchar(20) NOT NULL,
  `asset_name` varchar(50) DEFAULT NULL,
  `unit_price` decimal(15,8) DEFAULT '0.00000000',
  `qty` decimal(15,8) DEFAULT '0.00000000',
  `cost` decimal(15,8) DEFAULT '0.00000000',
  `date_created` datetime NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_processed` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `is_processed` (`is_processed`),
  KEY `msisdn` (`msisdn`),
  KEY `asset_id` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_alternate_market_bid`
--

LOCK TABLES `tbl_alternate_market_bid` WRITE;
/*!40000 ALTER TABLE `tbl_alternate_market_bid` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_alternate_market_bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_asset`
--

DROP TABLE IF EXISTS `tbl_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_asset` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `asset_acronym` varchar(20) NOT NULL,
  `asset_name` varchar(100) DEFAULT NULL,
  `unit_price` decimal(20,8) DEFAULT '0.00000000',
  `total` decimal(20,8) DEFAULT '0.00000000',
  `asset_trend` int DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_suspended` int DEFAULT '0',
  `is_deleted` int DEFAULT '0',
  PRIMARY KEY (`_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_asset`
--

LOCK TABLES `tbl_asset` WRITE;
/*!40000 ALTER TABLE `tbl_asset` DISABLE KEYS */;
INSERT INTO `tbl_asset` VALUES (1,'23314','EQTY','EQUITY BANK',27.50000000,22050.70000000,2,'2020-12-18 20:23:02','2022-07-28 06:54:15',0,0),(2,'20200','KCB','Kenya Commercial Bank',24.00000000,18086.00000000,1,'2020-12-18 20:53:06','2022-09-23 15:40:23',0,0),(3,'18195','HFCK','House Finance',12.00000000,957.70000000,0,'2020-12-18 21:09:31','2022-07-06 12:27:32',0,0),(4,'30006','CMC','CMC',10.00000000,9565.80000000,0,'2020-12-18 21:15:01','2022-10-11 15:13:36',0,0),(5,'25643','ABSA','ABSA',23.00000000,9990.00000000,0,'2020-12-18 21:22:33','2021-03-30 18:28:04',0,0),(6,'21222','ABSA','ABSA',23.00000000,9923.75000000,0,'2020-12-18 21:24:10','2022-07-27 10:14:30',0,0),(7,'17633','CABACID','CABACID',15.00000000,95863.20000000,1,'2020-12-18 21:31:28','2021-07-16 22:18:39',0,0),(25,'19570','NATION MEDIA','NATION',15.00000000,19934.54000000,0,'2021-04-30 00:36:29','2022-08-02 09:33:52',0,0),(26,'87273','SMRT','Smarty',16.00000000,-575.09000000,0,'2021-11-03 14:17:59','2022-09-26 14:24:47',0,0),(27,'10698','tRD','tRD',1000.00000000,997.33000000,0,'2021-11-10 04:34:14','2022-06-14 13:11:55',0,0),(28,'24774','TGP','ToGoPo',18.75000000,297685.37000000,0,'2022-09-13 12:41:56','2022-10-11 13:25:14',0,0);
/*!40000 ALTER TABLE `tbl_asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_config`
--

DROP TABLE IF EXISTS `tbl_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_config` (
  `cnf_id` int NOT NULL AUTO_INCREMENT,
  `trx_fee` double(8,2) DEFAULT NULL,
  `tax` double(15,2) DEFAULT NULL,
  `min_limit` double(15,2) DEFAULT NULL,
  `max_limit` double(15,2) DEFAULT NULL,
  `currency` varchar(5) DEFAULT 'USD',
  `equity_markup` decimal(8,2) DEFAULT NULL,
  `equity_offer_rate` decimal(8,2) DEFAULT NULL,
  `early_payment_fee` decimal(8,2) DEFAULT NULL,
  `setting_3` decimal(8,2) DEFAULT NULL,
  `time_stamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cnf_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_config`
--

LOCK TABLES `tbl_config` WRITE;
/*!40000 ALTER TABLE `tbl_config` DISABLE KEYS */;
INSERT INTO `tbl_config` VALUES (1,0.05,0.01,0.10,60.00,'KES',0.02,0.05,0.02,0.00,'2021-11-03 11:18:40');
/*!40000 ALTER TABLE `tbl_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_owner_portfolio`
--

DROP TABLE IF EXISTS `tbl_owner_portfolio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_owner_portfolio` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) NOT NULL,
  `asset_id` varchar(20) NOT NULL,
  `asset_acronym` varchar(25) DEFAULT NULL,
  `number_of_asset` decimal(15,8) DEFAULT '0.00000000',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` int DEFAULT '0',
  `lock` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `msisdn_indx` (`msisdn`),
  KEY `asset_id_indx` (`asset_id`),
  KEY `is_active_indx` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_owner_portfolio`
--

LOCK TABLES `tbl_owner_portfolio` WRITE;
/*!40000 ALTER TABLE `tbl_owner_portfolio` DISABLE KEYS */;
INSERT INTO `tbl_owner_portfolio` VALUES (1,'4915224043369','24774','TGP',10.00000000,'2022-10-11 12:12:18','2022-10-11 09:12:18',0,0),(2,'254707132162','24774','TGP',1.00000000,'2022-10-11 16:25:14','2022-10-11 13:25:14',0,0),(3,'4915224043369','30006','CMC',10.00000000,'2022-10-11 18:13:36','2022-10-11 15:13:36',0,0);
/*!40000 ALTER TABLE `tbl_owner_portfolio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_owner_portfolio_backup`
--

DROP TABLE IF EXISTS `tbl_owner_portfolio_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_owner_portfolio_backup` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) NOT NULL,
  `asset_id` varchar(20) NOT NULL,
  `asset_acronym` varchar(20) NOT NULL,
  `number_of_asset` decimal(15,8) DEFAULT '0.00000000',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` int DEFAULT '0',
  `lock` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `msisdn_indx` (`msisdn`),
  KEY `asset_id_indx` (`asset_id`),
  KEY `is_active_indx` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_owner_portfolio_backup`
--

LOCK TABLES `tbl_owner_portfolio_backup` WRITE;
/*!40000 ALTER TABLE `tbl_owner_portfolio_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_owner_portfolio_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_owner_portfolio_temp_list`
--

DROP TABLE IF EXISTS `tbl_owner_portfolio_temp_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_owner_portfolio_temp_list` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) NOT NULL,
  `asset_id` varchar(20) NOT NULL,
  `asset_acronym` varchar(20) NOT NULL,
  `number_of_asset` decimal(15,8) DEFAULT '0.00000000',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` int DEFAULT '0',
  `lock` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `msisdn_indx` (`msisdn`),
  KEY `asset_id_indx` (`asset_id`),
  KEY `is_active_indx` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_owner_portfolio_temp_list`
--

LOCK TABLES `tbl_owner_portfolio_temp_list` WRITE;
/*!40000 ALTER TABLE `tbl_owner_portfolio_temp_list` DISABLE KEYS */;
INSERT INTO `tbl_owner_portfolio_temp_list` VALUES (1,'4915224043369','24774','TGP',10.00000000,'2022-10-11 12:12:18','2022-10-11 09:12:18',0,0),(2,'254707132162','24774','TGP',1.00000000,'2022-10-11 16:25:14','2022-10-11 13:25:14',0,0),(3,'4915224043369','30006','CMC',10.00000000,'2022-10-11 18:13:36','2022-10-11 15:13:36',0,0);
/*!40000 ALTER TABLE `tbl_owner_portfolio_temp_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_purchase_request`
--

DROP TABLE IF EXISTS `tbl_purchase_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_purchase_request` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `uid` varchar(80) DEFAULT NULL,
  `name` varchar(25) DEFAULT NULL,
  `msisdn` varchar(20) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `unit_price` decimal(15,8) DEFAULT '0.00000000',
  `no_of_grain_purchased` decimal(15,8) DEFAULT '0.00000000',
  `cost` decimal(15,8) DEFAULT '0.00000000',
  `date_created` datetime NOT NULL,
  `date_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_processed` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `is_processed` (`is_processed`),
  KEY `msisdn` (`msisdn`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_purchase_request`
--

LOCK TABLES `tbl_purchase_request` WRITE;
/*!40000 ALTER TABLE `tbl_purchase_request` DISABLE KEYS */;
INSERT INTO `tbl_purchase_request` VALUES (1,'24774',NULL,'4915224043369','TGP',19.12000000,10.00000000,191.20000000,'2022-10-11 12:12:17','2022-10-11 09:12:18',1),(2,'24774',NULL,'254707132162','TGP',19.12000000,1.00000000,19.12000000,'2022-10-11 15:19:12','2022-10-11 13:25:14',1),(3,'30006',NULL,'4915224043369','CMC',10.00000000,10.00000000,100.00000000,'2022-10-11 18:13:35','2022-10-11 15:13:36',1);
/*!40000 ALTER TABLE `tbl_purchase_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_sale_bid`
--

DROP TABLE IF EXISTS `tbl_sale_bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_sale_bid` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `bid_id` varchar(80) DEFAULT NULL,
  `asset_id` varchar(80) DEFAULT NULL,
  `asset_name` varchar(25) DEFAULT NULL,
  `owner_msisdn` varchar(20) DEFAULT NULL,
  `bidder_msisdn` varchar(20) DEFAULT NULL,
  `qty` decimal(15,8) DEFAULT '0.00000000',
  `bid_price` decimal(15,8) DEFAULT '0.00000000',
  `time_stamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_accepted` int DEFAULT '0',
  `is_deleted` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `is_deleted` (`is_deleted`),
  KEY `bid_id` (`bid_id`),
  KEY `owner_msisdn` (`owner_msisdn`),
  KEY `is_accepted` (`is_accepted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_sale_bid`
--

LOCK TABLES `tbl_sale_bid` WRITE;
/*!40000 ALTER TABLE `tbl_sale_bid` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_sale_bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_sale_request`
--

DROP TABLE IF EXISTS `tbl_sale_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_sale_request` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `uid` varchar(80) DEFAULT NULL,
  `unit_price_no_markup` decimal(8,2) DEFAULT NULL,
  `msisdn` varchar(20) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `unit_price` decimal(15,8) DEFAULT '0.00000000',
  `no_of_grain_sold` decimal(15,8) DEFAULT '0.00000000',
  `no_markup_cost` decimal(15,8) DEFAULT '0.00000000',
  `cost` decimal(15,8) DEFAULT '0.00000000',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_processed` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `is_processed` (`is_processed`),
  KEY `msisdn` (`msisdn`),
  KEY `uid_index` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_sale_request`
--

LOCK TABLES `tbl_sale_request` WRITE;
/*!40000 ALTER TABLE `tbl_sale_request` DISABLE KEYS */;
INSERT INTO `tbl_sale_request` VALUES (1,'30006',25.00,'4915224043369','CMC',25.50000000,2.00000000,0.00000000,51.00000000,'2022-10-11 18:15:24','2022-10-11 15:15:24',0);
/*!40000 ALTER TABLE `tbl_sale_request` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tbl_sale_request_after_insert_trigger` AFTER INSERT ON `tbl_sale_request` FOR EACH ROW BEGIN
INSERT 
INTO 
`db_freknur_investment`.`tbl_sale_request_queue`
(`uid`,`msisdn`,`description`,`unit_price`,`no_of_grain_sold`,`cost`,`date_created`)
VALUES
(NEW.uid,NEW.msisdn,NEW.description,NEW.unit_price,NEW.no_of_grain_sold,NEW.cost,NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbl_sale_request_queue`
--

DROP TABLE IF EXISTS `tbl_sale_request_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_sale_request_queue` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `uid` varchar(20) NOT NULL,
  `msisdn` varchar(20) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `unit_price` decimal(15,8) DEFAULT '0.00000000',
  `no_of_grain_sold` decimal(15,8) DEFAULT '0.00000000',
  `cost` decimal(15,8) DEFAULT '0.00000000',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_processed` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `is_processed` (`is_processed`),
  KEY `msisdn` (`msisdn`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_sale_request_queue`
--

LOCK TABLES `tbl_sale_request_queue` WRITE;
/*!40000 ALTER TABLE `tbl_sale_request_queue` DISABLE KEYS */;
INSERT INTO `tbl_sale_request_queue` VALUES (1,'30006','4915224043369','CMC',25.50000000,2.00000000,51.00000000,'2022-10-11 18:15:24','2022-10-11 15:15:24',0);
/*!40000 ALTER TABLE `tbl_sale_request_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_statement`
--

DROP TABLE IF EXISTS `tbl_statement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_statement` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `unit_price` decimal(15,8) DEFAULT '0.00000000',
  `number_of_share` decimal(15,8) DEFAULT '0.00000000',
  `cost` decimal(15,8) DEFAULT '0.00000000',
  `running_bal` decimal(15,8) DEFAULT '0.00000000',
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `msisdn` (`msisdn`),
  KEY `is_archived` (`is_archived`)
) ENGINE=InnoDB AUTO_INCREMENT=1645 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_statement`
--

LOCK TABLES `tbl_statement` WRITE;
/*!40000 ALTER TABLE `tbl_statement` DISABLE KEYS */;
INSERT INTO `tbl_statement` VALUES (1,'4915224043369','TGP',19.12000000,10.00000000,191.20000000,2258.80000000,0),(1643,'254707132162','TGP',19.12000000,1.00000000,19.12000000,11806.12000000,0),(1644,'4915224043369','CMC',10.00000000,10.00000000,100.00000000,2158.80000000,0);
/*!40000 ALTER TABLE `tbl_statement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_transaction`
--

DROP TABLE IF EXISTS `tbl_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_code` varchar(50) NOT NULL,
  `reference_no` varchar(50) NOT NULL,
  `msisdn` varchar(15) NOT NULL,
  `cr` decimal(15,8) DEFAULT '0.00000000',
  `dr` decimal(15,8) DEFAULT '0.00000000',
  `balance` decimal(15,8) DEFAULT '0.00000000',
  `narration` text,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `msisdn` (`msisdn`),
  KEY `reference_no` (`reference_no`),
  KEY `account_id` (`account_code`),
  KEY `is_archived` (`is_archived`)
) ENGINE=InnoDB AUTO_INCREMENT=1648 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_transaction`
--

LOCK TABLES `tbl_transaction` WRITE;
/*!40000 ALTER TABLE `tbl_transaction` DISABLE KEYS */;
INSERT INTO `tbl_transaction` VALUES (1,'INC','GRN91A8E0780A','4915224043369',3.71250000,0.00000000,426.98220000,'FEE OF 3.71 EARNED FROM SELL OF TGP SHARES','2022-10-11 12:12:18','2022-10-11 09:12:18',0),(2,'FEE','GRN91A8E0780A','4915224043369',0.03750000,0.00000000,4.34000000,'LEVY DEDUCTED FROM A FEE EARNED FROM SELL OF TGP SHARES','2022-10-11 12:12:18','2022-10-11 09:12:18',0),(1644,'INC','GRN325DFF850A','254707132162',0.37000000,0.00000000,427.35000000,'FEE OF 0.37 EARNED FROM SELL OF TGP SHARES','2022-10-11 16:25:14','2022-10-11 13:25:14',0),(1645,'FEE','GRN325DFF850A','254707132162',0.00000000,0.00000000,4.34000000,'LEVY DEDUCTED FROM A FEE EARNED FROM SELL OF TGP SHARES','2022-10-11 16:25:14','2022-10-11 13:25:14',0),(1646,'INC','GRN10B743250A','4915224043369',1.98000000,0.00000000,429.33000000,'FEE OF 1.98 EARNED FROM SELL OF CMC SHARES','2022-10-11 18:13:36','2022-10-11 15:13:36',0),(1647,'FEE','GRN10B743250A','4915224043369',0.02000000,0.00000000,4.36000000,'LEVY DEDUCTED FROM A FEE EARNED FROM SELL OF CMC SHARES','2022-10-11 18:13:36','2022-10-11 15:13:36',0);
/*!40000 ALTER TABLE `tbl_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_freknur_investment'
--
/*!50003 DROP PROCEDURE IF EXISTS `sProcBuyAlternativeMarketAsset` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcBuyAlternativeMarketAsset`(
	IN `BUY_MSISDN` VARCHAR(20),
	IN `REQUEST_QTY` DECIMAL(15,4),
	IN `ASSET_NAME` VARCHAR(15),
        IN `ASSET_UID` VARCHAR(15), 
	IN `PRICE` DOUBLE(15,4),
	IN `CURRENT_BUYER_WALLET_BAL` DOUBLE(15,4),
	IN `TOTAL_COST` DOUBLE(15,4),
	IN `FEE_EARNED` DOUBLE(15,4)
)
BEGIN
	
	
	
	
	
        
	
	
	
	
	
	DECLARE REMINDER_QTY DOUBLE(15,4);
        DECLARE ASSET_IN_HAND_QTY DOUBLE(15,4);
	DECLARE REFERENCE VARCHAR(100);
	DECLARE PARTICULARS VARCHAR(100);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
		ROLLBACK;
		RESIGNAL;
	END;
	
	
	
	START TRANSACTION;	
	IF(TRIM(BUY_MSISDN) != "" OR TRIM(REQUEST_QTY) != "" OR TRIM(ASSET_NAME) != "" OR TRIM(PRICE) != "" OR TRIM(CURRENT_BUYER_WALLET_BAL) != "" OR TRIM(TOTAL_COST) != "" OR TRIM(FEE_EARNED) != "" OR TRIM(ASSET_UID) != "") THEN
		
		
		
		SET REFERENCE   = UCASE(CONCAT("BID",SUBSTRING(MD5(UUID_SHORT()),1,8),"0P"));
		SET PARTICULARS = CONCAT(UCASE(ASSET_NAME)," SHARES PURCHASED FROM ALTERNATIVE MARKET @.",TOTAL_COST);
		
		
		
		SET @STMT_0 = CONCAT("SELECT ",
				     "COUNT(`msisdn`) ",
				     "INTO ",
				     "@HEAP_SIZE "
				     "FROM ",
		                     "`db_freknur_investment`.`tbl_sale_request_queue` ",
			             "WHERE ",
				     "`is_processed` = 0 AND `msisdn` != '",TRIM(BUY_MSISDN),"'");
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
                
                
                
                IF(@HEAP_SIZE > 0) THEN
			
			
			
			SET @STMT_1 = CONCAT("SELECT ",
			             	     "`msisdn`,`no_of_grain_sold`,`uid`,`unit_price` ",
				             "INTO ",
				             "@OWNER_MSISDN,@OWNER_QTY,@ASSET_ID,@SELLING_PRICE "
	                                     "FROM ",
	                                     "`db_freknur_investment`.`tbl_sale_request_queue` ",
	                                     "WHERE ",
	                                     "`is_processed` = 0 AND `msisdn` != '",TRIM(BUY_MSISDN),"' AND `uid` = '",TRIM(ASSET_UID),"'",
				             "ORDER BY ",
				             "`date_created` ASC ",
				             "LIMIT 1");
			PREPARE QUERY FROM @STMT_1;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;

			SET REMINDER_QTY = (@OWNER_QTY - REQUEST_QTY);
		        
                        
                        
		        IF(REQUEST_QTY > 0) THEN
                        IF(PRICE = @SELLING_PRICE) THEN           
				IF(REMINDER_QTY = 0) THEN
					
					
					
					SET @STMT_2 = CONCAT("DELETE ",
						             "FROM ",
			                                     "`db_freknur_investment`.`tbl_sale_request` ",
			                                     "WHERE ",
			                                     "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
					PREPARE QUERY FROM @STMT_2;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
                                        
                                        
                                        
                                        SET @STMT_20 = CONCAT("DELETE ",
                                                              "FROM ",
                                                              "`db_freknur_investment`.`tbl_sale_request_queue` ",
                                                              "WHERE ",
                                                              "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
                                        PREPARE QUERY FROM @STMT_20;
                                        EXECUTE QUERY;
                                        DEALLOCATE PREPARE QUERY;
                                	
					
                                	
                                	SET @STMT_21 = CONCAT("DELETE ",
                                                              "FROM ",
                                                      	      "`db_freknur_investment`.`tbl_alternate_market_bid` ",
                                                              "WHERE ",
                                                              "`msisdn` = '",TRIM(BUY_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
                                	PREPARE QUERY FROM @STMT_21;
                                	EXECUTE QUERY;
                                	DEALLOCATE PREPARE QUERY;
				ELSE
					
					IF(REMINDER_QTY > 0) THEN
                                                
                                                
                                                
                                                SET @STMT_2 = CONCAT("UPDATE ",
                                                                     "`db_freknur_investment`.`tbl_sale_request` ",
                                                                     "SET ",
                                                                     "`no_of_grain_sold` = '",TRIM(REMINDER_QTY),"',`cost` = '",(TRIM(REMINDER_QTY)*TRIM(PRICE)),"',`date_modified`= NOW() ",
                                                                     "WHERE ",
                                                                     "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
                                                PREPARE QUERY FROM @STMT_2;
                                                EXECUTE QUERY;
                                                DEALLOCATE PREPARE QUERY;
						
						
						
						SET @STMT_20 = CONCAT("UPDATE ",
			                                              "`db_freknur_investment`.`tbl_sale_request_queue` ",
			                                              "SET ",
			                                	      "`no_of_grain_sold` = '",TRIM(REMINDER_QTY),"',`cost` = '",(TRIM(REMINDER_QTY)*TRIM(PRICE)),"',`date_modified`= NOW() ",
			                                              "WHERE ",
			                                              "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");                   
						PREPARE QUERY FROM @STMT_20;
						EXECUTE QUERY;
						DEALLOCATE PREPARE QUERY;
                                                
                                                
                                                
						IF(REQUEST_QTY <= @OWNER_QTY) THEN
                                                        
                                                        
                                                        
							SET @STMT_21 = CONCAT("DELETE ",
									      "FROM ",
									      "`db_freknur_investment`.`tbl_alternate_market_bid` ",
									      "WHERE ",
									      "`msisdn` = '",TRIM(BUY_MSISDN),"'");
							PREPARE QUERY FROM @STMT_21;
							EXECUTE QUERY;
							DEALLOCATE PREPARE QUERY;
						ELSE
                                			
                                			
                                			
                                			SET @STMT_21 = CONCAT("UPDATE ",
                                                      		              "`db_freknur_investment`.`tbl_alternate_market_bid` ",
                                                                              "SET ",
                                                                              "`qty` = '",TRIM(REMINDER_QTY),"',`cost` = '",(TRIM(REMINDER_QTY)*TRIM(PRICE)),"',`date_modified`= NOW() ",
                                                                              "WHERE ",
                                                                              "`msisdn` = '",TRIM(BUY_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
                                			PREPARE QUERY FROM @STMT_21;
                                			EXECUTE QUERY;
                                			DEALLOCATE PREPARE QUERY;
					        END IF;
					END IF;
				END IF;
			       

				IF(REMINDER_QTY >= 0) THEN
				        
                                        
                                        
                       	 		SET @STMT_3 = CONCAT("SELECT ",
                                             		     "`number_of_asset` ",
                                                             "INTO ",
                                                             "@PORTFOLIO_QTY ",
                                                             "FROM ",
                                                             "`db_freknur_investment`.`tbl_owner_portfolio` ",
                                                             "WHERE ",
                                                             "`asset_id` = '",TRIM(@ASSET_ID),"' AND `msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `lock` = 0");
                        		PREPARE QUERY FROM @STMT_3;
                        		EXECUTE QUERY;
                        		DEALLOCATE PREPARE QUERY;

				        SET ASSET_IN_HAND_QTY = (@PORTFOLIO_QTY - REQUEST_QTY);

		                        IF(ASSET_IN_HAND_QTY > 0) THEN
						
						
						
						SET @STMT_22 = CONCAT("UPDATE ",
							             "`db_freknur_investment`.`tbl_owner_portfolio` ",
							             "SET ",
								     "`number_of_asset` = '",TRIM(ASSET_IN_HAND_QTY),"',`date_modified` = NOW() ",
								     "WHERE ",
								     "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"'");
						PREPARE QUERY FROM @STMT_22;
						EXECUTE QUERY;
						DEALLOCATE PREPARE QUERY;
		                        ELSE
						
						
						
						SET @STMT_22 = CONCAT("DELETE ",
								      "FROM ",
								      "`db_freknur_investment`.`tbl_owner_portfolio` ",
								      "WHERE ",
								      "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"'");
						PREPARE QUERY FROM @STMT_22;
						EXECUTE QUERY;
						DEALLOCATE PREPARE QUERY;
                                        END IF;
					
					
					
					CALL `db_freknur_investment`.`sProcInitChartOfAccount`();		
					
					
					
					SET @STMT_4 = CONCAT("INSERT ",
			                                     "INTO ",
					                     "`db_freknur_investment`.`tbl_statement` ",
				                             "(`msisdn`,`description`,`unit_price`,`number_of_share`,`cost`,`running_bal`) ",
		                                             "VALUES ",
					                     "('",TRIM(BUY_MSISDN),"','",TRIM(ASSET_NAME),"','",TRIM(PRICE),"','",TRIM(REQUEST_QTY),"','",TRIM(TOTAL_COST),"','",TRIM(CURRENT_BUYER_WALLET_BAL),"')");                    
					PREPARE QUERY FROM @STMT_4;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_5 = CONCAT("UPDATE ",
			                                     "`db_freknur_loan`.`tbl_wallet` ",
					                     "SET ",
			                                     "`balance` = '",TRIM(CURRENT_BUYER_WALLET_BAL),"',`date_modified` = NOW() ",
				                             "WHERE ",
				                             "`msisdn` = '",TRIM(BUY_MSISDN),"'");                    
					PREPARE QUERY FROM @STMT_5;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_6 = CONCAT("UPDATE ",
				            		     "`db_freknur_loan`.`tbl_wallet` ",
				                             "SET ",
				                             "`balance` = (`balance`+'",TRIM(TOTAL_COST),"'),`date_modified` = NOW() ",
				                             "WHERE ",
			                                     "`msisdn` = '",TRIM(@OWNER_MSISDN),"'");                    
					PREPARE QUERY FROM @STMT_6;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;			
					
					
					
					SET @STMT_7 = CONCAT("INSERT ",
			                     		     "INTO ",
				                             "`db_freknur_loan`.`tbl_wallet_transaction` ",
				                             "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
					                     "VALUES ",
				                             "('",TRIM(REFERENCE),"','",TRIM(BUY_MSISDN),"','",TRIM(TOTAL_COST),"','",TRIM(CURRENT_BUYER_WALLET_BAL),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
					PREPARE QUERY FROM @STMT_7;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_8 = CONCAT("SELECT `tax` INTO @GOVT_LEVY FROM `db_freknur_investment`.`tbl_config`");
					PREPARE QUERY FROM @STMT_8;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_9 = CONCAT("SELECT ", 
			                                     "`account_code`,`balance` ",
					                     "INTO ",
					                     "@ACCOUNT_CODE,@BALANCE ",
				                             "FROM ",
			                                     "`db_freknur_investment`.`tbl_account` ",
					                     "WHERE ",
				                             "`account_code` = 'INC'");
					PREPARE QUERY FROM @STMT_9;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;						
			                
					
					
					SET @GOVT_TAX    = (FEE_EARNED * @GOVT_LEVY);			
					SET PARTICULARS  = CONCAT("FEE OF ",(FEE_EARNED - @GOVT_TAX)," EARNED FROM PURCHASE OF ",UCASE(ASSET_NAME)," SHARES");
					SET @NEW_BALANCE = (@BALANCE + (FEE_EARNED - @GOVT_TAX));
					
					
					
					SET @STMT_10 = CONCAT("INSERT ",
			                                      "INTO ",
					                      "`db_freknur_investment`.`tbl_transaction` ",
					                      "(`account_code`,`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
				                              "VALUES ",
			                                      "('",@ACCOUNT_CODE,"','",TRIM(REFERENCE),"','",TRIM(BUY_MSISDN),"','",(TRIM(FEE_EARNED) - TRIM(@GOVT_TAX)),"','",TRIM(@NEW_BALANCE),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
					PREPARE QUERY FROM @STMT_10;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_11 = CONCAT("UPDATE ",
				                              "`db_freknur_investment`.`tbl_account` ",
					                      "SET ",
					                      "`balance` = (`balance` + '",(TRIM(FEE_EARNED) - TRIM(@GOVT_TAX)),"'),`date_modified` = NOW() ",
					                      "WHERE ",
				                              "`account_code` = 'INC'");                     
					PREPARE QUERY FROM @STMT_11;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_12 = CONCAT("SELECT ",
			                      		      "`account_code`,`balance` ",
				                              "INTO ",
			                                      "@ACCOUNT_CODE,@BALANCE ",
			                                      "FROM ",
					                      "`db_freknur_investment`.`tbl_account` ",
				                              "WHERE ",
				                              "`account_code` = 'FEE'");
					PREPARE QUERY FROM @STMT_12;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @NEW_BALANCE = (@BALANCE + @GOVT_TAX);
					SET PARTICULARS  = CONCAT("LEVY DEDUCTED FROM A FEE EARNED FROM PURCHASE OF ",UCASE(ASSET_NAME)," SHARES");			
					
					
					
					SET @STMT_13 = CONCAT("INSERT ",
			                                      "INTO ",
					                      "`db_freknur_investment`.`tbl_transaction` ",
					                      "(`account_code`,`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
					                      "VALUES ",
					                      "('",@ACCOUNT_CODE,"','",TRIM(REFERENCE),"','",TRIM(BUY_MSISDN),"','",TRIM(@GOVT_TAX),"','",TRIM(@NEW_BALANCE),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
					PREPARE QUERY FROM @STMT_13;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;			
					
					
					
					SET @STMT_14 = CONCAT("UPDATE ",
				                              "`db_freknur_investment`.`tbl_account` ",
			                                      "SET ",
				                              "`balance` = (`balance` + '",TRIM(@GOVT_TAX),"'),`date_modified` = NOW() ",
			                                      "WHERE ",
					                      "`account_code` = 'FEE'");                     
					PREPARE QUERY FROM @STMT_14;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
				END IF;
				
				
				
				SET @STMT_15 = CONCAT("SELECT ",
				                      "COUNT(`_id`) ",
			                              "INTO ",
		                                      "@HEAP_PORTFOLIO_SIZE ",
			                              "FROM ",
					              "`db_freknur_investment`.`tbl_owner_portfolio` ",
					              "WHERE ",
					              "`msisdn` ='",TRIM(BUY_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"'");
				PREPARE QUERY FROM @STMT_15;
				EXECUTE QUERY;            
				DEALLOCATE PREPARE QUERY;
				
				
				
				IF(TRIM(@HEAP_PORTFOLIO_SIZE) = 0) THEN
					
					
					
					IF(REMINDER_QTY >= 0) THEN
						SET @STMT_16 = CONCAT("INSERT ",
					                              "`db_freknur_investment`.`tbl_owner_portfolio` ",
					                              "(`msisdn`,`asset_id`,`asset_acronym`,`number_of_asset`,`date_created`) ",
					                              "VALUES ",
					                              "('",TRIM(BUY_MSISDN),"','",TRIM(@ASSET_ID),"','",TRIM(UCASE(ASSET_NAME)),"','",TRIM(REQUEST_QTY),"','",NOW(),"')");
					        PREPARE QUERY FROM @STMT_16;
						EXECUTE QUERY;            
						DEALLOCATE PREPARE QUERY;												 			
					END IF;										
				ELSE
					
					
					
					IF(REMINDER_QTY >= 0) THEN
						
						
						
						SET @STMT_17 = CONCAT("UPDATE ",
					                              "`db_freknur_investment`.`tbl_owner_portfolio` ",
					                              "SET ",
					                              "`number_of_asset` = (`number_of_asset` + '",TRIM(REQUEST_QTY),"'), `date_modified` = NOW() ",
					                              "WHERE ",
					                              "`msisdn` = '",TRIM(BUY_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"'");	
						PREPARE QUERY FROM @STMT_17;
						EXECUTE QUERY;            
						DEALLOCATE PREPARE QUERY;
					END IF;			
				END IF;
                                
                                
                                
                                SET PARTICULARS = CONCAT(UCASE(ASSET_NAME)," SHARES SOLD @ ALTERNATIVE MARKET @.",TOTAL_COST);
                                
                                
                                
                                SET @STMT_18 = CONCAT("SELECT ",
                                                      "`balance` ",
                                                      "INTO ",
                                                      "@OWNER_BAL ",
                                                      "FROM ",
                                                      "`db_freknur_loan`.`tbl_wallet` ",
                                                      "WHERE ",
                                                      "`msisdn` = '",TRIM(@OWNER_MSISDN),"'");
                                PREPARE QUERY FROM @STMT_18;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
                                
                                
                                
                                SET @STMT_19 = CONCAT("INSERT ",
                                                      "INTO ",
                                                      "`db_freknur_loan`.`tbl_wallet_transaction` ",
                                                      "(`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
                                                      "VALUES ",
                                                      "('",TRIM(REFERENCE),"','",TRIM(@OWNER_MSISDN),"','",TRIM(TOTAL_COST),"','",TRIM(@OWNER_BAL),"','",TRIM(PARTICULARS),"','",NOW(),"')");
                                PREPARE QUERY FROM @STMT_19;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
				
				
				
				SET @JSON_O = CONCAT('{"ERROR":"0","RESULT":"SUCCESS","DATA":"',TRIM(@OWNER_MSISDN),'","MESSAGE":"Operation was successful."}');
				SELECT @JSON_O AS _JSON;
			ELSE
				
				
				
				SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"The price offer is less than the unit price of the asset."}';
				SELECT @JSON_O AS _JSON;		
			END IF;
		        ELSE									
                                
                                
                                
                                SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Operation has failed.1."}';
                                SELECT @JSON_O AS _JSON;
                        END IF;		
		ELSE
			
			
			
                	SET @JSON_O = CONCAT('{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Operation has failed.2."}');
                	SELECT @JSON_O AS _JSON;
		END IF;
                
                
                
                SET @STMT_22 = CONCAT("DELETE ",
                                      "FROM ",
                                      "`db_freknur_investment`.`tbl_alternate_market_bid` ",
                                      "WHERE ",
                                      "`msisdn` = '",TRIM(BUY_MSISDN),"'");
                PREPARE QUERY FROM @STMT_22;
                EXECUTE QUERY;
                DEALLOCATE PREPARE QUERY;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:BUY_MSISDN|REQUEST_QTY|ASSET_NAME|PRICE|TOTAL_COST|CURRENT_BUYER_WALLET_BAL needs to be SET."}';
		SELECT @JSON_O AS _JSON;																			   
	END IF;				   
	
	
	
	COMMIT;
	
	
	
	SET @HEAP_SIZE    = NULL;
	SET @OWNER_QTY    = NULL;
	SET @OWNER_MSISDN = NULL;
	SET @ACCOUNT_CODE = NULL;
	SET @GOVT_TAX     = NULL;
	SET @GOVT_LEVY    = NULL;
	SET @BALANCE      = NULL;
	SET @OWNER_BAL    = NULL;
	SET @ASSET_ID     = NULL;
	SET @NEW_BALANCE  = NULL;
	SET @HEAP_SIZE    = NULL;
        SET @PORTFOLIO_QTY = NULL;
	SET @SELLING_PRICE = NULL;
	SET @HEAP_PORTFOLIO_SIZE = NULL;
	SET @STMT_1       = NULL;
	SET @STMT_1       = NULL;
	SET @STMT_2       = NULL;
	SET @STMT_3       = NULL;
	SET @STMT_4       = NULL;
	SET @STMT_5       = NULL;
	SET @STMT_6       = NULL;
	SET @STMT_7       = NULL;
	SET @STMT_8       = NULL;
	SET @STMT_9       = NULL;
	SET @STMT_10      = NULL;
	SET @STMT_11      = NULL;
	SET @STMT_12      = NULL;	
	SET @STMT_13      = NULL;
	SET @STMT_14      = NULL;
	SET @STMT_15      = NULL;
	SET @STMT_16      = NULL;	
	SET @STMT_17      = NULL;
	SET @STMT_18      = NULL;
	SET @STMT_19      = NULL;
	SET @STMT_20      = NULL;
	SET @STMT_21      = NULL;
        SET @STMT_22      = NULL;
	SET PRICE         = NULL;
	SET BUY_MSISDN    = NULL;
	SET CURRENT_BUYER_WALLET_BAL = NULL;
	SET TOTAL_COST    = NULL;	
	SET ASSET_NAME    = NULL;
        SET ASSET_UID     = NULL; 
	SET REQUEST_QTY   = NULL;
	SET FEE_EARNED    = NULL;
	SET REFERENCE     = NULL;
	SET PARTICULARS   = NULL;
        SET ASSET_IN_HAND_QTY = NULL;		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcFreknurTokenTransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcFreknurTokenTransaction`(
	IN `MSISDN` VARCHAR(20),
	IN `AMOUNT` DECIMAL(15,2),
	IN `REF_NUMBER` VARCHAR(50),
	IN `ACCOUNT_TYPE` CHAR(2)
)
BEGIN
	
	
	
	
	
	
	
	DECLARE PARTICULARS TEXT;
	DECLARE RUNNING_BAL DOUBLE(15,2);
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
		ROLLBACK;
		
	END;
	
	
	
	START TRANSACTION;	
	
	
	
	IF(TRIM(AMOUNT) != "" || TRIM(MSISDN) != "" || ACCOUNT_TYPE != "") THEN
		
		
		
		SET @STMT_1 = CONCAT("SELECT ",
				     "COUNT(`id`), ",
		                     "`balance` ",
			             "INTO ",
				     "@CNT, ",
				     "@BALANCE ",
				     "FROM ",
				     "`db_freknur_loan`.`tbl_wallet` ",
				     " WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		IF(@CNT > "0") THEN
			
			
			
			IF(TRIM(ACCOUNT_TYPE) = "CR")THEN
				
				
				
				SET PARTICULARS = "WALLET DEPOSIT FROM SALE OF FKR TOKEN.";
				SET RUNNING_BAL = (@BALANCE + AMOUNT);
			ELSE
				
				
				
				SET PARTICULARS = "WITHDRAWAL FROM WALLET FOR PURCHASE OF FKR TOKEN.";
				SET RUNNING_BAL = (@BALANCE - AMOUNT);
			END IF;	
			
			
			
			IF(RUNNING_BAL >= "0") THEN
				IF(TRIM(ACCOUNT_TYPE) = "CR")THEN	
					SET @STMT_2 = CONCAT("INSERT ",
				                     	     "INTO ",
							     "`db_freknur_investment`.`tbl_transaction` ",
						             "(`account_code`,`reference_no`,`msisdn`,`dr`,`cr`,`balance`,`narration`,`date_created`) ",
							     "VALUES ",
							     "('0.00','",TRIM(REF_NUMBER),"','",TRIM(MSISDN),"','0.00','",TRIM(AMOUNT),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");	
				ELSE
					SET @STMT_2 = CONCAT("INSERT ",
				                     	     "INTO ",
							     "`db_freknur_investment`.`tbl_transaction` ",
							     "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
							     "VALUES ",
							     "('0.00','",TRIM(REF_NUMBER),"','",TRIM(MSISDN),"','0.00','",TRIM(AMOUNT),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");				
				END IF;
				PREPARE QUERY FROM @STMT_2;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
				
				
				
				IF(TRIM(ACCOUNT_TYPE) = "CR")THEN
					SET @STMT_3 = CONCAT("INSERT ",
				                     	     "INTO ",
						             "`db_freknur_loan`.`tbl_wallet_transaction` ",
						             "(`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
						             "VALUES ",
							     "('",TRIM(REF_NUMBER),"','",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
				ELSE
					SET @STMT_3 = CONCAT("INSERT ",
				                     	     "INTO ",
						             "`db_freknur_loan`.`tbl_wallet_transaction` ",
						             "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
						             "VALUES ",
							     "('",TRIM(REF_NUMBER),"','",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");				
				END IF;
				PREPARE QUERY FROM @STMT_3;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;	
				
				
				
				SET @STMT_4 = CONCAT("UPDATE ",
					             "`db_freknur_loan`.`tbl_wallet` ",
					             "SET ",
					             "`balance` = '",TRIM(RUNNING_BAL),"',`date_modified` = '",NOW(),"'",
						     " WHERE ",
					             "`is_active` = '1' AND `is_suspended` = '0' AND `msisdn` = '",TRIM(MSISDN),"'");
				PREPARE QUERY FROM @STMT_4;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
			ELSE
				
				
				
				SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Insufficient balance."}';
				SELECT @JSON_O AS _JSON;				
			END IF;				
			
			
			
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Wallet account has been reconciled."}';
			SELECT @JSON_O AS _JSON;	
		ELSE
			
			
			
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Wallet A/C does not EXIST."}';
			SELECT @JSON_O AS _JSON;
		END IF;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:MSISDN|AMOUNT needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	
	
	
	COMMIT;
	
	
	
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @JSON_O = NULL;
	SET @BALANCE  = NULL;	
	SET AMOUNT = NULL;
	SET MSISDN = NULL;
	SET PARTICULARS = NULL;
	SET RUNNING_BAL = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcHandlePurchaseRequestFromAltMarket` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcHandlePurchaseRequestFromAltMarket`(
	IN `BUY_MSISDN` VARCHAR(20),
	IN `REQUEST_QTY` DECIMAL(15,8),
	IN `ASSET_NAME` VARCHAR(15),
        IN `ASSET_UID` VARCHAR(15), 
	IN `PRICE` DECIMAL(15,8),
	IN `CURRENT_BUYER_WALLET_BAL` DECIMAL(15,8),
	IN `TOTAL_COST` DECIMAL(15,8),
	IN `FEE_EARNED` DECIMAL(15,8)
)
BEGIN
	
	
	
	
	
        
	
	
	
	
	
	DECLARE REMINDER_QTY DECIMAL(8,2);
        DECLARE ASSET_IN_HAND_QTY DECIMAL(8,2);
	DECLARE REFERENCE VARCHAR(100);
	DECLARE PARTICULARS VARCHAR(100);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
		ROLLBACK;
		RESIGNAL;
	END;
	
	
	
	START TRANSACTION;	
	IF(TRIM(BUY_MSISDN) != "" OR TRIM(REQUEST_QTY) != "" OR TRIM(ASSET_NAME) != "" OR TRIM(PRICE) != "" OR TRIM(CURRENT_BUYER_WALLET_BAL) != "" OR TRIM(TOTAL_COST) != "" OR TRIM(FEE_EARNED) != "" OR TRIM(ASSET_UID) != "") THEN
		
		
		
		SET REFERENCE   = UCASE(CONCAT("BID",SUBSTRING(MD5(UUID_SHORT()),1,8),"0P"));
		SET PARTICULARS = CONCAT(UCASE(ASSET_NAME)," SHARES PURCHASED FROM ALTERNATIVE MARKET @.",TOTAL_COST);
		
		
		
		SET @STMT_0 = CONCAT("SELECT ",
				     "COUNT(`msisdn`) ",
				     "INTO ",
				     "@HEAP_SIZE "
				     "FROM ",
		                     "`db_freknur_investment`.`tbl_sale_request_queue` ",
			             "WHERE ",
				     "`is_processed` = 0 AND `msisdn` != '",TRIM(BUY_MSISDN),"'");
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		SELECT @HEAP_SIZE AS p;
                
                
                
                IF(@HEAP_SIZE > 0) THEN
			
			
			
			SET @STMT_1 = CONCAT("SELECT ",
			             	     "`msisdn`,`no_of_grain_sold`,`uid`,`unit_price` ",
				             "INTO ",
				             "@OWNER_MSISDN,@OWNER_QTY,@ASSET_ID,@SELLING_PRICE "
	                                     "FROM ",
	                                     "`db_freknur_investment`.`tbl_sale_request_queue` ",
	                                     "WHERE ",
	                                     "`is_processed` = 0 AND `msisdn` != '",TRIM(BUY_MSISDN),"' AND `uid` = '",TRIM(ASSET_UID),"'",
				             "ORDER BY ",
				             "`date_created` ASC ",
				             "LIMIT 1");
			PREPARE QUERY FROM @STMT_1;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;

			SET REMINDER_QTY = (@OWNER_QTY - REQUEST_QTY);

			SELECT  CONCAT(REMINDER_QTY,"|", @SELLING_PRICE,"|",PRICE,"|",ROUND(TRIM(REMINDER_QTY)*TRIM(PRICE),2)) AS P;
		        
                        
                        
		        IF(REQUEST_QTY > 0) THEN
                        IF(PRICE = @SELLING_PRICE) THEN           
				IF(REMINDER_QTY = 0) THEN
					
					
					
					SET @STMT_2 = CONCAT("DELETE ",
						             "FROM ",
			                                     "`db_freknur_investment`.`tbl_sale_request` ",
			                                     "WHERE ",
			                                     "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
					PREPARE QUERY FROM @STMT_2;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
                                        
                                        
                                        
                                        SET @STMT_20 = CONCAT("DELETE ",
                                                              "FROM ",
                                                              "`db_freknur_investment`.`tbl_sale_request_queue` ",
                                                              "WHERE ",
                                                              "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
                                        PREPARE QUERY FROM @STMT_20;
                                        EXECUTE QUERY;
                                        DEALLOCATE PREPARE QUERY;
                                	
					
                                	
                                	SET @STMT_21 = CONCAT("DELETE ",
                                                              "FROM ",
                                                      	      "`db_freknur_investment`.`tbl_alternate_market_bid` ",
                                                              "WHERE ",
                                                              "`msisdn` = '",TRIM(BUY_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
                                	PREPARE QUERY FROM @STMT_21;
                                	EXECUTE QUERY;
                                	DEALLOCATE PREPARE QUERY;
				ELSE
					
					IF(REMINDER_QTY > 0) THEN
                                                
                                                
                                                
                                                SET @STMT_2 = CONCAT("UPDATE ",
                                                                     "`db_freknur_investment`.`tbl_sale_request` ",
                                                                     "SET ",
                                                                     "`no_of_grain_sold` = '",TRIM(REMINDER_QTY),"',`cost` = '",ROUND(TRIM(REMINDER_QTY)*TRIM(PRICE),2),"',`date_modified`= NOW() ",
                                                                     "WHERE ",
                                                                     "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
                                                PREPARE QUERY FROM @STMT_2;
                                                EXECUTE QUERY;
                                                DEALLOCATE PREPARE QUERY;
						
						
						
						SET @STMT_20 = CONCAT("UPDATE ",
			                                              "`db_freknur_investment`.`tbl_sale_request_queue` ",
			                                              "SET ",
			                                	      "`no_of_grain_sold` = '",TRIM(REMINDER_QTY),"',`cost` = '",ROUND(TRIM(REMINDER_QTY)*TRIM(PRICE),2),"',`date_modified`= NOW() ",
			                                              "WHERE ",
			                                              "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");                   
						PREPARE QUERY FROM @STMT_20;
						EXECUTE QUERY;
						DEALLOCATE PREPARE QUERY;
                                                
                                                
                                                
						IF(REQUEST_QTY <= @OWNER_QTY) THEN
                                                        
                                                        
                                                        
							SET @STMT_21 = CONCAT("DELETE ",
									      "FROM ",
									      "`db_freknur_investment`.`tbl_alternate_market_bid` ",
									      "WHERE ",
									      "`msisdn` = '",TRIM(BUY_MSISDN),"'");
							PREPARE QUERY FROM @STMT_21;
							EXECUTE QUERY;
							DEALLOCATE PREPARE QUERY;
						ELSE
                                			
                                			
                                			
                                			SET @STMT_21 = CONCAT("UPDATE ",
                                                      		              "`db_freknur_investment`.`tbl_alternate_market_bid` ",
                                                                              "SET ",
                                                                              "`qty` = '",TRIM(REMINDER_QTY),"',`cost` = '",ROUND(TRIM(REMINDER_QTY)*TRIM(PRICE),2),"',`date_modified`= NOW() ",
                                                                              "WHERE ",
                                                                              "`msisdn` = '",TRIM(BUY_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
                                			PREPARE QUERY FROM @STMT_21;
                                			EXECUTE QUERY;
                                			DEALLOCATE PREPARE QUERY;
					        END IF;
					END IF;
				END IF;
			       

				IF(REMINDER_QTY >= 0) THEN
				        
                                        
                                        
                       	 		SET @STMT_3 = CONCAT("SELECT ",
                                             		     "`number_of_asset` ",
                                                             "INTO ",
                                                             "@PORTFOLIO_QTY ",
                                                             "FROM ",
                                                             "`db_freknur_investment`.`tbl_owner_portfolio` ",
                                                             "WHERE ",
                                                             "`asset_id` = '",TRIM(@ASSET_ID),"' AND `msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `lock` = 0");
                        		PREPARE QUERY FROM @STMT_3;
                        		EXECUTE QUERY;
                        		DEALLOCATE PREPARE QUERY;

				        SET ASSET_IN_HAND_QTY = (@PORTFOLIO_QTY - REQUEST_QTY);

		                        IF(ASSET_IN_HAND_QTY > 0) THEN
						
						
						
						SET @STMT_22 = CONCAT("UPDATE ",
							             "`db_freknur_investment`.`tbl_owner_portfolio` ",
							             "SET ",
								     "`number_of_asset` = '",ROUND(TRIM(ASSET_IN_HAND_QTY),2),"',`date_modified` = NOW() ",
								     "WHERE ",
								     "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"'");
						PREPARE QUERY FROM @STMT_22;
						EXECUTE QUERY;
						DEALLOCATE PREPARE QUERY;
		                        ELSE
						
						
						
						SET @STMT_22 = CONCAT("DELETE ",
								      "FROM ",
								      "`db_freknur_investment`.`tbl_owner_portfolio` ",
								      "WHERE ",
								      "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"'");
						PREPARE QUERY FROM @STMT_22;
						EXECUTE QUERY;
						DEALLOCATE PREPARE QUERY;
                                        END IF;
					
					
					
					CALL `db_freknur_investment`.`sProcInitChartOfAccount`();		
					
					
					
					SET @STMT_4 = CONCAT("INSERT ",
			                                     "INTO ",
					                     "`db_freknur_investment`.`tbl_statement` ",
				                             "(`msisdn`,`description`,`unit_price`,`number_of_share`,`cost`,`running_bal`) ",
		                                             "VALUES ",
					                     "('",TRIM(BUY_MSISDN),"','",TRIM(ASSET_NAME),"','",ROUND(TRIM(PRICE),2),"','",ROUND(TRIM(REQUEST_QTY),2),"','",ROUND(TRIM(TOTAL_COST),2),"','",ROUND(TRIM(CURRENT_BUYER_WALLET_BAL),2),"')");                    
					PREPARE QUERY FROM @STMT_4;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_5 = CONCAT("UPDATE ",
			                                     "`db_freknur_loan`.`tbl_wallet` ",
					                     "SET ",
			                                     "`balance` = '",ROUND(TRIM(CURRENT_BUYER_WALLET_BAL),2),"',`date_modified` = NOW() ",
				                             "WHERE ",
				                             "`msisdn` = '",TRIM(BUY_MSISDN),"'");                    
					PREPARE QUERY FROM @STMT_5;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_6 = CONCAT("UPDATE ",
				            		     "`db_freknur_loan`.`tbl_wallet` ",
				                             "SET ",
				                             "`balance` = ROUND((`balance`+'",TRIM(TOTAL_COST),"'),2),`date_modified` = NOW() ",
				                             "WHERE ",
			                                     "`msisdn` = '",TRIM(@OWNER_MSISDN),"'");                    
					PREPARE QUERY FROM @STMT_6;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;			
					
					
					
					SET @STMT_7 = CONCAT("INSERT ",
			                     		     "INTO ",
				                             "`db_freknur_loan`.`tbl_wallet_transaction` ",
				                             "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
					                     "VALUES ",
				                             "('",TRIM(REFERENCE),"','",TRIM(BUY_MSISDN),"','",ROUND(TRIM(TOTAL_COST),8),"','",ROUND(TRIM(CURRENT_BUYER_WALLET_BAL),8),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
					PREPARE QUERY FROM @STMT_7;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_8 = CONCAT("SELECT `tax` INTO @GOVT_LEVY FROM `db_freknur_investment`.`tbl_config`");
					PREPARE QUERY FROM @STMT_8;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_9 = CONCAT("SELECT ", 
			                                     "`account_code`,`balance` ",
					                     "INTO ",
					                     "@ACCOUNT_CODE,@BALANCE ",
				                             "FROM ",
			                                     "`db_freknur_investment`.`tbl_account` ",
					                     "WHERE ",
				                             "`account_code` = 'INC'");
					PREPARE QUERY FROM @STMT_9;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;						
			                
					
					
					SET @GOVT_TAX    = (FEE_EARNED * @GOVT_LEVY);			
					SET PARTICULARS  = CONCAT("FEE OF ",ROUND((FEE_EARNED - @GOVT_TAX),2)," EARNED FROM PURCHASE OF ",UCASE(ASSET_NAME)," SHARES");
					SET @NEW_BALANCE = (@BALANCE + (FEE_EARNED - @GOVT_TAX));
					
					
					
					SET @STMT_10 = CONCAT("INSERT ",
			                                      "INTO ",
					                      "`db_freknur_investment`.`tbl_transaction` ",
					                      "(`account_code`,`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
				                              "VALUES ",
			                                      "('",@ACCOUNT_CODE,"','",TRIM(REFERENCE),"','",TRIM(BUY_MSISDN),"','",ROUND(TRIM(FEE_EARNED) - TRIM(@GOVT_TAX),2),"','",ROUND(TRIM(@NEW_BALANCE),2),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
					PREPARE QUERY FROM @STMT_10;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_11 = CONCAT("UPDATE ",
				                              "`db_freknur_investment`.`tbl_account` ",
					                      "SET ",
					                      "`balance` = (`balance` + '",ROUND(TRIM(FEE_EARNED) - TRIM(@GOVT_TAX),2),"'),`date_modified` = NOW() ",
					                      "WHERE ",
				                              "`account_code` = 'INC'");                     
					PREPARE QUERY FROM @STMT_11;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_12 = CONCAT("SELECT ",
			                      		      "`account_code`,`balance` ",
				                              "INTO ",
			                                      "@ACCOUNT_CODE,@BALANCE ",
			                                      "FROM ",
					                      "`db_freknur_investment`.`tbl_account` ",
				                              "WHERE ",
				                              "`account_code` = 'FEE'");
					PREPARE QUERY FROM @STMT_12;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @NEW_BALANCE = (@BALANCE + @GOVT_TAX);
					SET PARTICULARS  = CONCAT("LEVY DEDUCTED FROM A FEE EARNED FROM PURCHASE OF ",UCASE(ASSET_NAME)," SHARES");			
					
					
					
					SET @STMT_13 = CONCAT("INSERT ",
			                                      "INTO ",
					                      "`db_freknur_investment`.`tbl_transaction` ",
					                      "(`account_code`,`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
					                      "VALUES ",
					                      "('",@ACCOUNT_CODE,"','",TRIM(REFERENCE),"','",TRIM(BUY_MSISDN),"','",ROUND(TRIM(@GOVT_TAX),2),"','",ROUND(TRIM(@NEW_BALANCE),2),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
					PREPARE QUERY FROM @STMT_13;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;			
					
					
					
					SET @STMT_14 = CONCAT("UPDATE ",
				                              "`db_freknur_investment`.`tbl_account` ",
			                                      "SET ",
				                              "`balance` = (`balance` + '",ROUND(TRIM(@GOVT_TAX),2),"'),`date_modified` = NOW() ",
			                                      "WHERE ",
					                      "`account_code` = 'FEE'");                     
					PREPARE QUERY FROM @STMT_14;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
				END IF;
				
				
				
				SET @STMT_15 = CONCAT("SELECT ",
				                      "COUNT(`_id`) ",
			                              "INTO ",
		                                      "@HEAP_PORTFOLIO_SIZE ",
			                              "FROM ",
					              "`db_freknur_investment`.`tbl_owner_portfolio` ",
					              "WHERE ",
					              "`msisdn` ='",TRIM(BUY_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"'");
				PREPARE QUERY FROM @STMT_15;
				EXECUTE QUERY;            
				DEALLOCATE PREPARE QUERY;
				
				
				
				IF(TRIM(@HEAP_PORTFOLIO_SIZE) = 0) THEN
					
					
					
					IF(REMINDER_QTY >= 0) THEN
						SET @STMT_16 = CONCAT("INSERT ",
					                              "`db_freknur_investment`.`tbl_owner_portfolio` ",
					                              "(`msisdn`,`asset_id`,`asset_acronym`,`number_of_asset`,`date_created`) ",
					                              "VALUES ",
					                              "('",TRIM(BUY_MSISDN),"','",TRIM(@ASSET_ID),"','",TRIM(UCASE(ASSET_NAME)),"','",ROUND(TRIM(REQUEST_QTY),8),"','",NOW(),"')");
					        PREPARE QUERY FROM @STMT_16;
						EXECUTE QUERY;            
						DEALLOCATE PREPARE QUERY;												 			
					END IF;										
				ELSE
					
					
					
					IF(REMINDER_QTY >= 0) THEN
						
						
						
						SET @STMT_17 = CONCAT("UPDATE ",
					                              "`db_freknur_investment`.`tbl_owner_portfolio` ",
					                              "SET ",
					                              "`number_of_asset` = ROUND((`number_of_asset` + '",TRIM(REQUEST_QTY),"'),8), `date_modified` = NOW() ",
					                              "WHERE ",
					                              "`msisdn` = '",TRIM(BUY_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"'");	
						PREPARE QUERY FROM @STMT_17;
						EXECUTE QUERY;            
						DEALLOCATE PREPARE QUERY;
					END IF;			
				END IF;
                                
                                
                                
                                SET PARTICULARS = CONCAT(UCASE(ASSET_NAME)," SHARES SOLD @ ALTERNATIVE MARKET @.",ROUND(TOTAL_COST,2));
                                
                                
                                
                                SET @STMT_18 = CONCAT("SELECT ",
                                                      "`balance` ",
                                                      "INTO ",
                                                      "@OWNER_BAL ",
                                                      "FROM ",
                                                      "`db_freknur_loan`.`tbl_wallet` ",
                                                      "WHERE ",
                                                      "`msisdn` = '",TRIM(@OWNER_MSISDN),"'");
                                PREPARE QUERY FROM @STMT_18;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
                                
                                
                                
                                SET @STMT_19 = CONCAT("INSERT ",
                                                      "INTO ",
                                                      "`db_freknur_loan`.`tbl_wallet_transaction` ",
                                                      "(`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
                                                      "VALUES ",
                                                      "('",TRIM(REFERENCE),"','",TRIM(@OWNER_MSISDN),"','",ROUND(TRIM(TOTAL_COST),2),"','",ROUND(TRIM(@OWNER_BAL),2),"','",TRIM(PARTICULARS),"','",NOW(),"')");
                                PREPARE QUERY FROM @STMT_19;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
				
				
				
				SET @JSON_O = CONCAT('{"ERROR":"0","RESULT":"SUCCESS","DATA":"',TRIM(@OWNER_MSISDN),'","MESSAGE":"Operation was successful."}');
				SELECT @JSON_O AS _JSON;
			ELSE
				
				
				
				SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"The price offer is less than the unit price of the asset."}';
				SELECT @JSON_O AS _JSON;		
			END IF;
		        ELSE									
                                
                                
                                
                                SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Operation has failed 1."}';
                                SELECT @JSON_O AS _JSON;
                        END IF;		
		ELSE
			
			
			
                	SET @JSON_O = CONCAT('{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Operation has failed 2."}');
                	SELECT @JSON_O AS _JSON;
		END IF;
                
                
                
                SET @STMT_22 = CONCAT("DELETE ",
                                      "FROM ",
                                      "`db_freknur_investment`.`tbl_alternate_market_bid` ",
                                      "WHERE ",
                                      "`msisdn` = '",TRIM(BUY_MSISDN),"'");
                PREPARE QUERY FROM @STMT_22;
                EXECUTE QUERY;
                DEALLOCATE PREPARE QUERY;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:BUY_MSISDN|REQUEST_QTY|ASSET_NAME|PRICE|TOTAL_COST|CURRENT_BUYER_WALLET_BAL needs to be SET."}';
		SELECT @JSON_O AS _JSON;																			   
	END IF;				   
	
	
	
	COMMIT;
	
	
	
	SET @HEAP_SIZE    = NULL;
	SET @OWNER_QTY    = NULL;
	SET @OWNER_MSISDN = NULL;
	SET @ACCOUNT_CODE = NULL;
	SET @GOVT_TAX     = NULL;
	SET @GOVT_LEVY    = NULL;
	SET @BALANCE      = NULL;
	SET @OWNER_BAL    = NULL;
	SET @ASSET_ID     = NULL;
	SET @NEW_BALANCE  = NULL;
	SET @HEAP_SIZE    = NULL;
        SET @PORTFOLIO_QTY = NULL;
	SET @SELLING_PRICE = NULL;
	SET @HEAP_PORTFOLIO_SIZE = NULL;
	SET @STMT_1       = NULL;
	SET @STMT_1       = NULL;
	SET @STMT_2       = NULL;
	SET @STMT_3       = NULL;
	SET @STMT_4       = NULL;
	SET @STMT_5       = NULL;
	SET @STMT_6       = NULL;
	SET @STMT_7       = NULL;
	SET @STMT_8       = NULL;
	SET @STMT_9       = NULL;
	SET @STMT_10      = NULL;
	SET @STMT_11      = NULL;
	SET @STMT_12      = NULL;	
	SET @STMT_13      = NULL;
	SET @STMT_14      = NULL;
	SET @STMT_15      = NULL;
	SET @STMT_16      = NULL;	
	SET @STMT_17      = NULL;
	SET @STMT_18      = NULL;
	SET @STMT_19      = NULL;
	SET @STMT_20      = NULL;
	SET @STMT_21      = NULL;
        SET @STMT_22      = NULL;
	SET PRICE         = NULL;
	SET BUY_MSISDN    = NULL;
	SET CURRENT_BUYER_WALLET_BAL = NULL;
	SET TOTAL_COST    = NULL;	
	SET ASSET_NAME    = NULL;
        SET ASSET_UID     = NULL; 
	SET REQUEST_QTY   = NULL;
	SET FEE_EARNED    = NULL;
	SET REFERENCE     = NULL;
	SET PARTICULARS   = NULL;
        SET ASSET_IN_HAND_QTY = NULL;		
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcInitChartOfAccount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcInitChartOfAccount`()
BEGIN
	
	
	
	SET @STMT_0 = CONCAT("SELECT ",
			     "COUNT(`id`) ",
			     "INTO ",
			     "@SIZE ",
			     "FROM ",
			     "`db_freknur_investment`.`tbl_account`");                    
	PREPARE QUERY FROM @STMT_0;
	EXECUTE QUERY;
	DEALLOCATE PREPARE QUERY;
	
	
	
	IF(TRIM(@SIZE) = "0") THEN
		SET @STMT_1 = CONCAT("INSERT ",
			             "INTO ",
				     "`db_freknur_investment`.`tbl_account` ",
				     "(`account_code`,`account_name`,`balance`,`date_created`) ",
				     "VALUES ",
				     "('WRK','WORKING','0.00','",NOW(),"'), ",
				     "('INC','INCOMING','0.00','",NOW(),"'), ",
				     "('FEE','GOVT_TAX','0.00','",NOW(),"')");                    
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;	
	END IF;
	
	
	
	SET @SIZE = NULL;	
	SET @STMT_0 = NULL;
	SET @STMT_1 = NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcLogAssetPurchaseTrx` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcLogAssetPurchaseTrx`(
	IN `MSISDN` VARCHAR(20),
	IN `ASSET_ID` VARCHAR(50),
	IN `ASSET_NAME` VARCHAR(50),
	IN `PRICE` DECIMAL(15,8),
	IN `QTY` DECIMAL(15,8),
	IN `WALLET_BAL` DECIMAL(15,8),
	IN `TOTAL_COST` DECIMAL(15,8),
	IN `FEE_EARNED` DECIMAL(15,8)
)
BEGIN
	
	
	
	
	
	
	
	
	
	
	
	DECLARE PARTICULARS VARCHAR(100);
	DECLARE REFERENCE VARCHAR(100);
	DECLARE ACTIVITY_REF VARCHAR(100);
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		GET DIAGNOSTICS CONDITION 1
	        @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
		ROLLBACK;
		
	END;
	
	
	
	START TRANSACTION;	
	IF(TRIM(MSISDN) != "" OR TRIM(ASSET_ID) != "" OR TRIM(ASSET_NAME) != "" OR TRIM(PRICE) != "" OR TRIM(QTY) != "" OR  TRIM(WALLET_BAL) != "" OR TRIM(TOTAL_COST) != "" OR TRIM(FEE_EARNED) != "") THEN
		
		
		
		SET REFERENCE   = UCASE(CONCAT("GRN",SUBSTRING(MD5(UUID_SHORT()),1,8),"0A"));
		SET PARTICULARS = CONCAT(UCASE(ASSET_NAME)," ",ROUND(TRIM(QTY),2)," SHARES PURCHASED @.",ROUND(TRIM(TOTAL_COST),2));
		
		
		
		
		CALL `db_freknur_investment`.`sProcInitChartOfAccount`();
		
		
		
		SET @STMT_1 = CONCAT("INSERT ",
		                     "INTO ",
		                     "`db_freknur_investment`.`tbl_statement` ",
			             "(`msisdn`,`description`,`unit_price`,`number_of_share`,`cost`,`running_bal`) ",
				     "VALUES ",
			             "('",TRIM(MSISDN),"','",TRIM(ASSET_NAME),"','",TRIM(PRICE),"','",TRIM(QTY),"','",ROUND(TRIM(TOTAL_COST),8),"','",ROUND(TRIM(WALLET_BAL),8),"')");                    
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		
		
		SET @STMT_2 = CONCAT("UPDATE ",
			             "`db_freknur_loan`.`tbl_wallet` ",
				     "SET ",
			             "balance = '",ROUND(TRIM(WALLET_BAL),8),"'",
				     "WHERE ",
		                     "`msisdn` = '",TRIM(MSISDN),"'");                    
		PREPARE QUERY FROM @STMT_2;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;	
		
		
		
		
		SET @STMT_3 = CONCAT("INSERT ",
		                     "INTO ",
				     "`db_freknur_loan`.`tbl_wallet_transaction` ",
		                     "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
				     "VALUES ",
			             "('",TRIM(REFERENCE),"','",TRIM(MSISDN),"','",ROUND(TRIM(TOTAL_COST),8),"','",ROUND(TRIM(WALLET_BAL),8),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
		PREPARE QUERY FROM @STMT_3;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		
		SET @STMT_4 = CONCAT("UPDATE ",
			             "`db_freknur_investment`.`tbl_asset` ",
			             "SET ",
		                     "`total` = (`total` - '",TRIM(QTY),"'), `date_modified` = NOW() ",
			             "WHERE ",
			             "`uid` = '",TRIM(ASSET_ID),"'");                    
		PREPARE QUERY FROM @STMT_4;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		SET @STMT_5 = CONCAT("SELECT `tax` INTO @GOVT_LEVY FROM `db_freknur_investment`.`tbl_config`");
		PREPARE QUERY FROM @STMT_5;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		SET @STMT_6 = CONCAT("SELECT ", 
		                     "`account_code`,`balance` ",
		                     "INTO ",
		                     "@ACCOUNT_CODE,@BALANCE ",
		                     "FROM ",
		                     "`db_freknur_investment`.`tbl_account` ",
			             "WHERE ",
			             "`account_code` = 'INC'");
		PREPARE QUERY FROM @STMT_6;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		
		SET @GOVT_TAX    = (FEE_EARNED * @GOVT_LEVY);			
		SET PARTICULARS  = CONCAT("FEE OF ",ROUND((FEE_EARNED - @GOVT_TAX),2)," EARNED FROM SELL OF ",UCASE(ASSET_NAME)," SHARES");
		SET @NEW_BALANCE = (@BALANCE + (FEE_EARNED - @GOVT_TAX));
		
		
		
		SET @STMT_7 = CONCAT("INSERT ",
		                     "INTO ",
		                     "`db_freknur_investment`.`tbl_transaction` ",
				     "(`account_code`,`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
			             "VALUES ",
			             "('",@ACCOUNT_CODE,"','",TRIM(REFERENCE),"','",TRIM(MSISDN),"','",ROUND(TRIM(FEE_EARNED) - TRIM(@GOVT_TAX),2),"','",ROUND(TRIM(@NEW_BALANCE),2),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
		PREPARE QUERY FROM @STMT_7;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;	
		
		
		
		
		SET @STMT_8 = CONCAT("UPDATE ",
			             "`db_freknur_investment`.`tbl_account` ",
			             "SET ",
			             "`balance` = ROUND((`balance` + '",TRIM(FEE_EARNED) - TRIM(@GOVT_TAX),"'),2),`date_modified` = NOW() ",
			             "WHERE ",
		                     "`account_code` = 'INC'");                     
		PREPARE QUERY FROM @STMT_8;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		
		SET @STMT_9 = CONCAT("SELECT ",
		                     "`account_code`,`balance` ",
			             "INTO ",
		                     "@ACCOUNT_CODE,@BALANCE ",
			             "FROM ",
		                     "`db_freknur_investment`.`tbl_account` ",
			             "WHERE ",
		                     "`account_code` = 'FEE'");
		PREPARE QUERY FROM @STMT_9;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		SET @NEW_BALANCE = (@BALANCE + @GOVT_TAX);
		SET PARTICULARS  = CONCAT("LEVY DEDUCTED FROM A FEE EARNED FROM SELL OF ",UCASE(ASSET_NAME)," SHARES");			
		
		
		
		SET @STMT_8 = CONCAT("INSERT ",
		                     "INTO ",
			             "`db_freknur_investment`.`tbl_transaction` ",
			             "(`account_code`,`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
			             "VALUES ",
			             "('",@ACCOUNT_CODE,"','",TRIM(REFERENCE),"','",TRIM(MSISDN),"','",ROUND(TRIM(@GOVT_TAX),2),"','",ROUND(TRIM(@NEW_BALANCE),2),"','",TRIM(PARTICULARS),"',NOW())");                     
		PREPARE QUERY FROM @STMT_8;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		SET @STMT_9 = CONCAT("UPDATE ",
		                     "`db_freknur_investment`.`tbl_account` ",
			             "SET ",
			             "`balance` = ROUND((`balance` + '",TRIM(@GOVT_TAX),"'),2),`date_modified` = NOW() ",
				     "WHERE ",
		                     "`account_code` = 'FEE'");                     
		PREPARE QUERY FROM @STMT_9;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		SET @STMT_10 = CONCAT("SELECT ",
		                      "COUNT(`_id`) ",
				      "INTO ",
                                      "@HEAP_SIZE ",
			              "FROM ",
				      "`db_freknur_investment`.`tbl_owner_portfolio` ",
				      "WHERE ",
				      "`msisdn` ='",TRIM(MSISDN),"' AND `asset_id` = '",TRIM(ASSET_ID),"'");
                PREPARE QUERY FROM @STMT_10;
                EXECUTE QUERY;
                DEALLOCATE PREPARE QUERY; 
		
		
		
		IF(TRIM(@HEAP_SIZE) = "0") THEN
			
			
			
			SET @STMT_11 = CONCAT("INSERT ",
			                      "`db_freknur_investment`.`tbl_owner_portfolio` ",
			                      "(`msisdn`,`asset_id`,`asset_acronym`,`number_of_asset`,`date_created`) ",
			                      "VALUES ",
			                      "('",TRIM(MSISDN),"','",TRIM(ASSET_ID),"','",TRIM(UCASE(ASSET_NAME)),"','",TRIM(QTY),"','",NOW(),"')");
                        PREPARE QUERY FROM @STMT_11;
                        EXECUTE QUERY;
                        DEALLOCATE PREPARE QUERY;
			
			
			
                        SET @STMT_14 = CONCAT("INSERT ",
                                              "`db_freknur_investment`.`tbl_owner_portfolio_temp_list` ",
                                              "(`msisdn`,`asset_id`,`asset_acronym`,`number_of_asset`,`date_created`) ",
                                              "VALUES ",
                                              "('",TRIM(MSISDN),"','",TRIM(ASSET_ID),"','",TRIM(UCASE(ASSET_NAME)),"','",TRIM(QTY),"','",NOW(),"')");
                        PREPARE QUERY FROM @STMT_14;
                        EXECUTE QUERY;
                        DEALLOCATE PREPARE QUERY;
		ELSE
			
			
			
			SET @STMT_11 = CONCAT("UPDATE ",
			                      "`db_freknur_investment`.`tbl_owner_portfolio` ",
			                      "SET ",
			                      "`number_of_asset` = (`number_of_asset` + '",TRIM(QTY),"'), `date_modified` = NOW() ",
			                      "WHERE ",
			                      "`msisdn` = '",TRIM(MSISDN),"' AND `asset_id` = '",TRIM(ASSET_ID),"'");
                	PREPARE QUERY FROM @STMT_11;
                	EXECUTE QUERY;
                	DEALLOCATE PREPARE QUERY;
			
			
			
                        SET @STMT_14 = CONCAT("UPDATE ",
                                              "`db_freknur_investment`.`tbl_owner_portfolio_temp_list` ",
                                              "SET ",
                                              "`number_of_asset` = (`number_of_asset` + '",TRIM(QTY),"'), `date_modified` = NOW() ",
                                              "WHERE ",
                                              "`msisdn` = '",TRIM(MSISDN),"' AND `asset_id` = '",TRIM(ASSET_ID),"'");
                        PREPARE QUERY FROM @STMT_14;
                        EXECUTE QUERY;
                        DEALLOCATE PREPARE QUERY;
		END IF;
		
		
		
		SET @STMT_12 = CONCAT("UPDATE ",
		                      "`db_freknur_investment`.`tbl_purchase_request` ",
		                      "SET ",
		                      "`is_processed` = 1, `date_modified` = NOW() ",
		                      "WHERE ",
		                      "`msisdn` = '",TRIM(MSISDN),"' AND `uid` = '",TRIM(ASSET_ID),"' AND `is_processed` = 0");
		PREPARE QUERY FROM @STMT_12;
		EXECUTE QUERY;            
		DEALLOCATE PREPARE QUERY;	
		
		
		
		SET ACTIVITY_REF = CONCAT("PURCHASE OF ",ROUND((QTY),2)," ",TRIM(ASSET_NAME)," DIGITAL ASSETS @ COST OF ",ROUND(TRIM(TOTAL_COST),2)," HAS BEEN MADE.");
		
		
		
		SET @STMT_13 = CONCAT("INSERT ",
		                      "INTO ",
		                      "`db_freknur_general`.`tbl_activity_log` ",
		                      "(`msisdn`,`activity`)",
		                      "VALUES ",
				      "('",TRIM(MSISDN),"','",TRIM(ACTIVITY_REF),"')");
		PREPARE QUERY FROM @STMT_13;
		EXECUTE QUERY;            
		DEALLOCATE PREPARE QUERY; 
		
		
		
		SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation was successful."}';
		SELECT @JSON_O AS _JSON;						
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:MSISDN|ASSET_ID|ASSET_NAME|PRICE|QTY|WALLET_BAL needs to be SET."}';
		SELECT @JSON_O AS _JSON;		
	END IF;
	
	
	
	COMMIT;
	
	
	
	SET @ACCOUNT_CODE = NULL;
	SET @BALANCE = NULL;
	SET @NEW_BALANCE = NULL;
	SET @GOVT_TAX = NULL;
	SET @GOVT_LEVY = NULL;
	SET @JSON_O = NULL;	
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @STMT_5 = NULL;
	SET @STMT_6 = NULL;
	SET @STMT_7 = NULL;
	SET @STMT_8 = NULL;
	SET @STMT_9 = NULL;
	SET @STMT_10 = NULL;
	SET @STMT_10 = NULL;
	SET @STMT_11 = NULL;	
	SET @STMT_12 = NULL;
	SET @STMT_13 = NULL;
	SET @STMT_14 = NULL;
	SET @HEAP_SIZE = NULL;
	SET MSISDN = NULL;
	SET ASSET_ID = NULL;
	SET ASSET_NAME = NULL;
	SET PRICE = NULL;
	SET QTY = NULL;
	SET WALLET_BAL = NULL;	
	SET PARTICULARS = NULL;
	SET REFERENCE = NULL;
	SET ACTIVITY_REF = NULL;
	SET TOTAL_COST = NULL;
	SET FEE_EARNED = NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcSysAlternativeMarketAlertToSeller` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcSysAlternativeMarketAlertToSeller`(
	IN `MSISDN` VARCHAR(15),
	IN `ASSET_NAME` VARCHAR(20),
	IN `DURATION` VARCHAR(5),
	IN `OFFER_PRICE` DECIMAL(15,2),
	IN `ALERT_MSG` VARCHAR(160)
)
BEGIN
	
	
	
	
	
	
	
	
	DECLARE MESSAGE VARCHAR(160);
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
		ROLLBACK;
		
	END;
	
	
	
	START TRANSACTION;
	IF(TRIM(MSISDN) != "" OR TRIM(ASSET_NAME) != "" OR TRIM(DURATION) != "" OR TRIM(OFFER_PRICE) != "") THEN
		
		
		
		IF(TRIM(ALERT_MSG) = "") THEN
			SET MESSAGE = CONCAT("I have made an offer to purchase your ",UCASE(ASSET_NAME)," share(s) for ",TRIM(OFFER_PRICE)," per unit. The offer expires in 3hours.");
		ELSE
			SET MESSAGE = TRIM(ALERT_MSG);
	        END IF;
		
		
		
		SET @STMT_0 = CONCAT("SELECT COUNT(`_id`) INTO @HEAP_SIZE FROM `db_freknur_investment`.`tbl_sale_request_queue` WHERE `is_processed` = 0 ");
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
                
                
                
		IF(@HEAP_SIZE > "0") THEN
		
		
		
		SET @STMT_1 = CONCAT("SELECT ",
			             "`_id`,`msisdn`,`uid`,DATEDIFF(DATE(NOW()),DATE(`date_created`)) ",
			             "INTO ",
			             "@REC_ID,@MSISDN,@ASSET_ID,@DAY_DIFF ",
			             "FROM ",
				     "`db_freknur_investment`.`tbl_sale_request_queue` ",
				     "WHERE ",
			             "`is_processed` = 0 ",
				     "LIMIT 1");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;  
		
		
		
		IF(@DAY_DIFF >= DURATION) THEN
			
			
			
			CALL `db_freknur_loan`.`sProcQueueNotification`(TRIM(@MSISDN), MESSAGE, "SYS_ALERT");
			
			
			
			SET @STMT_2 = CONCAT("UPDATE ",
					     "`db_freknur_investment`.`tbl_sale_request_queue` ",
					     "SET ",
					     "`date_modified` = NOW(),`is_processed` = 1 ",
					     "WHERE ",
					     "`_id` = '",TRIM(@REC_ID),"'");
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @STMT_3 = CONCAT("DELETE ",
			                     "FROM ",
					     "`db_freknur_investment`.`tbl_sale_request` ",
					     "WHERE ",
					     "`msisdn` = '",TRIM(@MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = 0");
			PREPARE QUERY FROM @STMT_3;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
		END IF;
		
		
		
		SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation was successful."}';
		SELECT CONCAT(@DAY_DIFF,'   ', DURATION) AS _JSON;
                END IF;			
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:DURATION needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	
	
	
	COMMIT;
	
	
	
	SET @JSON_O     = NULL;	
	SET @STMT_0     = NULL;
	SET @STMT_1     = NULL;
	SET @STMT_2     = NULL;
	SET @STMT_3     = NULL;
	SET @DAY_DIFF   = NULL;
	SET @MSISDN     = NULL;
	SET @REC_ID     = NULL;
	SET @ASSET_ID   = NULL;
        SET @HEAP_SIZE  = NULL;
	SET OFFER_PRICE = NULL;
	SET ASSET_NAME  = NULL;
	SET ALERT_MSG   = NULL;
	SET MESSAGE     = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `db_freknur_loan`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_freknur_loan` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_freknur_loan`;

--
-- Table structure for table `notification_template`
--

DROP TABLE IF EXISTS `notification_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `language_id` int DEFAULT NULL,
  `message` char(160) DEFAULT NULL,
  `type` int DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_template`
--

LOCK TABLES `notification_template` WRITE;
/*!40000 ALTER TABLE `notification_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status_description` char(20) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_configs`
--

DROP TABLE IF EXISTS `system_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_configs` (
  `_income_rate` double(5,2) DEFAULT '0.00',
  `_interest_rate` double(5,2) DEFAULT '0.00',
  `_loan_duration_in_day` int DEFAULT '2',
  `_excise_rate` float DEFAULT '0.0909091',
  `_1_notification_hr` int DEFAULT '8',
  `_2_notification_hr` int DEFAULT '6',
  `_3_notification_hr` int DEFAULT '4',
  `_4_notification_hr` int DEFAULT '1',
  `_minimum_credit` double(15,2) DEFAULT NULL,
  `_maximum_credit` double(15,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_configs`
--

LOCK TABLES `system_configs` WRITE;
/*!40000 ALTER TABLE `system_configs` DISABLE KEYS */;
/*!40000 ALTER TABLE `system_configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_account`
--

DROP TABLE IF EXISTS `tbl_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_code` varchar(20) NOT NULL,
  `account_name` varchar(50) DEFAULT NULL,
  `balance` decimal(18,8) DEFAULT '0.00000000',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_unik` (`account_code`),
  KEY `bank_id` (`account_code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_account`
--

LOCK TABLES `tbl_account` WRITE;
/*!40000 ALTER TABLE `tbl_account` DISABLE KEYS */;
INSERT INTO `tbl_account` VALUES (1,'UTY','UTILITY',50000000.00000000,'2020-06-24 17:11:08','2022-10-06 09:55:41'),(2,'DEP','DEPOSIT',0.00000000,'2020-06-24 17:12:32','2020-06-24 14:12:33'),(3,'INC','INCOME',0.00000000,'2020-06-24 18:09:37','2022-09-27 13:49:31'),(4,'FEE','LOAN_FEE',0.00000000,'2020-06-24 18:10:57','2020-06-24 15:10:57');
/*!40000 ALTER TABLE `tbl_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_broadcast`
--

DROP TABLE IF EXISTS `tbl_broadcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_broadcast` (
  `_id` tinyint NOT NULL AUTO_INCREMENT,
  `message` varchar(420) NOT NULL,
  `broadcast_name` varchar(50) NOT NULL,
  `broadcast_date` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_processed` int DEFAULT '0',
  `is_deleted` int DEFAULT '0',
  PRIMARY KEY (`_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_broadcast`
--

LOCK TABLES `tbl_broadcast` WRITE;
/*!40000 ALTER TABLE `tbl_broadcast` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_broadcast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_credit_score`
--

DROP TABLE IF EXISTS `tbl_credit_score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_credit_score` (
  `id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(15) DEFAULT NULL,
  `credit_score` int DEFAULT NULL,
  `credit_limit` double(15,2) DEFAULT NULL,
  `date_scored` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `msisdn_ac` (`msisdn`),
  KEY `msisdn` (`msisdn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_credit_score`
--

LOCK TABLES `tbl_credit_score` WRITE;
/*!40000 ALTER TABLE `tbl_credit_score` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_credit_score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_debtor`
--

DROP TABLE IF EXISTS `tbl_debtor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_debtor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(50) DEFAULT NULL,
  `msisdn` varchar(15) NOT NULL,
  `amount_requested` double(15,2) DEFAULT '0.00',
  `amount_disbursed` double(15,2) DEFAULT '0.00',
  `repayment_amount` double(15,2) DEFAULT '0.00',
  `interest_amount` double(9,2) DEFAULT '0.00',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `expected_repayment_date` datetime DEFAULT NULL,
  `repayment_date` datetime DEFAULT NULL,
  `notification_count` int DEFAULT '0',
  `next_notification_date` datetime DEFAULT NULL,
  `is_repaid` int DEFAULT '0' COMMENT '1-Repaid|0-Unpaid',
  `is_archived` int DEFAULT '0' COMMENT '1-Archived|0-Not Archive',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_unik` (`reference_no`),
  KEY `reference_no` (`reference_no`),
  KEY `msisdn` (`msisdn`),
  KEY `is_repaid` (`is_repaid`),
  KEY `is_archived` (`is_archived`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_debtor`
--

LOCK TABLES `tbl_debtor` WRITE;
/*!40000 ALTER TABLE `tbl_debtor` DISABLE KEYS */;
INSERT INTO `tbl_debtor` VALUES (1,'LNR-JX4IIS5QOY','4915224043369',2500.00,2450.00,3125.00,625.00,'2022-10-06 12:55:41','2022-10-06 09:55:41','2022-10-16 12:55:41','2022-10-16 12:55:41',4,'2022-10-16 08:55:41',0,1);
/*!40000 ALTER TABLE `tbl_debtor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_defaulter`
--

DROP TABLE IF EXISTS `tbl_defaulter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_defaulter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(15) NOT NULL,
  `loan_amount` double(15,2) DEFAULT '0.00',
  `amount_repaid` double(15,2) DEFAULT '0.00',
  `cummulative_interest` double(15,2) DEFAULT '0.00',
  `expected_repayment_date` datetime DEFAULT NULL,
  `notification_date` datetime DEFAULT NULL,
  `date_repaid` datetime DEFAULT NULL,
  `roll_count` int DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `msisdn` (`msisdn`),
  KEY `is_archived` (`is_archived`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_defaulter`
--

LOCK TABLES `tbl_defaulter` WRITE;
/*!40000 ALTER TABLE `tbl_defaulter` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_defaulter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_language`
--

DROP TABLE IF EXISTS `tbl_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_language` (
  `id` int NOT NULL AUTO_INCREMENT,
  `language_code` char(3) DEFAULT NULL,
  `language_description` char(45) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `language_code` (`language_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_language`
--

LOCK TABLES `tbl_language` WRITE;
/*!40000 ALTER TABLE `tbl_language` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_loan_payout`
--

DROP TABLE IF EXISTS `tbl_loan_payout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_loan_payout` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(50) NOT NULL,
  `msisdn` varchar(15) NOT NULL,
  `amount` double(15,2) DEFAULT '0.00',
  `collateral_percentage` double(15,2) DEFAULT '0.00',
  `approved_by` varchar(25) DEFAULT NULL,
  `status` int DEFAULT '0',
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT NULL,
  `has_collateral` int DEFAULT '0',
  `is_processed` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_unik` (`reference_no`),
  KEY `msisdn` (`msisdn`),
  KEY `is_processed` (`is_processed`),
  KEY `request_id` (`reference_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_loan_payout`
--

LOCK TABLES `tbl_loan_payout` WRITE;
/*!40000 ALTER TABLE `tbl_loan_payout` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_loan_payout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_loan_repayment`
--

DROP TABLE IF EXISTS `tbl_loan_repayment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_loan_repayment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(15) NOT NULL,
  `amount` double(15,2) DEFAULT '0.00',
  `transaction_no` varchar(25) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_processed` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_no` (`transaction_no`),
  KEY `trxunik` (`transaction_no`),
  KEY `msisdn` (`msisdn`),
  KEY `is_processed` (`is_processed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_loan_repayment`
--

LOCK TABLES `tbl_loan_repayment` WRITE;
/*!40000 ALTER TABLE `tbl_loan_repayment` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_loan_repayment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_loan_request`
--

DROP TABLE IF EXISTS `tbl_loan_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_loan_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(50) DEFAULT NULL COMMENT 'loan request reference',
  `msisdn` varchar(50) NOT NULL COMMENT 'loanee identifier',
  `amount` double(15,2) DEFAULT '0.00',
  `collateral_percentage` double(15,2) DEFAULT '0.00',
  `task_flag` varchar(1) DEFAULT '0',
  `requested_by` varchar(50) DEFAULT NULL,
  `approved_by` varchar(50) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `has_collateral` int NOT NULL DEFAULT '0',
  `is_processed` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `msisdn_unik` (`msisdn`),
  UNIQUE KEY `ref_no` (`reference_no`),
  KEY `is_processed` (`is_processed`),
  KEY `msisdn` (`msisdn`),
  KEY `has_collateral` (`has_collateral`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_loan_request`
--

LOCK TABLES `tbl_loan_request` WRITE;
/*!40000 ALTER TABLE `tbl_loan_request` DISABLE KEYS */;
INSERT INTO `tbl_loan_request` VALUES (1,'LNR-JX4IIS5QOY','4915224043369',2500.00,0.00,'2','4915224043369','admin','2022-10-06 12:53:20','2022-10-06 09:55:40',0,1);
/*!40000 ALTER TABLE `tbl_loan_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_mpesa_receipt`
--

DROP TABLE IF EXISTS `tbl_mpesa_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_mpesa_receipt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(50) NOT NULL DEFAULT '0',
  `msisdn` varchar(15) NOT NULL,
  `amount` double(15,2) DEFAULT '0.00',
  `status` varchar(2500) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_unik` (`reference_no`),
  KEY `msisdn` (`msisdn`),
  KEY `is_archived` (`is_archived`),
  KEY `reference_no` (`reference_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_mpesa_receipt`
--

LOCK TABLES `tbl_mpesa_receipt` WRITE;
/*!40000 ALTER TABLE `tbl_mpesa_receipt` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_mpesa_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_transaction`
--

DROP TABLE IF EXISTS `tbl_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_code` varchar(50) NOT NULL,
  `reference_no` varchar(50) NOT NULL,
  `msisdn` varchar(15) NOT NULL,
  `cr` decimal(15,8) DEFAULT '0.00000000',
  `dr` decimal(15,8) DEFAULT '0.00000000',
  `balance` decimal(15,8) DEFAULT '0.00000000',
  `narration` text,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `msisdn` (`msisdn`),
  KEY `reference_no` (`reference_no`),
  KEY `account_id` (`account_code`),
  KEY `is_archived` (`is_archived`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_transaction`
--

LOCK TABLES `tbl_transaction` WRITE;
/*!40000 ALTER TABLE `tbl_transaction` DISABLE KEYS */;
INSERT INTO `tbl_transaction` VALUES (1,'UTY','LNR-JX4IIS5QOY','4915224043369',0.00000000,2500.00000000,-2500.00000000,'MONEY MOVEMENT OUT OF UTY.','2022-10-06 12:55:41','2022-10-06 09:55:41',0),(2,'FEE','LNR-JX4IIS5QOY','4915224043369',50.00000000,0.00000000,50.00000000,'LOAN HANDLING FEES EARNED.','2022-10-06 12:55:41','2022-10-06 09:55:41',0),(3,'0','LNR-JX4IIS5QOY','4915224043369',2450.00000000,0.00000000,2450.00000000,'MONEY MOVED FROM UTY TO CLIENT WALLET A/C.','2022-10-06 12:55:41','2022-10-06 09:55:41',0);
/*!40000 ALTER TABLE `tbl_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_wallet`
--

DROP TABLE IF EXISTS `tbl_wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_wallet` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uid` varchar(100) NOT NULL,
  `msisdn` varchar(15) NOT NULL,
  `balance` decimal(15,8) DEFAULT '0.00000000',
  `bonus` decimal(15,8) DEFAULT '0.00000000',
  `reference_no` varchar(50) NOT NULL DEFAULT '0',
  `loan_limit` varchar(10) DEFAULT '0',
  `county_id` int DEFAULT NULL,
  `language_id` int DEFAULT '1',
  `password` varchar(200) DEFAULT NULL,
  `salt` varchar(200) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` int DEFAULT '1' COMMENT '1-active 0-inactive',
  `is_suspended` int DEFAULT '0' COMMENT '1-suspended 0 not suspended',
  PRIMARY KEY (`id`),
  UNIQUE KEY `msisdn_unik` (`msisdn`),
  KEY `msisdn` (`msisdn`),
  KEY `status_id` (`is_active`),
  KEY `system_uid` (`uid`),
  KEY `is_suspended` (`is_suspended`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_wallet`
--

LOCK TABLES `tbl_wallet` WRITE;
/*!40000 ALTER TABLE `tbl_wallet` DISABLE KEYS */;
INSERT INTO `tbl_wallet` VALUES (1,'99411788130418788','254707132162',11806.12000000,0.00000000,'0','0',NULL,1,'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',NULL,'2022-03-14 16:33:44','2022-09-27 13:49:31',1,0),(2,'99411788130418811','254711884102',850.10000000,0.00000000,'0','0',NULL,1,'b0412597dcea813655574dc54a5b74967cf85317f0332a2591be7953a016f8de56200eb37d5ba593b1e4aa27cea5ca27100f94dccd5b04bae5cadd4454dba67d',NULL,'2022-04-19 15:28:15','2022-06-13 13:29:09',1,0),(3,'99411788130418818','254720726071',850.00000000,0.00000000,'0','0',NULL,1,'d4bd3b6e82888fa48dcff27b97aa596b8014dceca2b73d5a2cc0cc31a1709991b7684dd3cfe9ca355479a51751208e0fce49b85976eeaf1c687a67c1715dcd30',NULL,'2022-04-20 11:00:44','2022-04-20 08:00:44',1,0),(4,'99411788130418786','254722563707',138.11000000,0.00000000,'0','0',NULL,1,'b0412597dcea813655574dc54a5b74967cf85317f0332a2591be7953a016f8de56200eb37d5ba593b1e4aa27cea5ca27100f94dccd5b04bae5cadd4454dba67d',NULL,'2022-03-14 12:38:19','2022-08-10 12:22:09',1,0),(5,'99411788130418807','393519688608',2821.46000000,0.00000000,'LNR-xw6mpm6yud','0',NULL,1,'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',NULL,'2022-03-31 12:56:44','2022-04-25 14:57:25',1,0),(6,'99411788130418820','50672295577',850.00000000,0.00000000,'0','0',NULL,1,'fc97d44c8cd6cdd8616a7e3ab317a287874083996c8e072a4eba666604a9262770fdc26c3aea48866e4156c491d6e0c149b81b117f0c07c17b50d57955f31b2c',NULL,'2022-04-20 17:07:39','2022-04-20 14:07:40',1,0),(10,'99807424612925447','254722000000',266.00000000,0.00000000,'0','0',NULL,1,'f308662130d69bc2b2891a6092cdfeb818a83a8a23b2696a31f847d907b31d27833c64e400309eedc287cb721481af22499c3530b8fbc700360a9ea0d60d24e6',NULL,'2022-06-20 14:42:33','2022-06-20 11:42:33',1,0),(11,'99807424612925488','46708740682',0.00000000,0.00000000,'0','0',NULL,1,'10eabca237dd0c6fe5a49622fe8a631b1c6cb283b205140f4798dc05470f2b2c52c448130cdcb5b4f8dfbf856e34e1b6908bf31d002681002d781009e100274b',NULL,'2022-08-07 15:21:12','2022-08-07 12:21:12',1,0),(13,'99807424612971253','4915224043369',2158.80000000,0.00000000,'LNR-JX4IIS5QOY','0',NULL,1,'0fa0d81bce9e28873f5bac8aa91885fc2e4ab5b86054598964bcb8ef080426c5b4abadb6cd815e727a8e2adce056350fc902ba0ec268ba3fd0fb3d7ac593b6de',NULL,'2022-10-06 12:51:34','2022-10-06 09:55:41',1,0);
/*!40000 ALTER TABLE `tbl_wallet` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tbl_wallet_after_insert` AFTER INSERT ON `tbl_wallet` FOR EACH ROW BEGIN
INSERT
INTO `db_freknur_general`.`tbl_temp` (`_action`) 
SELECT 
NEW.msisdn 
FROM 
`db_freknur_loan`.`tbl_wallet`;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tbl_wallet_extra`
--

DROP TABLE IF EXISTS `tbl_wallet_extra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_wallet_extra` (
  `_id` bigint NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) DEFAULT NULL,
  `first_name` varchar(12) DEFAULT NULL,
  `second_name` varchar(65) DEFAULT NULL,
  `birth_date` varchar(12) DEFAULT NULL,
  `mail` varchar(35) DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL,
  `time_stamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`_id`),
  UNIQUE KEY `msisdn` (`msisdn`),
  KEY `country_code` (`country_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_wallet_extra`
--

LOCK TABLES `tbl_wallet_extra` WRITE;
/*!40000 ALTER TABLE `tbl_wallet_extra` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_wallet_extra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_wallet_transaction`
--

DROP TABLE IF EXISTS `tbl_wallet_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_wallet_transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference_no` varchar(50) NOT NULL,
  `msisdn` varchar(15) NOT NULL,
  `cr` decimal(15,8) DEFAULT '0.00000000',
  `dr` decimal(15,8) DEFAULT '0.00000000',
  `balance` decimal(15,8) DEFAULT '0.00000000',
  `narration` text NOT NULL,
  `date_created` datetime DEFAULT NULL COMMENT 'transaction_date',
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_archived` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `msisdn` (`msisdn`),
  KEY `is_archived` (`is_archived`),
  KEY `reference_no` (`reference_no`)
) ENGINE=InnoDB AUTO_INCREMENT=1647 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_wallet_transaction`
--

LOCK TABLES `tbl_wallet_transaction` WRITE;
/*!40000 ALTER TABLE `tbl_wallet_transaction` DISABLE KEYS */;
INSERT INTO `tbl_wallet_transaction` VALUES (1,'LNR-JX4IIS5QOY','4915224043369',2500.00000000,0.00000000,0.00000000,'LOAN AMOUNT REQUESTED.','2022-10-06 12:55:41','2022-10-06 09:55:41',0),(2,'LNR-JX4IIS5QOY','4915224043369',0.00000000,50.00000000,2450.00000000,'FEE CHARGED ON LOAN.','2022-10-06 12:55:41','2022-10-06 09:55:41',0),(3,'GRN91A8E0780A','4915224043369',0.00000000,191.20000000,2258.80000000,'TGP 10 SHARES PURCHASED @.191.2','2022-10-11 12:12:18','2022-10-11 09:12:18',0),(1645,'GRN325DFF850A','254707132162',0.00000000,19.12000000,11806.12000000,'TGP 1 SHARES PURCHASED @.19.12','2022-10-11 16:25:14','2022-10-11 13:25:14',0),(1646,'GRN10B743250A','4915224043369',0.00000000,100.00000000,2158.80000000,'CMC 10 SHARES PURCHASED @.100','2022-10-11 18:13:36','2022-10-11 15:13:36',0);
/*!40000 ALTER TABLE `tbl_wallet_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_freknur_loan'
--
/*!50003 DROP PROCEDURE IF EXISTS `sProcCheckoutOperation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcCheckoutOperation`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DOUBLE(15,2)
)
BEGIN
	
	
	
	
	
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	
	
	
	START TRANSACTION;	
	IF(TRIM(MSISDN) != "" OR TRIM(AMOUNT) != "") THEN
		
		
		
		SET @STMT_1 = CONCAT("SELECT "
	                             "COUNT(`msisdn`),IFNULL(`balance`,'0') AS balance,IFNULL(`reference_no`,'0') AS reference_no ",
		                     "INTO ",
		                     "@EXIST, @WALLET_BAL, @REFERENCE ",	
				     "FROM ",
				     "`tbl_wallet` ",							
				     "WHERE ",
				     "`is_active` = '1' AND `is_suspended` = '0' AND `msisdn` = '",TRIM(MSISDN),"' ",
                                     "GROUP BY "
                                     "`msisdn`"); 						                   
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		IF(@WALLET_BAL >= AMOUNT) THEN
			
			
			
			SET @STMT_2 = CONCAT("INSERT ",
			                     "INTO ",
					     "`tbl_mpesa_receipt` ",
					     "(`msisdn`,`amount`,`reference_no`,`date_created`) ",
					     "VALUES ",
					     "('",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",@REFERENCE,"','",NOW(),"') ",
					     "ON DUPLICATE KEY ",
					     "UPDATE ",
					     "`date_created` = '",NOW(),"'");                    
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @STMT_3 = CONCAT("UPDATE ",
			                     "`tbl_wallet` ",
					     "SET ",
					     "`balance` = (`balance` - '",AMOUNT,"'),`date_modified` = '",NOW(),"' ",
					     "WHERE ",
					     "`is_active` = '1' AND `is_suspended` = '0' AND `msisdn`= '",TRIM(MSISDN),"'");                    
			PREPARE QUERY FROM @STMT_3;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;

                        
                        
                        
                        IF(@EXIST IS NULL) THEN
	                     SET @EXIST = "0";
                        END IF;           
                        IF(@WALLET_BAL IS NULL) THEN
                             SET @WALLET_BAL = "0";           
                        END IF;
                        IF(@REFERENCE IS NULL) THEN
                             SET @REFERENCE = "0";
                        END IF;   
			
			
			
			IF(@EXIST = "0" OR @EXIST IS NULL) THEN
				
				
				
				SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"User does not exist"}';
                        ELSE
				
				
				
				SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Withdraw Complete"}';
			END IF;
			SELECT @JSON_O AS _JSON;
		ELSE
			
			
			
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Insufficient Balance:."}';
			SELECT @JSON_O AS _JSON;	
		END IF;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:MSISDN|AMOUNT needs to be SET."}';
		SELECT @JSON_O AS _JSON;	
	END IF;
	
	
	
	COMMIT;
	
	
	
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
        SET @EXIST  = NULL;
	SET @REFERENCE = NULL;
	SET @WALLET_BAL = NULL;
	SET MSISDN = NULL;
	SET AMOUNT = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcFlagLoaneeAsDefaulter` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcFlagLoaneeAsDefaulter`(
	IN `RECORD_ID` VARCHAR(20),
	IN `MSISDN` VARCHAR(20),
	IN `LOAN_AMT` DOUBLE(17,2),
	IN `EXPECTED_PAY_DATE` DATETIME,
	IN `TIME_IN_MONTH` INT
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
			RESIGNAL;
		END;
	IF(TRIM(RECORD_ID) != "" OR TRIM(MSISDN) != "" OR TRIM(LOAN_AMT) != "" OR TRIM(EXPECTED_PAY_DATE) != "" OR TRIM(TIME_IN_MONTH) != "") THEN
		START TRANSACTION;
		
		
		
		SET @STMT_1 = CONCAT('SELECT DATE_ADD(NOW(),INTERVAL ',TIME_IN_MONTH,' MONTH) INTO @NEXT_INTERVAL');
		
		
		
		PREPARE q FROM @STMT_1;
		EXECUTE q;
		DEALLOCATE PREPARE q;
		
		
		
		SET @STMT_2 =	CONCAT('INSERT ',
		                       'INTO ',
				       '`db_freknur_general`.`tbl_defaulter` ',
				       '(`msisdn`,`loan_amount`,`expected_repayment_date`,`notification_date`,`date_created`) ',
				       'VALUES ',
			               '("',TRIM(MSISDN),'","',TRIM(LOAN_AMT),'","',TRIM(EXPECTED_PAY_DATE),'","',TRIM(@NEXT_INTERVAL),'","',NOW(),'")');
		
		
		
		PREPARE q FROM @STMT_2;
		EXECUTE q;
		DEALLOCATE PREPARE q;												 						 
		
		
		
		SET @STMT_3 =	CONCAT('UPDATE `tbl_debtor` SET `is_archived` = 1 WHERE `msisdn` = "',TRIM(MSISDN),'" AND `id` = ',TRIM(RECORD_ID),'');
		
		
		
		PREPARE q FROM @STMT_3;								
		EXECUTE q;
		DEALLOCATE PREPARE q;
		
		
		
		SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation successful."}';
		SELECT @JSON_O AS _JSON;		
		COMMIT;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"SUCCESS","MESSAGE":"Params must be checked."}';
		SELECT @JSON_O AS _JSON;	
	END IF;
	
	
	
	SET @JSON_O           = NULL;
	SET @STMT_1           = NULL;
	SET @STMT_2           = NULL;
	SET @STMT_3           = NULL;
	SET @NEXT_INTERVAL    = NULL;
	SET RECORD_ID         = NULL;
	SET MSISDN            = NULL;
	SET LOAN_AMT          = NULL;
	SET TIME_IN_MONTH     = NULL;
	SET EXPECTED_PAY_DATE = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcGenerateID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcGenerateID`(
	OUT `NEW_ID` VARCHAR(10)
)
BEGIN
	
	
	
	

	
	
	
	SET @STMT_1 = CONCAT("SELECT ",
					     "CONCAT(CHAR(ROUND(RAND()*25)+97), ",
                         "CHAR(ROUND(RAND()*25)+97), ",
	                     "ROUND((RAND()*9)), ",
	                     "CHAR(ROUND(RAND()*25)+97), ",
	                     "CHAR(ROUND(RAND()*25)+97), ",
	                     "CHAR(ROUND(RAND()*25)+97), ",
	                     "ROUND((RAND()*9)), ",
	                     "CHAR(ROUND(RAND()*25)+97), ",
	                     "CHAR(ROUND(RAND()*25)+97), ",
	                     "CHAR(ROUND(RAND()*25)+97)) INTO @UNIQ_ID");
	PREPARE QUERY FROM @STMT_1;
	EXECUTE QUERY;
	DEALLOCATE PREPARE QUERY;
	
	
	
	SET NEW_ID = @UNIQ_ID;
	
	
	
	SET @STMT_1 = NULL;
	SET @UNIQ_ID = NULL;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcHandleLoanNotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcHandleLoanNotification`(
	IN `RECORD_ID` VARCHAR(20),
	IN `DIFF_IN_SECOND` VARCHAR(20),
	IN `NOFICATION_COUNT` VARCHAR(5),
	IN `HOUR_VAL` INT,
	IN `MSISDN` VARCHAR(20),
	IN `LOAN_AMT` DOUBLE(7,2),
	IN `EXPECTED_PAY_DATE` DATETIME
)
BEGIN

	DECLARE TIME_VAL DATETIME;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
			RESIGNAL;
		END;


	IF(TRIM(RECORD_ID) != "" OR TRIM(DIFF_IN_SECOND) != "" OR TRIM(NOFICATION_COUNT) != "" OR TRIM(HOUR_VAL) != "" OR TRIM(MSISDN) != "" OR TRIM(LOAN_AMT) != "" OR TRIM(EXPECTED_PAY_DATE) != "")THEN
		START TRANSACTION;
		
		
		
		SET TIME_VAL = DATE_SUB(EXPECTED_PAY_DATE,INTERVAL HOUR_VAL HOUR);
		
		
		
		CALL `sProcLoadMessageTemplate`('LOAN_ALERT', @MESSAGE_TEMP);
		
		
		
		SET EXPECTED_PAY_DATE = REPLACE(TRIM(EXPECTED_PAY_DATE),' ',' @ ');	
		
		
		
		IF(DIFF_IN_SECOND >= "0") THEN
			IF(NOFICATION_COUNT >= "0" AND NOFICATION_COUNT <= "4") THEN
				SET @STMT_1 = CONCAT('UPDATE ',
				                     '`tbl_debtor` ',
						     'SET ',
					             '`notification_count` = (`notification_count` + 1), `next_notification_date` = "',TRIM(TIME_VAL),'"  ',
						     'WHERE ',
						     '`msisdn` = "',TRIM(MSISDN),'" AND `id` = "',TRIM(RECORD_ID),'"');
				
				
				
				PREPARE q FROM @STMT_1;
				EXECUTE q;
				DEALLOCATE PREPARE q;											
				
				
				
				CALL `sProcQueueNotification`(TRIM(MSISDN),REPLACE(REPLACE(REPLACE(TRIM(@MESSAGE_TEMP),'{0}','Customer'),'{1}',TRIM(LOAN_AMT)),'{2}',TRIM(EXPECTED_PAY_DATE)), 'LOAN_ALERT');
			END IF;
			
			
			
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation successful."}';
			SELECT @JSON_O AS _JSON;
		END IF;
		COMMIT;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	
	
	
	SET @STMT_1           = NULL;
	SET @STMT_2           = NULL;
	SET @STMT_3           = NULL;
	SET @STMT_4           = NULL;		
	SET @MESSAGE_TEMP     = NULL;
	SET @NEXT_INTERVAL    = NULL;
	SET TIME_VAL          = NULL;
	SET HOUR_VAL          = NULL;
	SET MSISDN            = NULL;
	SET LOAN_AMT          = NULL;
	SET RECORD_ID         = NULL;
	SET DIFF_IN_SECOND    = NULL;
	SET NOFICATION_COUNT  = NULL;	
	SET EXPECTED_PAY_DATE = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcHandleSimpleInterestCalc` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcHandleSimpleInterestCalc`(
	IN `PRINCIPLE_AMOUNT` DOUBLE(11,2),
	IN `TIME_IN_MONTH` DOUBLE(11,2),
	IN `RATE` DOUBLE(11,2),
	IN `MSISDN` VARCHAR(25)
)
BEGIN
	
	
	
	DECLARE INTEREST DOUBLE(11,2);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;

	IF(TRIM(PRINCIPLE_AMOUNT) != "0" OR TRIM(TIME_IN_MONTH) != "0" OR TRIM(RATE) != "0" OR TRIM(MSISDN) != "") THEN
		START TRANSACTION;
		
		
		
		SET @STMT_0 = CONCAT('SELECT DATE_ADD(NOW(),INTERVAL ',TIME_IN_MONTH,' MONTH) INTO @NEXT_INTERVAL');
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		SET INTEREST = (PRINCIPLE_AMOUNT * (TIME_IN_MONTH/12) * RATE) / 100;
		
		
		
		SET @STMT_1 = CONCAT('UPDATE ',
	                             '`db_freknur_general`.`tbl_defaulter` ',
				     'SET ',
				     '`cummulative_interest` = (`cummulative_interest` + ',INTEREST,'),`roll_count` = (`roll_count` + 1),`notification_date` = "',TRIM(@NEXT_INTERVAL),'", `date_modified` = NOW() ',
				     'WHERE ',
				     '`msisdn` = "',TRIM(MSISDN),'" AND `date_repaid` IS NULL AND `is_archived` = 0 AND TIMESTAMPDIFF(MINUTE,`notification_date`,NOW()) >= 0');                   
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		SET @STMT_2 = CONCAT('SELECT ',
		                     '(`loan_amount`+`cummulative_interest`),`cummulative_interest`',
		                     'INTO ',
		                     '@TOTAL_OUTSTANDING_LOAN,@CUMMULATIVE_INTEREST ',
		                     'FROM ',
	                     	     '`db_freknur_general`.`tbl_defaulter` ',
				     'WHERE ',
				     '`msisdn` = "',TRIM(MSISDN),'" AND `date_repaid` IS NULL AND `is_archived` = 0');	 						                   
		PREPARE QUERY FROM @STMT_2;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;			
		
		
		
		CALL `sProcLoadMessageTemplate`('DEFAULTER_ALERT', @MESSAGE_TEMP);
		
		
		
		CALL `sProcQueueNotification`(TRIM(MSISDN),REPLACE(REPLACE(REPLACE(REPLACE(TRIM(@MESSAGE_TEMP),'{0}','CUSTOMER'),'{1}',TRIM(PRINCIPLE_AMOUNT)),'{2}',TRIM(@CUMMULATIVE_INTEREST)),'{3}',TRIM(@TOTAL_OUTSTANDING_LOAN)), 'DEFAULTER_ALERT');
		
		
		
		SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation successful."}';
		SELECT @JSON_O AS _JSON;		
		COMMIT;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"SUCCESS","MESSAGE":"Param must be checked."}';
		SELECT @JSON_O AS _JSON;		
	END IF;
	
	
	
	SET @JSON_O                 = NULL;  
	SET @STMT_0                 = NULL;
	SET @STMT_1                 = NULL;
	SET @STMT_2                 = NULL;
	SET @NEXT_INTERVAL          = NULL;
	SET @MESSAGE_TEMP           = NULL;
	SET RATE                    = NULL;
	SET MSISDN                  = NULL;
	SET INTEREST                = NULL;	
	SET TIME_IN_MONTH           = NULL;
	SET PRINCIPLE_AMOUNT        = NULL;
	SET @CUMMULATIVE_INTEREST   = NULL;
	SET @TOTAL_OUTSTANDING_LOAN = NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcHasExistingLoan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcHasExistingLoan`(
	IN `MSISDN` VARCHAR(50),
	OUT `OUTPUT` VARCHAR(1)
)
BEGIN
	
	
	
	
	
	IF(TRIM(MSISDN) <> "") THEN
		
		
		
		SET @STMT_1 = CONCAT("SELECT ",
		                     "COUNT(`reference_no`) ",
				     "INTO ",
				     "@LOAN_CNT ",
				     "FROM ",
				     "`tbl_debtor` ",
				     "WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"' AND `is_repaid` = '0'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		IF(@LOAN_CNT = "0")THEN
			SET @NO_OF_LOAN = 0;
		ELSE
			SET @NO_OF_LOAN = 1;
		END IF;
		
		
		
		SET OUTPUT = @NO_OF_LOAN; 	
	END IF;
	
	
	
	SET @STMT_1     = NULL;
	SET @LOAN_CNT   = NULL;
	SET @NO_OF_LOAN = NULL;
	SET MSISDN      = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcLoadMessageTemplate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcLoadMessageTemplate`(
	IN `CATEGORY` VARCHAR(50),
	OUT `OUT_MESSAGE` VARCHAR(150)
)
BEGIN
	
	
	
	
	
	IF(TRIM(CATEGORY) != "") THEN
		
		
		
		SET @STMT_1 = CONCAT("SELECT ",
		                     "`message` ",
				     "INTO ",
				     "@MESSAGE ",
				     "FROM ",
				     "`db_freknur_general`.`tbl_message_template`",
				     "WHERE ",
			             "`category` = '",UCASE(TRIM(CATEGORY)),"' AND `flag` = '0'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		SET OUT_MESSAGE = @MESSAGE; 		
	END IF;
	
	
	
	SET @STMT_1  = NULL;
	SET CATEGORY = NULL;
	SET @MESSAGE = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcLoanDispatch` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcLoanDispatch`(
	IN `REFERENCE_NO` VARCHAR(50),
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT_REQUESTED` DOUBLE(15,2),
	IN `AMOUNT_DISBURSED` DOUBLE(15,2),
	IN `REPAYMENT_AMOUNT` DOUBLE(15,2),
	IN `INTEREST_AMOUNT` DOUBLE(15,2),
	IN `DURATION_IN_DAYS` VARCHAR(5),
	IN `NOTIFICATION_1` VARCHAR(2)
)
BEGIN
	
	
	
	
	
	
	
	
	
	
	DECLARE RUNNING_BAL DOUBLE(15,2);
	DECLARE PARTICULARS TEXT;
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	
	
	
	START TRANSACTION;
	
	
	
	IF(TRIM(REFERENCE_NO) != "" OR TRIM(MSISDN) != "" OR TRIM(AMOUNT_REQUESTED) != "" OR TRIM(AMOUNT_DISBURSED) != "" OR TRIM(REPAYMENT_AMOUNT) != "" OR TRIM(DURATION_IN_DAYS) != "" OR TRIM(NOTIFICATION_1) != "") THEN
		
		
		
		SET @STMT_0 = CONCAT("SELECT ",
		                     "COUNT(`uid`),`balance` ",
				     "INTO ",
				     "@HAS_ACCOUNT,@BALANCE ",
				     "FROM ",
				     "`tbl_wallet` ",
				     "WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"'");
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		IF(@HAS_ACCOUNT > "0") THEN
			
			
			
			SET @REPAYMENT_DATE = DATE_ADD(NOW(), INTERVAL (DURATION_IN_DAYS * 24) HOUR);
			
			
			
			SET @NOTIFICATION_DATE = DATE_ADD(@REPAYMENT_DATE, INTERVAL (NOTIFICATION_1 * -1) HOUR); 
			
			
			
			SET @STMT_1 = CONCAT("INSERT ",
			                     "INTO ",
			                     "`tbl_debtor` ",
			                     "(`reference_no`,`msisdn`,`amount_requested`,`amount_disbursed`,`repayment_amount`,`interest_amount`,`date_created`,`expected_repayment_date`,`repayment_date`,`next_notification_date`) ",
			                     "VALUES ",
			                     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT_REQUESTED),"','",TRIM(AMOUNT_DISBURSED),"','",TRIM(REPAYMENT_AMOUNT),"','",TRIM(INTEREST_AMOUNT),"','",NOW(),"','",@REPAYMENT_DATE,"','",@REPAYMENT_DATE,"','",@NOTIFICATION_DATE,"') ",
			                     "ON DUPLICATE KEY ",
			                     "UPDATE `date_modified` = '",NOW(),"'");	
			PREPARE QUERY FROM @STMT_1;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET PARTICULARS = 'LOAN AMOUNT REQUESTED.';
			
			
			
			SET @STMT_2 = CONCAT("INSERT ",
			                     "INTO ",
					     "`tbl_wallet_transaction` ",
					     "(`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
					     "VALUES ",
				       	     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT_REQUESTED),"','0.00','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET PARTICULARS = 'FEE CHARGED ON LOAN.';
                        
                        
                        
                        SET RUNNING_BAL = (@BALANCE + AMOUNT_DISBURSED);
			
			
			
			SET @STMT_4 = CONCAT("INSERT ",
			                     "INTO ",
				             "`tbl_wallet_transaction` ",
					     "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
				             "VALUES ",
					     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",(TRIM(AMOUNT_REQUESTED)-TRIM(AMOUNT_DISBURSED)),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_4;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @STMT_5 = CONCAT("UPDATE ",
			                     "`tbl_wallet` ",
					     "SET ",
				             "`balance` = '",TRIM(RUNNING_BAL),"',`reference_no` = '",TRIM(REFERENCE_NO),"',`date_modified` = '",NOW(),"' ",
					     "WHERE ",
					     "`msisdn` = '",TRIM(MSISDN),"'");
			PREPARE QUERY FROM @STMT_5;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET PARTICULARS = 'MONEY MOVED FROM UTY TO CLIENT WALLET A/C.';			
			
			
			
			SET @STMT_6 = CONCAT("INSERT ",
			                     "INTO ",
					     "`tbl_transaction` ",
					     "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
					     "VALUES ",
					     "('0','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT_DISBURSED),"','0.00','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_6;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;			
			
			
			
			SET @STMT_7 = CONCAT("UPDATE ",
			                     "`db_freknur_general`.`tbl_loan_payout` ",
					     "SET ",
					     "`is_processed` = '1', `date_modified` = '",NOW(),"' ",
					     "WHERE ",
					     "`reference_no` = '",TRIM(REFERENCE_NO),"' AND `msisdn` = '",TRIM(MSISDN),"'");	   
			PREPARE QUERY FROM @STMT_7;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
                        
                        
                        
                        SET @STMT_8 = CONCAT("INSERT ",
                                             "INTO ",
                                             "`db_freknur_general`.`tbl_loan_temp_list` ",
                                             "(`msisdn`,`loan_amount`,`interest`)",
                                             "VALUES ",
                                             "('",TRIM(MSISDN),"','",TRIM(REPAYMENT_AMOUNT),"','",TRIM(INTEREST_AMOUNT),"')");
                        PREPARE QUERY FROM @STMT_8;
                        EXECUTE QUERY;
                        DEALLOCATE PREPARE QUERY;				
			
			
			
			SET @JSON_O = CONCAT('{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"LOAN DISPATCHED TO ACCOUNT:',MSISDN,'"}');
			SELECT @JSON_O AS _JSON;									
		ELSE
			
			
			
			SET @JSON_O = CONCAT('{"ERROR":"1","RESULT":"FAIL","MESSAGE":"ACCOUNT DOES NOT EXIST:',MSISDN,'"}');
			SELECT @JSON_O AS _JSON;			
		END IF;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"0","RESULT":"FAIL","MESSAGE":"Params:REFERENCE_NO|MSISDN|AMOUNT_REQUESTED|AMOUNT_DISBURSED|REPAYMENT_AMOUNT needs to be SET."}';
		SELECT @JSON_O AS _JSON;	
	END IF;
	
	
	
	COMMIT;
	
	
	
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @STMT_5 = NULL;
	SET @STMT_6 = NULL;
	SET @STMT_7 = NULL;
	SET @JSON_O = NULL;
	SET @BALANCE = NULL;
	SET @HAS_ACCOUNT = NULL;
	SET @REPAYMENT_DATE = NULL;
	SET @NOTIFICATION_DATE = NULL;
	SET MSISDN  = NULL;
	SET PARTICULARS = NULL;
	SET RUNNING_BAL = NULL;
	SET REFERENCE_NO  = NULL;
	SET AMOUNT_REQUESTED = NULL;
	SET AMOUNT_DISBURSED = NULL;
	SET INTEREST_AMOUNT = NULL;
	SET REPAYMENT_AMOUNT = NULL;
	SET DURATION_IN_DAYS = NULL;
	SET NOTIFICATION_1 = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcLoanRepayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcLoanRepayment`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DECIMAL(10,2),
	IN `TRANSACTION_NO` VARCHAR(50)
)
BEGIN
   DECLARE EXCESS DECIMAL(15,2);
   DECLARE HAS_LOAN VARCHAR(2);
   DECLARE MESSAGE VARCHAR(160);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;   
	IF(TRIM(MSISDN) != "" OR TRIM(AMOUNT) != "" OR TRANSACTION_NO != "") THEN
		START TRANSACTION;
		
		
		
		CALL `sProcHasExistingLoan`(MSISDN,HAS_LOAN);
		IF(HAS_LOAN = "1") THEN
			
			
			
			SET @STMT_0 = CONCAT("SELECT",
			                     " `interest_amount`,`reference_no`,`repayment_amount`,`expected_repayment_date`",
					     " INTO ",
					     " @INTEREST, @REFERENCE, @LOAN_AMOUNT, @PAY_DATE ",
			                     " FROM `tbl_debtor` ",
					     " WHERE `msisdn` = '",TRIM(MSISDN),"' AND `is_repaid` ='0'");
			PREPARE QUERY FROM @STMT_0;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET EXCESS = (AMOUNT - @LOAN_AMOUNT);
			
			
			
			IF(EXCESS = "0") THEN
				
				SET @STMT_1 = CONCAT("UPDATE `tbl_debtor` SET `repayment_amount` = 0,`is_repaid` = 1, `repayment_date` = NOW() WHERE `msisdn` = '",TRIM(MSISDN),"'");
				PREPARE QUERY FROM @STMT_1;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
		                
				
				
				SET @STMT_5 = CONCAT("UPDATE `tbl_wallet` SET `reference_no` = 0,`date_modified` = NOW() WHERE `is_suspended` = 0 AND `is_active` = 1 AND `msisdn` = '",TRIM(MSISDN),"'");
				PREPARE QUERY FROM @STMT_5;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
                                
                                
                                
                                SET @STMT_10 = CONCAT("DELETE FROM `db_freknur_general`.`tbl_loan_temp_list` WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_10;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
				
				
				
				CALL `sProcLogInterestEarned`(@INTEREST,MSISDN,@REFERENCE,"INCOME","CR");
                                
                                
                                
                                SET @STMT_6 = CONCAT("UPDATE `db_freknur_investment`.`tbl_owner_portfolio` SET `lock` = 0,`date_modified` = NOW() WHERE `lock` = 1 AND `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_6;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
                                
                                
                                
                                SET @STMT_7 = CONCAT("DELETE FROM `db_freknur_general`.`tbl_loan_collateral` WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_7;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
                                
                                
                                
                                SET MESSAGE = CONCAT("The LOAN has been  settled.");
			ELSEIF(EXCESS > "0") THEN
				
				SET @STMT_1 = CONCAT("UPDATE `tbl_debtor` SET `repayment_amount` = 0,`is_repaid` = 1, `repayment_date` = NOW() WHERE `msisdn` = '",TRIM(MSISDN),"'");
				PREPARE QUERY FROM @STMT_1;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
				
				
				
				SET @STMT_3 = CONCAT("UPDATE `tbl_wallet` SET `balance` = '",FORMAT(EXCESS,2),"',`reference_no` = 0,`date_modified` = NOW() WHERE `msisdn` = '",TRIM(MSISDN),"'");
				PREPARE QUERY FROM @STMT_3;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
                                
                                
                                
                                SET @STMT_10 = CONCAT("DELETE FROM `db_freknur_general`.`tbl_loan_temp_list` WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_10;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
				
				
				
				CALL `sProcLogInterestEarned`(@INTEREST,MSISDN,@REFERENCE,"INCOME","CR");
                                
                                
                                
                                SET @STMT_6 = CONCAT("UPDATE `db_freknur_investment`.`tbl_owner_portfolio` SET `lock` = 0,`date_modified` = NOW() WHERE `lock` = 1 AND `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_6;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
                                
                                
                                
                                SET @STMT_7 = CONCAT("DELETE FROM `db_freknur_general`.`tbl_loan_collateral` WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_7;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
				
				
				
				SET MESSAGE  = CONCAT("The LOAN is settled. Excess BAL of ",FORMAT(EXCESS,2)," has been moved to your Wallet.");
			ELSE
				
				SET @STMT_1 = CONCAT("UPDATE `tbl_debtor` SET `repayment_amount` = ",ABS(EXCESS),", `repayment_date` = NOW() WHERE `msisdn` = '",TRIM(MSISDN),"'");
				PREPARE QUERY FROM @STMT_1;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
                                
                                
                                
                                SET @STMT_10 = CONCAT("UPDATE `db_freknur_general`.`tbl_loan_temp_list` SET `loan_amount` = ",ABS(EXCESS),"  WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_10;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
				
				
				
				SET MESSAGE  = CONCAT("The LOAN is partially paid; outstanding LOAN balance now is ",FORMAT(ABS(EXCESS),2)," that is due on ",@PAY_DATE,"");
			END IF;
                        
                        
                        
			IF(EXCESS >= "0") THEN
                                SET @STMT_8 = CONCAT("DELETE FROM `db_freknur_investment`.`tbl_owner_portfolio_temp_list` WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_8;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;				
			END IF;
			
			
			
			SET @STMT_4 = CONCAT("UPDATE `db_freknur_general`.`tbl_loan_repayment` SET `is_processed` = 1 WHERE `msisdn` = '",TRIM(MSISDN),"' AND `transaction_no` = '",TRIM(TRANSACTION_NO),"' AND `is_processed` = 0");			
			PREPARE QUERY FROM @STMT_4;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
  			
			
			
			SELECT CONCAT('{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"',MESSAGE,'"}') AS _JSON;
			
			COMMIT;	
		ELSE
			
			
			
			SELECT '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"You do not have a LOAN."}' AS _JSON;
		END IF;
	ELSE
		
		
		
		SELECT '{"ERROR":"1","RESULT":"SUCCESS","MESSAGE":"MSISDN and LOAN AMOUNT must be checked."}' AS _JSON;
	END IF;
	
	
	
	SET @STMT_0 = NULL;
	SET @STMT_1 = NULL;
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @STMT_5 = NULL;
	SET @STMT_6 = NULL;
	SET @STMT_7 = NULL;
	SET @STMT_8 = NULL;
	SET @STMT_10 = NULL;
	SET @PAY_DATE = NULL;
	SET @INTEREST = NULL;
	SET @REFERENCE = NULL;
	SET @LOAN_AMOUNT = NULL;
	SET EXCESS = NULL;
	SET MSISDN = NULL;
	SET AMOUNT = NULL;
	SET MESSAGE = NULL;	
	SET HAS_LOAN = NULL;
	SET TRANSACTION_NO = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcLoanRequest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcLoanRequest`(
	IN `MSISDN` VARCHAR(50),
	IN `AMOUNT` VARCHAR(50)
)
BEGIN
	
	
	
	
	
	IF(TRIM(MSISDN) <> "" AND TRIM(AMOUNT) <> "") THEN
		
		
		
		SET @STMT_1 = CONCAT("SELECT ",
		                     "COUNT(`msisdn`) ",
							 "INTO ",
							 "@REQUEST_CNT ",
							 "FROM ",
							 "`tbl_loan_request` ",
							 "WHERE ",
							 "`msisdn` ='",TRIM(MSISDN),"' AND `is_processed` = '0'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		IF(@REQUEST_CNT = 0) THEN
			
			
			
			CALL `sProcHasExistingLoan`(MSISDN,@HAS_LOAN);
			
			
			
			IF(@HAS_LOAN = "1")THEN
				
				
				
				SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"You have an existing loan."}';
				SELECT @JSON_O AS _JSON;			
			ELSE
				
				
				
				CALL `sProcGenerateID`(@REF_NUM);	
				
				
				
				SET @STMT_2 = CONCAT("INSERT ",
				                     "INTO ",
									 "`tbl_loan_request` ",
									 "(`msisdn`,`reference_no`,`amount`,`requested_by`,`date_created`) ",
									 "VALUES ",
									 "('",TRIM(MSISDN),"','",UCASE(@REF_NUM),"','",TRIM(AMOUNT),"','",TRIM(MSISDN),"','",NOW(),"') ",
									 "ON DUPLICATE KEY ",
									 "UPDATE `date_modified` = NOW()");
				PREPARE QUERY FROM @STMT_2;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
				
				
				
				SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Loan request was successful."}';
				SELECT @JSON_O AS _JSON;
			END IF;
		ELSE
			
			
			
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"You have a pending loan request."}';
			SELECT @JSON_O AS _JSON;					
		END IF;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Param: MSISDN|AMOUNT needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
		
		
		
		SET @STMT_1      = NULL;
		SET @STMT_2      = NULL;
		SET @JSON_O      = NULL;
		SET @REF_NUM     = NULL;
		SET @HAS_LOAN    = NULL;		
		SET @REQUEST_CNT = NULL;
		SET MSISDN       = NULL;
		SET AMOUNT       = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcLogInterestEarned` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcLogInterestEarned`(
	IN `INTEREST` DOUBLE(7,2),
	IN `MSISDN` VARCHAR(20),
	IN `REFERENCE_NO` VARCHAR(50),
	IN `ACCOUNT_NAME` VARCHAR(10),
	IN `TRANS_TYPE` VARCHAR(5)
)
BEGIN
	
	
	
	
	
	
	
	
	DECLARE PARTICULARS TEXT;
	DECLARE RUNNING_BAL DOUBLE(15,2);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	
	
	
	IF(TRIM(INTEREST) != "" OR TRIM(MSISDN) != "" OR TRIM(REFERENCE_NO) != "" OR TRIM(ACCOUNT_NAME) != "" OR TRIM(TRANS_TYPE) != "") THEN
		START TRANSACTION;
		
		
		
		SET @STMT_0 = CONCAT("SELECT ",
		                     "COUNT(`uid`) ",
				     "INTO ",
				     "@HAS_ACCOUNT ",
				     "FROM ",
				     "`tbl_wallet` ",
				     "WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"'");
		
		
		
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		IF(@HAS_ACCOUNT > "0")THEN		
			
			
			
			SET @STMT_1 = CONCAT("SELECT ",
			                     "`account_code`,`account_name`,`balance` ",
			                     "INTO ",
			                     "@ACC_CODE,@ACC_NAME,@BALANCE ",
					     "FROM ",
					     "`tbl_account` ",
					     "WHERE ",
					     "`account_name` = '",TRIM(ACCOUNT_NAME),"'"); 
			PREPARE QUERY FROM @STMT_1;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			IF(UCASE(TRANS_TYPE) = "CR") THEN
				SET PARTICULARS = "INTEREST EARNED FROM LOAN.";
				
				
				
				SET RUNNING_BAL = (@BALANCE + INTEREST);	
				
				
				
				SET @STMT_2 = CONCAT("INSERT ",
				                     "INTO ",
						     "`tbl_transaction` ",
						     "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
						     "VALUES ",
						     "('",@ACC_CODE,"','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(INTEREST),"','0.00','",RUNNING_BAL,"','",PARTICULARS,"','",NOW(),"')");
				
				
				
			  	PREPARE QUERY FROM @STMT_2;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
				
				
				
				SET @STMT_3 = CONCAT("UPDATE ",
				                     "`tbl_account` ",
						     "SET ",
						     "`balance` = '",RUNNING_BAL,"',`date_modified` = '",NOW(),"' ",
					             "WHERE ",
					             "`account_code` ='",@ACC_CODE,"'");	
				
				
				
				PREPARE QUERY FROM @STMT_3;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;																														
			END IF;		
			
			
			
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Movement complete."}';
			SELECT @JSON_O AS _JSON;				
		ELSE
			
			
			
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:INTEREST|MSISDN|REFERENCE_NO|ACCOUNT_NAME|TRANS_TYPE needs to be SET."}';
			SELECT @JSON_O AS _JSON;
		END IF;
					
		COMMIT;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"A/C does not exist."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	
	
	
	SET @JSON_O      = NULL;
	SET @STMT_1      = NULL;
	SET @STMT_2      = NULL;
	SET @STMT_3      = NULL;
	SET @BALANCE     = NULL;
	SET @ACC_CODE    = NULL;
	SET @ACC_NAME    = NULL;
	SET @HAS_ACCOUNT = NULL;	
	SET INTEREST     = NULL;
	SET MSISDN       = NULL;
	SET REFERENCE_NO = NULL;
	SET ACCOUNT_NAME = NULL;
	SET TRANS_TYPE   = NULL;
	SET PARTICULARS  = NULL;
	SET RUNNING_BAL  = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcLogLoanFee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcLogLoanFee`(
	IN `MSISDN` VARCHAR(50),
	IN `REFERENCE_NO` VARCHAR(50),
	IN `HANDLING_FEE` DOUBLE(15,2),
	IN `ACCOUNT_NAME` VARCHAR(15)
)
BEGIN
	
	
	
	
	
	
	
	
	DECLARE PARTICULARS TEXT;
	DECLARE RUNNING_BAL DOUBLE(15,2);
	IF(TRIM(MSISDN) != "" OR TRIM(REFERENCE_NO) != "" OR TRIM(HANDLING_FEE) != "" OR TRIM(ACCOUNT_NAME) != "") THEN
		
		
		
		SET @STMT_0 = CONCAT("SELECT ",
		                     "COUNT(`uid`) ",
							 "INTO ",
							 "@HAS_ACCOUNT ",
							 "FROM ",
							 "`tbl_wallet` ",
							 "WHERE ",
							 "`msisdn` = '",TRIM(MSISDN),"'");
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		IF(@HAS_ACCOUNT > "0")THEN	
			
			
			
			SET @STMT_1 = CONCAT("SELECT ",
			                     "`account_code`,`account_name`,`balance` ",
			                     "INTO ",
			                     "@ACC_CODE,@ACC_NAME,@BALANCE ",
								 "FROM ",
								 "`tbl_account` ",
								 "WHERE ",
								 "`account_name` = '",TRIM(ACCOUNT_NAME),"'"); 
			PREPARE QUERY FROM @STMT_1;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;	
			
			
			
			SET PARTICULARS = "LOAN HANDLING FEES EARNED.";
			
			
			
			SET RUNNING_BAL = (@BALANCE + HANDLING_FEE);	
			
			
			
			SET @STMT_2 = CONCAT("INSERT ",
			                     "INTO ",
								 "`tbl_transaction` ",
								 "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
								 "VALUES ",
								 "('",@ACC_CODE,"','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(HANDLING_FEE),"','0.00','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @STMT_3 = CONCAT("UPDATE ",
			                     "`tbl_account` ",
								 "SET ",
								 "`balance` = '",RUNNING_BAL,"' ",
								 "WHERE ",
								 "`account_code` ='",@ACC_CODE,"'");
			PREPARE QUERY FROM @STMT_3;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Movement complete."}';
			SELECT @JSON_O AS _JSON;
		ELSE
			
			
			
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"A/C does not exist."}';
			SELECT @JSON_O AS _JSON;		
		END IF;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:MSISDN|REFERENCE_NO|HANDLING_FEE|ACCOUNT_NAME needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	
	
	
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @JSON_O = NULL;
	SET @BALANCE  = NULL;
	SET @ACC_CODE = NULL;
	SET @ACC_NAME = NULL;
	SET @HAS_ACCOUNT = NULL;	
	SET MSISDN = NULL;
	SET PARTICULARS = NULL;
	SET RUNNING_BAL = NULL;
	SET REFERENCE_NO = NULL;
	SET ACCOUNT_NAME = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcLogRejectedLoanRequest` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcLogRejectedLoanRequest`(
	IN `MSISDN` VARCHAR(20),
	IN `REMARKS` TEXT
)
BEGIN
	
	
	
	
	
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
                GET DIAGNOSTICS CONDITION 1
                @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
                SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
                ROLLBACK;
	END;
	IF(TRIM(MSISDN) != "" OR TRIM(REMARKS) != "") THEN
		START TRANSACTION;
		
		
		
		SET @STMT_1 = CONCAT("INSERT ",
		                     "INTO ",
				     "`db_freknur_general`.`tbl_rejected_loan` ",
			             "(`msisdn`,`remarks`,`date_created`) ",
				     "VALUES ",
			             "('",TRIM(MSISDN),"','",TRIM(REMARKS),"','",NOW(),"')");                    
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		SET @STMT_2 = CONCAT("DELETE ",
		                     "FROM ",
			             "`db_freknur_loan`.`tbl_loan_request` ",
				     "WHERE "
				     "`is_processed` = 0 AND `msisdn` = '",TRIM(MSISDN),"'");                    
		PREPARE QUERY FROM @STMT_2;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;		
		
		
		
		SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Loan requested has been logged."}';
		SELECT @JSON_O AS _JSON;
		COMMIT;		
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:AMOUNT|REMARKS|MSISDN needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	
	
	
	SET @STMT_1  = NULL;
	SET @STMT_2  = NULL;
	SET @JSON_O  = NULL;
	SET REMARKS  = NULL;
	SET MSISDN   = NULL;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcLogTransactions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcLogTransactions`(
	IN `AMOUNT` DOUBLE(15,2),
	IN `MSISDN` VARCHAR(15),
	IN `REFERENCE_NO` VARCHAR(50),
	IN `ACCOUNT_NAME` VARCHAR(15),
	IN `TRANS_TYPE` VARCHAR(5)
)
BEGIN
	
	
	
	
	
	
	
	
	DECLARE PARTICULARS TEXT;
	DECLARE RUNNING_BAL DOUBLE(15,2);
	
	
	
	IF(TRIM(AMOUNT) != "" OR TRIM(MSISDN) != "" OR TRIM(REFERENCE_NO) != "" OR TRIM(ACCOUNT_NAME) != "" OR TRIM(TRANS_TYPE) != "") THEN
		
		
		
		SET @STMT_0 = CONCAT("SELECT ",
		                     "COUNT(`uid`) ",
							 "INTO ",
							 "@HAS_ACCOUNT ",
							 "FROM ",
							 "`tbl_wallet` ",
							 "WHERE ",
							 "`msisdn` = '",TRIM(MSISDN),"'");
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		IF(@HAS_ACCOUNT > "0")THEN		
			
			
			
			SET @STMT_1 = CONCAT("SELECT ",
			                     "`account_code`,`account_name`,`balance` ",
			                     "INTO ",
								 "@ACC_CODE,@ACC_NAME,@BALANCE ",
								 "FROM ",
								 "`tbl_account` ",
								 "WHERE ",
								 "`account_name` = '",TRIM(ACCOUNT_NAME),"'"); 
			PREPARE QUERY FROM @STMT_1;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			IF(UCASE(TRANS_TYPE) = "DR") THEN
				SET PARTICULARS = "MONEY MOVEMENT OUT OF UTY.";
				
				
				
				SET RUNNING_BAL = (@BALANCE - AMOUNT);		
				
				
				
				SET @STMT_2 = CONCAT("INSERT ",
				                     "INTO ",
									 "`tbl_transaction` ",
									 "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
									 "VALUES ",
									 "('",@ACC_CODE,"','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','0.00','",TRIM(AMOUNT),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
				
				
				
				SET @STMT_3 = CONCAT("UPDATE ",
				                     "`tbl_account` ",
									 "SET ",
									 "`balance` = '",RUNNING_BAL,"',`date_modified` = '",NOW(),"' ",
									 "WHERE ",
									 "`account_code` ='",@ACC_CODE,"'");																																			
			ELSE
				SET PARTICULARS = "MONEY MOVEMENT INTO DEP.";
				
				
				
				SET RUNNING_BAL = (@BALANCE + AMOUNT);	
				
				
				
				SET @STMT_2 = CONCAT("INSERT ",
				                     "INTO ",
									 "`tbl_transaction` ",
									 "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
									 "VALUES ",
									 "('",@ACC_CODE,"','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(HANDLING_FEE),"','0.00','",RUNNING_BAL,"','",PARTICULARS,"','",NOW(),"')");
				
				
				
				SET @STMT_3 = CONCAT("UPDATE ",
				                     "`tbl_account` ",
									 "SET ",
									 "`balance` = '",RUNNING_BAL,"',`date_modified` = '",NOW(),"' ",
									 "WHERE ",
									 "`account_code` ='",@ACC_CODE,"'");																				
			END IF;
			
			
			
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			PREPARE QUERY FROM @STMT_3;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;		
			
			
			
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Movement complete."}';
			SELECT @JSON_O AS _JSON;	
		ELSE
			
			
			
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:AMOUNT|MSISDN|REFERENCE_NO|ACCOUNT_NAME|TRANS_TYPE needs to be SET."}';
			SELECT @JSON_O AS _JSON;
		END IF;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"A/C does not exist."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	
	
	
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @JSON_O = NULL;
	SET @BALANCE  = NULL;
	SET @ACC_CODE = NULL;
	SET @ACC_NAME = NULL;	
	SET AMOUNT = NULL;
	SET MSISDN = NULL;
	SET REFERENCE_NO = NULL;
	SET ACCOUNT_NAME = NULL;
	SET TRANS_TYPE = NULL;
	SET PARTICULARS = NULL;
	SET RUNNING_BAL = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcQueueLoan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcQueueLoan`(
	IN `REFERENCE_NO` VARCHAR(50),
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DOUBLE(15,2),
	IN `APPROVED_BY` VARCHAR(50),
        IN `HAS_COLLATERAL` INT(1)
)
BEGIN
	
	
	
	
	
	
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;	
	IF(TRIM(REFERENCE_NO) != "" OR TRIM(MSISDN) != "" OR TRIM(AMOUNT) != "" OR TRIM(APPROVED_BY) != "" OR TRIM(HAS_COLLATERAL) != "") THEN
		START TRANSACTION;
		
		
		
		SET @STMT_1 = CONCAT("INSERT ",
		                     "INTO ",
				     "`db_freknur_general`.`tbl_loan_payout` ",
				     "(`reference_no`,`msisdn`,`amount`,`date_created`,`approved_by`,`has_collateral`) ",
				     "VALUES ",
				     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",NOW(),"','",TRIM(APPROVED_BY),"','",TRIM(HAS_COLLATERAL),"') ",
			             "ON DUPLICATE KEY UPDATE ",
				     "`date_modified` = '",NOW(),"'");                    
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		SET @STMT_2 = CONCAT("UPDATE ",
		                     "`db_freknur_loan`.`tbl_loan_request` ",
				     "SET ",
			             "`is_processed` = 1 ",
			             "WHERE ",
				     "`reference_no` = '",TRIM(REFERENCE_NO),"' AND `msisdn` = '",TRIM(MSISDN),"'");	                     
		PREPARE QUERY FROM @STMT_2;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;	
		
		
		
		SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation successful."}';
		SELECT @JSON_O AS _JSON;
		COMMIT;		
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:REFERENCE_NO|MSISDN|AMOUNT|APPROVED_BY|HAS_COLLATERAL needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	
	
	
	SET @STMT_1        = NULL;
	SET @STMT_2        = NULL;
	SET @JSON_O        = NULL;
	SET REFERENCE_NO   = NULL;
	SET MSISDN         = NULL;
	SET AMOUNT         = NULL;
	SET APPROVED_BY    = NULL;
	SET HAS_COLLATERAL = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcQueueNotification` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcQueueNotification`(
	IN `MSISDN` VARCHAR(15),
	IN `MESSAGE` VARCHAR(150),
	IN `CATEGORY` VARCHAR(50)
)
BEGIN

IF(TRIM(MSISDN) != ""  OR TRIM(MESSAGE) != "" OR TRIM(CATEGORY) != "") THEN

	
	
	
	SET @STMT_1 = CONCAT("INSERT ",
	                     "INTO ",
			     "`db_freknur_general`.`tbl_notification` ",
			     "(`uid`,`msisdn`,`message`,`category`,`date_created`) ",
			     "VALUES ",
			     "('",uuid(),"','",TRIM(MSISDN),"','",TRIM(MESSAGE),"','",TRIM(CATEGORY),"','",NOW(),"') ",
			     "ON DUPLICATE KEY UPDATE ",
			     "`date_modified` = '",NOW(),"'");                    
	PREPARE QUERY FROM @STMT_1;
	EXECUTE QUERY;
	DEALLOCATE PREPARE QUERY;
	
	
	
	SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation successful."}';	
	SELECT @JSON_O AS _JSON;
ELSE
	
	
	
	SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:MSISDN|MESSAGE|CATEGORY needs to be SET."}';
	SELECT @JSON_O AS _JSON;
END IF;
	
	
	
	SET @STMT_1  = NULL;
	SET @JSON_O  = NULL;
	SET MSISDN   = NULL;
	SET MESSAGE  = NULL;
	SET CATEGORY = NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcWalletCashOutForSettlement` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcWalletCashOutForSettlement`(
	IN `AMOUNT` DECIMAL(15,2),
	IN `MSISDN` VARCHAR(20),
	IN `TRANSTYPE` INT(1)
)
BEGIN
	
	
	
	
	
	
	DECLARE PARTICULARS TEXT;
	DECLARE REFERENCE_NO TEXT;
	DECLARE RUNNING_BAL DOUBLE(15,2);
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
		ROLLBACK;
		
	END;
	IF(TRIM(AMOUNT) != "" || TRIM(MSISDN) != "" || TRIM(TRANSTYPE) != "") THEN
		SET REFERENCE_NO = CONCAT('LNRE-',UCASE(LEFT(UUID(),8)));
		
		
		
		START TRANSACTION;
		
		
		
		SET @STMT_1 = CONCAT("SELECT ",
		                     "`balance` ",
				     "INTO ",
				     "@BALANCE ",
				     "FROM ",
				     "`db_freknur_loan`.`tbl_wallet` ",
				     "WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		IF(AMOUNT > "0" && AMOUNT <= @BALANCE) THEN
			
			
			
			SET PARTICULARS = "ECASH HAS BEEN DRAWN TO REPAY A LOAN.";
			
			
			
			SET RUNNING_BAL = (@BALANCE - AMOUNT);			
			
			
			
			SET @STMT_2 = CONCAT("INSERT ",
			                     "INTO ",
					     "`db_freknur_loan`.`tbl_wallet_transaction` ",
					     "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
					     "VALUES ",
					     "('",REFERENCE_NO,"','",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @STMT_3 = CONCAT("UPDATE `db_freknur_loan`.`tbl_wallet` SET `balance` = `balance` - '",TRIM(AMOUNT),"' WHERE `msisdn` = '",TRIM(MSISDN),"'");
			PREPARE QUERY FROM @STMT_3;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Movement of cash from wallet complete."}';
			SELECT @JSON_O AS _JSON;
		ELSE
			
			
			
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Invalid operation."}';
			SELECT @JSON_O AS _JSON;		
		END IF;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Param: AMOUNT|MSISDN|TRANSTYPE needs to be SET."}';
		SELECT @JSON_O AS _JSON;
		COMMIT;
	END IF;
	
	
	
	SET @EXIST  = NULL;
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @JSON_O = NULL;	
	SET @BALANCE = NULL;
	SET AMOUNT  = NULL;
	SET MSISDN  = NULL;
	SET TRANSTYPE = NULL;
	SET RUNNING_BAL = NULL;
	SET PARTICULARS = NULL;
	SET REFERENCE_NO = NULL;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcWalletToWalletTransfer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcWalletToWalletTransfer`(
	IN `AMOUNT` DOUBLE(15,2),
	IN `WALLET_BAL` DOUBLE(15,2),
	IN `MSISDN` VARCHAR(15),
	IN `BENEFICIARY_MSISDN` VARCHAR(15)
)
BEGIN
	
	
	
	
	
	
	DECLARE PARTICULARS_1 TEXT;
	DECLARE PARTICULARS_2 TEXT;
	DECLARE REFERENCE_NO TEXT;
        DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
        BEGIN
                GET DIAGNOSTICS CONDITION 1
                @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
                SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
                ROLLBACK;
                
        END;

	IF(TRIM(AMOUNT) != "" || TRIM(WALLET_BAL) != "" || TRIM(BENEFICIARY_MSISDN) != "") THEN
		
		
		
		START TRANSACTION;	
		IF(AMOUNT > "0" && AMOUNT <= WALLET_BAL) THEN
			IF(TRIM(MSISDN) != BENEFICIARY_MSISDN) THEN
				
				
				
				SET @STMT_1 = CONCAT("SELECT COUNT(`balance`),`balance` INTO @EXIST,@BENEFICIARY_WALLET_BAL FROM `db_freknur_loan`.`tbl_wallet` WHERE `msisdn` = '",TRIM(BENEFICIARY_MSISDN),"'");
				PREPARE QUERY FROM @STMT_1;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
				IF(@EXIST > "0") THEN				
					
					
					
					SET @STMT_2 = CONCAT("UPDATE `db_freknur_loan`.`tbl_wallet` SET `balance` = `balance` - '",TRIM(AMOUNT),"' WHERE `msisdn` = '",TRIM(MSISDN),"'");
					PREPARE QUERY FROM @STMT_2;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET @STMT_3 = CONCAT("UPDATE `db_freknur_loan`.`tbl_wallet` SET `balance` = `balance` + '",TRIM(AMOUNT),"' WHERE `msisdn` = '",TRIM(BENEFICIARY_MSISDN),"'");
					PREPARE QUERY FROM @STMT_3;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
                                        
                                        
                                        
					SET REFERENCE_NO = CONCAT('TRF-',UCASE(LEFT(UUID(),8)));
					
					
					
					SET PARTICULARS_1 = CONCAT("RECEIVED: ",TRIM(AMOUNT), "FROM SENDER A/C: ",TRIM(MSISDN));
					
					
					
					SET @STMT_4 = CONCAT("INSERT ",
					                     "INTO ",
							     "`db_freknur_loan`.`tbl_wallet_transaction` ",
							     "(`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
							     "VALUES ",
							     "('",TRIM(REFERENCE_NO),"','",TRIM(BENEFICIARY_MSISDN),"','",TRIM(AMOUNT),"','",(TRIM(@BENEFICIARY_WALLET_BAL) + TRIM(AMOUNT)),"','",PARTICULARS_1,"','",NOW(),"')");
					PREPARE QUERY FROM @STMT_4;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					
					
					
					SET PARTICULARS_2 = CONCAT("TRANSFER: ",TRIM(AMOUNT), "HAS BEEN MOVED TO BENEFICIARY A/C: ",TRIM(BENEFICIARY_MSISDN));
					
					
					
					SET @STMT_5 = CONCAT("INSERT ",
					                     "INTO ",
							     "`db_freknur_loan`.`tbl_wallet_transaction` ",
							     "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
							     "VALUES ",
							     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",(TRIM(WALLET_BAL) - TRIM(AMOUNT)),"','",PARTICULARS_2,"','",NOW(),"')");
					PREPARE QUERY FROM @STMT_5;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;	
					
					
					
					SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Electronic cash movement to beneficiary successful."}';
					SELECT @JSON_O AS _JSON;
				ELSE
					
					
					
					SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Beneficiary account does not exist."}';
					SELECT @JSON_O AS _JSON;
				END IF;
			ELSE
				
				
				
				SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Invalid transaction: SENDER cannot be a BENEFICIARY."}';
				SELECT @JSON_O AS _JSON;				
			END IF;						
		ELSE
			
			
			
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Transaction cannot be completed, insufficient balance."}';
			SELECT @JSON_O AS _JSON;
		END IF;
		COMMIT;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Param: AMOUNT|WALLET_BAL|BENEFICIARY_MSISDN needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	
	
	
	SET @EXIST  = NULL;
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @STMT_5 = NULL;
	SET @JSON_O = NULL;
	SET @BENEFICIARY_WALLET_BAL = NULL;	
	SET AMOUNT  = NULL;
	SET MSISDN  = NULL;
	SET WALLET_BAL = NULL;
	SET BENEFICIARY_MSISDN = NULL;
	SET PARTICULARS_1 = NULL;	
	SET PARTICULARS_2 = NULL;
	SET REFERENCE_NO = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sProcWithdrawECash` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcWithdrawECash`(
	IN `AMOUNT` DECIMAL(15,2),
	IN `MSISDN` VARCHAR(20)
)
BEGIN
	
	
	
	
	
	DECLARE PARTICULARS TEXT;
	DECLARE RUNNING_BAL DOUBLE(15,2);
	DECLARE REFERENCE_NO TEXT;
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
		ROLLBACK;
		
	END;
	
	
	
	START TRANSACTION;	
	
	
	
	IF(TRIM(AMOUNT) != "" OR TRIM(MSISDN) != "" ) THEN
		SET REFERENCE_NO = CONCAT('CSHO-',UCASE(LEFT(UUID(),8)));
		
		
		
		SET @STMT_1 = CONCAT("SELECT ",
                                     "COUNT(`balance`), ",
		                     "`balance` ",
				     "INTO ",
                                     "@CNT, ",
				     "@BALANCE ",
				     "FROM ",
				     "`db_freknur_loan`.`tbl_wallet` ",
			             "WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		
		
		
		IF(@CNT > "0") THEN
		IF(@BALANCE > "0" && AMOUNT <= @BALANCE) THEN
			
			
			
			SET PARTICULARS = "WITHDRAW E-CASH FROM WALLET.";
			
			
			
			SET RUNNING_BAL = (@BALANCE - AMOUNT);	
			
			
			
			SET @STMT_2 = CONCAT("INSERT ",
			                     "INTO ",
				             "`db_freknur_loan`.`tbl_transaction` ",
					     "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
					     "VALUES ",
					     "('0.00','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','0.00','",TRIM(AMOUNT),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");	
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @STMT_3 = CONCAT("INSERT ",
			                     "INTO ",
					     "`db_freknur_loan`.`tbl_wallet_transaction` ",
				             "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
				             "VALUES ",
			                     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_3;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @STMT_4 = CONCAT("UPDATE ",
					     "`db_freknur_loan`.`tbl_wallet` ",
                                             "SET ",
					     "`balance` = '",TRIM(RUNNING_BAL),"',`date_modified` = '",NOW(),"' ",
				             "WHERE ",
					     "`is_active` = '1' AND `is_suspended` = '0' AND `msisdn` = '",TRIM(MSISDN),"'");
			PREPARE QUERY FROM @STMT_4;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			
			
			
			SET @STMT_5 = CONCAT("INSERT ",
					     "INTO ",
					     "`db_freknur_general`.`tbl_mpesa_receipt` ",
				             "(`msisdn`,`amount`,`reference_no`,`date_created`) ",
                                             "VALUES ",
					     "('",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",TRIM(REFERENCE_NO),"','",NOW(),"') ",
					     " ON ",
					     "DUPLICATE KEY ",
				             "UPDATE `date_modified` = '",NOW(),"'");
			PREPARE QUERY FROM @STMT_5;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;					
			
			
			
			SET @JSON_O = CONCAT('{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"An amount of ',TRIM(AMOUNT),' has been withdrawn."}');
			SELECT @JSON_O AS _JSON;	
		ELSE
			
			
			
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Insufficient balance."}';
			SELECT @JSON_O AS _JSON;
		END IF;
		ELSE
                        
                        
                        
                        SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Wallet A/C does not EXIST."}';
                        SELECT @JSON_O AS _JSON;
		END IF;
	ELSE
		
		
		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:MSISDN|AMOUNT needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	
	
	
	COMMIT;
	
	
	
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @STMT_5 = NULL;
	SET @CNT = NULL;
	SET @JSON_O = NULL;
	SET @BALANCE  = NULL;	
	SET AMOUNT = NULL;
	SET MSISDN = NULL;
	SET PARTICULARS = NULL;
	SET RUNNING_BAL = NULL;
	SET REFERENCE_NO = NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `db_freknur_notification`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_freknur_notification` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_freknur_notification`;

--
-- Table structure for table `tbl_broadcast`
--

DROP TABLE IF EXISTS `tbl_broadcast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_broadcast` (
  `_id` bigint NOT NULL AUTO_INCREMENT,
  `uid` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `message` varchar(520) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `broadcast_date` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_processed` int DEFAULT '0',
  PRIMARY KEY (`_id`) USING BTREE,
  UNIQUE KEY `uid` (`uid`) USING BTREE,
  KEY `is_processed` (`is_processed`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_broadcast`
--

LOCK TABLES `tbl_broadcast` WRITE;
/*!40000 ALTER TABLE `tbl_broadcast` DISABLE KEYS */;
INSERT INTO `tbl_broadcast` VALUES (1,'d6e244ac-3423-11ed-a525-42010aa20003','hello world','2022-09-21 00:00:00','2022-09-14 14:53:25','2022-09-14 11:53:25',0),(2,'efa9ef76-3423-11ed-a525-42010aa20003','eeee','2022-09-20 00:00:00','2022-09-14 14:54:06','2022-09-14 11:54:06',0),(3,'082f84fc-3424-11ed-98e3-42010aa20003','test message from freknur','2022-08-10 12:47:24','2022-09-14 14:54:47','2022-09-14 11:54:47',0),(4,'2dfc0d4c-3427-11ed-874a-42010aa20003','test message from freknur','2022-08-10 12:47:24','2022-09-14 15:17:19','2022-09-14 12:17:19',0),(5,'44fde8ee-3427-11ed-8748-42010aa20003','test message from freknur','2022-08-10 12:47:24','2022-09-14 15:17:58','2022-09-14 12:17:58',0),(6,'5668dec2-3427-11ed-94eb-42010aa20003','test message from freknur','2022-08-10 12:47:24','2022-09-14 15:18:27','2022-09-14 12:18:27',0),(7,'a592e43e-3427-11ed-8298-42010aa20003','hello world 2','2022-09-28 00:00:00','2022-09-14 15:20:40','2022-09-14 12:20:40',0),(8,'75029674-3428-11ed-a4d7-42010aa20003','test message from freknur','2022-08-10 12:47:24','2022-09-14 15:26:28','2022-09-14 12:26:28',0),(9,'a546bada-3429-11ed-8298-42010aa20003','zssss','2022-09-22 00:00:00','2022-09-14 15:34:58','2022-09-14 12:34:58',0),(10,'bece2296-342d-11ed-8298-42010aa20003','m,m,m,m,','2022-09-25 00:00:00','2022-09-14 16:04:19','2022-09-14 13:04:19',0),(11,'0d4f8752-342e-11ed-8298-42010aa20003','m,m,','2022-09-25 00:00:00','2022-09-14 16:06:31','2022-09-14 13:06:31',0),(12,'30d28478-343c-11ed-8298-42010aa20003','opera','2022-09-27 00:00:00','2022-09-14 17:47:44','2022-09-14 14:47:44',0);
/*!40000 ALTER TABLE `tbl_broadcast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_freknur_notification'
--

--
-- Current Database: `db_freknur_paypal`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_freknur_paypal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_freknur_paypal`;

--
-- Table structure for table `tbl_ipn_receipt`
--

DROP TABLE IF EXISTS `tbl_ipn_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ipn_receipt` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `txn_id` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '0',
  `ipn` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`_id`) USING BTREE,
  UNIQUE KEY `txn_id` (`txn_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ipn_receipt`
--

LOCK TABLES `tbl_ipn_receipt` WRITE;
/*!40000 ALTER TABLE `tbl_ipn_receipt` DISABLE KEYS */;
INSERT INTO `tbl_ipn_receipt` VALUES (2,'8643509750','{\'item_name\': \'something\', \'item_number\': \'AK-1234\', \'payment_status\': \'Completed\', \'payment_amount\': \'12.34\', \'payment_currency\': \'USD\', \'txn_id\': \'8643509750\', \'receiver_email\': \'seller@paypalsandbox.com\', \'payer_email\': \'buyer@paypalsandbox.com\'}','2021-11-11 20:12:10'),(3,'720163729','{\'item_name\': \'loan\', \'item_number\': \'12345678\', \'payment_status\': \'Completed\', \'payment_amount\': None, \'payment_currency\': None, \'txn_id\': \'720163729\', \'receiver_email\': \'info@merchant.com\', \'payer_email\': \'joedoe@net.com\'}','2021-11-11 20:12:10'),(4,'120163729','{\'item_name\': \'loan\', \'item_number\': \'1234567889\', \'payment_status\': \'Completed\', \'payment_amount\': None, \'payment_currency\': None, \'txn_id\': \'120163729\', \'receiver_email\': \'info@merchant.com\', \'payer_email\': \'joedoe@net.com\'}','2021-11-11 22:23:31'),(5,'30163729','{\'item_name\': \'loan\', \'item_number\': \'1234567889\', \'payment_status\': \'Completed\', \'payment_amount\': None, \'payment_currency\': None, \'txn_id\': \'30163729\', \'receiver_email\': \'info@merchant.com\', \'payer_email\': \'joedoe@net.com\'}','2021-11-11 22:32:38'),(6,'301637290','{\'item_name\': \'loan\', \'item_number\': \'1234567889\', \'payment_status\': \'Completed\', \'payment_amount\': None, \'payment_currency\': None, \'txn_id\': \'301637290\', \'receiver_email\': \'info@merchant.com\', \'payer_email\': \'joedoe@net.com\'}','2021-11-11 22:56:05'),(7,'448182434','{\'item_name\': \'something\', \'item_number\': \'AK-1234\', \'payment_status\': \'Completed\', \'payment_amount\': \'12.34\', \'payment_currency\': \'USD\', \'txn_id\': \'448182434\', \'receiver_email\': \'seller@paypalsandbox.com\', \'payer_email\': \'buyer@paypalsandbox.com\'}','2021-11-17 09:12:59');
/*!40000 ALTER TABLE `tbl_ipn_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_paypal_bridge_temp`
--

DROP TABLE IF EXISTS `tbl_paypal_bridge_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_paypal_bridge_temp` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `msisdn` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `paypal_customer_email` varchar(35) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`_id`) USING BTREE,
  UNIQUE KEY `msisdn` (`msisdn`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_paypal_bridge_temp`
--

LOCK TABLES `tbl_paypal_bridge_temp` WRITE;
/*!40000 ALTER TABLE `tbl_paypal_bridge_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_paypal_bridge_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_freknur_paypal'
--

--
-- Current Database: `db_freknur_stats`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_freknur_stats` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_freknur_stats`;

--
-- Table structure for table `tbl_approved_loan_stats`
--

DROP TABLE IF EXISTS `tbl_approved_loan_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_approved_loan_stats` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `daily_cnt` int DEFAULT '0',
  `total` decimal(15,2) DEFAULT '0.00',
  `time_stamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_achived` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `is_achived` (`is_achived`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_approved_loan_stats`
--

LOCK TABLES `tbl_approved_loan_stats` WRITE;
/*!40000 ALTER TABLE `tbl_approved_loan_stats` DISABLE KEYS */;
INSERT INTO `tbl_approved_loan_stats` VALUES (1,2,1000.00,'2022-06-28 15:04:46',0),(2,1,4800.00,'2022-08-10 09:47:23',0),(3,1,500.00,'2022-09-27 12:24:33',0),(4,1,4200.00,'2022-09-28 11:28:18',0),(5,1,2500.00,'2022-10-06 09:55:40',0);
/*!40000 ALTER TABLE `tbl_approved_loan_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_debtor_stats`
--

DROP TABLE IF EXISTS `tbl_debtor_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_debtor_stats` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `daily_cnt` int DEFAULT '0',
  `total` decimal(15,2) DEFAULT '0.00',
  `time_stamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_achived` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `is_achived` (`is_achived`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_debtor_stats`
--

LOCK TABLES `tbl_debtor_stats` WRITE;
/*!40000 ALTER TABLE `tbl_debtor_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_debtor_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_loan_stats`
--

DROP TABLE IF EXISTS `tbl_loan_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_loan_stats` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `daily_cnt` int DEFAULT '0',
  `total` decimal(15,2) DEFAULT '0.00',
  `time_stamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_achived` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `is_achived` (`is_achived`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_loan_stats`
--

LOCK TABLES `tbl_loan_stats` WRITE;
/*!40000 ALTER TABLE `tbl_loan_stats` DISABLE KEYS */;
INSERT INTO `tbl_loan_stats` VALUES (5,8,0.00,'2022-04-19 22:31:45',0),(6,5,81.00,'2022-06-10 14:36:21',0),(7,1857,1.00,'2022-06-14 13:12:40',0),(8,6,120.00,'2022-06-21 06:43:42',0),(9,8,4000.00,'2022-06-27 21:29:02',0),(10,1,500.00,'2022-07-07 12:52:37',0),(11,7,3500.00,'2022-07-12 14:57:37',0),(12,1,500.00,'2022-09-27 12:22:31',0),(13,1,4200.00,'2022-09-28 11:25:14',0),(14,1,2500.00,'2022-10-06 09:53:21',0);
/*!40000 ALTER TABLE `tbl_loan_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_purchase_asset_stats`
--

DROP TABLE IF EXISTS `tbl_purchase_asset_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_purchase_asset_stats` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `daily_cnt` int DEFAULT '0',
  `total` decimal(15,2) DEFAULT '0.00',
  `time_stamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_achived` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `is_achived` (`is_achived`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_purchase_asset_stats`
--

LOCK TABLES `tbl_purchase_asset_stats` WRITE;
/*!40000 ALTER TABLE `tbl_purchase_asset_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_purchase_asset_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_rejected_loan_stats`
--

DROP TABLE IF EXISTS `tbl_rejected_loan_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_rejected_loan_stats` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `daily_cnt` int DEFAULT '0',
  `total` decimal(15,2) DEFAULT '0.00',
  `time_stamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_achived` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `is_achived` (`is_achived`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_rejected_loan_stats`
--

LOCK TABLES `tbl_rejected_loan_stats` WRITE;
/*!40000 ALTER TABLE `tbl_rejected_loan_stats` DISABLE KEYS */;
INSERT INTO `tbl_rejected_loan_stats` VALUES (1,1,500.00,'2022-06-28 08:32:46',0),(2,1,500.00,'2022-07-07 13:20:37',0),(3,7,3500.00,'2022-07-12 14:59:10',0),(4,1,3280.00,'2022-07-13 14:37:50',0),(5,1,2800.00,'2022-07-27 09:34:38',0);
/*!40000 ALTER TABLE `tbl_rejected_loan_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_sale_asset_stats`
--

DROP TABLE IF EXISTS `tbl_sale_asset_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_sale_asset_stats` (
  `_id` int NOT NULL AUTO_INCREMENT,
  `daily_cnt` int DEFAULT '0',
  `total` decimal(15,2) DEFAULT '0.00',
  `time_stamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_achived` int DEFAULT '0',
  PRIMARY KEY (`_id`),
  KEY `is_achived` (`is_achived`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_sale_asset_stats`
--

LOCK TABLES `tbl_sale_asset_stats` WRITE;
/*!40000 ALTER TABLE `tbl_sale_asset_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_sale_asset_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_freknur_stats'
--

--
-- Current Database: `db_freknur_wallet`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_freknur_wallet` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_freknur_wallet`;

--
-- Table structure for table `betaTesters`
--

DROP TABLE IF EXISTS `betaTesters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `betaTesters` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `EmailAddress` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `EmailAddress` (`EmailAddress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `betaTesters`
--

LOCK TABLES `betaTesters` WRITE;
/*!40000 ALTER TABLE `betaTesters` DISABLE KEYS */;
/*!40000 ALTER TABLE `betaTesters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliverydetails`
--

DROP TABLE IF EXISTS `deliverydetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliverydetails` (
  `deliveryID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `deliveryCountry` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deliveryAddress` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deliveryInfor` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deliveryContact` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `deliveryDefault` int NOT NULL,
  `deliveryCountryCode` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`deliveryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliverydetails`
--

LOCK TABLES `deliverydetails` WRITE;
/*!40000 ALTER TABLE `deliverydetails` DISABLE KEYS */;
/*!40000 ALTER TABLE `deliverydetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devicesim`
--

DROP TABLE IF EXISTS `devicesim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devicesim` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `contacts` int NOT NULL DEFAULT '0',
  `allSMS` int NOT NULL DEFAULT '0',
  `incomingSMS` int NOT NULL DEFAULT '0',
  `outgoingSMS` int NOT NULL DEFAULT '0',
  `draftSMS` int NOT NULL DEFAULT '0',
  `conversations` int NOT NULL DEFAULT '0',
  `apps` int NOT NULL,
  `imei` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `brand` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `design` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `displayName` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `isPhysicalDevice` tinyint(1) NOT NULL,
  `manufacturer` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `model` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `product` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `host` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `hardware` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `allowsVOIP` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `carrierName` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `isoCountryCode` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mobileCountryCode` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `mobileNetworkCode` varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `countryPhonePrefix` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `simcards` int NOT NULL,
  `callLogEntries` int NOT NULL,
  `dateOfLastCallLog` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `durationOfLastCallLog` int NOT NULL,
  `typeofLastCallLog` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `freeDiskSpace` float NOT NULL,
  `totalDiskSpace` float NOT NULL,
  `wifiName` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wifiBSSID` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wifiIP` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wifiIPv6` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wifiSubmask` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wifiBroadcast` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wifiGateway` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `typeOfConnectivity` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vpnActive` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userID` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devicesim`
--

LOCK TABLES `devicesim` WRITE;
/*!40000 ALTER TABLE `devicesim` DISABLE KEYS */;
INSERT INTO `devicesim` VALUES (1,1,0,0,0,0,0,0,112,'fceb6f81d8d44ea7','OPPO','CPH1819','CPH1819EX_11_F.27',1,'OPPO','CPH1819','CPH1819','10','ubuntu16-122-237','mt6771','','','','','','',0,3000,'2022-07-21 17:31:20.287',198,'incoming',8256.13,51427.5,'','40:7d:0f:89:37:64','192.168.100.189','fe80::e6c4:83ff:fe01:14d1','255.255.255.0','/192.168.100.255','192.168.100.1','wifi',0),(2,2,0,0,0,0,0,0,2,'6e10d4417fd1ad3a','Redmi','fleur','RP1A.200720.011',1,'Xiaomi','2201117SY','fleur_eea','11','m1-xm-ota-bd291.bj.idc.xiaomi.com','mt6781','','','','','','',0,1350,'2022-07-23 21:46:29.660',56,'outgoing',64314.4,109862,'','74:0a:e1:4c:32:73','192.168.8.117','fe80::d23e:794e:b8a4:9cb3','255.255.255.0','/192.168.8.255','192.168.8.1','wifi',0),(6,3,0,0,0,0,0,0,57,'eb59385f7b75d96e','samsung','a7y18lte','QP1A.190711.020.A750FXXU5CVG1',1,'samsung','SM-A750F','a7y18ltejt','10','21HHAG04','exynos7885','','','','','','',0,20,'2022-09-23 10:16:24.670',0,'missed',31067.8,53576.4,'','38:ff:36:1c:fc:58','192.168.1.210','fe80::88a0:a3ff:fe52:5a39','255.255.255.0','/192.168.1.255','192.168.1.1','wifi',0),(7,4,0,0,0,0,0,0,2,'6e10d4417fd1ad3a','Redmi','fleur','RP1A.200720.011',1,'Xiaomi','2201117SY','fleur_eea','11','m1-xm-ota-bd291.bj.idc.xiaomi.com','mt6781','','','','','','',0,1471,'2022-09-26 16:32:52.042',44,'incoming',59662.8,109862,'','null','null','null','','null','0.0.0.0','cellular',0),(8,5,0,0,0,0,0,0,2,'6e10d4417fd1ad3a','Redmi','fleur','RP1A.200720.011',1,'Xiaomi','2201117SY','fleur_eea','11','m1-xm-ota-bd291.bj.idc.xiaomi.com','mt6781','','','','','','',0,1482,'2022-10-06 11:36:53.078',158,'outgoing',60165.1,109862,'','ec:a8:1f:a9:40:40','192.168.0.87','fe80::d23e:794e:b8a4:9cb3','255.255.255.0','/192.168.0.255','192.168.0.1','wifi',0);
/*!40000 ALTER TABLE `devicesim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eosaccounts`
--

DROP TABLE IF EXISTS `eosaccounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eosaccounts` (
  `accountID` int NOT NULL AUTO_INCREMENT,
  `accountName` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `userID` int NOT NULL,
  `transactionID` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `prKey` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`accountID`),
  UNIQUE KEY `accountName` (`accountName`),
  UNIQUE KEY `userID` (`userID`),
  UNIQUE KEY `transactionID` (`transactionID`),
  UNIQUE KEY `prKey` (`prKey`),
  UNIQUE KEY `url` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eosaccounts`
--

LOCK TABLES `eosaccounts` WRITE;
/*!40000 ALTER TABLE `eosaccounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `eosaccounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loginActivity`
--

DROP TABLE IF EXISTS `loginActivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loginActivity` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `account` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `time` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ipAdd` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loginActivity`
--

LOCK TABLES `loginActivity` WRITE;
/*!40000 ALTER TABLE `loginActivity` DISABLE KEYS */;
INSERT INTO `loginActivity` VALUES (1,'254722563707',0,'2022-07-22 18:11:00.388481','android','Nairobi, Kenya','192.168.100.189'),(2,'254722563707',1,'2022-07-22 18:15:32.206108','android','Nairobi, Kenya','192.168.100.189'),(3,'254722563707',0,'2022-07-25 12:39:58.887127','android','Nairobi, Kenya','192.168.100.189'),(4,'254722563707',0,'2022-07-25 12:40:14.587232','android','Nairobi, Kenya','192.168.100.189'),(5,'254722563707',0,'2022-07-25 12:41:27.450204','android','Nairobi, Kenya','192.168.100.189'),(6,'254722563707',0,'2022-07-25 12:42:32.756148','android','Nairobi, Kenya','192.168.100.189'),(7,'254722563707',0,'2022-07-25 12:43:21.921025','android','Nairobi, Kenya','192.168.100.189'),(8,'254722563707',0,'2022-07-25 13:05:08.741863','android','Nairobi, Kenya','192.168.100.189'),(9,'254722563707',1,'2022-07-25 13:13:21.595289','android','Nairobi, Kenya','192.168.100.189'),(10,'254722563707',1,'2022-07-25 13:42:49.900789','android','Nairobi, Kenya','192.168.100.189'),(11,'4915224043369',1,'2022-07-27 12:55:34.900680','android','Melissia, Greece','192.168.8.117'),(12,'4915224043369',1,'2022-07-27 13:01:39.686791','android','Zakinthos, Greece','192.168.8.117'),(13,'254722563707',1,'2022-07-28 09:20:26.950878','android','Nairobi, Kenya','192.168.100.189'),(14,'254722563707',0,'2022-07-28 09:52:32.602580','android','Nairobi, Kenya','192.168.100.189'),(15,'254722563707',1,'2022-07-28 09:52:51.746968','android','Nairobi, Kenya','192.168.100.189'),(16,'254722563707',0,'2022-07-28 12:15:24.113708','android','Nairobi, Kenya','192.168.100.189'),(17,'254722563707',1,'2022-07-28 12:15:44.127373','android','Nairobi, Kenya','192.168.100.189'),(18,'254707132162',0,'2022-07-29 14:05:44.454610','android','Nairobi, Kenya','192.168.1.246'),(19,'254707132162',0,'2022-07-29 14:06:00.728451','android','Nairobi, Kenya','192.168.1.246'),(20,'254707132162',0,'2022-07-29 14:06:17.270896','android','Nairobi, Kenya','192.168.1.246'),(21,'254707132162',0,'2022-07-29 14:12:46.807805','android','Nairobi, Kenya','192.168.1.246'),(22,'4915224043369',1,'2022-07-30 13:05:34.563058','android','Planos, Greece','null'),(23,'254707132162',0,'2022-08-02 11:33:21.152489','android','Nairobi, Kenya','192.168.1.246'),(24,'254707132162',0,'2022-08-02 11:36:34.316097','android','Nairobi, Kenya','192.168.1.246'),(25,'254707132162',0,'2022-08-02 11:46:30.026318','android','Nairobi, Kenya','192.168.1.246'),(26,'254707132162',1,'2022-08-02 11:49:27.917350','android','Nairobi, Kenya','192.168.1.246'),(27,'46708740682',0,'2022-08-07 14:21:25.082114','undefined','undefined','undefined'),(28,'254707132162',1,'2022-08-08 11:21:47.271899','android','Nairobi, Kenya','192.168.1.246'),(29,'254707132162',1,'2022-08-08 11:49:03.048528','android','Nairobi, Kenya','192.168.1.246'),(30,'254707132162',1,'2022-08-08 16:56:05.248801','android','Nairobi, Kenya','192.168.1.246'),(31,'4915224043369',1,'2022-08-09 15:13:03.512004','android','Rostock, Germany','192.168.0.87'),(32,'254722563707',0,'2022-08-10 12:24:49.315075','android','Nairobi, Kenya','192.168.100.189'),(33,'254722563707',1,'2022-08-10 12:25:19.597817','android','Nairobi, Kenya','192.168.100.189'),(34,'4915224043369',1,'2022-08-10 11:48:28.232063','android','Rostock, Germany','192.168.0.87'),(35,'2547722563707',0,'2022-08-10 13:38:03.502349','android','Nairobi, Kenya','192.168.100.189'),(36,'254722563707',1,'2022-08-10 13:38:52.140938','android','Nairobi, Kenya','192.168.100.189'),(37,'254722563707',0,'2022-08-10 14:06:50.243374','android','Nairobi, Kenya','192.168.100.189'),(38,'254722563707',1,'2022-08-10 14:07:21.416653','android','Nairobi, Kenya','192.168.100.189'),(39,'254722563707',1,'2022-08-10 16:11:11.807894','android','Nairobi, Kenya','192.168.100.189'),(40,'254722563707',1,'2022-08-10 16:27:24.042499','android','Nairobi, Kenya','192.168.100.189'),(41,'4915224043369',1,'2022-08-11 09:30:44.025372','android','Rostock, Germany','192.168.0.87'),(42,'254707132162',1,'2022-08-12 15:40:20.137677','android','Nairobi, Kenya','192.168.1.246'),(43,'254707132162',1,'2022-08-15 21:01:22.034788','android','Nairobi, Kenya','null'),(44,'4915224043369',1,'2022-08-19 09:16:51.189966','android','Rostock, Germany','192.168.0.87'),(45,'254707132162',1,'2022-08-19 11:49:42.931477','android','Nairobi, Kenya','192.168.1.225'),(46,'254707132162',1,'2022-08-22 16:57:51.287484','android','Nairobi, Kenya','192.168.1.225'),(47,'2547072162',0,'2022-08-22 22:33:32.743893','android','Nairobi, Kenya','null'),(48,'254707132162',1,'2022-08-22 22:33:58.435245','android','Nairobi, Kenya','null'),(49,'254707132162',1,'2022-08-23 17:20:59.465396','android','Nairobi, Kenya','192.168.1.225'),(50,'254722563707',1,'2022-08-24 16:45:25.834964','android','Nairobi, Kenya','192.168.100.100'),(51,'254722563707',1,'2022-08-30 17:37:17.412250','android','Nairobi, Kenya','192.168.100.201'),(52,'254707132162',1,'2022-08-31 11:32:30.335408','android','Nairobi, Kenya','192.168.1.210'),(53,'254707132162',1,'2022-08-31 12:50:26.866373','android','Nairobi, Kenya','192.168.1.210'),(54,'4915224043369',1,'2022-09-07 15:35:11.813514','android','Rostock, Germany','192.168.0.87'),(55,'4915224043369',1,'2022-09-07 20:50:06.594736','android','Rostock, Germany','null'),(56,'4915224043369',1,'2022-09-13 11:40:03.777693','android','Rostock, Germany','192.168.0.87'),(57,'254707132162',0,'2022-09-14 10:53:06.452280','undefined','undefined','undefined'),(58,'254707132162',0,'2022-09-14 10:53:47.900502','undefined','undefined','undefined'),(59,'254707132162',1,'2022-09-14 11:16:57.430453','android','Nairobi, Kenya','null'),(60,'4915224043369',1,'2022-09-14 15:37:46.603744','android','Rostock, Germany','192.168.0.87'),(61,'254707132162',0,'2022-09-15 13:20:22.749984','android','Nairobi, Kenya','192.168.1.210'),(62,'254707132162',1,'2022-09-15 13:20:59.459341','android','Nairobi, Kenya','192.168.1.210'),(63,'4915224043369',1,'2022-09-15 15:11:09.077093','android','Rostock, Germany','192.168.0.87'),(64,'4915224043369',1,'2022-09-16 19:07:23.516075','android','Rostock, Germany','192.168.0.87'),(65,'4915224043369',1,'2022-09-19 11:28:54.355543','android','Rostock, Germany','192.168.0.87'),(66,'254707132162',1,'2022-09-19 15:31:38.854858','android','Nairobi, Kenya','192.168.1.210'),(67,'4915224043369',1,'2022-09-20 12:47:18.291181','android','Rostock, Germany','192.168.0.87'),(68,'4915224043369',1,'2022-09-20 13:23:09.669459','android','Rostock, Germany','192.168.0.87'),(69,'254707132162',1,'2022-09-20 17:32:53.721527','android','Nairobi, Kenya','192.168.1.210'),(70,'4915224043369',1,'2022-09-21 14:07:42.044841','android','Rostock, Germany','192.168.0.87'),(71,'254707132162',1,'2022-09-23 15:30:45.351178','android','Nairobi, Kenya','192.168.1.210'),(72,'254707132162',1,'2022-09-23 16:34:55.461298','android','Nairobi, Kenya','192.168.1.210'),(73,'254707132162',1,'2022-09-26 16:59:30.351455','android','Nairobi, Kenya','192.168.1.210'),(74,'254707132162',1,'2022-09-27 15:06:24.494516','android','Nairobi, Kenya','192.168.1.210'),(75,'4915224043369',0,'2022-09-27 22:34:31.236218','android','Rostock, Germany','192.168.0.87'),(76,'4915224043369',0,'2022-09-27 22:38:06.313005','android','Rostock, Germany','192.168.0.87'),(77,'4915224043369',1,'2022-09-28 09:48:27.970066','android','Rostock, Germany','null'),(78,'4915224043369',1,'2022-09-28 13:23:53.934274','android','Rostock, Germany','192.168.0.87'),(79,'4915224043369',1,'2022-09-28 15:28:56.989663','android','Rostock, Germany','192.168.0.87'),(80,'4915224043369',1,'2022-09-29 11:29:08.551107','android','Rostock, Germany','null'),(81,'4915224043369',1,'2022-09-29 12:24:15.487926','android','Rostock, Germany','192.168.0.87'),(82,'4915224043369',1,'2022-09-29 15:01:46.791098','android','Rostock, Germany','192.168.0.87'),(83,'4915224043369',0,'2022-10-06 11:49:30.667185','android','Rostock, Germany','192.168.0.87'),(84,'4915224043369',1,'2022-10-06 11:51:45.581159','android','Rostock, Germany','192.168.0.87'),(85,'4915224043369',1,'2022-10-06 11:57:49.513117','android','Rostock, Germany','192.168.0.87'),(86,'4915224043369',1,'2022-10-06 12:52:25.998644','android','Rostock, Germany','192.168.0.87'),(87,'254707132162',1,'2022-10-08 11:00:51.233752','android','Nairobi, Kenya','null'),(88,'4915224043369',1,'2022-10-11 11:09:11.432728','android','Rostock, Germany','192.168.0.87'),(89,'254707132162',1,'2022-10-11 14:53:43.505777','android','Nairobi, Kenya','192.168.1.203'),(90,'4915224043369',1,'2022-10-11 17:09:50.957847','android','Rostock, Germany','192.168.0.87'),(91,'254707132162',1,'2022-10-11 21:45:05.731069','android','Nairobi, Kenya','null'),(92,'254707132162',1,'2022-10-12 16:22:22.432870','android','Nairobi, Kenya','192.168.1.203'),(93,'254707132162',1,'2022-10-13 11:07:04.398453','android','Nairobi, Kenya','192.168.1.203'),(94,'254707132162',1,'2022-10-13 15:50:13.698933','android','Nairobi, Kenya','192.168.1.203'),(95,'254707132162',1,'2022-10-18 11:58:44.287062','android','Nairobi, Kenya','192.168.1.203');
/*!40000 ALTER TABLE `loginActivity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_markets`
--

DROP TABLE IF EXISTS `token_markets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_markets` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `AccountNumber` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NumberOfTokens` decimal(10,4) DEFAULT NULL,
  `PricePerToken` decimal(10,4) DEFAULT NULL,
  `Date` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_markets`
--

LOCK TABLES `token_markets` WRITE;
/*!40000 ALTER TABLE `token_markets` DISABLE KEYS */;
/*!40000 ALTER TABLE `token_markets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_transactions`
--

DROP TABLE IF EXISTS `token_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_transactions` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PhoneNumber` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Date` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CR` decimal(10,4) DEFAULT NULL,
  `DR` decimal(10,4) DEFAULT NULL,
  `Balance` decimal(10,4) DEFAULT NULL,
  `rewards` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_transactions`
--

LOCK TABLES `token_transactions` WRITE;
/*!40000 ALTER TABLE `token_transactions` DISABLE KEYS */;
INSERT INTO `token_transactions` VALUES (1,'4915224043369','2022-10-06 12:51:00',0.0100,0.0000,0.0100,1),(2,'4915224043369','2022-10-11 12:12:00',0.0100,0.0000,0.0200,1),(3,'254707132162','2022-10-11 15:19:00',0.0100,0.0000,0.1000,1),(4,'4915224043369','2022-10-11 18:10:00',0.0100,0.0000,0.0300,1),(5,'4915224043369','2022-10-11 18:11:00',0.0100,0.0000,0.0400,1),(6,'4915224043369','2022-10-11 18:13:00',0.0100,0.0000,0.0500,1);
/*!40000 ALTER TABLE `token_transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_freknur_token` AFTER INSERT ON `token_transactions` FOR EACH ROW BEGIN
	IF((NEW.CR IS NOT NULL || NEW.CR <> '0.00') && NEW.DR = '0.00') THEN
		SET @ACTIVITY = CONCAT('FREKNUR TOKEN WORTH:',' ',NEW.CR, ' HAS BEEN BOUGHT.');
	END IF;
	IF((NEW.DR IS NOT NULL || NEW.DR <> '0.00') && NEW.CR = '0.00') THEN
		SET @ACTIVITY = CONCAT('FREKNUR TOKEN WORTH:',' ',NEW.DR, ' HAS BEEN SOLD.');
	END IF;
	
	
	
	INSERT INTO `db_freknur_general`.`tbl_activity_log`(`msisdn`,`activity`) VALUES (NEW.PhoneNumber,@ACTIVITY);
	
	
	
	SET @ACTIVITY = NULL;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Account` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Balance` decimal(10,4) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Account` (`Account`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,'254722563707',4.0500),(3,'254707132162',0.1000),(5,'4915224043369',0.0500);
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transactionID` int NOT NULL AUTO_INCREMENT,
  `referenceNo` varchar(50) NOT NULL,
  `phoneNumber` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `processingCode` int NOT NULL,
  `transactionAmount` float NOT NULL,
  `dateCreated` datetime NOT NULL,
  `responseCode` int DEFAULT NULL,
  `responseMessage` varchar(100) DEFAULT NULL,
  `currencyCode` char(3) NOT NULL DEFAULT 'KES',
  `transactionIdentifier` varchar(500) NOT NULL,
  `debitAccount` varchar(25) DEFAULT NULL,
  `creditAccount` varchar(25) DEFAULT NULL,
  `reversed` bit(1) NOT NULL DEFAULT b'0',
  `processed` bit(1) NOT NULL DEFAULT b'0',
  `successful` bit(1) NOT NULL DEFAULT b'0',
  `txid` char(64) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`transactionID`)
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,'166504977139898812','4915224043369',101,0,'2022-10-06 11:49:31',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(2,'166504987207220830','4915224043369',108,0,'2022-10-06 11:51:11',NULL,NULL,'$','EMAIL VERIFICATION PROCESS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(3,'16650498887569818','4915224043369',108,0,'2022-10-06 11:51:28',NULL,NULL,'$','EMAIL VERIFICATION PROCESS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(4,'166504989216966122','4915224043369',100,0,'2022-10-06 11:51:32',NULL,NULL,'$','NEW USER HAS JOINED FREKNUR',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(5,'166504990624489763','4915224043369',101,0,'2022-10-06 11:51:46',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(6,'166504990719965208','4915224043369',114,0,'2022-10-06 11:51:46',NULL,NULL,'$','STORE REGISTRATION TOKEN FOR PUSH NOTIFICATIONS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(7,'166504990749033997','4915224043369',110,0,'2022-10-06 11:51:47',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(8,'166504996867996319','4915224043369',205,0,'2022-10-06 11:52:48',NULL,NULL,'$','LOAN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(9,'166504997294068405','4915224043369',201,0,'2022-10-06 11:52:52',NULL,NULL,'$','GET USER\'S DEVICE AND SIM INFORMATION',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(10,'166504997395280353','4915224043369',202,0,'2022-10-06 11:52:53',NULL,NULL,'$','GET LOAN SETTINGS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(11,'16650499987147810','4915224043369',203,2500,'2022-10-06 11:53:09',NULL,NULL,'$','LOAN REQUEST',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(12,'166505002305128273','4915224043369',110,0,'2022-10-06 11:53:42',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(13,'166505025234116403','4915224043369',503,0,'2022-10-06 11:57:31',NULL,NULL,'$','TOKEN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(14,'16650502572883684','4915224043369',110,0,'2022-10-06 11:57:37',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(15,'16650502701851352','4915224043369',101,0,'2022-10-06 11:57:50',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(16,'166505027117848266','4915224043369',110,0,'2022-10-06 11:57:50',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(17,'166505029143361631','4915224043369',112,0,'2022-10-06 11:58:10',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(18,'166505354673376208','4915224043369',101,0,'2022-10-06 12:52:26',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(19,'166505354799928174','4915224043369',110,0,'2022-10-06 12:52:27',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(20,'16650535577217025','4915224043369',111,0,'2022-10-06 12:52:37',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(21,'166521605395754030','254707132162',101,0,'2022-10-08 11:00:51',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(22,'166521605623196861','254707132162',110,0,'2022-10-08 11:00:54',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(23,'16652160626735236','254707132162',503,0,'2022-10-08 11:01:00',NULL,NULL,'$','TOKEN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(24,'166521606755558627','254707132162',503,0,'2022-10-08 11:01:06',NULL,NULL,'$','TOKEN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(25,'166521607038714591','254707132162',110,0,'2022-10-08 11:01:09',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(26,'166521607402212304','254707132162',503,0,'2022-10-08 11:01:12',NULL,NULL,'$','TOKEN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(27,'166521607715724195','254707132162',111,0,'2022-10-08 11:01:15',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(28,'166521607982344306','254707132162',112,0,'2022-10-08 11:01:18',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(29,'166521608152064315','254707132162',205,0,'2022-10-08 11:01:19',NULL,NULL,'$','LOAN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(30,'166521609045127917','254707132162',503,0,'2022-10-08 11:01:29',NULL,NULL,'$','TOKEN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(31,'16652161020651941','254707132162',505,0,'2022-10-08 11:01:40',NULL,NULL,'$','GET TOKEN MARKETS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(32,'166521610334783844','254707132162',505,0,'2022-10-08 11:01:41',NULL,NULL,'$','GET TOKEN MARKETS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(33,'166521610460416720','254707132162',505,0,'2022-10-08 11:01:42',NULL,NULL,'$','GET TOKEN MARKETS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(34,'166521610588385777','254707132162',505,0,'2022-10-08 11:01:43',NULL,NULL,'$','GET TOKEN MARKETS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(35,'166521611205069745','254707132162',503,0,'2022-10-08 11:01:50',NULL,NULL,'$','TOKEN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(36,'166521614788687049','254707132162',503,0,'2022-10-08 11:02:26',NULL,NULL,'$','TOKEN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(37,'166521615710990925','254707132162',113,0,'2022-10-08 11:02:35',NULL,NULL,'$','LOGIN ACTIVITY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(38,'16652161710311474','254707132162',110,0,'2022-10-08 11:02:49',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(39,'166521617470380790','254707132162',111,0,'2022-10-08 11:02:53',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(40,'16654793520695390','4915224043369',101,0,'2022-10-11 11:09:11',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(41,'166547935346673391','4915224043369',110,0,'2022-10-11 11:09:13',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(42,'166547936447744988','4915224043369',205,0,'2022-10-11 11:09:24',NULL,NULL,'$','LOAN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(43,'166547951297432130','4915224043369',112,0,'2022-10-11 11:11:52',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(44,'166547951990995992','4915224043369',302,0,'2022-10-11 11:12:00',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(45,'166547953501824957','4915224043369',303,191.2,'2022-10-11 11:12:08',NULL,NULL,'$','BUY UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(46,'166547954407423931','4915224043369',110,0,'2022-10-11 11:12:24',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(47,'166547955483999726','4915224043369',112,0,'2022-10-11 11:12:34',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(48,'166547966123282390','4915224043369',302,0,'2022-10-11 11:14:21',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(49,'166547969835919264','4915224043369',112,0,'2022-10-11 11:14:58',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(50,'166548922468856134','254707132162',101,0,'2022-10-11 14:53:44',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(51,'166548922697578012','254707132162',110,0,'2022-10-11 14:53:46',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(52,'166548922983137814','254707132162',112,0,'2022-10-11 14:53:48',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(53,'166548923569153647','254707132162',302,0,'2022-10-11 14:53:55',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(54,'166548924077179528','254707132162',302,0,'2022-10-11 14:54:00',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(55,'16654902116166288','254707132162',302,0,'2022-10-11 15:10:12',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(56,'166549072703789372','254707132162',302,0,'2022-10-11 15:18:46',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(57,'166549075080846304','254707132162',303,19.12,'2022-10-11 15:19:02',NULL,NULL,'$','BUY UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(58,'166549075553667994','254707132162',110,0,'2022-10-11 15:19:15',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(59,'166549076207028797','254707132162',112,0,'2022-10-11 15:19:21',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(60,'166549076964163099','254707132162',205,0,'2022-10-11 15:19:29',NULL,NULL,'$','LOAN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(61,'166549077637338510','254707132162',112,0,'2022-10-11 15:19:36',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(62,'166549080903640517','254707132162',110,0,'2022-10-11 15:20:09',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(63,'16654908127102477','254707132162',112,0,'2022-10-11 15:20:12',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(64,'166549081500938298','254707132162',111,0,'2022-10-11 15:20:14',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(65,'166549083504486587','254707132162',112,0,'2022-10-11 15:20:35',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(66,'166549085439799344','254707132162',302,0,'2022-10-11 15:20:54',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(67,'166549088717563013','254707132162',305,0,'2022-10-11 15:21:25',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(68,'166549089432664546','254707132162',112,0,'2022-10-11 15:21:34',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(69,'16654909047156753','254707132162',111,0,'2022-10-11 15:21:44',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(70,'166549093473533932','254707132162',112,0,'2022-10-11 15:22:14',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(71,'16654909362654268','254707132162',205,0,'2022-10-11 15:22:16',NULL,NULL,'$','LOAN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(72,'166549235901971199','254707132162',111,0,'2022-10-11 15:45:58',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(73,'166549237184214452','254707132162',111,0,'2022-10-11 15:46:11',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(74,'166549238470048339','254707132162',205,0,'2022-10-11 15:46:24',NULL,NULL,'$','LOAN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(75,'166549238935926079','254707132162',205,0,'2022-10-11 15:46:28',NULL,NULL,'$','LOAN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(76,'166549239070251326','254707132162',112,0,'2022-10-11 15:46:30',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(77,'166549239512821032','254707132162',111,0,'2022-10-11 15:46:34',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(78,'166549239844493986','254707132162',111,0,'2022-10-11 15:46:36',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(79,'166549474691757579','254707132162',110,0,'2022-10-11 16:25:46',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(80,'16654947476018174','254707132162',111,0,'2022-10-11 16:25:47',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(81,'166549544150824517','254707132162',110,0,'2022-10-11 16:37:21',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(82,'166549544697670557','254707132162',110,0,'2022-10-11 16:37:24',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(83,'166549545512435252','254707132162',112,0,'2022-10-11 16:37:34',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(84,'166549547251521401','254707132162',302,0,'2022-10-11 16:37:52',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(85,'166549561990939059','254707132162',112,0,'2022-10-11 16:40:19',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(86,'166549563962840658','254707132162',112,0,'2022-10-11 16:40:39',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(87,'166549564898251817','254707132162',112,0,'2022-10-11 16:40:48',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(88,'166549565100560355','254707132162',302,0,'2022-10-11 16:40:50',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(89,'166550099142096939','4915224043369',101,0,'2022-10-11 17:09:51',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(90,'166550099272733356','4915224043369',110,0,'2022-10-11 17:09:52',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(91,'166550100417856629','4915224043369',112,0,'2022-10-11 17:10:03',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(92,'166550101669173493','4915224043369',302,0,'2022-10-11 17:10:16',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(93,'166550104303457263','4915224043369',303,160,'2022-10-11 17:10:35',NULL,NULL,'$','BUY UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(94,'166550110906734756','4915224043369',303,160,'2022-10-11 17:11:40',NULL,NULL,'$','BUY UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(95,'166550111737411820','4915224043369',302,0,'2022-10-11 17:11:57',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(96,'166550120146681117','4915224043369',302,0,'2022-10-11 17:13:21',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(97,'166550121350238576','4915224043369',303,100,'2022-10-11 17:13:26',NULL,NULL,'$','BUY UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(98,'166550121874832935','4915224043369',110,0,'2022-10-11 17:13:38',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(99,'166550124061853995','4915224043369',112,0,'2022-10-11 17:14:00',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(100,'166550128710215351','4915224043369',112,0,'2022-10-11 17:14:47',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(101,'166550130318627028','4915224043369',302,0,'2022-10-11 17:15:03',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(102,'166550132268497491','4915224043369',304,50,'2022-10-11 17:15:16',NULL,NULL,'$','SELL UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(103,'16655013279663489','4915224043369',110,0,'2022-10-11 17:15:28',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(104,'166550134419413167','4915224043369',305,0,'2022-10-11 17:15:44',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(105,'166550137999736630','4915224043369',112,0,'2022-10-11 17:16:20',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(106,'166550138518596708','4915224043369',302,0,'2022-10-11 17:16:25',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(107,'16655139071908896','254707132162',101,0,'2022-10-11 21:45:06',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(108,'166551390930099733','254707132162',110,0,'2022-10-11 21:45:08',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(109,'166558094340954186','254707132162',101,0,'2022-10-12 16:22:22',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(110,'16655809461845506','254707132162',110,0,'2022-10-12 16:22:25',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(111,'16655809597062423','254707132162',305,0,'2022-10-12 16:22:38',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(112,'166558096738284088','254707132162',205,0,'2022-10-12 16:22:46',NULL,NULL,'$','LOAN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(113,'166558097942081133','254707132162',205,0,'2022-10-12 16:22:58',NULL,NULL,'$','LOAN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(114,'166558098416454161','254707132162',112,0,'2022-10-12 16:23:01',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(115,'166558099078688539','254707132162',302,0,'2022-10-12 16:23:11',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(116,'166558104317514861','254707132162',304,500,'2022-10-12 16:23:49',NULL,NULL,'$','SELL UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(117,'16655810484564015','254707132162',110,0,'2022-10-12 16:24:08',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(118,'166558105546473564','254707132162',305,0,'2022-10-12 16:24:15',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(119,'166558105859097445','254707132162',305,0,'2022-10-12 16:24:18',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(120,'166558108159384066','254707132162',307,0,'2022-10-12 16:24:41',NULL,NULL,'$','DELETE SELLER ORDER',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(121,'166558108458685249','254707132162',110,0,'2022-10-12 16:24:44',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(122,'166558108889855174','254707132162',112,0,'2022-10-12 16:24:48',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(123,'166558109005424982','254707132162',302,0,'2022-10-12 16:24:50',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(124,'166558115291025306','254707132162',304,57,'2022-10-12 16:25:47',NULL,NULL,'$','SELL UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(125,'166558117019853817','254707132162',304,57,'2022-10-12 16:25:59',NULL,NULL,'$','SELL UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(126,'166558117469515907','254707132162',110,0,'2022-10-12 16:26:14',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(127,'166558118454870774','254707132162',305,0,'2022-10-12 16:26:24',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(128,'166558123280487804','254707132162',307,0,'2022-10-12 16:27:13',NULL,NULL,'$','DELETE SELLER ORDER',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(129,'16655812361114201','254707132162',110,0,'2022-10-12 16:27:16',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(130,'166558124212460776','254707132162',112,0,'2022-10-12 16:27:21',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(131,'16655812423008461','254707132162',302,0,'2022-10-12 16:27:22',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(132,'166558128549735301','254707132162',304,18.75,'2022-10-12 16:27:54',NULL,NULL,'$','SELL UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(133,'166558130366078285','254707132162',304,18.75,'2022-10-12 16:28:12',NULL,NULL,'$','SELL UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(134,'166558132082438888','254707132162',304,18.75,'2022-10-12 16:28:28',NULL,NULL,'$','SELL UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(135,'166558132552093745','254707132162',110,0,'2022-10-12 16:28:45',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(136,'166558133393521427','254707132162',305,0,'2022-10-12 16:28:53',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(137,'166558144569750852','254707132162',307,0,'2022-10-12 16:30:45',NULL,NULL,'$','DELETE SELLER ORDER',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(138,'166558151086245468','254707132162',110,0,'2022-10-12 16:31:51',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(139,'166558151297471775','254707132162',112,0,'2022-10-12 16:31:53',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(140,'166558151421673201','254707132162',302,0,'2022-10-12 16:31:54',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(141,'166558640690188062','254707132162',112,0,'2022-10-12 17:53:26',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(142,'166558640703675534','254707132162',302,0,'2022-10-12 17:53:27',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(143,'166558643095930144','254707132162',304,18.75,'2022-10-12 17:53:41',NULL,NULL,'$','SELL UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(144,'166558644409979090','254707132162',305,0,'2022-10-12 17:54:04',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(145,'166558645827131245','254707132162',305,0,'2022-10-12 17:54:19',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(146,'166558647434031261','254707132162',307,0,'2022-10-12 17:54:35',NULL,NULL,'$','DELETE SELLER ORDER',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(147,'1665586477143428','254707132162',110,0,'2022-10-12 17:54:37',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(148,'166564843005062476','254707132162',101,0,'2022-10-13 11:07:04',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(149,'166564843253658704','254707132162',110,0,'2022-10-13 11:07:11',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(150,'166564846169643034','254707132162',305,0,'2022-10-13 11:07:41',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(151,'166564846979126022','254707132162',112,0,'2022-10-13 11:07:48',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(152,'166564847413546243','254707132162',302,0,'2022-10-13 11:07:54',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(153,'166564849568193765','254707132162',304,18.75,'2022-10-13 11:08:05',NULL,NULL,'$','SELL UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(154,'166564850030883591','254707132162',110,0,'2022-10-13 11:08:20',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(155,'166564850485089577','254707132162',305,0,'2022-10-13 11:08:25',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(156,'166564925425816430','254707132162',305,0,'2022-10-13 11:20:54',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(157,'166564926718912241','254707132162',306,25,'2022-10-13 11:21:07',NULL,NULL,'$','MODIFY SELLER ORDER',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(158,'166564927127382695','254707132162',110,0,'2022-10-13 11:21:11',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(159,'166564927508290667','254707132162',305,0,'2022-10-13 11:21:13',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(160,'166564930340641156','254707132162',307,0,'2022-10-13 11:21:43',NULL,NULL,'$','DELETE SELLER ORDER',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(161,'166564930607293487','254707132162',110,0,'2022-10-13 11:21:46',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(162,'166565269596084194','254707132162',305,0,'2022-10-13 12:18:16',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(163,'166565272692817883','254707132162',305,0,'2022-10-13 12:18:47',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(164,'166565303593812299','254707132162',305,0,'2022-10-13 12:23:56',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(165,'166565582427657581','254707132162',305,0,'2022-10-13 13:10:24',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(166,'166565585312477818','254707132162',305,0,'2022-10-13 13:10:53',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(167,'166565587079138647','254707132162',112,0,'2022-10-13 13:11:11',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(168,'166565590799839385','254707132162',305,0,'2022-10-13 13:11:48',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(169,'166565593476720850','254707132162',305,0,'2022-10-13 13:12:15',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(170,'166565593697585852','254707132162',305,0,'2022-10-13 13:12:16',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '\0',_binary '\0',NULL),(171,'166565599774517322','254707132162',305,0,'2022-10-13 13:13:05',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(172,'166565634278894997','254707132162',305,0,'2022-10-13 13:19:02',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(173,'166565635523543781','254707132162',305,0,'2022-10-13 13:19:15',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(174,'166566541392923183','254707132162',101,0,'2022-10-13 15:50:14',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(175,'166566541641394171','254707132162',110,0,'2022-10-13 15:50:15',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(176,'166566543521589785','254707132162',305,0,'2022-10-13 15:50:34',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(177,'166566544760142848','254707132162',111,0,'2022-10-13 15:50:46',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(178,'166566586399645149','254707132162',305,0,'2022-10-13 15:57:44',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(179,'166566592521166300','254707132162',305,0,'2022-10-13 15:58:45',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(180,'166575488113942437','254707132162',111,0,'2022-10-14 16:41:21',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(181,'16657548946908749','254707132162',111,0,'2022-10-14 16:41:35',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(182,'166575492388157763','254707132162',111,0,'2022-10-14 16:42:04',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(183,'166575496244697999','254707132162',112,0,'2022-10-14 16:42:42',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(184,'166575498561343926','254707132162',302,0,'2022-10-14 16:43:05',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(185,'16657550027459846','254707132162',112,0,'2022-10-14 16:43:23',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(186,'166575500606539109','254707132162',205,0,'2022-10-14 16:43:25',NULL,NULL,'$','LOAN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(187,'166575501882576111','254707132162',202,0,'2022-10-14 16:43:39',NULL,NULL,'$','GET LOAN SETTINGS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(188,'166575506395614029','254707132162',305,0,'2022-10-14 16:44:24',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(189,'166575509497688719','254707132162',113,0,'2022-10-14 16:44:53',NULL,NULL,'$','LOGIN ACTIVITY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(190,'166575511967464931','254707132162',503,0,'2022-10-14 16:45:18',NULL,NULL,'$','TOKEN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(191,'166575513698277649','254707132162',505,0,'2022-10-14 16:45:36',NULL,NULL,'$','GET TOKEN MARKETS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(192,'166575514073673027','254707132162',505,0,'2022-10-14 16:45:39',NULL,NULL,'$','GET TOKEN MARKETS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(193,'166575514837413088','254707132162',503,0,'2022-10-14 16:45:47',NULL,NULL,'$','TOKEN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(194,'166575526583988008','254707132162',505,0,'2022-10-14 16:47:46',NULL,NULL,'$','GET TOKEN MARKETS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(195,'166575527371742069','254707132162',505,0,'2022-10-14 16:47:54',NULL,NULL,'$','GET TOKEN MARKETS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(196,'166575528303719185','254707132162',500,0,'2022-10-14 16:48:03',NULL,NULL,'$','GENERATE TOKEN STATEMENT',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(197,'166575529518555915','254707132162',110,0,'2022-10-14 16:48:15',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(198,'166575529742635834','254707132162',503,0,'2022-10-14 16:48:17',NULL,NULL,'$','TOKEN INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(199,'166608352543987496','254707132162',101,0,'2022-10-18 11:58:44',NULL,NULL,'$','A FREKNUR USER HAS LOGGED IN',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(200,'166608352765778781','254707132162',110,0,'2022-10-18 11:58:46',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(201,'166608354438225059','254707132162',111,0,'2022-10-18 11:58:59',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(202,'166608355064719086','254707132162',112,0,'2022-10-18 11:59:09',NULL,NULL,'$','SHARES INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(203,'166608355674336506','254707132162',302,0,'2022-10-18 11:59:16',NULL,NULL,'$','GET FEE CHARGES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(204,'166608359827972155','254707132162',304,800,'2022-10-18 11:59:45',NULL,NULL,'$','SELL UNITS ',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(205,'166608360411111623','254707132162',110,0,'2022-10-18 12:00:03',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(206,'166608360992380164','254707132162',305,0,'2022-10-18 12:00:08',NULL,NULL,'$','SELLER ORDERS',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(207,'166608362056334859','254707132162',307,0,'2022-10-18 12:00:19',NULL,NULL,'$','DELETE SELLER ORDER',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(208,'166608362349737252','254707132162',110,0,'2022-10-18 12:00:22',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(209,'166608362888170502','254707132162',110,0,'2022-10-18 12:00:26',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(210,'166608363160160171','254707132162',111,0,'2022-10-18 12:00:30',NULL,NULL,'$','WALLET INQUIRIES ONLY',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(211,'166609723857077073','254707132162',110,0,'2022-10-18 15:47:16',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL),(212,'166609724399393576','254707132162',110,0,'2022-10-18 15:47:17',NULL,NULL,'$','USER\'S FREKNUR BASIC INQUIRIES',NULL,NULL,_binary '\0',_binary '',_binary '',NULL);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `firstName` text NOT NULL,
  `lastName` text NOT NULL,
  `homeAddress` varchar(100) NOT NULL,
  `country` varchar(250) NOT NULL,
  `countryCode` varchar(10) NOT NULL,
  `dialCode` varchar(10) NOT NULL,
  `birthDate` varchar(10) NOT NULL,
  `phoneNumber` varchar(25) NOT NULL,
  `emailAddress` varchar(50) NOT NULL,
  `password` varchar(600) NOT NULL,
  `emailVerified` int NOT NULL DEFAULT '0',
  `trials` int NOT NULL DEFAULT '0',
  `oneTimePin` int DEFAULT NULL,
  `active` int NOT NULL DEFAULT '1',
  `firstTimeLogin` int NOT NULL DEFAULT '1',
  `profileLevelID` int NOT NULL DEFAULT '1',
  `nationalID` varchar(8) DEFAULT NULL,
  `loanStatus` int NOT NULL DEFAULT '1',
  `resetPasswordToken` varchar(250) DEFAULT NULL,
  `resetPasswordExpires` varchar(250) DEFAULT NULL,
  `worldCitizenID` varchar(255) DEFAULT NULL,
  `registrationToken` varchar(255) DEFAULT NULL,
  `imei` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `phoneNumber` (`phoneNumber`),
  UNIQUE KEY `emailAddress` (`emailAddress`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COMMENT='Holds the users of the wallet';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Jessica ','Pearson ','Nairobi ','Kenya','KE','+254','25-07-1993','254722563707','joy.naitore@inmobia.com','7c5d4a5367ff63d7642c1244ad36d59fe14c1d55485f274d4e9515d1cbb8fb4b0f616ac545eeb55f18cf9aa7675adb625dc8adbb5e048d433df4c665e677720d',0,0,NULL,1,1,1,NULL,1,NULL,NULL,'1920005525','djCd3yOOTj62uac1a5T6OS:APA91bE64kWxWeGMgWQ9vbR8ShSJ7LxEbgdeHDwVK85lflLVNHyEVP-B9soL7go_afaY0aulhuBFb6jv8rlpVXw2LCIYFDBmjG1ptWpm_MJ63BZY5Jg91sOtN-CXxC4B1IUrxfEXyLLJ','87d2862acc9f529a'),(3,'doe','joe','Nairobi ','Kenya','KE','+254','02-08-2004','254707132162','alex.irungu@inmobia.com','4188b0993f30dffad307a76c033948cee116b343d9904789124823dcea0b260bdb67e776663ef05aea3e3c64d18b58318869e6dfd5dd4d7561e0c87c3ab83a5c',0,0,NULL,1,0,1,NULL,1,NULL,NULL,'4315178998','fxrsEdkeR-ah3PaSTP4QUn:APA91bH9oi2BSlSS_rhs15P5nzs1tNuerubu5dcwWlcHbqmUZ4IgWgzkH2HxtJ_dAejgZygZ5gJ_PZDfGPybmJ_M6Dj8T7rLCHmJvBlDgzelFtEJ8UZn9lE1uDBWuAyWSmKb_urA302O','eb59385f7b75d96e'),(5,'Tops','kragelund','sausage ville, rockstock','Deutschland','DE','+49','06-10-2017','4915224043369','tkp@inmobia.com','0fa0d81bce9e28873f5bac8aa91885fc2e4ab5b86054598964bcb8ef080426c5b4abadb6cd815e727a8e2adce056350fc902ba0ec268ba3fd0fb3d7ac593b6de',0,0,NULL,1,0,1,NULL,1,NULL,NULL,'2217250246','fCjLa8aIROaE3MHV2gsN_B:APA91bH9A3fO59tJlyNE8_yOCGuj4pdT6uZizeyNIRmJPKOvMvT22V_EDlwFmnJM1KZQ8BgVHPhcrDZi4E87x_ZZRIfuz48pbZkWaGeYQueIZ-hQc2Bae08oSB8QH4ZiwtgkXEN1iVpa','6e10d4417fd1ad3a');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verification`
--

DROP TABLE IF EXISTS `verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cred` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `code` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cred` (`cred`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification`
--

LOCK TABLES `verification` WRITE;
/*!40000 ALTER TABLE `verification` DISABLE KEYS */;
/*!40000 ALTER TABLE `verification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_freknur_wallet'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-25 11:18:50
