DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqHandleInboundSms`(
	IN `_Source` VARCHAR(50),
	IN `_Message` VARCHAR(450),
	IN `_Destination` VARCHAR(50),
	IN `_LinkID` VARCHAR(50)

)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	IF(TRIM(_Source) = "" || TRIM(_Message) = "" || TRIM(_Destination) = "" || TRIM(_LinkID) = "") THEN
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================	
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
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================		
		SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Queue Message","PAYLOAD":{"phone":"',TRIM(_Source),'","message":"',TRIM(_Message),'","linkid":"',TRIM(_LinkID),'"}}') AS json_result;		
	END IF;
-- .=========================================
-- . RESET VARS
-- .=========================================
SET @qry = NULL;
SET _Source = NULL;
SET _Message = NULL;
SET _Destination = NULL;
SET _LinkID = NULL;
END$$;

DELIMITER; //

