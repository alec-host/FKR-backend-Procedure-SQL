DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_investment`.`sProcInitChartOfAccount`()
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT ''
BEGIN
	-- ====================================================================
	-- .sql statement 0: read accounts.
	-- ====================================================================
	SET @STMT_0 = CONCAT("SELECT ",
			     "COUNT(`id`) ",
			     "INTO ",
			     "@SIZE ",
			     "FROM ",
			     "`db_freknur_investment`.`tbl_account`");                    
	PREPARE QUERY FROM @STMT_0;
	EXECUTE QUERY;
	DEALLOCATE PREPARE QUERY;
	-- ====================================================================
	-- .create book keeping a/c if not created.
	-- ====================================================================
	IF(TRIM(@SIZE) = "0") THEN
		SET @STMT_1 = CONCAT("INSERT ",
			             "INTO ",
				     "`db_freknur_investment`.`tbl_account` ",
				     "(`account_code`,`account_name`,`balance`,`date_created`) ",
				     "VALUES ",
				     "('WRK','WORKING','0.00','",NOW(),"'), ",
				     "('INC','INCOMING','0.00','",NOW(),"'), ",
				     "('FEE','GOVT_TAX','0.00','",NOW(),"')");                    
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;	
	END IF;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================
	SET @SIZE = NULL;	
	SET @STMT_0 = NULL;
	SET @STMT_1 = NULL;

END$$
DELIMITER; //
