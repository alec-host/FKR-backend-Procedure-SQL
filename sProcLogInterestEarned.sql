DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE db_freknur_loan.`sProcLogInterestEarned`(
	IN `INTEREST` DOUBLE(7,2),
	IN `MSISDN` VARCHAR(20),
	IN `REFERENCE_NO` VARCHAR(50),
	IN `ACCOUNT_NAME` VARCHAR(10),
	IN `TRANS_TYPE` VARCHAR(5)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	-- ====================================================================
	-- .Params.
	-- .@INTEREST.
	-- .@MSISDN.
	-- .@REFERENCE_NO.
	-- .@ACCOUNT_NAME.
	-- .@TRANS_TYPE.
	-- ====================================================================	
	DECLARE PARTICULARS TEXT;
	DECLARE RUNNING_BAL DOUBLE(15,2);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	-- ====================================================================
	-- .params checked.
	-- ====================================================================	
	IF(TRIM(INTEREST) != "" OR TRIM(MSISDN) != "" OR TRIM(REFERENCE_NO) != "" OR TRIM(ACCOUNT_NAME) != "" OR TRIM(TRANS_TYPE) != "") THEN
		START TRANSACTION;
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================
		SET @STMT_0 = CONCAT("SELECT ",
		                     "COUNT(`uid`) ",
				     "INTO ",
				     "@HAS_ACCOUNT ",
				     "FROM ",
				     "`tbl_wallet` ",
				     "WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"'");
		-- ====================================================================
		-- .commit stmt 1.
		-- ====================================================================									
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .has a wallet a/c?
		-- ====================================================================		
		IF(@HAS_ACCOUNT > "0")THEN		
			-- ====================================================================
			-- .sql statement 2.
			-- ====================================================================	
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
			-- ====================================================================
			-- .transaction type.
			-- ====================================================================
			IF(UCASE(TRANS_TYPE) = "CR") THEN
				SET PARTICULARS = "INTEREST EARNED FROM LOAN.";
				-- ====================================================================
				-- .calc running bal.
				-- ====================================================================	
				SET RUNNING_BAL = (@BALANCE + INTEREST);	
				-- ====================================================================
				-- .sql statement 3.
				-- ====================================================================		
				SET @STMT_2 = CONCAT("INSERT ",
				                     "INTO ",
						     "`tbl_transaction` ",
						     "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
						     "VALUES ",
						     "('",@ACC_CODE,"','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(INTEREST),"','0.00','",RUNNING_BAL,"','",PARTICULARS,"','",NOW(),"')");
				-- ====================================================================
				-- .commit stmt 3.
				-- ====================================================================
			  	PREPARE QUERY FROM @STMT_2;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
				-- ====================================================================
				-- .sql statement 4.
				-- ====================================================================											
				SET @STMT_3 = CONCAT("UPDATE ",
				                     "`tbl_account` ",
						     "SET ",
						     "`balance` = '",RUNNING_BAL,"',`date_modified` = '",NOW(),"' ",
					             "WHERE ",
					             "`account_code` ='",@ACC_CODE,"'");	
				-- ====================================================================
				-- .commit stmt 4.
				-- ====================================================================
				PREPARE QUERY FROM @STMT_3;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;																														
			END IF;		
			-- ====================================================================
			-- .output.
			-- ====================================================================		
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Movement complete."}';
			SELECT @JSON_O AS _JSON;				
		ELSE
			-- ====================================================================
			-- .output.
			-- ====================================================================		
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:INTEREST|MSISDN|REFERENCE_NO|ACCOUNT_NAME|TRANS_TYPE needs to be SET."}';
			SELECT @JSON_O AS _JSON;
		END IF;
					
		COMMIT;
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"A/C does not exist."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================
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
END$$
DELIMITER;
