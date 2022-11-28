DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE db_freknur_loan.`sProcLoanRepayment`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DECIMAL(15,8),
	IN `TRANSACTION_NO` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
   DECLARE EXCESS DECIMAL(15,8);
   DECLARE HAS_LOAN VARCHAR(2);
   DECLARE MESSAGE VARCHAR(160);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;   
	IF(TRIM(MSISDN) != "" OR TRIM(AMOUNT) != "" OR TRANSACTION_NO != "") THEN
		START TRANSACTION;
		-- .==================================================================
		-- .routine call.
		-- .==================================================================		
		CALL `sProcHasExistingLoan`(MSISDN,HAS_LOAN);
		IF(HAS_LOAN = "1") THEN
			-- .==================================================================
			-- .get loan details.
			-- .==================================================================
			SET @STMT_0 = CONCAT(" SELECT",
			                     " `interest_amount`,`reference_no`,`repayment_amount`,`expected_repayment_date`",
					     " INTO ",
					     " @INTEREST, @REFERENCE, @LOAN_AMOUNT, @PAY_DATE ",
			                     " FROM `tbl_debtor` ",
					     " WHERE `msisdn` = '",TRIM(MSISDN),"' AND `is_repaid` ='0'");
			PREPARE QUERY FROM @STMT_0;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- .==================================================================
			-- .balance.
			-- .==================================================================
			SET EXCESS = (AMOUNT - @LOAN_AMOUNT);
			-- .==================================================================
			-- .3 possible payment approach.
			-- .==================================================================
			IF(EXCESS = "0") THEN
				-- .LOAN SETTLEMENT.
				SET @STMT_1 = CONCAT("UPDATE `tbl_debtor` SET `repayment_amount` = 0,`is_repaid` = 1, `repayment_date` = NOW() WHERE `msisdn` = '",TRIM(MSISDN),"'");
				PREPARE QUERY FROM @STMT_1;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
		                -- .==================================================================			
				-- .RESET LOAN FLAG.
				-- .==================================================================
				SET @STMT_5 = CONCAT("UPDATE `tbl_wallet` SET `reference_no` = 0,`date_modified` = NOW() WHERE `is_suspended` = 0 AND `is_active` = 1 AND `msisdn` = '",TRIM(MSISDN),"'");
				PREPARE QUERY FROM @STMT_5;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
                                -- .==================================================================
                                -- .delete loan log.
                                -- .==================================================================
                                SET @STMT_10 = CONCAT("DELETE FROM `db_freknur_general`.`tbl_loan_temp_list` WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_10;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
				-- .==================================================================
				-- .routine call:record income.
				-- .==================================================================				
				CALL `sProcLogInterestEarned`(@INTEREST,MSISDN,@REFERENCE,"INCOME","CR");
                                -- .==================================================================
                                -- .unlock portfolio.
                                -- .==================================================================
???LINES MISSING
???LINES MISSING
	-- .reset vars.
	-- .==================================================================	
	SET @STMT_0 = NULL;
	SET @STMT_1 = NULL;
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @STMT_5 = NULL;
	SET @STMT_6 = NULL;
	SET @STMT_7 = NULL;
	SET @STMT_8 = NULL;
	SET @STMT_10 = NULL;
	SET @PAY_DATE = NULL;
	SET @INTEREST = NULL;
	SET @REFERENCE = NULL;
	SET @LOAN_AMOUNT = NULL;
	SET EXCESS = NULL;
	SET MSISDN = NULL;
	SET AMOUNT = NULL;
	SET MESSAGE = NULL;	
	SET HAS_LOAN = NULL;
	SET TRANSACTION_NO = NULL;
END$$
DELIMITER; //
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE db_freknur_loan.`sProcLoanRepayment`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DECIMAL(10,2),
	IN `TRANSACTION_NO` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
   DECLARE EXCESS DECIMAL(15,2);
   DECLARE HAS_LOAN VARCHAR(2);
   DECLARE MESSAGE VARCHAR(160);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;   
	IF(TRIM(MSISDN) != "" OR TRIM(AMOUNT) != "" OR TRANSACTION_NO != "") THEN
		START TRANSACTION;
		-- .==================================================================
		-- .routine call.
		-- .==================================================================		
		CALL `sProcHasExistingLoan`(MSISDN,HAS_LOAN);
		IF(HAS_LOAN = "1") THEN
			-- .==================================================================
			-- .get loan details.
			-- .==================================================================
			SET @STMT_0 = CONCAT(" SELECT",
			                     " `interest_amount`,`reference_no`,`repayment_amount`,`expected_repayment_date`",
					     " INTO ",
					     " @INTEREST, @REFERENCE, @LOAN_AMOUNT, @PAY_DATE ",
			                     " FROM `tbl_debtor` ",
					     " WHERE `msisdn` = '",TRIM(MSISDN),"' AND `is_repaid` ='0'");
			PREPARE QUERY FROM @STMT_0;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- .==================================================================
			-- .balance.
			-- .==================================================================
			SET EXCESS = (AMOUNT - @LOAN_AMOUNT);
			-- .==================================================================
			-- .3 possible payment approach.
			-- .==================================================================
			IF(EXCESS = "0") THEN
				-- .LOAN SETTLEMENT.
				SET @STMT_1 = CONCAT("UPDATE `tbl_debtor` SET `repayment_amount` = 0,`is_repaid` = 1, `repayment_date` = NOW() WHERE `msisdn` = '",TRIM(MSISDN),"'");
				PREPARE QUERY FROM @STMT_1;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
		                -- .==================================================================			
				-- .RESET LOAN FLAG.
				-- .==================================================================
				SET @STMT_5 = CONCAT("UPDATE `tbl_wallet` SET `reference_no` = 0,`date_modified` = NOW() WHERE `is_suspended` = 0 AND `is_active` = 1 AND `msisdn` = '",TRIM(MSISDN),"'");
				PREPARE QUERY FROM @STMT_5;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
                                -- .==================================================================
                                -- .delete loan log.
                                -- .==================================================================
                                SET @STMT_10 = CONCAT("DELETE FROM `db_freknur_general`.`tbl_loan_temp_list` WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_10;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
				-- .==================================================================
				-- .routine call:record income.
				-- .==================================================================				
				CALL `sProcLogInterestEarned`(@INTEREST,MSISDN,@REFERENCE,"INCOME","CR");
                                -- .==================================================================
                                -- .unlock portfolio.
                                -- .==================================================================
???LINES MISSING
???LINES MISSING
	-- .reset vars.
	-- .==================================================================	
	SET @STMT_0 = NULL;
	SET @STMT_1 = NULL;
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @STMT_5 = NULL;
	SET @STMT_6 = NULL;
	SET @STMT_7 = NULL;
	SET @STMT_8 = NULL;
	-- .reset vars.
	-- .==================================================================	
	SET @STMT_0 = NULL;
	SET @STMT_1 = NULL;
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @STMT_5 = NULL;
	SET @STMT_6 = NULL;
	SET @STMT_7 = NULL;
	SET @STMT_8 = NULL;
	SET @STMT_10 = NULL;
	SET @PAY_DATE = NULL;
	SET @INTEREST = NULL;
	SET @REFERENCE = NULL;
	SET @LOAN_AMOUNT = NULL;
	SET EXCESS = NULL;
	SET MSISDN = NULL;
	SET AMOUNT = NULL;
	SET MESSAGE = NULL;	
	SET HAS_LOAN = NULL;
	SET TRANSACTION_NO = NULL;
END$$
DELIMITER; //
