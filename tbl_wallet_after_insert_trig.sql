DELIMITER $$
CREATE TRIGGER `tbl_wallet_after_insert` AFTER INSERT ON `db_freknur_loan`.`tbl_wallet` FOR EACH ROW BEGIN
INSERT
INTO `db_freknur_general`.`tbl_temp` (`_action`) 
SELECT 
NEW.msisdn 
FROM 
`db_freknur_loan`.`tbl_wallet`;
END$$
DELIMITER; //

