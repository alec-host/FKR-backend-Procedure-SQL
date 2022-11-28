DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientUtiliseBonus`(
	IN `MSISDN` VARCHAR(15),
	IN `BONUS` DECIMAL(10,2)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	IF(TRIM(MSISDN) = "" || TRIM(BONUS) = "") THEN
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"0","MESSAGE","Unsuccessful - Invalid Input","OPERATION":"Utilise Bonus"}') AS json_result;
	ELSE
	-- .=========================================
	-- . Check if MSISDN exist.
	-- .=========================================
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
	-- .=========================================
	-- . Update wallet balance.
	-- .=========================================	  
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
			-- .=========================================
			-- . OUTPUT.
			-- .=========================================
			SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Utilise Bonus"}') AS json_result;
		ELSE
			-- .=========================================
			-- . OUTPUT.
			-- .=========================================
			SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Insufficient Bonus","OPERATION":"Utilise Bonus"}') AS json_result;			
		END IF;
	ELSE
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Account does not Exist.","OPERATION":"Utilise Bonus"}') AS json_result;	
	END IF;
END IF;
-- .=========================================
-- . RESET VARS
-- .=========================================
SET @qry = NULL;
SET MSISDN = NULL;
SET BONUS = NULL;
SET @MSISDN_XFOUND = NULL;
SET @BONUS_BAL = NULL;
END$$;
DELIMITER; //
