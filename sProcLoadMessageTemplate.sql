DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcLoadMessageTemplate`(
	IN `CATEGORY` VARCHAR(50),
	OUT `OUT_MESSAGE` VARCHAR(150)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	-- ====================================================================
	-- .Params.
	-- .CATEGORY.
	-- .@OUTPUT.
	-- ====================================================================
	IF(TRIM(CATEGORY) != "") THEN
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================	
		SET @STMT_1 = CONCAT("SELECT ",
		                     "`message` ",
				     "INTO ",
				     "@MESSAGE ",
				     "FROM ",
				     "`db_freknur_general`.`tbl_message_template`",
				     "WHERE ",
			             "`category` = '",UCASE(TRIM(CATEGORY)),"' AND `flag` = '0'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .output.
		-- ====================================================================		
		SET OUT_MESSAGE = @MESSAGE; 		
	END IF;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================	
	SET @STMT_1  = NULL;
	SET CATEGORY = NULL;
	SET @MESSAGE = NULL;
END$$
DELIMITER; //
