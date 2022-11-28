DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProcCheckoutOperation`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DOUBLE(15,2)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	-- ====================================================================
	-- .Params.
	-- .@MSISDN.
	-- .@AMOUNT.
	-- ====================================================================
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	-- ====================================================================
	-- .start transaction.
	-- ====================================================================
	START TRANSACTION;	
	IF(TRIM(MSISDN) != "" OR TRIM(AMOUNT) != "") THEN
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================	
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
		-- ====================================================================
		-- .do we have the money to proceed?
		-- ====================================================================		
		IF(@WALLET_BAL >= AMOUNT) THEN
			-- ====================================================================
			-- .sql statement 2.
			-- ====================================================================	
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
			-- ====================================================================
			-- .sql statement 3.
			-- ====================================================================	
			SET @STMT_3 = CONCAT("UPDATE ",
			                     "`tbl_wallet` ",
					     "SET ",
					     "`balance` = (`balance` - '",AMOUNT,"'),`date_modified` = '",NOW(),"' ",
					     "WHERE ",
					     "`is_active` = '1' AND `is_suspended` = '0' AND `msisdn`= '",TRIM(MSISDN),"'");                    
			PREPARE QUERY FROM @STMT_3;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .output.
			-- ====================================================================
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Withdraw Complete"}';
			SELECT @JSON_O AS _JSON;
		ELSE
			-- ====================================================================
			-- .output.
			-- ====================================================================
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Insufficient Balance:."}';
			SELECT @JSON_O AS _JSON;	
		END IF;
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================	
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:MSISDN|AMOUNT needs to be SET."}';
		SELECT @JSON_O AS _JSON;	
	END IF;
	-- ====================================================================
	-- .commit transaction.
	-- ====================================================================
	COMMIT;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @REFERENCE = NULL;
	SET @WALLET_BAL = NULL;
	SET MSISDN = NULL;
	SET AMOUNT = NULL;
END$$
DELIMITER;
