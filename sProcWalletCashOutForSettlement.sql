DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcWalletCashOutForSettlement`(
	IN `AMOUNT` DECIMAL(15,2),
	IN `MSISDN` VARCHAR(20),
	IN `TRANSTYPE` INT(1)
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
	-- .@TRANSTYPE.
	-- ====================================================================
	DECLARE PARTICULARS TEXT;
	DECLARE REFERENCE_NO TEXT;
	DECLARE RUNNING_BAL DOUBLE(15,2);
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
		ROLLBACK;
		-- RESIGNAL;
	END;
	IF(TRIM(AMOUNT) != "" || TRIM(MSISDN) != "" || TRIM(TRANSTYPE) != "") THEN
		SET REFERENCE_NO = CONCAT('LNRE-',UCASE(LEFT(UUID(),8)));
		-- ====================================================================
		-- .start transaction.
		-- ====================================================================
		START TRANSACTION;
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================
		SET @STMT_1 = CONCAT("SELECT ",
		                     "`balance` ",
				     "INTO ",
				     "@BALANCE ",
				     "FROM ",
				     "`db_freknur_loan`.`tbl_wallet` ",
				     "WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		IF(AMOUNT > "0" && AMOUNT <= @BALANCE) THEN
			-- ====================================================================
			-- .transaction type.
			-- ====================================================================
			SET PARTICULARS = "ECASH HAS BEEN DRAWN TO REPAY A LOAN.";
			-- ====================================================================
			-- .calc running bal.
			-- ====================================================================
			SET RUNNING_BAL = (@BALANCE - AMOUNT);			
			-- ====================================================================
			-- .sql statement 2.
			-- ====================================================================
			SET @STMT_2 = CONCAT("INSERT ",
			                     "INTO ",
					     "`db_freknur_loan`.`tbl_wallet_transaction` ",
					     "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
					     "VALUES ",
					     "('",REFERENCE_NO,"','",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .update wallet bal.
			-- ====================================================================	
			SET @STMT_3 = CONCAT("UPDATE `db_freknur_loan`.`tbl_wallet` SET `balance` = `balance` - '",TRIM(AMOUNT),"' WHERE `msisdn` = '",TRIM(MSISDN),"'");
			PREPARE QUERY FROM @STMT_3;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .output.
			-- ====================================================================
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Movement of cash from wallet complete."}';
			SELECT @JSON_O AS _JSON;
		ELSE
			-- ====================================================================
			-- .output.
			-- ====================================================================
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Invalid operation."}';
			SELECT @JSON_O AS _JSON;		
		END IF;
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Param: AMOUNT|MSISDN|TRANSTYPE needs to be SET."}';
		SELECT @JSON_O AS _JSON;
		COMMIT;
	END IF;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================
	SET @EXIST  = NULL;
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @JSON_O = NULL;	
	SET @BALANCE = NULL;
	SET AMOUNT  = NULL;
	SET MSISDN  = NULL;
	SET TRANSTYPE = NULL;
	SET RUNNING_BAL = NULL;
	SET PARTICULARS = NULL;
	SET REFERENCE_NO = NULL;	
END$$
DELIMITER; //
