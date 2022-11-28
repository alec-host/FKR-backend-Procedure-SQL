DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqLogWithdrawalFee`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DECIMAL(15,8),
	IN `FEE` DECIMAL(15,8)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	IF(TRIM(MSISDN) = "" || TRIM(AMOUNT) = "" || TRIM(FEE) = "") THEN
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid Input","OPERATION":"Log Fees"}') AS json_result;
	ELSE
		-- .=========================================
		-- . DO WE HAVE A RECORD.
		-- .=========================================
		SET @qry = CONCAT("SELECT COUNT(`fee_id`) INTO @EXIST_WF FROM `tbl_fee_log` WHERE `is_archived` = '0'");
		PREPARE stmt_0 FROM @qry;
		EXECUTE stmt_0;
		DEALLOCATE PREPARE stmt_0;	
		
		SET @PARTICULARS = CONCAT("Fees ",TRIM(FEE)," Earned from ",TRIM(AMOUNT)," from TX initiated by: ",TRIM(MSISDN));
		
		select @PARTICULARS;
		-- .=========================================
		-- . EXIST.
		-- .=========================================
		IF(@EXIST_WF = "0") THEN			
			-- .=========================================
			-- . INSERT A TRANSACTION LOG.
			-- .=========================================
			SET @qry = CONCAT("INSERT ",
			                  "INTO ",
			                  "`tbl_fee_log` ",
			                  "(`msisdn`,`particulars`,`cr`,`balance`) ",
				          "VALUES ",
				          "(",TRIM(MSISDN),",","'",@PARTICULARS,"'",",","'",TRIM(FEE),"'",",","'",TRIM(FEE),"'",")");
			PREPARE stmt_1 FROM @qry;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1;
		ELSE
			-- .=========================================
			-- . GET LAST BALANCE.
			-- .=========================================
			SET @qry = CONCAT("SELECT `balance` INTO @PREVIOUS_BALANCE FROM `tbl_fee_log` ORDER BY `fee_id` DESC LIMIT 1");
			PREPARE stmt_1 FROM @qry;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1;						
			-- .=========================================
			-- . GLOBAL FEE BALANCE.
			-- .=========================================
			SET @FEE_COLLECTION = (@PREVIOUS_BALANCE + FEE);
			-- .=========================================
			-- . INSERT A TRANSACTION LOG.
			-- .=========================================
			SET @qry = CONCAT("INSERT ",
			                  "INTO ",
				          "`tbl_fee_log` ",
		                          "(`msisdn`,`particulars`,`cr`,`balance`) ",
					  "VALUES ",
			                  "(",TRIM(MSISDN),",","'",@PARTICULARS,"'",",","'",TRIM(FEE),"'",",","'",TRIM(@FEE_COLLECTION),"'",")");
			PREPARE stmt_2 FROM @qry;
			EXECUTE stmt_2;
			DEALLOCATE PREPARE stmt_2;							
		END IF;
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Wallet monies movement"}') AS json_result;
	END IF;
	-- .=========================================
	-- . RESET VARS
	-- .=========================================
	SET @qry              = NULL;
	SET @EXIST_WF         = NULL;
	SET @FEE_COLLECTION   = NULL;
	SET @PREVIOUS_BALANCE = NULL;
	SET FEE               = NULL;
	SET MSISDN            = NULL;
	SET AMOUNT            = NULL;

END$$;
DELIMITER; //
