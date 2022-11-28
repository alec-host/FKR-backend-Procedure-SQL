DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_investment`.`sProcSysAlternativeMarketAlertToSeller`(
	IN `MSISDN` VARCHAR(15),
	IN `ASSET_NAME` VARCHAR(20),
	IN `DURATION` VARCHAR(5),
	IN `OFFER_PRICE` DECIMAL(15,2),
	IN `ALERT_MSG` VARCHAR(160)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	-- ====================================================================
	-- .Params.
	-- .@REC_ID.
	-- .@MSISDN.
	-- .@DAY_DIF(pre-calculated).
	-- .@OFFER_PRICE(pre-calculated).
	-- .@ALERT_MSG(set to "")
	-- ====================================================================
	DECLARE MESSAGE VARCHAR(160);
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
	IF(TRIM(MSISDN) != "" OR TRIM(ASSET_NAME) != "" OR TRIM(DURATION) != "" OR TRIM(OFFER_PRICE) != "") THEN
		-- ====================================================================
		-- .vars.
		-- ====================================================================
		IF(TRIM(ALERT_MSG) = "") THEN
			SET MESSAGE = CONCAT("I have made an offer to purchase your ",UCASE(ASSET_NAME)," share(s) for ",TRIM(OFFER_PRICE)," per unit. The offer expires in 3hours.");
		ELSE
			SET MESSAGE = TRIM(ALERT_MSG);
	        END IF;
		-- ====================================================================
		-- .statement 0.
		-- ====================================================================
		SET @STMT_0 = CONCAT("SELECT COUNT(`_id`) INTO @HEAP_SIZE FROM `db_freknur_investment`.`tbl_sale_request_queue` WHERE `is_processed` = 0 ");
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
                -- ====================================================================
                -- .do we have requests to process
                -- ====================================================================
		IF(@HEAP_SIZE > "0") THEN
		-- ====================================================================
		-- .statement 1.
		-- ====================================================================
		SET @STMT_1 = CONCAT("SELECT ",
			             "`_id`,`msisdn`,`uid`,DATEDIFF(DATE(NOW()),DATE(`date_created`)) ",
			             "INTO ",
			             "@REC_ID,@MSISDN,@ASSET_ID,@DAY_DIFF ",
			             "FROM ",
				     "`db_freknur_investment`.`tbl_sale_request_queue` ",
				     "WHERE ",
			             "`is_processed` = 0 ",
				     "LIMIT 1");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;  
		-- ====================================================================
		-- .check duration in days that has elapsed.
		-- ====================================================================
		IF(@DAY_DIFF >= DURATION) THEN
			-- ====================================================================
			-- .procedure call.
			-- ====================================================================
			CALL `db_freknur_loan`.`sProcQueueNotification`(TRIM(@MSISDN), MESSAGE, "SYS_ALERT");
			-- ====================================================================
			-- .statement 2.
			-- ====================================================================
			SET @STMT_2 = CONCAT("UPDATE ",
					     "`db_freknur_investment`.`tbl_sale_request_queue` ",
					     "SET ",
					     "`date_modified` = NOW(),`is_processed` = 1 ",
					     "WHERE ",
					     "`_id` = '",TRIM(@REC_ID),"'");
			PREPARE QUERY FROM @STMT_2;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .statement 3.
			-- ====================================================================
			SET @STMT_3 = CONCAT("DELETE ",
			                     "FROM ",
					     "`db_freknur_investment`.`tbl_sale_request` ",
					     "WHERE ",
					     "`msisdn` = '",TRIM(@MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = 0");
			PREPARE QUERY FROM @STMT_3;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;
		END IF;
		-- ====================================================================
		-- .output.
		-- ====================================================================	
		SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation was successful."}';
		SELECT CONCAT(@DAY_DIFF,'   ', DURATION) AS _JSON;
                END IF;			
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================	
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:DURATION needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	-- ====================================================================
	-- .commit transaction.
	-- ====================================================================
	COMMIT;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================
	SET @JSON_O     = NULL;	
	SET @STMT_0     = NULL;
	SET @STMT_1     = NULL;
	SET @STMT_2     = NULL;
	SET @STMT_3     = NULL;
	SET @DAY_DIFF   = NULL;
	SET @MSISDN     = NULL;
	SET @REC_ID     = NULL;
	SET @ASSET_ID   = NULL;
        SET @HEAP_SIZE  = NULL;
	SET OFFER_PRICE = NULL;
	SET ASSET_NAME  = NULL;
	SET ALERT_MSG   = NULL;
	SET MESSAGE     = NULL;
END$$
DELIMITER; //
