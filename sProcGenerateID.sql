-- Dumping structure for procedure db_freknur_loan.sProcGenerateID
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcGenerateID`(
	OUT `NEW_ID` VARCHAR(10)
)
BEGIN
	-- ====================================================================
	-- .Params.
	-- .@NEW_ID.
	-- ====================================================================

	-- ====================================================================
	-- .unique code generator.
	-- ====================================================================
	SET @STMT_1 = CONCAT("SELECT ",
					     "CONCAT(CHAR(ROUND(RAND()*25)+97), ",
                         "CHAR(ROUND(RAND()*25)+97), ",
	                     "ROUND((RAND()*9)), ",
	                     "CHAR(ROUND(RAND()*25)+97), ",
	                     "CHAR(ROUND(RAND()*25)+97), ",
	                     "CHAR(ROUND(RAND()*25)+97), ",
	                     "ROUND((RAND()*9)), ",
	                     "CHAR(ROUND(RAND()*25)+97), ",
	                     "CHAR(ROUND(RAND()*25)+97), ",
	                     "CHAR(ROUND(RAND()*25)+97)) INTO @UNIQ_ID");
	PREPARE QUERY FROM @STMT_1;
	EXECUTE QUERY;
	DEALLOCATE PREPARE QUERY;
	-- ====================================================================
	-- .output.
	-- ====================================================================		
	SET NEW_ID = @UNIQ_ID;
	-- ====================================================================
	-- .reset vars.
	-- ====================================================================
	SET @STMT_1 = NULL;
	SET @UNIQ_ID = NULL;	
END$$
DELIMITER; //
