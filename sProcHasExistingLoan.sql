DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcHasExistingLoan`(
	IN `MSISDN` VARCHAR(50),
	OUT `OUTPUT` VARCHAR(1)
)
BEGIN
	-- ====================================================================
	-- .Params.
	-- .@MSISDN
	-- .@OUTPUT.
	-- ====================================================================
	IF(TRIM(MSISDN) <> "") THEN
		-- ====================================================================
		-- .sql statement 1.
		-- ====================================================================	
		SET @STMT_1 = CONCAT("SELECT ",
		                     "COUNT(`reference_no`) ",
				     "INTO ",
			             "@LOAN_CNT ",
			             "FROM ",
				     "`tbl_debtor` ",
				     "WHERE ",
				     "`msisdn` = '",TRIM(MSISDN),"' AND `is_repaid` = '0'");
		PREPARE QUERY FROM @STMT_1;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .get loan count.
		-- ====================================================================
		IF(@LOAN_CNT = "0")THEN
			SET @STMT_2 = CONCAT("SELECT 0 INTO @NO_OF_LOAN");
		ELSE
			SET @STMT_2 = CONCAT("SELECT 1 INTO @NO_OF_LOAN");
		END IF;
		PREPARE QUERY FROM @STMT_2;
		EXECUTE QUERY;
		DEALLOCATE PREPARE QUERY;
		-- ====================================================================
		-- .output.
		-- ====================================================================		
		SET OUTPUT = @NO_OF_LOAN; 	
	END IF;
	-- ====================================================================
	-- .reset the vars.
	-- ====================================================================	
	SET @STMT_1     = NULL;
	SET @STMT_2     = NULL;
	SET @LOAN_CNT   = NULL;
	SET @NO_OF_LOAN = NULL;
	SET MSISDN      = NULL;
END$$
DELIMITER; //
