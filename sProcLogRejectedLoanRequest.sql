DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcLogRejectedLoanRequest`(
	IN `MSISDN` VARCHAR(20),
	IN `REMARKS` TEXT
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	-- ====================================================================
	-- .Params.
	-- .@AMOUNT.
	-- .@REMARKS.
	-- .@MSISDN.
	-- ====================================================================
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
                GET DIAGNOSTICS CONDITION 1
                @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
                SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
                ROLLBACK;
	END;
	IF(TRIM(MSISDN) != "" OR TRIM(REMARKS) != "") THEN
		START TRANSACTION;
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================	
		SET @STMT_1 = CONCAT("INSERT ",
		                     "INTO ",
				     "`db_freknur_general`.`tbl_rejected_loan` ",
			             "(`msisdn`,`remarks`,`date_created`) ",
				     "VALUES ",
			             "('",TRIM(MSISDN),"','",TRIM(REMARKS),"','",NOW(),"')");                    
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .sql statement 2.
		-- ====================================================================	
		SET @STMT_2 = CONCAT("DELETE ",
		                     "FROM ",
			             "`db_freknur_loan`.`tbl_loan_request` ",
				     "WHERE "
				     "`is_processed` = 0 AND `msisdn` = '",TRIM(MSISDN),"'");                    
		PREPARE QUERY FROM @STMT_2;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;		
		-- ====================================================================
		-- .output.
		-- ====================================================================	
		SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Loan requested has been logged."}';
		SELECT @JSON_O AS _JSON;
		COMMIT;		
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================	
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:AMOUNT|REMARKS|MSISDN needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================
	SET @STMT_1  = NULL;
	SET @STMT_2  = NULL;
	SET @JSON_O  = NULL;
	SET REMARKS  = NULL;
	SET MSISDN   = NULL;	
END$$
DELIMITER; //
