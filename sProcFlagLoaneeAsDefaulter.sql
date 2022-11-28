DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcFlagLoaneeAsDefaulter`(
	IN `RECORD_ID` VARCHAR(20),
	IN `MSISDN` VARCHAR(20),
	IN `LOAN_AMT` DOUBLE(17,2),
	IN `EXPECTED_PAY_DATE` DATETIME,
	IN `TIME_IN_MONTH` INT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
			RESIGNAL;
		END;
	IF(TRIM(RECORD_ID) != "" OR TRIM(MSISDN) != "" OR TRIM(LOAN_AMT) != "" OR TRIM(EXPECTED_PAY_DATE) != "" OR TRIM(TIME_IN_MONTH) != "") THEN
		START TRANSACTION;
		-- .===================================================================
		-- .GET NEXT NOFICATION DATE.	
		-- .===================================================================
		SET @STMT_1 = CONCAT('SELECT DATE_ADD(NOW(),INTERVAL ',TIME_IN_MONTH,' MONTH) INTO @NEXT_INTERVAL');
		-- .===================================================================
		-- .EXECUTE STMT 1.
		-- .===================================================================				
		PREPARE q FROM @STMT_1;
		EXECUTE q;
		DEALLOCATE PREPARE q;
		-- .===================================================================
		-- .LIST LOANEE AS DEFAULTER.
		-- .===================================================================
		SET @STMT_2 =	CONCAT('INSERT ',
		                       'INTO ',
				       '`db_freknur_general`.`tbl_defaulter` ',
				       '(`msisdn`,`loan_amount`,`expected_repayment_date`,`notification_date`,`date_created`) ',
				       'VALUES ',
			               '("',TRIM(MSISDN),'","',TRIM(LOAN_AMT),'","',TRIM(EXPECTED_PAY_DATE),'","',TRIM(@NEXT_INTERVAL),'","',NOW(),'")');
		-- .===================================================================
		-- .EXECUTE STMT 2.
		-- .===================================================================
		PREPARE q FROM @STMT_2;
		EXECUTE q;
		DEALLOCATE PREPARE q;												 						 
		-- .===================================================================
		-- .KNOCK OF THE RECORD.
		-- .===================================================================
		SET @STMT_3 =	CONCAT('UPDATE `tbl_debtor` SET `is_archived` = 1 WHERE `msisdn` = "',TRIM(MSISDN),'" AND `id` = ',TRIM(RECORD_ID),'');
		-- .===================================================================
		-- .EXECUTE STMT 3.
		-- .===================================================================
		PREPARE q FROM @STMT_3;								
		EXECUTE q;
		DEALLOCATE PREPARE q;
		-- ====================================================================
		-- .output.
		-- ====================================================================		
		SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation successful."}';
		SELECT @JSON_O AS _JSON;		
		COMMIT;
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================		
		SET @JSON_O = '{"ERROR":"1","RESULT":"SUCCESS","MESSAGE":"Params must be checked."}';
		SELECT @JSON_O AS _JSON;	
	END IF;
	-- .===================================================================
	-- .RESET VARS.
	-- .===================================================================
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
END$$
DELIMITER; //
