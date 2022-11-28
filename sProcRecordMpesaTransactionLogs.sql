DELIMITER $$
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
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
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
	-- .====================================================================
	-- .output.
	-- .====================================================================
	SELECT CONCAT('{"RESULT":"SUCCESS","MESSAGE":"Log has been recorded."}') AS message;
END IF;
-- .====================================================================
-- .reset vars.
-- .====================================================================
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

END$$;

DELIMITER; //
