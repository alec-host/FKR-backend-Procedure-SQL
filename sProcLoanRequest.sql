DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcLoanRequest`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` VARCHAR(15)
)
BEGIN
	-- ====================================================================
	-- .Params.
	-- .@MSISDN
	-- .@AMOUNT.
	-- ====================================================================
	IF(TRIM(MSISDN) <> "" AND TRIM(AMOUNT) <> "") THEN
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================	
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
			-- ====================================================================
			-- .stored proc call to check for existing loan.
			-- ====================================================================
			CALL `sProcHasExistingLoan`(MSISDN,@HAS_LOAN);
			-- ====================================================================
			-- .do have a loan?
			-- ====================================================================
			IF(@HAS_LOAN = "1")THEN
				-- ====================================================================
				-- .output.
				-- ====================================================================
				SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"You have an existing loan."}';
				SELECT @JSON_O AS _JSON;			
			ELSE
				-- ====================================================================
				-- .stored proc call.
				-- ====================================================================
				CALL `sProcGenerateID`(@REF_NUM);	
				-- ====================================================================
				-- .sql statement 2.
				-- ====================================================================	
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
				-- ====================================================================
				-- .output.
				-- ====================================================================
				SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Loan request was successful."}';
				SELECT @JSON_O AS _JSON;
			END IF;
		ELSE
			-- ====================================================================
			-- .output.
			-- ====================================================================
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"You have a pending loan request."}';
			SELECT @JSON_O AS _JSON;					
		END IF;
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================	
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Param: MSISDN|AMOUNT needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
		-- ====================================================================
		-- .reset the vars.
		-- ====================================================================
		SET @STMT_1      = NULL;
		SET @STMT_2      = NULL;
		SET @JSON_O      = NULL;
		SET @REF_NUM     = NULL;
		SET @HAS_LOAN    = NULL;		
		SET @REQUEST_CNT = NULL;
		SET MSISDN       = NULL;
		SET AMOUNT       = NULL;
END$$
DELIMITER; //
