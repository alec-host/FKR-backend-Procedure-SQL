DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_investment`.`sProcHandlePurchaseRequestFromAltMarket`(
	IN `BUY_MSISDN` VARCHAR(20),
	IN `REQUEST_QTY` DECIMAL(15,8),
	IN `ASSET_NAME` VARCHAR(15),
        IN `ASSET_UID` VARCHAR(15), 
	IN `PRICE` DECIMAL(15,8),
	IN `CURRENT_BUYER_WALLET_BAL` DECIMAL(15,8),
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
	-- .@BUY_MSISDN.
	-- .@REQUEST_QTY.
	-- .@ASSET_NAME.
        -- .@ASSET_UID.
	-- .@PRICE.
	-- .@CURRENT_BUYER_WALLET_BAL(pre-calculated).
	-- .@TOTAL_COST(pre-calculated).
	-- .@FEE_EARNED(pre-calculated).
	-- ====================================================================
	DECLARE REMINDER_QTY DECIMAL(8,2);
        DECLARE ASSET_IN_HAND_QTY DECIMAL(8,2);
	DECLARE REFERENCE VARCHAR(100);
	DECLARE PARTICULARS VARCHAR(100);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		GET DIAGNOSTICS CONDITION 1
		@p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
		ROLLBACK;
		RESIGNAL;
	END;
	-- ====================================================================
	-- .start transaction.
	-- ====================================================================
	START TRANSACTION;	
	IF(TRIM(BUY_MSISDN) != "" OR TRIM(REQUEST_QTY) != "" OR TRIM(ASSET_NAME) != "" OR TRIM(PRICE) != "" OR TRIM(CURRENT_BUYER_WALLET_BAL) != "" OR TRIM(TOTAL_COST) != "" OR TRIM(FEE_EARNED) != "" OR TRIM(ASSET_UID) != "") THEN
		-- ====================================================================
		-- .variables.
		-- ====================================================================
		SET REFERENCE   = UCASE(CONCAT("BID",SUBSTRING(MD5(UUID_SHORT()),1,8),"0P"));
		SET PARTICULARS = CONCAT(UCASE(ASSET_NAME)," SHARES PURCHASED FROM ALTERNATIVE MARKET @.",TOTAL_COST);
		-- ====================================================================
		-- .statement 0.
		-- ====================================================================
		SET @STMT_0 = CONCAT("SELECT ",
				     "COUNT(`msisdn`) ",
				     "INTO ",
				     "@HEAP_SIZE "
				     "FROM ",
		                     "`db_freknur_investment`.`tbl_sale_request_queue` ",
			             "WHERE ",
				     "`is_processed` = 0 AND `msisdn` != '",TRIM(BUY_MSISDN),"'");
		PREPARE QUERY FROM @STMT_0;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		SELECT @HEAP_SIZE AS p;
                -- ====================================================================
                -- .do we have requests?
                -- ====================================================================
                IF(@HEAP_SIZE > 0) THEN
			-- ====================================================================
			-- .statement 1.
			-- ====================================================================
			SET @STMT_1 = CONCAT("SELECT ",
			             	     "`msisdn`,`no_of_grain_sold`,`uid`,`unit_price` ",
				             "INTO ",
				             "@OWNER_MSISDN,@OWNER_QTY,@ASSET_ID,@SELLING_PRICE "
	                                     "FROM ",
	                                     "`db_freknur_investment`.`tbl_sale_request_queue` ",
	                                     "WHERE ",
	                                     "`is_processed` = 0 AND `msisdn` != '",TRIM(BUY_MSISDN),"' AND `uid` = '",TRIM(ASSET_UID),"'",
				             "ORDER BY ",
				             "`date_created` ASC ",
				             "LIMIT 1");
			PREPARE QUERY FROM @STMT_1;
			EXECUTE QUERY;
			DEALLOCATE PREPARE QUERY;

			SET REMINDER_QTY = (@OWNER_QTY - REQUEST_QTY);

			SELECT  CONCAT(REMINDER_QTY,"|", @SELLING_PRICE,"|",PRICE,"|",ROUND(TRIM(REMINDER_QTY)*TRIM(PRICE),2)) AS P;
		        -- ====================================================================
                        -- .is the request greater than 0?
                        -- ====================================================================
		        IF(REQUEST_QTY > 0) THEN
                        IF(PRICE = @SELLING_PRICE) THEN           
				IF(REMINDER_QTY = 0) THEN
					-- ====================================================================
					-- .remove request log.
					-- ====================================================================
					SET @STMT_2 = CONCAT("DELETE ",
						             "FROM ",
			                                     "`db_freknur_investment`.`tbl_sale_request` ",
			                                     "WHERE ",
			                                     "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
					PREPARE QUERY FROM @STMT_2;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
                                        -- ====================================================================
                                        -- .remove request log.
                                        -- ====================================================================
                                        SET @STMT_20 = CONCAT("DELETE ",
                                                              "FROM ",
                                                              "`db_freknur_investment`.`tbl_sale_request_queue` ",
                                                              "WHERE ",
                                                              "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
                                        PREPARE QUERY FROM @STMT_20;
                                        EXECUTE QUERY;
                                        DEALLOCATE PREPARE QUERY;
                                	-- ====================================================================
					-- .remove request log.
                                	-- ====================================================================
                                	SET @STMT_21 = CONCAT("DELETE ",
                                                              "FROM ",
                                                      	      "`db_freknur_investment`.`tbl_alternate_market_bid` ",
                                                              "WHERE ",
                                                              "`msisdn` = '",TRIM(BUY_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
                                	PREPARE QUERY FROM @STMT_21;
                                	EXECUTE QUERY;
                                	DEALLOCATE PREPARE QUERY;
				ELSE
					
					IF(REMINDER_QTY > 0) THEN
                                                -- ====================================================================
                                                -- .re-adjust no_of_grain_sold.
                                                -- ====================================================================
                                                SET @STMT_2 = CONCAT("UPDATE ",
                                                                     "`db_freknur_investment`.`tbl_sale_request` ",
                                                                     "SET ",
                                                                     "`no_of_grain_sold` = '",TRIM(REMINDER_QTY),"',`cost` = '",ROUND(TRIM(REMINDER_QTY)*TRIM(PRICE),2),"',`date_modified`= NOW() ",
                                                                     "WHERE ",
                                                                     "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
                                                PREPARE QUERY FROM @STMT_2;
                                                EXECUTE QUERY;
                                                DEALLOCATE PREPARE QUERY;
						-- ====================================================================
						-- .re-adjust no_of_grain_sold.
						-- ====================================================================
						SET @STMT_20 = CONCAT("UPDATE ",
			                                              "`db_freknur_investment`.`tbl_sale_request_queue` ",
			                                              "SET ",
			                                	      "`no_of_grain_sold` = '",TRIM(REMINDER_QTY),"',`cost` = '",ROUND(TRIM(REMINDER_QTY)*TRIM(PRICE),2),"',`date_modified`= NOW() ",
			                                              "WHERE ",
			                                              "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `uid` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");                   
						PREPARE QUERY FROM @STMT_20;
						EXECUTE QUERY;
						DEALLOCATE PREPARE QUERY;
                                                -- ====================================================================
                                                -- .size of request.
                                                -- ====================================================================
						IF(REQUEST_QTY <= @OWNER_QTY) THEN
                                                        -- ====================================================================
                                                        -- .remove request log.
                                                        -- ====================================================================
							SET @STMT_21 = CONCAT("DELETE ",
									      "FROM ",
									      "`db_freknur_investment`.`tbl_alternate_market_bid` ",
									      "WHERE ",
									      "`msisdn` = '",TRIM(BUY_MSISDN),"'");
							PREPARE QUERY FROM @STMT_21;
							EXECUTE QUERY;
							DEALLOCATE PREPARE QUERY;
						ELSE
                                			-- ====================================================================
                                			-- .re-adjust qty.
                                			-- ====================================================================
                                			SET @STMT_21 = CONCAT("UPDATE ",
                                                      		              "`db_freknur_investment`.`tbl_alternate_market_bid` ",
                                                                              "SET ",
                                                                              "`qty` = '",TRIM(REMINDER_QTY),"',`cost` = '",ROUND(TRIM(REMINDER_QTY)*TRIM(PRICE),2),"',`date_modified`= NOW() ",
                                                                              "WHERE ",
                                                                              "`msisdn` = '",TRIM(BUY_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"' AND `is_processed` = '0'");
                                			PREPARE QUERY FROM @STMT_21;
                                			EXECUTE QUERY;
                                			DEALLOCATE PREPARE QUERY;
					        END IF;
					END IF;
				END IF;
			       

				IF(REMINDER_QTY >= 0) THEN
				        -- ====================================================================
                                        -- .track owner portfolio.
                                        -- ====================================================================
                       	 		SET @STMT_3 = CONCAT("SELECT ",
                                             		     "`number_of_asset` ",
                                                             "INTO ",
                                                             "@PORTFOLIO_QTY ",
                                                             "FROM ",
                                                             "`db_freknur_investment`.`tbl_owner_portfolio` ",
                                                             "WHERE ",
                                                             "`asset_id` = '",TRIM(@ASSET_ID),"' AND `msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `lock` = 0");
                        		PREPARE QUERY FROM @STMT_3;
                        		EXECUTE QUERY;
                        		DEALLOCATE PREPARE QUERY;

				        SET ASSET_IN_HAND_QTY = (@PORTFOLIO_QTY - REQUEST_QTY);

		                        IF(ASSET_IN_HAND_QTY > 0) THEN
						-- ====================================================================
						-- .re-adjust owner's asset portifolio.
						-- ====================================================================
						SET @STMT_22 = CONCAT("UPDATE ",
							             "`db_freknur_investment`.`tbl_owner_portfolio` ",
							             "SET ",
								     "`number_of_asset` = '",ROUND(TRIM(ASSET_IN_HAND_QTY),2),"',`date_modified` = NOW() ",
								     "WHERE ",
								     "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"'");
						PREPARE QUERY FROM @STMT_22;
						EXECUTE QUERY;
						DEALLOCATE PREPARE QUERY;
		                        ELSE
						-- ====================================================================
						-- .remove asset from owner portifolio list..
						-- ====================================================================
						SET @STMT_22 = CONCAT("DELETE ",
								      "FROM ",
								      "`db_freknur_investment`.`tbl_owner_portfolio` ",
								      "WHERE ",
								      "`msisdn` = '",TRIM(@OWNER_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"'");
						PREPARE QUERY FROM @STMT_22;
						EXECUTE QUERY;
						DEALLOCATE PREPARE QUERY;
                                        END IF;
					-- ====================================================================
					-- .create book keeping accounts.
					-- ====================================================================
					CALL `db_freknur_investment`.`sProcInitChartOfAccount`();		
					-- ====================================================================
					-- .sql statement 4: log trx.
					-- ====================================================================
					SET @STMT_4 = CONCAT("INSERT ",
			                                     "INTO ",
					                     "`db_freknur_investment`.`tbl_statement` ",
				                             "(`msisdn`,`description`,`unit_price`,`number_of_share`,`cost`,`running_bal`) ",
		                                             "VALUES ",
					                     "('",TRIM(BUY_MSISDN),"','",TRIM(ASSET_NAME),"','",ROUND(TRIM(PRICE),2),"','",ROUND(TRIM(REQUEST_QTY),2),"','",ROUND(TRIM(TOTAL_COST),2),"','",ROUND(TRIM(CURRENT_BUYER_WALLET_BAL),2),"')");                    
					PREPARE QUERY FROM @STMT_4;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					-- ====================================================================
					-- .sql statement 5: update buyer wallet bal.
					-- ====================================================================
					SET @STMT_5 = CONCAT("UPDATE ",
			                                     "`db_freknur_loan`.`tbl_wallet` ",
					                     "SET ",
			                                     "`balance` = '",ROUND(TRIM(CURRENT_BUYER_WALLET_BAL),2),"',`date_modified` = NOW() ",
				                             "WHERE ",
				                             "`msisdn` = '",TRIM(BUY_MSISDN),"'");                    
					PREPARE QUERY FROM @STMT_5;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					-- ====================================================================
					-- .sql statement 6: update seller wallet bal.
					-- ====================================================================
					SET @STMT_6 = CONCAT("UPDATE ",
				            		     "`db_freknur_loan`.`tbl_wallet` ",
				                             "SET ",
				                             "`balance` = ROUND((`balance`+'",TRIM(TOTAL_COST),"'),2),`date_modified` = NOW() ",
				                             "WHERE ",
			                                     "`msisdn` = '",TRIM(@OWNER_MSISDN),"'");                    
					PREPARE QUERY FROM @STMT_6;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;			
					-- ====================================================================
					-- .sql statement 7: log trx.
					-- ====================================================================
					SET @STMT_7 = CONCAT("INSERT ",
			                     		     "INTO ",
				                             "`db_freknur_loan`.`tbl_wallet_transaction` ",
				                             "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
					                     "VALUES ",
				                             "('",TRIM(REFERENCE),"','",TRIM(BUY_MSISDN),"','",ROUND(TRIM(TOTAL_COST),8),"','",ROUND(TRIM(CURRENT_BUYER_WALLET_BAL),8),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
					PREPARE QUERY FROM @STMT_7;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					-- ====================================================================
					-- .sql statement 8: govt tax.
					-- ====================================================================
					SET @STMT_8 = CONCAT("SELECT `tax` INTO @GOVT_LEVY FROM `db_freknur_investment`.`tbl_config`");
					PREPARE QUERY FROM @STMT_8;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
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
				                             "`account_code` = 'INC'");
					PREPARE QUERY FROM @STMT_9;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;						
			                -- ====================================================================
					-- .variables.
					-- ====================================================================
					SET @GOVT_TAX    = (FEE_EARNED * @GOVT_LEVY);			
					SET PARTICULARS  = CONCAT("FEE OF ",ROUND((FEE_EARNED - @GOVT_TAX),2)," EARNED FROM PURCHASE OF ",UCASE(ASSET_NAME)," SHARES");
					SET @NEW_BALANCE = (@BALANCE + (FEE_EARNED - @GOVT_TAX));
					-- ====================================================================
					-- .sql statement 10: log trx.
					-- ====================================================================
					SET @STMT_10 = CONCAT("INSERT ",
			                                      "INTO ",
					                      "`db_freknur_investment`.`tbl_transaction` ",
					                      "(`account_code`,`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
				                              "VALUES ",
			                                      "('",@ACCOUNT_CODE,"','",TRIM(REFERENCE),"','",TRIM(BUY_MSISDN),"','",ROUND(TRIM(FEE_EARNED) - TRIM(@GOVT_TAX),2),"','",ROUND(TRIM(@NEW_BALANCE),2),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
					PREPARE QUERY FROM @STMT_10;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					-- ====================================================================
					-- .sql statement 11: update accounts.
					-- ====================================================================
					SET @STMT_11 = CONCAT("UPDATE ",
				                              "`db_freknur_investment`.`tbl_account` ",
					                      "SET ",
					                      "`balance` = (`balance` + '",ROUND(TRIM(FEE_EARNED) - TRIM(@GOVT_TAX),2),"'),`date_modified` = NOW() ",
					                      "WHERE ",
				                              "`account_code` = 'INC'");                     
					PREPARE QUERY FROM @STMT_11;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					-- ====================================================================
					-- .sql statement 12: account info.
					-- ====================================================================
					SET @STMT_12 = CONCAT("SELECT ",
			                      		      "`account_code`,`balance` ",
				                              "INTO ",
			                                      "@ACCOUNT_CODE,@BALANCE ",
			                                      "FROM ",
					                      "`db_freknur_investment`.`tbl_account` ",
				                              "WHERE ",
				                              "`account_code` = 'FEE'");
					PREPARE QUERY FROM @STMT_12;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					-- ====================================================================
					-- .calc cummulative govt tax.
					-- ====================================================================
					SET @NEW_BALANCE = (@BALANCE + @GOVT_TAX);
					SET PARTICULARS  = CONCAT("LEVY DEDUCTED FROM A FEE EARNED FROM PURCHASE OF ",UCASE(ASSET_NAME)," SHARES");			
					-- ====================================================================
					-- .sql statement 13: log trx.
					-- ====================================================================
					SET @STMT_13 = CONCAT("INSERT ",
			                                      "INTO ",
					                      "`db_freknur_investment`.`tbl_transaction` ",
					                      "(`account_code`,`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
					                      "VALUES ",
					                      "('",@ACCOUNT_CODE,"','",TRIM(REFERENCE),"','",TRIM(BUY_MSISDN),"','",ROUND(TRIM(@GOVT_TAX),2),"','",ROUND(TRIM(@NEW_BALANCE),2),"','",TRIM(PARTICULARS),"','",NOW(),"')");                     
					PREPARE QUERY FROM @STMT_13;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;			
					-- ====================================================================
					-- .sql statement 14: update accounts.
					-- ====================================================================
					SET @STMT_14 = CONCAT("UPDATE ",
				                              "`db_freknur_investment`.`tbl_account` ",
			                                      "SET ",
				                              "`balance` = (`balance` + '",ROUND(TRIM(@GOVT_TAX),2),"'),`date_modified` = NOW() ",
			                                      "WHERE ",
					                      "`account_code` = 'FEE'");                     
					PREPARE QUERY FROM @STMT_14;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
				END IF;
				-- ====================================================================
				-- .sql statement 15: get buyer asset portifolio.
				-- ====================================================================	
				SET @STMT_15 = CONCAT("SELECT ",
				                      "COUNT(`_id`) ",
			                              "INTO ",
		                                      "@HEAP_PORTFOLIO_SIZE ",
			                              "FROM ",
					              "`db_freknur_investment`.`tbl_owner_portfolio` ",
					              "WHERE ",
					              "`msisdn` ='",TRIM(BUY_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"'");
				PREPARE QUERY FROM @STMT_15;
				EXECUTE QUERY;            
				DEALLOCATE PREPARE QUERY;
				-- ====================================================================
				-- .does portfolio exist.
				-- ====================================================================									 
				IF(TRIM(@HEAP_PORTFOLIO_SIZE) = 0) THEN
					-- ====================================================================
					-- .sql statement 16: record buyer asset portifolio.
					-- ====================================================================
					IF(REMINDER_QTY >= 0) THEN
						SET @STMT_16 = CONCAT("INSERT ",
					                              "`db_freknur_investment`.`tbl_owner_portfolio` ",
					                              "(`msisdn`,`asset_id`,`asset_acronym`,`number_of_asset`,`date_created`) ",
					                              "VALUES ",
					                              "('",TRIM(BUY_MSISDN),"','",TRIM(@ASSET_ID),"','",TRIM(UCASE(ASSET_NAME)),"','",ROUND(TRIM(REQUEST_QTY),8),"','",NOW(),"')");
					        PREPARE QUERY FROM @STMT_16;
						EXECUTE QUERY;            
						DEALLOCATE PREPARE QUERY;												 			
					END IF;										
				ELSE
					-- ====================================================================
					-- .is request greater than available qty.
					-- ====================================================================
					IF(REMINDER_QTY >= 0) THEN
						-- ====================================================================
						-- .sql statement 17: update buyer asset portifolio.
						-- ====================================================================
						SET @STMT_17 = CONCAT("UPDATE ",
					                              "`db_freknur_investment`.`tbl_owner_portfolio` ",
					                              "SET ",
					                              "`number_of_asset` = ROUND((`number_of_asset` + '",TRIM(REQUEST_QTY),"'),8), `date_modified` = NOW() ",
					                              "WHERE ",
					                              "`msisdn` = '",TRIM(BUY_MSISDN),"' AND `asset_id` = '",TRIM(@ASSET_ID),"'");	
						PREPARE QUERY FROM @STMT_17;
						EXECUTE QUERY;            
						DEALLOCATE PREPARE QUERY;
					END IF;			
				END IF;
                                -- ====================================================================
                                -- .variables.
                                -- ====================================================================
                                SET PARTICULARS = CONCAT(UCASE(ASSET_NAME)," SHARES SOLD @ ALTERNATIVE MARKET @.",ROUND(TOTAL_COST,2));
                                -- ====================================================================
                                -- .sql statement 18: select seller wallet bal.
                                -- ====================================================================
                                SET @STMT_18 = CONCAT("SELECT ",
                                                      "`balance` ",
                                                      "INTO ",
                                                      "@OWNER_BAL ",
                                                      "FROM ",
                                                      "`db_freknur_loan`.`tbl_wallet` ",
                                                      "WHERE ",
                                                      "`msisdn` = '",TRIM(@OWNER_MSISDN),"'");
                                PREPARE QUERY FROM @STMT_18;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
                                -- ====================================================================
                                -- .sql statement 19: log trx.
                                -- ====================================================================
                                SET @STMT_19 = CONCAT("INSERT ",
                                                      "INTO ",
                                                      "`db_freknur_loan`.`tbl_wallet_transaction` ",
                                                      "(`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
                                                      "VALUES ",
                                                      "('",TRIM(REFERENCE),"','",TRIM(@OWNER_MSISDN),"','",ROUND(TRIM(TOTAL_COST),2),"','",ROUND(TRIM(@OWNER_BAL),2),"','",TRIM(PARTICULARS),"','",NOW(),"')");
                                PREPARE QUERY FROM @STMT_19;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
				-- ====================================================================
				-- .output.
				-- ====================================================================	
				SET @JSON_O = CONCAT('{"ERROR":"0","RESULT":"SUCCESS","DATA":"',TRIM(@OWNER_MSISDN),'","MESSAGE":"Operation was successful."}');
				SELECT @JSON_O AS _JSON;
			ELSE
				-- ====================================================================
				-- .output.
				-- ====================================================================	
				SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"The price offer is less than the unit price of the asset."}';
				SELECT @JSON_O AS _JSON;		
			END IF;
		        ELSE									
                                -- ====================================================================
                                -- .output.
                                -- ==================================================================== 
                                SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Operation has failed 1."}';
                                SELECT @JSON_O AS _JSON;
                        END IF;		
		ELSE
			-- ====================================================================
			-- .output.
			-- ====================================================================
                	SET @JSON_O = CONCAT('{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Operation has failed 2."}');
                	SELECT @JSON_O AS _JSON;
		END IF;
                -- ====================================================================
                -- .delete request.
                -- ====================================================================
                SET @STMT_22 = CONCAT("DELETE ",
                                      "FROM ",
                                      "`db_freknur_investment`.`tbl_alternate_market_bid` ",
                                      "WHERE ",
                                      "`msisdn` = '",TRIM(BUY_MSISDN),"'");
                PREPARE QUERY FROM @STMT_22;
                EXECUTE QUERY;
                DEALLOCATE PREPARE QUERY;
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================	
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:BUY_MSISDN|REQUEST_QTY|ASSET_NAME|PRICE|TOTAL_COST|CURRENT_BUYER_WALLET_BAL needs to be SET."}';
		SELECT @JSON_O AS _JSON;																			   
	END IF;				   
	-- ====================================================================
	-- .commit transaction.
	-- ====================================================================
	COMMIT;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================
	SET @HEAP_SIZE    = NULL;
	SET @OWNER_QTY    = NULL;
	SET @OWNER_MSISDN = NULL;
	SET @ACCOUNT_CODE = NULL;
	SET @GOVT_TAX     = NULL;
	SET @GOVT_LEVY    = NULL;
	SET @BALANCE      = NULL;
	SET @OWNER_BAL    = NULL;
	SET @ASSET_ID     = NULL;
	SET @NEW_BALANCE  = NULL;
	SET @HEAP_SIZE    = NULL;
        SET @PORTFOLIO_QTY = NULL;
	SET @SELLING_PRICE = NULL;
	SET @HEAP_PORTFOLIO_SIZE = NULL;
	SET @STMT_1       = NULL;
	SET @STMT_1       = NULL;
	SET @STMT_2       = NULL;
	SET @STMT_3       = NULL;
	SET @STMT_4       = NULL;
	SET @STMT_5       = NULL;
	SET @STMT_6       = NULL;
	SET @STMT_7       = NULL;
	SET @STMT_8       = NULL;
	SET @STMT_9       = NULL;
	SET @STMT_10      = NULL;
	SET @STMT_11      = NULL;
	SET @STMT_12      = NULL;	
	SET @STMT_13      = NULL;
	SET @STMT_14      = NULL;
	SET @STMT_15      = NULL;
	SET @STMT_16      = NULL;	
	SET @STMT_17      = NULL;
	SET @STMT_18      = NULL;
	SET @STMT_19      = NULL;
	SET @STMT_20      = NULL;
	SET @STMT_21      = NULL;
        SET @STMT_22      = NULL;
	SET PRICE         = NULL;
	SET BUY_MSISDN    = NULL;
	SET CURRENT_BUYER_WALLET_BAL = NULL;
	SET TOTAL_COST    = NULL;	
	SET ASSET_NAME    = NULL;
        SET ASSET_UID     = NULL; 
	SET REQUEST_QTY   = NULL;
	SET FEE_EARNED    = NULL;
	SET REFERENCE     = NULL;
	SET PARTICULARS   = NULL;
        SET ASSET_IN_HAND_QTY = NULL;		
END$$
DELIMITER;
