DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcHandleLoanNotification`()
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	-- .===================================================================
	-- .MYSQL AGENT ALERT.
	-- .===================================================================
	SET @STMT_1 = CONCAT('SELECT ',
			     '`id`, ',
   			     'TIMESTAMPDIFF(SECOND,`next_notification_date`,NOW()) AS diff, ',
			     '`notification_count`, ',
			     'DATE_SUB(`expected_repayment_date`,INTERVAL 6 HOUR) AS alert_1, ',
			     'DATE_SUB(`expected_repayment_date`,INTERVAL 4 HOUR) AS alert_2, ',
			     'DATE_SUB(`expected_repayment_date`,INTERVAL 2 HOUR) AS alert_3, ',
			     'DATE_SUB(`expected_repayment_date`,INTERVAL 1 HOUR) AS alert_4, ',
			     '`msisdn`, ',
			     '`repayment_amount`, ',
			     '`expected_repayment_date` '
			     'INTO ',
			     '@RECORD_ID, ',
			     '@BLAST_IN_SECOND, ',
			     '@ALERT_COUNT, ',
			     '@ALERT_4, ',
			     '@ALERT_3, ',
			     '@ALERT_2,  ',
			     '@ALERT_1,  ',
			     '@MSISDN,  ',
			     '@LOAN_AMT, ',
		             '@EXPECTED_PAY_DATE ' 
			     'FROM ',
			     '`tbl_debtor` ',
			     'WHERE `is_repaid` = 0 AND `is_archived` = 0 ',
			     'LIMIT 1');
	PREPARE QUERY FROM @STMT_1;
	EXECUTE QUERY;
	DEALLOCATE PREPARE QUERY;
	-- .===================================================================
	-- .GET MESSAGE TEMP.
	-- .===================================================================
	CALL `sProcLoadMessageTemplate`('LOAN_ALERT', @MESSAGE_TEMP);
        -- .===================================================================
        -- .FORMAT PAY DATE.
        -- .===================================================================			
        SET @EXPECTED_PAY_DATE = REPLACE(TRIM(@EXPECTED_PAY_DATE),' ',' @ ');
	-- .===================================================================
	-- .CONDITION.
	-- .===================================================================
	IF(@BLAST_IN_SECOND >= '0') THEN
		IF(@ALERT_COUNT = '0') THEN
			SET @STMT_2 = CONCAT('UPDATE ',
			                     '`tbl_debtor` ',
				             'SET ',
				             '`notification_count` = (`notification_count` + 1), next_notification_date = "',TRIM(@ALERT_1),'"  ',
					     'WHERE ',
					     '`msisdn` = "',TRIM(@MSISDN),'" AND `id` = "',TRIM(@RECORD_ID),'"');
			-- .===================================================================
			-- .QUEUE NOTIFICATION.
			-- .===================================================================
			CALL `sProcQueueNotification`(TRIM(@MSISDN),REPLACE(REPLACE(@MESSAGE_TEMP,'{0}','User'),'{1}',@EXPECTED_PAY_DATE), 'LOAN_ALERT');					
		ELSEIF(@ALERT_COUNT = '1') THEN
			SET @STMT_2 = CONCAT('UPDATE ',
			                     '`tbl_debtor` ',
			                     'SET ',
			                     '`notification_count` = (`notification_count` + 1), next_notification_date = "',TRIM(@ALERT_2),'"  ',
				             'WHERE ',
				             '`msisdn` = "',TRIM(@MSISDN),'" AND `id` = "',TRIM(@RECORD_ID),'"');	
			-- .===================================================================
			-- .QUEUE NOTIFICATION.
			-- .===================================================================
			CALL `sProcQueueNotification`(TRIM(@MSISDN),REPLACE(REPLACE(@MESSAGE_TEMP,'{0}','User'),'{1}',@EXPECTED_PAY_DATE), 'LOAN_ALERT');										
		ELSEIF(@ALERT_COUNT = '2') THEN
			SET @STMT_2 = CONCAT('UPDATE ',
			                     '`tbl_debtor` ',
					     'SET ',
					     '`notification_count` = (`notification_count` + 1), next_notification_date = "',TRIM(@ALERT_3),'" ',
					     'WHERE ',
					     '`msisdn` = "',TRIM(@MSISDN),'" AND `id` = "',TRIM(@RECORD_ID),'"');	
			-- .===================================================================
			-- .QUEUE NOTIFICATION.
			-- .===================================================================
			CALL `sProcQueueNotification`(TRIM(@MSISDN),REPLACE(REPLACE(@MESSAGE_TEMP,'{0}','User'),'{1}',@EXPECTED_PAY_DATE), 'LOAN_ALERT');
		ELSEIF(@ALERT_COUNT = '3') THEN
			SET @STMT_2 = CONCAT('UPDATE ',
			                     '`tbl_debtor` ',
				             'SET ',
					     '`notification_count` = (`notification_count` + 1), next_notification_date = "',TRIM(@ALERT_4),'" ',
				             'WHERE ',
				             '`msisdn` = "',TRIM(@MSISDN),'" AND `id` = "',TRIM(@RECORD_ID),'"');	
			-- .===================================================================
			-- .QUEUE NOTIFICATION.
			-- .===================================================================
			CALL `sProcQueueNotification`(TRIM(@MSISDN),REPLACE(REPLACE(@MESSAGE_TEMP,'{0}','User'),'{1}',@EXPECTED_PAY_DATE), 'LOAN_ALERT');										
		ELSE	
			IF(@ALERT_COUNT = '4')	THEN
				-- .===================================================================
				-- .LIST LOANEE AS DEFAULTER.
				-- .===================================================================
				SET @STMT_2 =	CONCAT('INSERT ',
				                       'INTO ',
						       '`db_freknur_general`.`tbl_defaulter` ',
						       '(`msisdn`,`loan_amount`,`expected_repayment_date`,`date_created`) ',
						       'VALUES ',
						       '("',TRIM(@MSISDN),'","',TRIM(@LOAN_AMT),'","',TRIM(@EXPECTED_PAY_DATE),'","',NOW(),'")');						 
				-- .===================================================================
				-- .KNOCK OF THE RECORD.
				-- .===================================================================
				SET @STMT_3 =	CONCAT('UPDATE `tbl_debtor` SET `is_archived` = 1 WHERE `msisdn` = "',TRIM(@MSISDN),'" AND `id` = ',TRIM(@RECORD_ID),'');
				SELECT @STMT_3;
				PREPARE QUERY FROM @STMT_3;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
			END IF;
		END IF;
		-- .===================================================================
		-- .EXECUTE STMT 2.
		-- .===================================================================
		PREPARE QUERY FROM @STMT_2;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
	END IF;
	-- .===================================================================
	-- .RESET VARS
	-- .===================================================================
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;	
	SET @MSISDN = NULL;
	SET @ALERT_4 = NULL;
	SET @ALERT_3 = NULL;
	SET @ALERT_2 = NULL;
	SET @ALERT_1 = NULL;
	SET @LOAN_AMT = NULL;
	SET @RECORD_ID = NULL;
	SET @ALERT_COUNT = NULL;
	SET @MESSAGE_TEMP = NULL;
	SET @BLAST_IN_SECOND = NULL;
	SET @EXPECTED_PAY_DATE = NULL;
	
END$$
DELIMITER; //
