DELIMITER $$
CREATE TRIGGER `tbl_sale_request_after_insert_trigger` AFTER INSERT ON `db_freknur_investment`.`tbl_sale_request` FOR EACH ROW BEGIN
INSERT 
INTO 
`db_freknur_investment`.`tbl_sale_request_queue`
(`uid`,`msisdn`,`description`,`unit_price`,`no_of_grain_sold`,`cost`,`date_created`)
VALUES
(NEW.uid,NEW.msisdn,NEW.description,NEW.unit_price,NEW.no_of_grain_sold,NEW.cost,NOW());
END$$
DELIMITER; //
