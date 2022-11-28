DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcActivateWallet`(
	IN `MSISDN` VARCHAR(50),
	IN `PASSWD` VARCHAR(50))
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	-- ====================================================================
	-- .Params.
	-- .@MSISDN.
	-- .@PASSWD.
	-- ====================================================================
	DECLARE exit handler FOR SQLEXCEPTION, SQLWARNING
	BEGIN
		ROLLBACK;
		RESIGNAL;
	END;	
	IF(TRIM(MSISDN) <> "") THEN
		-- ====================================================================
		SET @STMT_1 = CONCAT("INSERT ",
			             "INTO ",
			             "`tbl_wallet` ",
		                     "(`uid`,`msisdn`,`password`,`date_created`) ",
			             "VALUES ",
		                     "('",uuid_short(),"','",TRIM(MSISDN),"','",TRIM(PASSWD),"','",NOW(),"') ",
			             "ON DUPLICATE KEY ",
			             "UPDATE `date_modified` = '",NOW(),"'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;				
	END IF;
	-- ====================================================================
	-- .commit transaction.
	-- ====================================================================
	COMMIT;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================
	SET @STMT_1 = NULL;
	SET @STMT_2 = NULL;
	SET @JSON_O = NULL;
	SET MSISDN  = NULL;
	SET PASSWD  = NULL;	
END$$
DELIMITER //
