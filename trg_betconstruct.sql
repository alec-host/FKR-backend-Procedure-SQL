DELIMITER $$
CREATE DEFINER=`root`@`localhost` TRIGGER `trg_betconstruct` AFTER INSERT ON `tbl_mpesa_transaction_log` FOR EACH ROW BEGIN
	INSERT 
	INTO 
	tbl_betconstruct
	(
		`TransID`,
		`TransTime`,
		`TransAmount`,
		`BusinessShortCode`,
		`BillRefNumber`,
		`MSISDN`,
		`FirstName`,
		`MiddleName`,
		`LastName`
	) 
	VALUES
	(
		NEW.TransID,
		NEW.TransTime,
		NEW.TransAmount,
		NEW.BusinessShortCode,
		NEW.BillRefNumber,
		NEW.MSISDN,
		NEW.FirstName,
		NEW.MiddleName,
		NEW.LastName
	);
	
END$$
DELIMITER; //
