DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE db_freknur_loan.`sProcLogLoanFee`(
        IN `MSISDN` VARCHAR(50),
        IN `REFERENCE_NO` VARCHAR(50),
        IN `HANDLING_FEE` DOUBLE(15,8),
        IN `ACCOUNT_NAME` VARCHAR(15)
)
BEGIN

        DECLARE PARTICULARS TEXT;
        DECLARE RUNNING_BAL DOUBLE(15,8);
        IF(TRIM(MSISDN) != "" OR TRIM(REFERENCE_NO) != "" OR TRIM(HANDLING_FEE) != "" OR TRIM(ACCOUNT_NAME) != "") THEN

                SET @STMT_0 = CONCAT("SELECT ",
                                     "COUNT(`uid`) ",
                                     "INTO ",
                                     "@HAS_ACCOUNT ",
                                     "FROM ",
                                     "`tbl_wallet` ",
                                     "WHERE ",
                                     "`msisdn` = '",TRIM(MSISDN),"'");
                PREPARE QUERY FROM @STMT_0;
                EXECUTE QUERY;
                DEALLOCATE PREPARE QUERY;



                IF(@HAS_ACCOUNT > "0")THEN

                        SET @STMT_1 = CONCAT("SELECT ",
                                             "`account_code`,`account_name`,`balance` ",
                                             "INTO ",
                                             "@ACC_CODE,@ACC_NAME,@BALANCE ",
                                             "FROM ",
                                             "`tbl_account` ",
                                             "WHERE ",
                                             "`account_name` = '",TRIM(ACCOUNT_NAME),"'");
                        PREPARE QUERY FROM @STMT_1;
                        EXECUTE QUERY;
                        DEALLOCATE PREPARE QUERY;

                        SET PARTICULARS = "LOAN HANDLING FEES EARNED.";
                        SET RUNNING_BAL = (@BALANCE + HANDLING_FEE);



                        SET @STMT_2 = CONCAT("INSERT ",
                                             "INTO ",
                                             "`tbl_transaction` ",
                                             "(`account_code`,`reference_no`,`msisdn`,`cr`,`dr`,`balance`,`narration`,`date_created`) ",
                                             "VALUES ",
                                             "('",@ACC_CODE,"','",TRIM(REFERENCE_NO),"','",TRIM(MSISDN),"','",TRIM(HANDLING_FEE),"','0.00','",TRIM(RUNNING_BAL),"','",PARTICULARS,"','",NOW(),"')");
                        PREPARE QUERY FROM @STMT_2;
                        EXECUTE QUERY;
                        DEALLOCATE PREPARE QUERY;



                        SET @STMT_3 = CONCAT("UPDATE ",
                                             "`tbl_account` ",
                                             "SET ",
                                             "`balance` = '",RUNNING_BAL,"' ",
                                             "WHERE ",
                                             "`account_code` ='",@ACC_CODE,"'");
                        PREPARE QUERY FROM @STMT_3;
                        EXECUTE QUERY;
                        DEALLOCATE PREPARE QUERY;



                        SET @JSON_O = '{"ERROR":"0","RESULT":"SUCCESS","MESSAGE":"Movement complete."}';
                        SELECT @JSON_O AS _JSON;
                ELSE

                        SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"A/C does not exist."}';
                        SELECT @JSON_O AS _JSON;
                END IF;
        ELSE

                SET @JSON_O = '{"ERROR":"1","RESULT":"FAIL","MESSAGE":"Params:MSISDN|REFERENCE_NO|HANDLING_FEE|ACCOUNT_NAME needs to be SET."}';
                SELECT @JSON_O AS _JSON;
        END IF;



        SET @STMT_1 = NULL;
        SET @STMT_2 = NULL;
        SET @STMT_3 = NULL;
        SET @JSON_O = NULL;
        SET @BALANCE  = NULL;
        SET @ACC_CODE = NULL;
        SET @ACC_NAME = NULL;
        SET @HAS_ACCOUNT = NULL;
        SET MSISDN = NULL;
        SET PARTICULARS = NULL;
        SET RUNNING_BAL = NULL;
        SET REFERENCE_NO = NULL;
        SET ACCOUNT_NAME = NULL;
END$$
DELIMITER; //
