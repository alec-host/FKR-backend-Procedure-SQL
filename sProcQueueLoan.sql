DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcQueueLoan`(
	IN `REFERENCE_NO` VARCHAR(50),
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DOUBLE(15,8),
	IN `APPROVED_BY` VARCHAR(50),
        IN `HAS_COLLATERAL` INT(1)
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
	-- .@REFERENCE_NO.
	-- .@AMOUNT.
	-- .@APPROVED_BY.
	-- ====================================================================
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;	
	IF(TRIM(REFERENCE_NO) != "" OR TRIM(MSISDN) != "" OR TRIM(AMOUNT) != "" OR TRIM(APPROVED_BY) != "" OR TRIM(HAS_COLLATERAL) != "") THEN
		START TRANSACTION;
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================	
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
		-- ====================================================================
		-- .sql statement 2.
		-- ====================================================================	
		SET @STMT_2 = CONCAT("UPDATE ",
		                     "`db_freknur_loan`.`tbl_loan_request` ",
				     "SET ",
			             "`is_processed` = 1 ",
			             "WHERE ",
				     "`reference_no` = '",TRIM(REFERENCE_NO),"' AND `msisdn` = '",TRIM(MSISDN),"'");	                     
		PREPARE QUERY FROM @STMT_2;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;	
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
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:REFERENCE_NO|MSISDN|AMOUNT|APPROVED_BY|HAS_COLLATERAL needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================
	SET @STMT_1        = NULL;
	SET @STMT_2        = NULL;
	SET @JSON_O        = NULL;
	SET REFERENCE_NO   = NULL;
	SET MSISDN         = NULL;
	SET AMOUNT         = NULL;
	SET APPROVED_BY    = NULL;
	SET HAS_COLLATERAL = NULL;
END$$
DELIMITER //
