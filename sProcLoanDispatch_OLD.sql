DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcLoanDispatch`(
	IN `REFERENCE_NO` VARCHAR(50),
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT_REQUESTED` DOUBLE(15,2),
	IN `AMOUNT_DISBURSED` DOUBLE(15,2),
	IN `REPAYMENT_AMOUNT` DOUBLE(15,2),
	IN `INTEREST_AMOUNT` DOUBLE(15,2),
	IN `DURATION_IN_DAYS` VARCHAR(5),
	IN `NOTIFICATION_1` VARCHAR(2)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	-- ====================================================================
	-- .Params.
	-- .@REFERENCE_NO.
	-- .@MSISDN.
	-- .@AMOUNT_REQUESTED.
	-- .@AMOUNT_DISBURSED.
	-- .@REPAYMENT_AMOUNT.
	-- .@DURATION_IN_DAYS.
	-- .@NOTIFICATION_1.
	-- ====================================================================
	DECLARE RUNNING_BAL DOUBLE(15,2);
	DECLARE PARTICULARS TEXT;
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;
	-- ====================================================================
	-- .start transaction.
	-- ====================================================================
	START TRANSACTION;
	-- ====================================================================
	-- .valid params.
	-- ====================================================================
	IF(TRIM(REFERENCE_NO) != "" OR TRIM(MSISDN) != "" OR TRIM(AMOUNT_REQUESTED) != "" OR TRIM(AMOUNT_DISBURSED) != "" OR TRIM(REPAYMENT_AMOUNT) != "" OR TRIM(DURATION_IN_DAYS) != "" OR TRIM(NOTIFICATION_1) != "") THEN
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================	
		SET @STMT_0 = CONCAT("SELECT ",
		                     "COUNT(`uid`),`balance` ",
				     "INTO ",
				     "@HAS_ACCOUNT,@BALANCE ",
				     "FROM ",
				     "`tbl_wallet` ",
				     "WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"'");
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		IF(@HAS_ACCOUNT > "0") THEN
			-- ====================================================================
			-- .calc loan repayment date.
			-- ====================================================================			
			SET @REPAYMENT_DATE = DATE_ADD(NOW(), INTERVAL (DURATION_IN_DAYS * 24) HOUR);
			-- ====================================================================
			-- .calc notifaction date.
			-- ====================================================================			
			SET @NOTIFICATION_DATE = DATE_ADD(@REPAYMENT_DATE, INTERVAL (NOTIFICATION_1 * -1) HOUR); 
			-- ====================================================================
			-- .sql statement 2.
			-- ====================================================================
			SET @STMT_1 = CONCAT("INSERT ",
			                     "INTO ",
			                     "`tbl_debtor` ",
			                     "(`reference_no`,`msisdn`,`amount_requested`,`amount_disbursed`,`repayment_amount`,`interest_amount`, ",
                                             "`date_created`,`expected_repayment_date`,`repayment_date`,`next_notification_date`) ",
                                             "VALUES ",
			                     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT_REQUESTED),"','",TRIM(AMOUNT_DISBURSED),"',",
                                             "'",TRIM(REPAYMENT_AMOUNT),"','",TRIM(INTEREST_AMOUNT),"','",NOW(),"','",@REPAYMENT_DATE,"','",@REPAYMENT_DATE,"','",@NOTIFICATION_DATE,"') ",
                                             "ON DUPLICATE KEY ",
                                             "UPDATE `date_modified` = '",NOW(),"'");	
			PREPARE QUERY FROM @STMT_1;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .set particulars.
			-- ====================================================================			
			SET PARTICULARS = 'MONEY MOVED TO CLIENT WALLET A/C.';
			-- ====================================================================
			-- .sql statement 3.
			-- ====================================================================
			SET @STMT_2 = CONCAT("INSERT ",
			                     "INTO ",
					     "`tbl_wallet_transaction` ",
					     "(`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
					     "VALUES ",
					     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT_REQUESTED),"','",TRIM(AMOUNT_DISBURSED),"','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .set particulars.
			-- ====================================================================			
			SET PARTICULARS = 'LOAN PROCESSING FEE CHARGED.';
			-- ====================================================================
			-- .sql statement 4.
			-- ====================================================================
			SET @STMT_4 = CONCAT("INSERT ",
			                     "INTO ",
					     "`tbl_wallet_transaction` ",
					     "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
					     "VALUES ",
					     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",(TRIM(AMOUNT_REQUESTED)-TRIM(AMOUNT_DISBURSED)),"','0.00','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_4;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .calc running balance.
			-- ====================================================================
			SET RUNNING_BAL = (@BALANCE + AMOUNT_DISBURSED);
			-- ====================================================================
			-- .sql statement 5.
			-- ====================================================================
			SET @STMT_5 = CONCAT("UPDATE ",
			                     "`tbl_wallet` ",
				             "SET ",
					     "`balance` = '",TRIM(RUNNING_BAL),"',`reference_no` = '",TRIM(REFERENCE_NO),"',`date_modified` = '",NOW(),"' ",
					     "WHERE ",
					     "`msisdn` = '",TRIM(MSISDN),"'");
			PREPARE QUERY FROM @STMT_5;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .set particulars.
			-- ====================================================================
			SET PARTICULARS = 'MONEY MOVED FROM UTY TO CLIENT WALLET A/C.';			
			-- ====================================================================
			-- .sql statement 6.
			-- ====================================================================
			SET @STMT_6 = CONCAT("INSERT ",
			                     "INTO ",
					     "`tbl_transaction` ",
					     "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
					     "VALUES ",
					     "('0','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT_DISBURSED),"','0.00','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_6;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;			
			-- ====================================================================
			-- .sql statement 7.
			-- ====================================================================
			SET @STMT_7 = CONCAT("UPDATE ",
			                     "`tbl_loan_payout` ",
					     "SET ",
					     "`is_processed` = '1', `date_modified` = '",NOW(),"' ",
					     "WHERE ",
				             "`reference_no` = '",TRIM(REFERENCE_NO),"' AND `msisdn` = '",TRIM(MSISDN),"'");	   
			PREPARE QUERY FROM @STMT_7;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .output.
			-- ====================================================================	
			SET @JSON_O = CONCAT('{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"LOAN DISPATCHED TO ACCOUNT:',MSISDN,'"}');
			SELECT @JSON_O AS _JSON;									
		ELSE
			-- ====================================================================
			-- .output.
			-- ====================================================================	
			SET @JSON_O = CONCAT('{"ERROR":"1","RESULT":"FAIL","MESSAGE":"ACCOUNT DOES NOT EXIST:',MSISDN,'"}');
			SELECT @JSON_O AS _JSON;			
		END IF;
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================	
		SET @JSON_O = '{"ERROR":"0","RESULT":"FAIL","MESSAGE":"Params:REFERENCE_NO|MSISDN|AMOUNT_REQUESTED|AMOUNT_DISBURSED|REPAYMENT_AMOUNT needs to be SET."}';
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
	SET @BALANCE = NULL;
	SET @HAS_ACCOUNT = NULL;
	SET @REPAYMENT_DATE = NULL;
	SET @NOTIFICATION_DATE = NULL;
	SET MSISDN  = NULL;
	SET PARTICULARS = NULL;
	SET RUNNING_BAL = NULL;
	SET REFERENCE_NO  = NULL;
	SET AMOUNT_REQUESTED = NULL;
	SET AMOUNT_DISBURSED = NULL;
	SET REPAYMENT_AMOUNT = NULL;
	SET DURATION_IN_DAYS = NULL;
	SET NOTIFICATION_1 = NULL;
END$$;
DELIMITER; //
