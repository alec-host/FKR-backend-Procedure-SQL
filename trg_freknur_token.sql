DELIMITER $$
CREATE DEFINER=`root`@`localhost` TRIGGER `trg_freknur_token` AFTER INSERT ON `token_transactions` FOR EACH ROW BEGIN
	IF((NEW.CR IS NOT NULL || NEW.CR <> '0.00') && NEW.DR = '0.00') THEN
		SET @ACTIVITY = CONCAT('FREKNUR TOKEN WORTH:',' ',NEW.CR, ' HAS BEEN BOUGHT.');
	END IF;
	IF((NEW.DR IS NOT NULL || NEW.DR <> '0.00') && NEW.CR = '0.00') THEN
		SET @ACTIVITY = CONCAT('FREKNUR TOKEN WORTH:',' ',NEW.DR, ' HAS BEEN SOLD.');
	END IF;
	-- .======================================================================
	-- . log the transaction activity.
	-- .======================================================================
	INSERT INTO `db_freknur_general`.`tbl_activity_log`(`msisdn`,`activity`) VALUES (NEW.PhoneNumber,@ACTIVITY);
	-- .======================================================================
	-- . reset variable.
	-- .======================================================================	
	SET @ACTIVITY = NULL;
END$$
DELIMITER; //
