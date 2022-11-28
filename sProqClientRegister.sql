DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientRegister`(
	IN `MSISDN` VARCHAR(50),
	IN `CLIENT_ID` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN

	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
  	BEGIN
	    ROLLBACK;
	    RESIGNAL;
	END;
	
	IF(TRIM(MSISDN) = "" || TRIM(CLIENT_ID) = "") THEN
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
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
		-- .=========================================
		-- . Check if MSISDN exist.
		-- .=========================================	
		IF(@MSISDN_FOUND = "0") THEN
			SET @qry2 = CONCAT("INSERT INTO tbl_wallet(`MSISDN`,`ClientId`,`DateCreated`,`LastActivity`) VALUES('",TRIM(MSISDN),"','",TRIM(CLIENT_ID),"','",NOW(),"','",NOW(),"') ");
			PREPARE stmt_1 FROM @qry2;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1; 
			
			SET @qry3 = CONCAT("INSERT INTO tbl_wallet_ext(`MSISDN`,`Password`) VALUES('",TRIM(MSISDN),"','0')");
			PREPARE stmt_2 FROM @qry3;
			EXECUTE stmt_2;
			DEALLOCATE PREPARE stmt_2; 
			-- .=========================================
			-- . OUTPUT.
			-- .=========================================
			SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Register User"}') AS json_result;
		ELSE
			-- .=========================================
			-- . OUTPUT.
			-- .=========================================
			SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - User Exist","OPERATION":"Register User"}') AS json_result;							
		END IF;
		
		COMMIT;	
	END IF;

END$$;
DELIMITER; //
