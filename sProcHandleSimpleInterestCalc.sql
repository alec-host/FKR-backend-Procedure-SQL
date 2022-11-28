
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcHandleSimpleInterestCalc`(
	IN `PRINCIPLE_AMOUNT` DOUBLE(11,2),
	IN `TIME_IN_MONTH` DOUBLE(11,2),
	IN `RATE` DOUBLE(11,2),
	IN `MSISDN` VARCHAR(25)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	-- .===================================================================
	-- .MYSQL AGENT ALERT.
	-- .===================================================================	
	DECLARE INTEREST DOUBLE(11,2);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;

	IF(TRIM(PRINCIPLE_AMOUNT) != "0" OR TRIM(TIME_IN_MONTH) != "0" OR TRIM(RATE) != "0" OR TRIM(MSISDN) != "") THEN
		START TRANSACTION;
		-- .===================================================================
		-- .GET NEXT NOFICATION DATE.	
		-- .===================================================================
		SET @STMT_0 = CONCAT('SELECT DATE_ADD(NOW(),INTERVAL ',TIME_IN_MONTH,' MONTH) INTO @NEXT_INTERVAL');
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- .===================================================================
		-- .CALC SIMPLE INTEREST.	
		-- .===================================================================		
		SET INTEREST = (PRINCIPLE_AMOUNT * (TIME_IN_MONTH/12) * RATE) / 100;
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================	
		SET @STMT_1 = CONCAT('UPDATE ',
	                             '`db_freknur_general`.`tbl_defaulter` ',
				     'SET ',
				     '`cummulative_interest` = (`cummulative_interest` + ',INTEREST,'),`roll_count` = (`roll_count` + 1),`notification_date` = "',TRIM(@NEXT_INTERVAL),'", `date_modified` = NOW() ',
				     'WHERE ',
				     '`msisdn` = "',TRIM(MSISDN),'" AND `date_repaid` IS NULL AND `is_archived` = 0 AND TIMESTAMPDIFF(MINUTE,`notification_date`,NOW()) >= 0');                   
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .sql statement 2.
		-- ====================================================================			
		SET @STMT_2 = CONCAT('SELECT ',
		                     '(`loan_amount`+`cummulative_interest`),`cummulative_interest`',
		                     'INTO ',
		                     '@TOTAL_OUTSTANDING_LOAN,@CUMMULATIVE_INTEREST ',
		                     'FROM ',
	                     	     '`db_freknur_general`.`tbl_defaulter` ',
				     'WHERE ',
				     '`msisdn` = "',TRIM(MSISDN),'" AND `date_repaid` IS NULL AND `is_archived` = 0');	 						                   
		PREPARE QUERY FROM @STMT_2;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;			
		-- .===================================================================
		-- .GET MESSAGE TEMP.
		-- .===================================================================
		CALL `sProcLoadMessageTemplate`('DEFAULTER_ALERT', @MESSAGE_TEMP);
		-- .===================================================================
		-- .QUEUE NOTIFICATION.
		-- .===================================================================
		CALL `sProcQueueNotification`(TRIM(MSISDN),REPLACE(REPLACE(REPLACE(REPLACE(TRIM(@MESSAGE_TEMP),'{0}','CUSTOMER'),'{1}',TRIM(PRINCIPLE_AMOUNT)),'{2}',TRIM(@CUMMULATIVE_INTEREST)),'{3}',TRIM(@TOTAL_OUTSTANDING_LOAN)), 'DEFAULTER_ALERT');
		-- ====================================================================
		-- .output.
		-- ====================================================================		
		SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation successful."}';
		SELECT @JSON_O AS _JSON;		
		COMMIT;
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================		
		SET @JSON_O = '{"ERROR":"1","RESULT":"SUCCESS","MESSAGE":"Param must be checked."}';
		SELECT @JSON_O AS _JSON;		
	END IF;
	-- .===================================================================
	-- .RESET VARIABLES.
	-- .===================================================================
	SET @JSON_O                 = NULL;  
	SET @STMT_0                 = NULL;
	SET @STMT_1                 = NULL;
	SET @STMT_2                 = NULL;
	SET @NEXT_INTERVAL          = NULL;
	SET @MESSAGE_TEMP           = NULL;
	SET RATE                    = NULL;
	SET MSISDN                  = NULL;
	SET INTEREST                = NULL;	
	SET TIME_IN_MONTH           = NULL;
	SET PRINCIPLE_AMOUNT        = NULL;
	SET @CUMMULATIVE_INTEREST   = NULL;
	SET @TOTAL_OUTSTANDING_LOAN = NULL;

END$$
DELIMITER; //
