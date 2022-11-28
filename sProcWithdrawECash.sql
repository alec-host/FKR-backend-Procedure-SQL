DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcWithdrawECash`(
	IN `AMOUNT` DECIMAL(15,2),
	IN `MSISDN` VARCHAR(20)
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
	-- ====================================================================	
	DECLARE PARTICULARS TEXT;
	DECLARE RUNNING_BAL DOUBLE(15,2);
	DECLARE REFERENCE_NO TEXT;
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
		ROLLBACK;
		-- RESIGNAL;
	END;
	-- ====================================================================
	-- .start transaction.
	-- ====================================================================
	START TRANSACTION;	
	-- ====================================================================
	-- .params checked.
	-- ====================================================================	
	IF(TRIM(AMOUNT) != "" OR TRIM(MSISDN) != "" ) THEN
		SET REFERENCE_NO = CONCAT('CSHO-',UCASE(LEFT(UUID(),8)));
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================
		SET @STMT_1 = CONCAT("SELECT ",
                                     "COUNT(`balance`), ",
		                     "`balance` ",
				     "INTO ",
                                     "@CNT, ",
				     "@BALANCE ",
				     "FROM ",
				     "`db_freknur_loan`.`tbl_wallet` ",
			             "WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .has a wallet a/c?
		-- ====================================================================
		IF(@CNT > "0") THEN
		IF(@BALANCE > "0" && AMOUNT <= @BALANCE) THEN
			-- ====================================================================
			-- .transaction type.
			-- ====================================================================			
			SET PARTICULARS = "WITHDRAW E-CASH FROM WALLET.";
			-- ====================================================================
			-- .calc running bal.
			-- ====================================================================	
			SET RUNNING_BAL = (@BALANCE - AMOUNT);	
			-- ====================================================================
			-- .sql statement 2.
			-- ====================================================================		
			SET @STMT_2 = CONCAT("INSERT ",
			                     "INTO ",
				             "`db_freknur_loan`.`tbl_transaction` ",
					     "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
					     "VALUES ",
					     "('0.00','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','0.00','",TRIM(AMOUNT),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");	
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .sql statement 3.
			-- ====================================================================
			SET @STMT_3 = CONCAT("INSERT ",
			                     "INTO ",
					     "`db_freknur_loan`.`tbl_wallet_transaction` ",
				             "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
				             "VALUES ",
			                     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_3;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .sql statement 4.
			-- ====================================================================
			SET @STMT_4 = CONCAT("UPDATE ",
					     "`db_freknur_loan`.`tbl_wallet` ",
                                             "SET ",
					     "`balance` = '",TRIM(RUNNING_BAL),"',`date_modified` = '",NOW(),"' ",
				             "WHERE ",
					     "`is_active` = '1' AND `is_suspended` = '0' AND `msisdn` = '",TRIM(MSISDN),"'");
			PREPARE QUERY FROM @STMT_4;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .sql statement 5.
			-- ====================================================================
			SET @STMT_5 = CONCAT("INSERT ",
					     "INTO ",
					     "`db_freknur_general`.`tbl_mpesa_receipt` ",
				             "(`msisdn`,`amount`,`reference_no`,`date_created`) ",
                                             "VALUES ",
					     "('",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",TRIM(REFERENCE_NO),"','",NOW(),"') ",
					     " ON ",
					     "DUPLICATE KEY ",
				             "UPDATE `date_modified` = '",NOW(),"'");
			PREPARE QUERY FROM @STMT_5;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;					
			-- ====================================================================
			-- .output.
			-- ====================================================================
			SET @JSON_O = CONCAT('{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"An amount of ',TRIM(AMOUNT),' has been withdrawn."}');
			SELECT @JSON_O AS _JSON;	
		ELSE
			-- ====================================================================
			-- .output.
			-- ====================================================================
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Insufficient balance."}';
			SELECT @JSON_O AS _JSON;
		END IF;
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
	SET @STMT_5 = NULL;
	SET @CNT = NULL;
	SET @JSON_O = NULL;
	SET @BALANCE  = NULL;	
	SET AMOUNT = NULL;
	SET MSISDN = NULL;
	SET PARTICULARS = NULL;
	SET RUNNING_BAL = NULL;
	SET REFERENCE_NO = NULL;
END$$
DELIMITER; //
