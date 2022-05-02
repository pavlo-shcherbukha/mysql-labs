/***********************************************************
* Вставка транзакций в  таблицу транзакций
*
*
*
*/

USE test3;

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;


INSERT INTO APP2$TRN ( DTTRN, DBT_CUSTID, KRD_CUSTID, SUM, TRM_COMMENT)
VALUES( CURRENT_DATE(), 1,2, 2.21, 'Перавая транзакция');


INSERT INTO APP2$TRN ( DTTRN, DBT_CUSTID, KRD_CUSTID, SUM, TRM_COMMENT)
VALUES( CURRENT_DATE(), 1 , 4, 1.11, 'Вторая транзакция');





