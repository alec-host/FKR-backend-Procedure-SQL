DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcHandleLoanNotification`(
	IN `RECORD_ID` VARCHAR(20),
	IN `DIFF_IN_SECOND` VARCHAR(20),
	IN `NOFICATION_COUNT` VARCHAR(5),
	IN `HOUR_VAL` INT,
	IN `MSISDN` VARCHAR(20),
	IN `LOAN_AMT` DOUBLE(7,2),
	IN `EXPECTED_PAY_DATE` DATETIME
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN

	DECLARE TIME_VAL DATETIME;

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
			RESIGNAL;
		END;


	IF(TRIM(RECORD_ID) != "" OR TRIM(DIFF_IN_SECOND) != "" OR TRIM(NOFICATION_COUNT) != "" OR TRIM(HOUR_VAL) != "" OR TRIM(MSISDN) != "" OR TRIM(LOAN_AMT) != "" OR TRIM(EXPECTED_PAY_DATE) != "")THEN
		START TRANSACTION;
		-- .===================================================================
		-- .DECLARED VARS.
		-- .===================================================================
		SET TIME_VAL = DATE_SUB(EXPECTED_PAY_DATE,INTERVAL HOUR_VAL HOUR);
		-- .===================================================================
		-- .GET MESSAGE TEMP.
		-- .===================================================================
		CALL `sProcLoadMessageTemplate`('LOAN_ALERT', @MESSAGE_TEMP);
		-- .===================================================================
		-- .FORMAT PAY DATE.
		-- .===================================================================                 
		SET EXPECTED_PAY_DATE = REPLACE(TRIM(EXPECTED_PAY_DATE),' ',' @ ');	
		-- .===================================================================
		-- .CONDITION.
		-- .===================================================================
		IF(DIFF_IN_SECOND >= "0") THEN
			IF(NOFICATION_COUNT >= "0" AND NOFICATION_COUNT <= "4") THEN
				SET @STMT_1 = CONCAT('UPDATE ',
				                     '`tbl_debtor` ',
						     'SET ',
					             '`notification_count` = (`notification_count` + 1), `next_notification_date` = "',TRIM(TIME_VAL),'"  ',
						     'WHERE ',
						     '`msisdn` = "',TRIM(MSISDN),'" AND `id` = "',TRIM(RECORD_ID),'"');
				-- .===================================================================
				-- .EXECUTE STMT 1.
				-- .===================================================================
				PREPARE q FROM @STMT_1;
				EXECUTE q;
				DEALLOCATE PREPARE q;											
				-- .===================================================================
				-- .QUEUE NOTIFICATION.
				-- .===================================================================
				CALL `sProcQueueNotification`(TRIM(MSISDN),REPLACE(REPLACE(REPLACE(TRIM(@MESSAGE_TEMP),'{0}','Customer'),'{1}',TRIM(LOAN_AMT)),'{2}',TRIM(EXPECTED_PAY_DATE)), 'LOAN_ALERT');
			END IF;
			-- ====================================================================
			-- .output.
			-- ====================================================================		
			SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation successful."}';
			SELECT @JSON_O AS _JSON;
		END IF;
		COMMIT;
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================		
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	-- .===================================================================
	-- .RESET VARS
	-- .===================================================================
	SET @STMT_1           = NULL;
	SET @STMT_2           = NULL;
	SET @STMT_3           = NULL;
	SET @STMT_4           = NULL;		
	SET @MESSAGE_TEMP     = NULL;
	SET @NEXT_INTERVAL    = NULL;
	SET TIME_VAL          = NULL;
	SET HOUR_VAL          = NULL;
	SET MSISDN            = NULL;
	SET LOAN_AMT          = NULL;
	SET RECORD_ID         = NULL;
	SET DIFF_IN_SECOND    = NULL;
	SET NOFICATION_COUNT  = NULL;	
	SET EXPECTED_PAY_DATE = NULL;
END$$
DELIMITER; //
