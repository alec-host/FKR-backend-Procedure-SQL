DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcWalletToWalletTransfer`(
	IN `AMOUNT` DOUBLE(15,2),
	IN `WALLET_BAL` DOUBLE(15,2),
	IN `MSISDN` VARCHAR(15),
	IN `BENEFICIARY_MSISDN` VARCHAR(15)
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
	-- .@WALLET_BAL.
	-- .@BENEFICIARY_MSISDN.
	-- ====================================================================
	DECLARE PARTICULARS_1 TEXT;
	DECLARE PARTICULARS_2 TEXT;
	DECLARE REFERENCE_NO TEXT;
        DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
        BEGIN
                GET DIAGNOSTICS CONDITION 1
                @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
                SELECT @p1 AS RETURNED_SQLSTATE, @p2 AS MESSAGE_TEXT;
                ROLLBACK;
                -- RESIGNAL;
        END;

	IF(TRIM(AMOUNT) != "" || TRIM(WALLET_BAL) != "" || TRIM(BENEFICIARY_MSISDN) != "") THEN
		-- ====================================================================
		-- .start transaction.
		-- ====================================================================
		START TRANSACTION;	
		IF(AMOUNT > "0" && AMOUNT <= WALLET_BAL) THEN
			IF(TRIM(MSISDN) != BENEFICIARY_MSISDN) THEN
				-- ====================================================================
				-- .do beneficiary a/c exist?
				-- ====================================================================
				SET @STMT_1 = CONCAT("SELECT COUNT(`balance`),`balance` INTO @EXIST,@BENEFICIARY_WALLET_BAL FROM `db_freknur_loan`.`tbl_wallet` WHERE `msisdn` = '",TRIM(BENEFICIARY_MSISDN),"'");
				PREPARE QUERY FROM @STMT_1;
				EXECUTE QUERY;
				DEALLOCATE PREPARE QUERY;
				IF(@EXIST > "0") THEN				
					-- ====================================================================
					-- .update wallet bal.
					-- ====================================================================	
					SET @STMT_2 = CONCAT("UPDATE `db_freknur_loan`.`tbl_wallet` SET `balance` = `balance` - '",TRIM(AMOUNT),"' WHERE `msisdn` = '",TRIM(MSISDN),"'");
					PREPARE QUERY FROM @STMT_2;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					-- ====================================================================
					-- .update beneficiary wallet bal.
					-- ====================================================================	
					SET @STMT_3 = CONCAT("UPDATE `db_freknur_loan`.`tbl_wallet` SET `balance` = `balance` + '",TRIM(AMOUNT),"' WHERE `msisdn` = '",TRIM(BENEFICIARY_MSISDN),"'");
					PREPARE QUERY FROM @STMT_3;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
                                        -- ====================================================================
                                        -- .generate a reference id.
                                        -- ==================================================================== 
					SET REFERENCE_NO = CONCAT('TRF-',UCASE(LEFT(UUID(),8)));
					-- ====================================================================
					-- .particulars.
					-- ====================================================================
					SET PARTICULARS_1 = CONCAT("RECEIVED: ",TRIM(AMOUNT), "FROM SENDER A/C: ",TRIM(MSISDN));
					-- ====================================================================
					-- .sql statement 4.
					-- ====================================================================
					SET @STMT_4 = CONCAT("INSERT ",
					                     "INTO ",
							     "`db_freknur_loan`.`tbl_wallet_transaction` ",
							     "(`reference_no`,`msisdn`,`cr`,`balance`,`narration`,`date_created`) ",
							     "VALUES ",
							     "('",TRIM(REFERENCE_NO),"','",TRIM(BENEFICIARY_MSISDN),"','",TRIM(AMOUNT),"','",(TRIM(@BENEFICIARY_WALLET_BAL) + TRIM(AMOUNT)),"','",PARTICULARS_1,"','",NOW(),"')");
					PREPARE QUERY FROM @STMT_4;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;
					-- ====================================================================
					-- .particulars.
					-- ====================================================================
					SET PARTICULARS_2 = CONCAT("TRANSFER: ",TRIM(AMOUNT), "HAS BEEN MOVED TO BENEFICIARY A/C: ",TRIM(BENEFICIARY_MSISDN));
					-- ====================================================================
					-- .sql statement 5.
					-- ====================================================================
					SET @STMT_5 = CONCAT("INSERT ",
					                     "INTO ",
							     "`db_freknur_loan`.`tbl_wallet_transaction` ",
							     "(`reference_no`,`msisdn`,`dr`,`balance`,`narration`,`date_created`) ",
							     "VALUES ",
							     "('",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(AMOUNT),"','",(TRIM(WALLET_BAL) - TRIM(AMOUNT)),"','",PARTICULARS_2,"','",NOW(),"')");
					PREPARE QUERY FROM @STMT_5;
					EXECUTE QUERY;
					DEALLOCATE PREPARE QUERY;	
					-- ====================================================================
					-- .output.
					-- ====================================================================
					SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Electronic cash movement to beneficiary successful."}';
					SELECT @JSON_O AS _JSON;
				ELSE
					-- ====================================================================
					-- .output.
					-- ====================================================================
					SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Beneficiary account does not exist."}';
					SELECT @JSON_O AS _JSON;
				END IF;
			ELSE
				-- ====================================================================
				-- .output.
				-- ====================================================================
				SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Invalid transaction: SENDER cannot be a BENEFICIARY."}';
				SELECT @JSON_O AS _JSON;				
			END IF;						
		ELSE
			-- ====================================================================
			-- .output.
			-- ====================================================================
			SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Transaction cannot be completed, insufficient balance."}';
			SELECT @JSON_O AS _JSON;
		END IF;
		COMMIT;
	ELSE
		-- ====================================================================
		-- .output.
		-- ====================================================================
		SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Param: AMOUNT|WALLET_BAL|BENEFICIARY_MSISDN needs to be SET."}';
		SELECT @JSON_O AS _JSON;
	END IF;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================
	SET @EXIST  = NULL;
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @STMT_3 = NULL;
	SET @STMT_4 = NULL;
	SET @STMT_5 = NULL;
	SET @JSON_O = NULL;
	SET @BENEFICIARY_WALLET_BAL = NULL;	
	SET AMOUNT  = NULL;
	SET MSISDN  = NULL;
	SET WALLET_BAL = NULL;
	SET BENEFICIARY_MSISDN = NULL;
	SET PARTICULARS_1 = NULL;	
	SET PARTICULARS_2 = NULL;
	SET REFERENCE_NO = NULL;
END$$
DELIMITER; //
