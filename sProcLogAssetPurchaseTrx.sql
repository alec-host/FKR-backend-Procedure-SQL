DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_investment`.`sProcLogAssetPurchaseTrx`(
	IN `MSISDN` VARCHAR(20),
	IN `ASSET_ID` VARCHAR(50),
	IN `ASSET_NAME` VARCHAR(50),
	IN `PRICE` DECIMAL(15,8),
	IN `QTY` DECIMAL(15,8),
	IN `WALLET_BAL` DECIMAL(15,8),
	IN `TOTAL_COST` DECIMAL(15,8),
	IN `FEE_EARNED` DECIMAL(15,8)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	-- ====================================================================
	-- .Params.
	-- .@MSISDN.
	-- .@ASSET_ID.
	-- .@ASSET_NAME.
	-- .@PRICE.
	-- .@QTY.
	-- .@WALLET_BAL.
	-- .@TOTAL_COST.
	-- .@FEE_EARNED.
	-- ====================================================================
	DECLARE PARTICULARS VARCHAR(100);
	DECLARE REFERENCE VARCHAR(100);
	DECLARE ACTIVITY_REF VARCHAR(100);
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
	IF(TRIM(MSISDN) != "" OR TRIM(ASSET_ID) != "" OR TRIM(ASSET_NAME) != "" OR TRIM(PRICE) != "" OR TRIM(QTY) != "" OR  TRIM(WALLET_BAL) != "" OR TRIM(TOTAL_COST) != "" OR TRIM(FEE_EARNED) != "") THEN
		-- ====================================================================
		-- .variables.
		-- ====================================================================
		SET REFERENCE   = UCASE(CONCAT("GRN",SUBSTRING(MD5(UUID_SHORT()),1,8),"0A"));
		SET PARTICULARS = CONCAT(UCASE(ASSET_NAME)," ",ROUND(TRIM(QTY),2)," SHARES PURCHASED @.",ROUND(TRIM(TOTAL_COST),2));
		-- select "hello world" as p;
		-- ====================================================================
		-- .create book keeping accounts.
		-- ====================================================================
		CALL `db_freknur_investment`.`sProcInitChartOfAccount`();
		-- ====================================================================
		-- .sql statement 1: log trx.
		-- ====================================================================
		SET @STMT_1 = CONCAT("INSERT ",
		                     "INTO ",
		                     "`db_freknur_investment`.`tbl_statement` ",
			             "(`msisdn`,`description`,`unit_price`,`number_of_share`,`cost`,`running_bal`) ",
				     "VALUES ",
			             "('",TRIM(MSISDN),"','",TRIM(ASSET_NAME),"','",TRIM(PRICE),"','",TRIM(QTY),"','",ROUND(TRIM(TOTAL_COST),8),"','",ROUND(TRIM(WALLET_BAL),8),"')");                    
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- select "hello world" as p;
		-- ====================================================================
		-- .sql statement 2: update wallet bal.
		-- ====================================================================
		-- select "hello world" as p;	
		SET @STMT_2 = CONCAT("UPDATE ",
			             "`db_freknur_loan`.`tbl_wallet` ",
				     "SET ",
			             "balance = '",ROUND(TRIM(WALLET_BAL),8),"'",
				     "WHERE ",
		                     "`msisdn` = '",TRIM(MSISDN),"'");                    
		PREPARE QUERY FROM @STMT_2;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;	
		-- select "hello world" as p;
		-- ====================================================================
		-- .sql statement 3: log trx.
		-- ====================================================================				
		SET @STMT_3 = CONCAT("INSERT ",
		                     "INTO ",
				     "`db_freknur_loan`.`tbl_wallet_transaction` ",
		                     "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
				     "VALUES ",
			             "('",TRIM(REFERENCE),"','",TRIM(MSISDN),"','",ROUND(TRIM(TOTAL_COST),8),"','",ROUND(TRIM(WALLET_BAL),8),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
		PREPARE QUERY FROM @STMT_3;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- select "hello world" as p;			
		-- ====================================================================
		-- .sql statement 4: update assets.
		-- ====================================================================	
		SET @STMT_4 = CONCAT("UPDATE ",
			             "`db_freknur_investment`.`tbl_asset` ",
			             "SET ",
		                     "`total` = (`total` - '",TRIM(QTY),"'), `date_modified` = NOW() ",
			             "WHERE ",
			             "`uid` = '",TRIM(ASSET_ID),"'");                    
		PREPARE QUERY FROM @STMT_4;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .sql statement 5: govt tax.
		-- ====================================================================
		SET @STMT_5 = CONCAT("SELECT `tax` INTO @GOVT_LEVY FROM `db_freknur_investment`.`tbl_config`");
		PREPARE QUERY FROM @STMT_5;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .sql statement 6: account info.
		-- ====================================================================
		SET @STMT_6 = CONCAT("SELECT ", 
		                     "`account_code`,`balance` ",
		                     "INTO ",
		                     "@ACCOUNT_CODE,@BALANCE ",
		                     "FROM ",
		                     "`db_freknur_investment`.`tbl_account` ",
			             "WHERE ",
			             "`account_code` = 'INC'");
		PREPARE QUERY FROM @STMT_6;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- select "hello world 999999" as p;						
		-- ====================================================================
		-- .variables.
		-- ====================================================================	
		SET @GOVT_TAX    = (FEE_EARNED * @GOVT_LEVY);			
		SET PARTICULARS  = CONCAT("FEE OF ",ROUND((FEE_EARNED - @GOVT_TAX),2)," EARNED FROM SELL OF ",UCASE(ASSET_NAME)," SHARES");
		SET @NEW_BALANCE = (@BALANCE + (FEE_EARNED - @GOVT_TAX));
		-- ====================================================================
		-- .sql statement 7: log trx.
		-- ====================================================================
		SET @STMT_7 = CONCAT("INSERT ",
		                     "INTO ",
		                     "`db_freknur_investment`.`tbl_transaction` ",
				     "(`account_code`,`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
			             "VALUES ",
			             "('",@ACCOUNT_CODE,"','",TRIM(REFERENCE),"','",TRIM(MSISDN),"','",ROUND(TRIM(FEE_EARNED) - TRIM(@GOVT_TAX),2),"','",ROUND(TRIM(@NEW_BALANCE),2),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
		PREPARE QUERY FROM @STMT_7;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;	
		-- select "hello world 2222224555" as p;
		-- ====================================================================
		-- .sql statement 8: update accounts.
		-- ====================================================================
		SET @STMT_8 = CONCAT("UPDATE ",
			             "`db_freknur_investment`.`tbl_account` ",
			             "SET ",
			             "`balance` = ROUND((`balance` + '",TRIM(FEE_EARNED) - TRIM(@GOVT_TAX),"'),2),`date_modified` = NOW() ",
			             "WHERE ",
		                     "`account_code` = 'INC'");                     
		PREPARE QUERY FROM @STMT_8;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- select "hello world  bbbbbbbbbb" as p;
		-- ====================================================================
		-- .sql statement 9: account info.
		-- ====================================================================
		SET @STMT_9 = CONCAT("SELECT ",
		                     "`account_code`,`balance` ",
			             "INTO ",
		                     "@ACCOUNT_CODE,@BALANCE ",
			             "FROM ",
		                     "`db_freknur_investment`.`tbl_account` ",
			             "WHERE ",
		                     "`account_code` = 'FEE'");
		PREPARE QUERY FROM @STMT_9;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .calc cummulative govt tax.
		-- ====================================================================
		SET @NEW_BALANCE = (@BALANCE + @GOVT_TAX);
		SET PARTICULARS  = CONCAT("LEVY DEDUCTED FROM A FEE EARNED FROM SELL OF ",UCASE(ASSET_NAME)," SHARES");			
		-- ====================================================================
		-- .sql statement 8: log trx.@ACCOUNT_CODE_1,@NEW_BALANCE_1,@BALANCE_1
		-- ====================================================================
		SET @STMT_8 = CONCAT("INSERT ",
		                     "INTO ",
			             "`db_freknur_investment`.`tbl_transaction` ",
			             "(`account_code`,`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
			             "VALUES ",
			             "('",@ACCOUNT_CODE,"','",TRIM(REFERENCE),"','",TRIM(MSISDN),"','",ROUND(TRIM(@GOVT_TAX),2),"','",ROUND(TRIM(@NEW_BALANCE),2),"','",TRIM(PARTICULARS),"',NOW())");                     
		PREPARE QUERY FROM @STMT_8;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .sql statement 9: update accounts.
		-- ====================================================================
		SET @STMT_9 = CONCAT("UPDATE ",
		                     "`db_freknur_investment`.`tbl_account` ",
			             "SET ",
			             "`balance` = ROUND((`balance` + '",TRIM(@GOVT_TAX),"'),2),`date_modified` = NOW() ",
				     "WHERE ",
		                     "`account_code` = 'FEE'");                     
		PREPARE QUERY FROM @STMT_9;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .sql statement 10: record client asset portifolio.
		-- ====================================================================	
		SET @STMT_10 = CONCAT("SELECT ",
		                      "COUNT(`_id`) ",
				      "INTO ",
                                      "@HEAP_SIZE ",
			              "FROM ",
				      "`db_freknur_investment`.`tbl_owner_portfolio` ",
				      "WHERE ",
				      "`msisdn` ='",TRIM(MSISDN),"' AND `asset_id` = '",TRIM(ASSET_ID),"'");
                PREPARE QUERY FROM @STMT_10;
                EXECUTE QUERY;
                DEALLOCATE PREPARE QUERY; 
		-- ====================================================================
		-- .check param @HEAP_SIZE.
		-- ====================================================================									 
		IF(TRIM(@HEAP_SIZE) = "0") THEN
			-- ====================================================================
			-- .sql statement 11.01: record client asset portifolio.
			-- ====================================================================
			SET @STMT_11 = CONCAT("INSERT ",
			                      "`db_freknur_investment`.`tbl_owner_portfolio` ",
			                      "(`msisdn`,`asset_id`,`asset_acronym`,`number_of_asset`,`date_created`) ",
			                      "VALUES ",
			                      "('",TRIM(MSISDN),"','",TRIM(ASSET_ID),"','",TRIM(UCASE(ASSET_NAME)),"','",TRIM(QTY),"','",NOW(),"')");
                        PREPARE QUERY FROM @STMT_11;
                        EXECUTE QUERY;
                        DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .record client temp asset portifolio.
			-- ====================================================================
                        SET @STMT_14 = CONCAT("INSERT ",
                                              "`db_freknur_investment`.`tbl_owner_portfolio_temp_list` ",
                                              "(`msisdn`,`asset_id`,`asset_acronym`,`number_of_asset`,`date_created`) ",
                                              "VALUES ",
                                              "('",TRIM(MSISDN),"','",TRIM(ASSET_ID),"','",TRIM(UCASE(ASSET_NAME)),"','",TRIM(QTY),"','",NOW(),"')");
                        PREPARE QUERY FROM @STMT_14;
                        EXECUTE QUERY;
                        DEALLOCATE PREPARE QUERY;
		ELSE
			-- ====================================================================
			-- .sql statement 11.02: update client asset portifolio.
			-- ====================================================================
			SET @STMT_11 = CONCAT("UPDATE ",
			                      "`db_freknur_investment`.`tbl_owner_portfolio` ",
			                      "SET ",
			                      "`number_of_asset` = (`number_of_asset` + '",TRIM(QTY),"'), `date_modified` = NOW() ",
			                      "WHERE ",
			                      "`msisdn` = '",TRIM(MSISDN),"' AND `asset_id` = '",TRIM(ASSET_ID),"'");
                	PREPARE QUERY FROM @STMT_11;
                	EXECUTE QUERY;
                	DEALLOCATE PREPARE QUERY;
			-- ====================================================================
			-- .record customer temp asset portifolio.
			-- ====================================================================
                        SET @STMT_14 = CONCAT("UPDATE ",
                                              "`db_freknur_investment`.`tbl_owner_portfolio_temp_list` ",
                                              "SET ",
                                              "`number_of_asset` = (`number_of_asset` + '",TRIM(QTY),"'), `date_modified` = NOW() ",
                                              "WHERE ",
                                              "`msisdn` = '",TRIM(MSISDN),"' AND `asset_id` = '",TRIM(ASSET_ID),"'");
                        PREPARE QUERY FROM @STMT_14;
                        EXECUTE QUERY;
                        DEALLOCATE PREPARE QUERY;
		END IF;
		-- ====================================================================
		-- .sql statement 12: mark processed.
		-- ====================================================================
		SET @STMT_12 = CONCAT("UPDATE ",
		                      "`db_freknur_investment`.`tbl_purchase_request` ",
		                      "SET ",
		                      "`is_processed` = 1, `date_modified` = NOW() ",
		                      "WHERE ",
		                      "`msisdn` = '",TRIM(MSISDN),"' AND `uid` = '",TRIM(ASSET_ID),"' AND `is_processed` = 0");
		PREPARE QUERY FROM @STMT_12;
		EXECUTE QUERY;            
		DEALLOCATE PREPARE QUERY;	
		-- ====================================================================
		-- .activity log reference.
		-- ====================================================================
		SET ACTIVITY_REF = CONCAT("PURCHASE OF ",ROUND((QTY),2)," ",TRIM(ASSET_NAME)," DIGITAL ASSETS @ COST OF ",ROUND(TRIM(TOTAL_COST),2)," HAS BEEN MADE.");
		-- ====================================================================
		-- .sql statement 13: log activity.
		-- ====================================================================
		SET @STMT_13 = CONCAT("INSERT ",
		                      "INTO ",
		                      "`db_freknur_general`.`tbl_activity_log` ",
		                      "(`msisdn`,`activity`)",
		                      "VALUES ",
				      "('",TRIM(MSISDN),"','",TRIM(ACTIVITY_REF),"')");
		PREPARE QUERY FROM @STMT_13;
		EXECUTE QUERY;            
		DEALLOCATE PREPARE QUERY; 
		-- ====================================================================
		-- .output.
		-- ====================================================================	
		SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation was successful."}';
		SELECT @JSON_O AS _JSON;						
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================	
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:MSISDN|ASSET_ID|ASSET_NAME|PRICE|QTY|WALLET_BAL needs to be SET."}';
		SELECT @JSON_O AS _JSON;		
	END IF;
	-- ====================================================================
	-- .commit transaction.
	-- ====================================================================
	COMMIT;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================
	SET @ACCOUNT_CODE = NULL;
	SET @BALANCE = NULL;
	SET @NEW_BALANCE = NULL;
	SET @GOVT_TAX = NULL;
	SET @GOVT_LEVY = NULL;
	SET @JSON_O = NULL;	
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @STMT_5 = NULL;
	SET @STMT_6 = NULL;
	SET @STMT_7 = NULL;
	SET @STMT_8 = NULL;
	SET @STMT_9 = NULL;
	SET @STMT_10 = NULL;
	SET @STMT_10 = NULL;
	SET @STMT_11 = NULL;	
	SET @STMT_12 = NULL;
	SET @STMT_13 = NULL;
	SET @STMT_14 = NULL;
	SET @HEAP_SIZE = NULL;
	SET MSISDN = NULL;
	SET ASSET_ID = NULL;
	SET ASSET_NAME = NULL;
	SET PRICE = NULL;
	SET QTY = NULL;
	SET WALLET_BAL = NULL;	
	SET PARTICULARS = NULL;
	SET REFERENCE = NULL;
	SET ACTIVITY_REF = NULL;
	SET TOTAL_COST = NULL;
	SET FEE_EARNED = NULL;

END$$
DELIMITER; //
