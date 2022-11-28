DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `db_freknur_loan`.`sProcLoanRepayment`(
        IN `MSISDN` VARCHAR(15),
        IN `AMOUNT` DECIMAL(15,8),
        IN `TRANSACTION_NO` VARCHAR(50)
)
BEGIN
   DECLARE EXCESS DECIMAL(15,8);
   DECLARE HAS_LOAN VARCHAR(2);
   DECLARE MESSAGE VARCHAR(160);
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
                ROLLBACK;
                RESIGNAL;
        END;
        IF(TRIM(MSISDN) != "" OR TRIM(AMOUNT) != "" OR TRANSACTION_NO != "") THEN
                START TRANSACTION;

                CALL `sProcHasExistingLoan`(MSISDN,HAS_LOAN);
                IF(HAS_LOAN = "1") THEN

                        SET @STMT_0 = CONCAT("SELECT",
                                             " `interest_amount`,`reference_no`,`repayment_amount`,`expected_repayment_date`",
                                             " INTO ",
                                             " @INTEREST, @REFERENCE, @LOAN_AMOUNT, @PAY_DATE ",
                                             " FROM `tbl_debtor` ",
                                             " WHERE `msisdn` = '",TRIM(MSISDN),"' AND `is_repaid` ='0'");
                        PREPARE QUERY FROM @STMT_0;
                        EXECUTE QUERY;
                        DEALLOCATE PREPARE QUERY;

                        SET EXCESS = (AMOUNT - @LOAN_AMOUNT);

                        IF(EXCESS = "0") THEN

                                SET @STMT_1 = CONCAT("UPDATE `tbl_debtor` SET `repayment_amount` = 0,`is_repaid` = 1, `repayment_date` = NOW() WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_1;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;

                                SET @STMT_5 = CONCAT("UPDATE `tbl_wallet` SET `reference_no` = 0,`date_modified` = NOW() WHERE `is_suspended` = 0 AND `is_active` = 1 AND `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_5;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;

                                SET @STMT_10 = CONCAT("DELETE FROM `db_freknur_general`.`tbl_loan_temp_list` WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_10;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;

                                CALL `sProcLogInterestEarned`(@INTEREST,MSISDN,@REFERENCE,"INCOME","CR");

                                SET @STMT_6 = CONCAT("UPDATE `db_freknur_investment`.`tbl_owner_portfolio` SET `lock` = 0,`date_modified` = NOW() WHERE `lock` = 1 AND `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_6;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;

                                SET @STMT_7 = CONCAT("DELETE FROM `db_freknur_general`.`tbl_loan_collateral` WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_7;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;

                                SET MESSAGE = CONCAT("The LOAN is settled.");

                        ELSEIF(EXCESS > "0") THEN

                                SET @STMT_1 = CONCAT("UPDATE `tbl_debtor` SET `repayment_amount` = 0,`is_repaid` = 1, `repayment_date` = NOW() WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_1;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;

                                SET @STMT_3 = CONCAT("UPDATE `tbl_wallet` SET `balance` = '",FORMAT(EXCESS,2),"',`reference_no` = 0,`date_modified` = NOW() WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_3;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;

                                SET @STMT_10 = CONCAT("DELETE FROM `db_freknur_general`.`tbl_loan_temp_list` WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_10;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;

                                CALL `sProcLogInterestEarned`(@INTEREST,MSISDN,@REFERENCE,"INCOME","CR");

                                SET @STMT_6 = CONCAT("UPDATE `db_freknur_investment`.`tbl_owner_portfolio` SET `lock` = 0,`date_modified` = NOW() WHERE `lock` = 1 AND `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_6;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;

                                SET @STMT_7 = CONCAT("DELETE FROM `db_freknur_general`.`tbl_loan_collateral` WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_7;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;

                                SET MESSAGE  = CONCAT("The LOAN is settled. Excess BAL of ",FORMAT(EXCESS,2)," has been moved to your Wallet.");

                        ELSE

                                SET @STMT_1 = CONCAT("UPDATE `tbl_debtor` SET `repayment_amount` = ",ABS(EXCESS),", `repayment_date` = NOW() WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_1;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;

                                SET @STMT_10 = CONCAT("UPDATE `db_freknur_general`.`tbl_loan_temp_list` SET `loan_amount` = ",ABS(EXCESS),"  WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_10;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;

                                SET MESSAGE  = CONCAT("The LOAN is partially paid; outstanding LOAN balance now is ",FORMAT(ABS(EXCESS),2)," that is due on ",@PAY_DATE,"");

                        END IF;

                        IF(EXCESS >= "0") THEN
                                SET @STMT_8 = CONCAT("DELETE FROM `db_freknur_investment`.`tbl_owner_portfolio_temp_list` WHERE `msisdn` = '",TRIM(MSISDN),"'");
                                PREPARE QUERY FROM @STMT_8;
                                EXECUTE QUERY;
                                EXECUTE QUERY;
                                DEALLOCATE PREPARE QUERY;
                        END IF;

                        SET @STMT_4 = CONCAT("UPDATE `db_freknur_general`.`tbl_loan_repayment` SET `is_processed` = 1 WHERE `msisdn` = '",TRIM(MSISDN),"' AND `transaction_no` = '",TRIM(TRANSACTION_NO),"' AND `is_processed` = 0");
                        PREPARE QUERY FROM @STMT_4;
                        EXECUTE QUERY;
                        DEALLOCATE PREPARE QUERY;

                        SELECT CONCAT('{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"',MESSAGE,'"}') AS _JSON;

                        COMMIT;
                ELSE
                        SELECT '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"You do not have a LOAN."}' AS _JSON;
                END IF;
        ELSE
                SELECT '{"ERROR":"1","RESULT":"SUCCESS","MESSAGE":"MSISDN and LOAN AMOUNT must be checked."}' AS _JSON;
        END IF;

        SET @STMT_0 = NULL;
        SET @STMT_1 = NULL;
        SET @STMT_3 = NULL;
        SET @STMT_4 = NULL;
        SET @STMT_5 = NULL;
        SET @STMT_6 = NULL;
        SET @STMT_7 = NULL;
        SET @STMT_8 = NULL;
        SET @STMT_10 = NULL;
        SET @PAY_DATE = NULL;
        SET @INTEREST = NULL;
        SET @REFERENCE = NULL;
        SET @LOAN_AMOUNT = NULL;
        SET EXCESS = NULL;
        SET MSISDN = NULL;
        SET AMOUNT = NULL;
        SET MESSAGE = NULL;
        SET HAS_LOAN = NULL;
        SET TRANSACTION_NO = NULL;
END ;;
DELIMITER ;
