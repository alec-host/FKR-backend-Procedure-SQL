DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcQueueNotification`(
	IN `MSISDN` VARCHAR(15),
	IN `MESSAGE` VARCHAR(150),
	IN `CATEGORY` VARCHAR(50)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN

IF(TRIM(MSISDN) != ""  OR TRIM(MESSAGE) != "" OR TRIM(CATEGORY) != "") THEN

	-- ====================================================================
	-- .sql statement 1.
	-- ====================================================================	
	SET @STMT_1 = CONCAT("INSERT ",
	                     "INTO ",
			     "`db_freknur_general`.`tbl_notification` ",
			     "(`uid`,`msisdn`,`message`,`category`,`date_created`) ",
			     "VALUES ",
			     "('",uuid(),"','",TRIM(MSISDN),"','",TRIM(MESSAGE),"','",TRIM(CATEGORY),"','",NOW(),"') ",
			     "ON DUPLICATE KEY UPDATE ",
			     "`date_modified` = '",NOW(),"'");                    
	PREPARE QUERY FROM @STMT_1;
	EXECUTE QUERY;
	DEALLOCATE PREPARE QUERY;
	-- ====================================================================
	-- .output.
	-- ====================================================================	
	SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Operation successful."}';	
	SELECT @JSON_O AS _JSON;
ELSE
	-- ====================================================================
	-- .output.
	-- ====================================================================	
	SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:MSISDN|MESSAGE|CATEGORY needs to be SET."}';
	SELECT @JSON_O AS _JSON;
END IF;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================
	SET @STMT_1  = NULL;
	SET @JSON_O  = NULL;
	SET MSISDN   = NULL;
	SET MESSAGE  = NULL;
	SET CATEGORY = NULL;

END$$
DELIMITER; //
