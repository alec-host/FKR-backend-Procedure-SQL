DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientAuthentication`(
	IN `MSISDN` VARCHAR(15),
	IN `PIN` VARCHAR(10)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	IF(TRIM(MSISDN) = "" || TRIM(PIN) = "") THEN
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid input","OPERATION":"Authentication","INFO":"0,0,0,0,0,0"}') AS json_result;
	ELSE
		SET @qry = CONCAT("SELECT ", 
                        "A.`FirstName`,A.`Language`,A.`PromotionNotificationFlag`,B.`Balance`,B.`Bonus`,A.`StakeCountTracker` ",
                        "INTO ",
                        "@FNAME,@LANG,@FLAG,@BAL,@BONUS,@STAKE_CNT_TRACKER "
                        "FROM ",
						      "`tbl_wallet` A ",
                        "INNER JOIN ",
                        "`tbl_wallet_ext` B ",
                        "ON ",
                        "A.`MSISDN` = B.`MSISDN` ",
                        "WHERE ",
                        "A.`MSISDN` = '",TRIM(MSISDN),"' AND B.`Password` ='",TRIM(PIN),"'");
						
		PREPARE stmt_1 FROM @qry;
		EXECUTE stmt_1;
		DEALLOCATE PREPARE stmt_1;
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		IF(@FNAME IS NOT NULL && @LANG IS NOT NULL && @FLAG IS NOT NULL && @BAL IS NOT NULL && @BONUS IS NOT NULL && @STAKE_CNT_TRACKER IS NOT NULL) THEN
			SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Authentication","INFO":"',CONCAT(@FNAME,",",@LANG,",",@FLAG,",",@BAL,",",@BONUS,",",@STAKE_CNT_TRACKER),'"}') AS json_result;
		ELSE
			SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid MSISDN or Pin","OPERATION":"Authentication","INFO":"0,0,0,0,0,0"}') AS json_result;
		END IF;													
	END IF;
-- .=========================================
-- . RESET VARS
-- .=========================================
SET @qry = NULL;
SET @FNAME = NULL;
SET @LANG = NULL;
SET @FLAG = NULL;
SET @BAL = NULL;
SET @BONUS = NULL;
SET @STAKE_CNT_TRACKER = NULL;	

END$$;
DELIMITER; //


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientBalance`(
	IN `MSISDN` VARCHAR(50),
	IN `PIN` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
-- .=========================================
-- . Routine check customer's wallet balance & bonus.
-- .=========================================
IF(TRIM(MSISDN) = "" || TRIM(PIN) = "") THEN
	-- .=========================================
	-- . OUTPUT.
	-- .=========================================
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid input","OPERATION":"Check Balance","BALANCE":"0.00","BONUS":"0.00"}') AS json_result;
ELSE
	SET @qry = CONCAT("SELECT ",
	                  "B.Balance,B.Bonus ",
			  "INTO ",
		          "@BAL,@BONUS " 
		          "FROM ",
		          "tbl_wallet A ",
		          "INNER JOIN ",
		          "tbl_wallet_ext B ",
		          "ON ",
		          "A.MSISDN=B.MSISDN ",
			  "WHERE ",
			  "A.MSISDN = '",TRIM(MSISDN),"' AND B.Password = '",TRIM(PIN),"' AND A.IsLocked = '0'"); 
											  				   
	PREPARE stmt_1 FROM @qry;
	EXECUTE stmt_1;
	DEALLOCATE PREPARE stmt_1;	

	IF(@BAL IS NOT NULL && @BONUS IS NOT NULL) THEN
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"1","MESSAGE":"Success","OPERATION":"Check Balance","BALANCE":"',@BAL,'","BONUS":"',@BONUS,'"}') AS json_result;
	ELSE
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Wallet account does not EXIST","OPERATION":"Check Balance","BALANCE":"0.00","BONUS":"0.00"}') AS json_result;
	END IF;						   
END IF;
-- .=========================================
-- . RESET VARS
-- .=========================================
SET @qry = NULL;
SET MSISDN = NULL;
SET PIN = NULL;
SET @BAL = NULL;
SET @BONUS = NULL;

