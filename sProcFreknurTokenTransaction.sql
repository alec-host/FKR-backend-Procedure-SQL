DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_investment`.`sProcFreknurTokenTransaction`(
	IN `MSISDN` VARCHAR(20),
	IN `AMOUNT` DECIMAL(15,8),
	IN `REF_NUMBER` VARCHAR(50),
	IN `ACCOUNT_TYPE` CHAR(2)
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
	-- .@MSISDN.
	-- .@REF_NUMBER.
	-- .@ACCOUNT_TYPE.
	-- ====================================================================
	DECLARE PARTICULARS TEXT;
	DECLARE RUNNING_BAL DOUBLE(15,2);
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
		ROLLBACK;
		#RESIGNAL;
	END;
	-- ====================================================================
	-- .start transaction.
	-- ====================================================================
	START TRANSACTION;	
	-- ====================================================================
	-- .params checked.
	-- ====================================================================	
	IF(TRIM(AMOUNT) != "" || TRIM(MSISDN) != "" || ACCOUNT_TYPE != "") THEN
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================
		SET @STMT_1 = CONCAT("SELECT ",
				     "COUNT(`id`), ",
		                     "`balance` ",
			             "INTO ",
				     "@CNT, ",
				     "@BALANCE ",
				     "FROM ",
				     "`db_freknur_loan`.`tbl_wallet` ",
				     " WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .has a wallet a/c?
		-- ====================================================================
		IF(@CNT > "0") THEN
			-- ====================================================================
			-- .calc running bal.
			-- ====================================================================
			IF(TRIM(ACCOUNT_TYPE) = "CR")THEN
				-- ====================================================================
				-- .transaction type.
				-- ====================================================================
				SET PARTICULARS = "WALLET DEPOSIT FROM SALE OF FKR TOKEN.";
				SET RUNNING_BAL = (@BALANCE + AMOUNT);
			ELSE
				-- ====================================================================
				-- .transaction type.
				-- ====================================================================
				SET PARTICULARS = "WITHDRAWAL FROM WALLET FOR PURCHASE OF FKR TOKEN.";
				SET RUNNING_BAL = (@BALANCE - AMOUNT);
			END IF;	
			-- ====================================================================
			-- .sql statement 2.
			-- ====================================================================	
			IF(RUNNING_BAL >= "0") THEN
				IF(TRIM(ACCOUNT_TYPE) = "CR")THEN	
					SET @STMT_2 = CONCAT("INSERT ",
				                     	     "INTO ",
							     "`db_freknur_investment`.`tbl_transaction` ",
						             "(`account_code`,`reference_no`,`msisdn`,`dr`,`cr`,`balance`,`narration`,`date_created`) ",
							     "VALUES ",
							     "('0.00','",TRIM(REF_NUMBER),"','",TRIM(MSISDN),"','0.00','",ROUND(TRIM(AMOUNT),8),"','",ROUND(TRIM(RUNNING_BAL),8),"','",PARTICULARS,"','",NOW(),"')");	
				ELSE
					SET @STMT_2 = CONCAT("INSERT ",
				                     	     "INTO ",
							     "`db_freknur_investment`.`tbl_transaction` ",
							     "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
							     "VALUES ",
							     "('0.00','",TRIM(REF_NUMBER),"','",TRIM(MSISDN),"','0.00','",ROUND(TRIM(AMOUNT),8),"','",ROUND(TRIM(RUNNING_BAL),8),"','",PARTICULARS,"','",NOW(),"')");				
				END IF;
				PREPARE QUERY FROM @STMT_2;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
				-- ====================================================================
				-- .sql statement 3.
				-- ====================================================================
				IF(TRIM(ACCOUNT_TYPE) = "CR")THEN
					SET @STMT_3 = CONCAT("INSERT ",
				                     	     "INTO ",
						             "`db_freknur_loan`.`tbl_wallet_transaction` ",
						             "(`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
						             "VALUES ",
							     "('",TRIM(REF_NUMBER),"','",TRIM(MSISDN),"','",ROUND(TRIM(AMOUNT),8),"','",ROUND(TRIM(RUNNING_BAL),8),"','",PARTICULARS,"','",NOW(),"')");
				ELSE
					SET @STMT_3 = CONCAT("INSERT ",
				                     	     "INTO ",
						             "`db_freknur_loan`.`tbl_wallet_transaction` ",
						             "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
						             "VALUES ",
							     "('",TRIM(REF_NUMBER),"','",TRIM(MSISDN),"','",ROUND(TRIM(AMOUNT),8),"','",ROUND(TRIM(RUNNING_BAL),8),"','",PARTICULARS,"','",NOW(),"')");				
				END IF;
				PREPARE QUERY FROM @STMT_3;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;	
				-- ====================================================================
				-- .sql statement 4.
				-- ====================================================================
				SET @STMT_4 = CONCAT("UPDATE ",
					             "`db_freknur_loan`.`tbl_wallet` ",
					             "SET ",
					             "`balance` = '",ROUND(TRIM(RUNNING_BAL),8),"',`date_modified` = '",NOW(),"'",
						     " WHERE ",
					             "`is_active` = '1' AND `is_suspended` = '0' AND `msisdn` = '",TRIM(MSISDN),"'");
				PREPARE QUERY FROM @STMT_4;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
			ELSE
				-- ====================================================================
				-- .output.
				-- ====================================================================
				SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Insufficient balance."}';
				SELECT @JSON_O AS _JSON;				
			END IF;				
			-- ====================================================================
			-- .output.
			-- ====================================================================
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Wallet account has been reconciled."}';
			SELECT @JSON_O AS _JSON;	
		ELSE
			-- ====================================================================
			-- .output.
			-- ====================================================================
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Wallet A/C does not EXIST."}';
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
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @JSON_O = NULL;
	SET @BALANCE  = NULL;	
	SET AMOUNT = NULL;
	SET MSISDN = NULL;
	SET PARTICULARS = NULL;
	SET RUNNING_BAL = NULL;
END$$
DELIMITER; // 
