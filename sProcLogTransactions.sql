DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcLogTransactions`(
	IN `AMOUNT` DECIMAL(15,8),
	IN `MSISDN` VARCHAR(15),
	IN `REFERENCE_NO` VARCHAR(50),
	IN `ACCOUNT_NAME` VARCHAR(15),
	IN `TRANS_TYPE` VARCHAR(5)
)
BEGIN
	-- ====================================================================
	-- .Params.
	-- .@AMOUNT.
	-- .@MSISDN.
	-- .@REFERENCE_NO.
	-- .@ACCOUNT_NAME.
	-- .@TRANS_TYPE.
	-- ====================================================================	
	DECLARE PARTICULARS TEXT;
	DECLARE RUNNING_BAL DECIMAL(15,8);
	-- ====================================================================
	-- .params checked.
	-- ====================================================================	
	IF(TRIM(AMOUNT) != "" OR TRIM(MSISDN) != "" OR TRIM(REFERENCE_NO) != "" OR TRIM(ACCOUNT_NAME) != "" OR TRIM(TRANS_TYPE) != "") THEN
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================
		SET @STMT_0 = CONCAT("SELECT ",
		                     "COUNT(`uid`) ",
				     "INTO ",
				     "@HAS_ACCOUNT ",
				     "FROM ",
				     "`db_freknur_loan`.`tbl_wallet` ",
				     "WHERE ",
			             "`msisdn` = '",TRIM(MSISDN),"'");
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
				             "`db_freknur_loan`.`tbl_account` ",
					     "WHERE ",
				             "`account_name` = '",TRIM(ACCOUNT_NAME),"'"); 
			PREPARE QUERY FROM @STMT_1;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .transaction type.
			-- ====================================================================			
			IF(UCASE(TRANS_TYPE) = "DR") THEN
				SET PARTICULARS = "MONEY MOVEMENT OUT OF UTY.";
				-- ====================================================================
				-- .calc running bal.
				-- ====================================================================	
				SET RUNNING_BAL = (@BALANCE - AMOUNT);		
				-- ====================================================================
				-- .sql statement 3.
				-- ====================================================================				
				SET @STMT_2 = CONCAT("INSERT ",
				                     "INTO ",
						     "`db_freknur_loan`.`tbl_transaction` ",
						     "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
						     "VALUES ",
						     "('",@ACC_CODE,"','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','0.00','",TRIM(AMOUNT),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
				-- ====================================================================
				-- .sql statement 4.
				-- ====================================================================											
				SET @STMT_3 = CONCAT("UPDATE ",
				                     "`db_freknur_loan`.`tbl_account` ",
						     "SET ",
						     "`balance` = '",RUNNING_BAL,"',`date_modified` = '",NOW(),"' ",
						     "WHERE ",
						     "`account_code` ='",@ACC_CODE,"'");																																			
			ELSE
				SET PARTICULARS = "MONEY MOVEMENT INTO DEP.";
				-- ====================================================================
				-- .calc running bal.
				-- ====================================================================	
				SET RUNNING_BAL = (@BALANCE + AMOUNT);	
				-- ====================================================================
				-- .sql statement 3.
				-- ====================================================================		
				SET @STMT_2 = CONCAT("INSERT ",
				                     "INTO ",
					             "`db_freknur_loan`.`tbl_transaction` ",
						     "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
						     "VALUES ",
						     "('",@ACC_CODE,"','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(HANDLING_FEE),"','0.00','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
				-- ====================================================================
				-- .sql statement 4.
				-- ====================================================================											
				SET @STMT_3 = CONCAT("UPDATE ",
				                     "`db_freknur_loan`.`tbl_account` ",
						     "SET ",
						     "`balance` = '",TRIM(RUNNING_BAL),"',`date_modified` = '",NOW(),"' ",
						     "WHERE ",
						     "`account_code` ='",@ACC_CODE,"'");																				
			END IF;
			-- ====================================================================
			-- .commit stmt 3.
			-- ====================================================================		
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .commit stmt 4.
			-- ====================================================================		
			PREPARE QUERY FROM @STMT_3;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;		
			-- ====================================================================
			-- .output.
			-- ====================================================================		
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Movement complete."}';
			SELECT @JSON_O AS _JSON;	
		ELSE
			-- ====================================================================
			-- .output.
			-- ====================================================================		
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:AMOUNT|MSISDN|REFERENCE_NO|ACCOUNT_NAME|TRANS_TYPE needs to be SET."}';
			SELECT @JSON_O AS _JSON;
		END IF;
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
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @JSON_O = NULL;
	SET @BALANCE  = NULL;
	SET @ACC_CODE = NULL;
	SET @ACC_NAME = NULL;	
	SET AMOUNT = NULL;
	SET MSISDN = NULL;
	SET REFERENCE_NO = NULL;
	SET ACCOUNT_NAME = NULL;
	SET TRANS_TYPE = NULL;
	SET PARTICULARS = NULL;
	SET RUNNING_BAL = NULL;
END$$
DELIMITER; //