END$$;
DELIMITER; //


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientDeposit`(
	IN `MSISDN` VARCHAR(15),
	IN `MESSAGE` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	IF(TRIM(MSISDN) = "" || TRIM(MESSAGE) = "") THEN
		select "";
	ELSE
		select "";
	END IF;

END$$;
DELIMITER; //



DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientPlaceBet`(
	IN `MSISDN` VARCHAR(15),
	IN `BET_AMOUNT` DECIMAL(10,2)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	IF(TRIM(MSISDN) = "" || TRIM(BET_AMOUNT) = "") THEN
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"0","MESSAGE","Unsuccessful - Invalid Input","OPERATION":"Place a Bet"}') AS json_result;
	ELSE
		-- .=========================================
		-- . Check if MSISDN exist.
		-- .=========================================
	   SET @qry = CONCAT("SELECT ",
		                  "COUNT(A.`MSISDN`), B.`Balance` ",
							   "INTO ",
								"@USER_MSISDN, @CURRENT_BAL ",
								"FROM ",
								"`tbl_wallet` A ",
								"INNER JOIN ",
								"`tbl_wallet_ext` B ", 
								"ON ",
								"A.`MSISDN`=B.`MSISDN` ",
								"WHERE ",
								"A.`MSISDN` = '",TRIM(MSISDN),"'");
		PREPARE stmt FROM @qry;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt; 
		-- .=========================================
		-- . Update wallet balance.
		-- .=========================================	  
	   IF(@USER_MSISDN > "0") THEN
	   	IF(@CURRENT_BAL >= BET_AMOUNT) THEN
				SET @qry1 = CONCAT("UPDATE ",
				                   "`tbl_wallet` A ",
				                   "INNER JOIN ",
										 "`tbl_wallet_ext` B ",
									  	 "ON ",
										 "A.MSISDN = B.MSISDN ",
										 "SET ",
										 "A.`StakeCountTracker` = (A.`StakeCountTracker` + 1),",
										 "B.`Balance` = (B.`Balance` - '",TRIM(BET_AMOUNT),"'),",
										 "A.`DateModified` = '",NOW(),"'",
									  	 "WHERE ",
										 "A.`MSISDN` = '",TRIM(MSISDN),"' AND A.`IsLocked` = '0'");									
				PREPARE stmt_0 FROM @qry1;
				EXECUTE stmt_0;
				DEALLOCATE PREPARE stmt_0;
				-- .=========================================
				-- . OUTPUT.
				-- .=========================================
				SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Place a Bet"}') AS json_result;
			ELSE
				-- .=========================================
				-- . OUTPUT.
				-- .=========================================
				SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Insufficient Balance","OPERATION":"Place a Bet"}') AS json_result;			
			END IF;
		ELSE
			-- .=========================================
			-- . OUTPUT.
			-- .=========================================
			SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Account does not Exist.","OPERATION":"Place a Bet"}') AS json_result;	
		END IF;
	END IF;
	-- .=========================================
	-- . RESET VARS
	-- .=========================================
	SET @qry = NULL;
	SET MSISDN = NULL;
	SET BET_AMOUNT = NULL;
	SET @USER_MSISDN = NULL;
	SET @CURRENT_BAL = NULL;	
	
END$$;
DELIMITER; //



DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientRegister`(
	IN `MSISDN` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN

	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
  	BEGIN
	    ROLLBACK;
	    RESIGNAL;
	END;
	
	IF(TRIM(MSISDN) = "") THEN
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid Input","OPERATION":"Register User"}') AS json_result;
	ELSE
	
	   START TRANSACTION;
	   
	   SET @qry  = CONCAT("SELECT ",
		                   "COUNT(A.MSISDN) ",
								 "INTO ",
								 "@MSISDN_FOUND ",
								 "FROM ",
								 "tbl_wallet A ",
								 "INNER JOIN ",
								 "tbl_wallet_ext B ", 
								 "ON ",
								 "A.MSISDN=B.MSISDN ",
								 "WHERE ",
								 "A.MSISDN = '",TRIM(MSISDN),"'");
								
		PREPARE stmt_0 FROM @qry;
		EXECUTE stmt_0;
		DEALLOCATE PREPARE stmt_0; 
		-- .=========================================
		-- . Check if MSISDN exist.
		-- .=========================================	
		IF(@MSISDN_FOUND = "0") THEN
			SET @qry2 = CONCAT("INSERT INTO tbl_wallet(`MSISDN`,`DateCreated`,`LastActivity`) VALUES('",TRIM(MSISDN),"','",NOW(),"','",NOW(),"') ");
			PREPARE stmt_1 FROM @qry2;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1; 
			
			SET @qry3 = CONCAT("INSERT INTO tbl_wallet_ext(`MSISDN`,`Password`) VALUES('",TRIM(MSISDN),"','",NOW(),"')");
			PREPARE stmt_2 FROM @qry3;
			EXECUTE stmt_2;
			DEALLOCATE PREPARE stmt_2; 
			-- .=========================================
			-- . OUTPUT.
			-- .=========================================
			SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Register User"}') AS json_result;
		ELSE
			-- .=========================================
			-- . OUTPUT.
			-- .=========================================
			SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - User Exist","OPERATION":"Register User"}') AS json_result;							
		END IF;
		
		COMMIT;	
	END IF;

END$$;
DELIMITER; //



DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientUtiliseBonus`(
	IN `MSISDN` VARCHAR(15),
	IN `BONUS` DECIMAL(10,2)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	IF(TRIM(MSISDN) = "" || TRIM(BONUS) = "") THEN
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"0","MESSAGE","Unsuccessful - Invalid Input","OPERATION":"Utilise Bonus"}') AS json_result;
	-- .=========================================
	-- . Check if MSISDN exist.
	-- .=========================================
   SET @qry1 = CONCAT("SELECT ",
	                   "COUNT(A.MSISDN), B.Bonus ",
							 "INTO ",
							 "@MSISDN_XFOUND, @BONUS_BAL ",
							 "FROM ",
							 "tbl_wallet A ",
							 "INNER JOIN ",
							 "tbl_wallet_ext B ", 
							 "ON ",
							 "A.MSISDN=B.MSISDN ",
							 "WHERE ",
							 "A.MSISDN = '",TRIM(MSISDN),"'");
	PREPARE stmt_0 FROM @qry1;
	EXECUTE stmt_0;
	DEALLOCATE PREPARE stmt_0; 
	-- .=========================================
	-- . Update wallet balance.
	-- .=========================================	  
   IF(@MSISDN_XFOUND > "0") THEN
   	IF(@BONUS_BAL >= BONUS) THEN
			SET @qry2 = CONCAT("UPDATE ",
			                   "tbl_wallet A ",
			                   "INNER JOIN ",
									 "tbl_wallet_ext B ",
								  	 "ON ",
									 "A.MSISDN = B.MSISDN ",
									 "SET ",
									 "B.Bonus = (B.Bonus - '",TRIM(BONUS),"'),",
									 "A.DateModified = '",NOW(),"'",
								  	 "WHERE ",
									 "A.MSISDN = '",TRIM(MSISDN),"' AND A.IsLocked = '0'");									
			PREPARE stmt_1 FROM @qry2;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1;
			-- .=========================================
			-- . OUTPUT.
			-- .=========================================
			SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Utilise Bonus"}') AS json_result;
		ELSE
			-- .=========================================
			-- . OUTPUT.
			-- .=========================================
			SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Insufficient Bonus","OPERATION":"Utilise Bonus"}') AS json_result;			
		END IF;
	ELSE
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Account does not Exist.","OPERATION":"Utilise Bonus"}') AS json_result;	
	END IF;
END IF;
-- .=========================================
-- . RESET VARS
-- .=========================================
SET @qry = NULL;
SET MSISDN = NULL;
SET BONUS = NULL;
SET @MSISDN_XFOUND = NULL;
SET @BONUS_BAL = NULL;

END$$;
DELIMITER; //



DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqClientWithdraw`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DECIMAL(10,2)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
IF(TRIM(MSISDN) = "" || TRIM(AMOUNT) = "") THEN
	-- .=========================================
	-- . OUTPUT.
	-- .=========================================
	SELECT CONCAT('{"RESULT":"0","MESSAGE","Unsuccessful - Invalid Input","OPERATION":"Withdraw E-Cash"}') AS json_result;
ELSE
	-- .=========================================
	-- . Check if MSISDN exist.
	-- .=========================================
   SET @qry1 = CONCAT("SELECT ",
	                   "COUNT(A.MSISDN), B.Balance ",
							 "INTO ",
							 "@MSISDN_FOUND, @WALLET_BAL ",
							 "FROM ",
							 "tbl_wallet A ",
							 "INNER JOIN ",
							 "tbl_wallet_ext B ", 
							 "ON ",
							 "A.MSISDN=B.MSISDN ",
							 "WHERE ",
							 "A.MSISDN = '",TRIM(MSISDN),"'");
	PREPARE stmt_0 FROM @qry1;
	EXECUTE stmt_0;
	DEALLOCATE PREPARE stmt_0; 
	-- .=========================================
	-- . Update wallet balance.
	-- .=========================================	  
   IF(@MSISDN_FOUND > "0") THEN
   	IF(@WALLET_BAL >= AMOUNT) THEN
			SET @qry2 = CONCAT("UPDATE ",
			                   "tbl_wallet A ",
			                   "INNER JOIN ",
									 "tbl_wallet_ext B ",
								  	 "ON ",
									 "A.MSISDN = B.MSISDN ",
									 "SET ",
									 "B.Balance = (B.Balance - '",TRIM(AMOUNT),"'),",
									 "A.DateModified = '",NOW(),"'",
								  	 "WHERE ",
									 "A.MSISDN = '",TRIM(MSISDN),"' AND A.IsLocked = '0'");									
			PREPARE stmt_1 FROM @qry2;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1;
			-- .=========================================
			-- . OUTPUT.
			-- .=========================================
			SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Withdraw E-Cash"}') AS json_result;
		ELSE
			-- .=========================================
			-- . OUTPUT.
			-- .=========================================
			SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Insufficient Balance","OPERATION":"Withdraw E-Cash"}') AS json_result;			
		END IF;
	ELSE
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Account does not Exist.","OPERATION":"Withdraw E-Cash"}') AS json_result;	
	END IF;
END IF;
-- .=========================================
-- . RESET VARS
-- .=========================================
SET @qry = NULL;
SET MSISDN = NULL;
SET AMOUNT = NULL;
SET @MSISDN_FOUND = NULL;
SET @WALLET_BAL = NULL;

END$$;
DELIMITER; //


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqHandleOutboundSms`(
	IN `_Destination` VARCHAR(15),
	IN `_Source` VARCHAR(10),
	IN `_Message` VARCHAR(480)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	IF(TRIM(_Destination) = "" || TRIM(_Source) = "" || TRIM(_Message) = "") THEN
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================	
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid Input","OPERATION":"Queue Message"}') AS json_result;
	ELSE
		SET @qry = CONCAT("INSERT ",
		                  "INTO  ",
								"`tbl_outgoing_sms` ",
								"(`Destination`,`Source`,`Message`,`DateCreated`) ",
								"VALUES ",
								"('",TRIM(_Destination),"','",TRIM(_Source),"','",TRIM(_Message),"','",NOW(),"')");
		PREPARE stmt_1 FROM @qry;
		EXECUTE stmt_1;
		DEALLOCATE PREPARE stmt_1; 
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================		
		SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Queue Message"}') AS json_result;		
	END IF;
-- .=========================================
-- . RESET VARS
-- .=========================================
SET @qry = NULL;
SET _Destination = NULL;
SET _Source = NULL;
SET _Message = NULL;	

END$$;
DELIMITER; //



DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqLogWalletMoneyMovement`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DECIMAL(7,2),
	IN `FLAG` CHAR(5)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	IF(TRIM(MSISDN) = "" || TRIM(AMOUNT) = "" || TRIM(FLAG) = "") THEN
		-- .=========================================
		-- . OUTPUT.
		-- .=========================================
		SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful - Invalid Input","OPERATION":"Wallet monies movement"}') AS json_result;
	ELSE
		-- .=========================================
		-- . CHECK IF MOBILE EXIST, THEN GET BAL.
		-- .=========================================
		SET @qry = CONCAT("SELECT ", 
		                  "COUNT(A.MSISDN), ",
			               "IFNULL(B.Balance,0.00) ",
			               "INTO ",
			               "@EXIST_WM,@BALANCE_WM ",
			               "FROM ",
			               "`tbl_wallet` A ",
			               "INNER JOIN ",
			               "`tbl_wallet_ext` B ",
			               "ON ",
			               "A.MSISDN=B.MSISDN ",
			               "WHERE "
			               "A.MSISDN = '",TRIM(MSISDN),"' AND A.IsLocked = '0'");
									
			PREPARE stmt_1 FROM @qry;
			EXECUTE stmt_1;
			DEALLOCATE PREPARE stmt_1;
			-- .=========================================
			-- . UPDATE BALANCE.
			-- .=========================================	
			IF(@EXIST_WM > "0")THEN
				IF(UPPER(TRIM(FLAG)) = "CR") THEN
					-- .=========================================
					-- . PARTICULARS.
					-- .=========================================
					SET @TX_DETAILS = CONCAT("'","Deposit of ",TRIM(AMOUNT),"'");				
					-- .=========================================
					-- . UPDATE BALANCE.
					-- .=========================================
					SET @NEW_BALANCE = (@BALANCE_WM + AMOUNT);
					-- .=========================================
					-- . INSERT A TRANSACTION LOG.
					-- .=========================================
					SET @qry = CONCAT("INSERT ",
					                  "INTO ",
									      "`tbl_withdrawal_log` ",
									      "(`msisdn`,`particulars`,`cr`,`balance`) ",
									      "VALUES ",
									      "(",TRIM(MSISDN),",",@TX_DETAILS,",",TRIM(AMOUNT),",",@NEW_BALANCE,")");
					PREPARE stmt_1 FROM @qry;
					EXECUTE stmt_1;
					DEALLOCATE PREPARE stmt_1;
					-- .=========================================
					-- . OUTPUT.
					-- .=========================================
					SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Wallet monies movement"}') AS json_result;											      
				ELSE
					-- .=========================================
					-- . PARTICULARS.
					-- .=========================================
					SET @TX_DETAILS = CONCAT("'","Withdrawal of ",TRIM(AMOUNT),"'");					
					-- .=========================================
					-- . UPDATE BALANCE.
					-- .=========================================
					SET @NEW_BALANCE = (@BALANCE_WM - AMOUNT);
					-- .=========================================
					-- . INSERT A TRANSACTION LOG.
					-- .=========================================
					SET @qry = CONCAT("INSERT ",
					                  "INTO ",
									      "`tbl_withdrawal_log` ",
									      "(`msisdn`,`particulars`,`dr`,`balance`) ",
									      "VALUES ",
									      "(",TRIM(MSISDN),",",@TX_DETAILS,",",TRIM(AMOUNT),",",@NEW_BALANCE,")");
					PREPARE stmt_1 FROM @qry;
					EXECUTE stmt_1;
					DEALLOCATE PREPARE stmt_1; 		
					-- .=========================================
					-- . OUTPUT.
					-- .=========================================
					SELECT CONCAT('{"RESULT":"1","MESSAGE":"Successful","OPERATION":"Wallet monies movement"}') AS json_result;
				END IF;
			ELSE
				-- .=========================================
				-- . OUTPUT.
				-- .=========================================
				SELECT CONCAT('{"RESULT":"0","MESSAGE":"Unsuccessful: Customer Not Found","OPERATION":"Wallet monies movement"}') AS json_result;			
			END IF;
	END IF;
	-- .=========================================
	-- . RESET VARS
	-- .=========================================
	SET @qry         = NULL;
	SET @EXIST_WM    = NULL;
	SET @BALANCE_WM  = NULL;
	SET @NEW_BALANCE = NULL;
	SET @TX_DETAILS  = NULL;
	SET MSISDN       = NULL;
	SET AMOUNT       = NULL;		

END$$;
DELIMITER; //


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sProqLogWithdrawalFee`(
	IN `MSISDN` VARCHAR(15),
	IN `AMOUNT` DECIMAL(7,2),
	IN `FEE` DECIMAL(7,2)
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
