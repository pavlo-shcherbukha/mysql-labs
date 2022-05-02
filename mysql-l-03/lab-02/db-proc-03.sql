/**************************************
*
* Процедура выполняющая обработку (прцессинг транзакций)
*
*
*
*
*/

tee db-proc-03.log

use test3; 

DROP PROCEDURE IF EXISTS APP2_TRNPROC;


DELIMITER // 

	CREATE PROCEDURE `APP2_TRNPROC` ( IN A_TRNID INT ) 
	LANGUAGE SQL 
	DETERMINISTIC 
	SQL SECURITY DEFINER 
	COMMENT 'Процессинг транзакций' 
        
	BEGIN 
	    DECLARE L_STEP CHAR(255) DEFAULT '';
            DECLARE L_MSG  CHAR(255) DEFAULT '';
            DECLARE L_EXCEPTION CONDITION FOR SQLSTATE '45000';
            

            -- Переменные данных транзакции
            DECLARE L_TRNID        INT ;
            DECLARE L_DTTRN        DATE ; 
            DECLARE L_DBT_CUSTID   INT ;
            DECLARE L_KRD_CUSTID   INT ; 
            DECLARE L_SUM          DECIMAL(9,2) ; 
            DECLARE L_TRM_COMMENT  CHAR(50) ; 
            DECLARE L_PROC_STATUS  CHAR(1) ;
            DECLARE L_NOT_FOUND    INT DEFAULT 0;
            -- Переменные клиента по дебету (списанию)
            DECLARE L_DCUSTID        INT ;
            DECLARE L_DSUM           DECIMAL(9,2) ; 
            DECLARE L_DDS            DATE ;
            DECLARE L_DDF            DATE ; 
            -- Переменные клиента по кредиту (зачисление)
            DECLARE L_KCUSTID        INT ;
            DECLARE L_KSUM           DECIMAL(9,2) ; 
            DECLARE L_KDS            DATE ;
            DECLARE L_KDF            DATE ; 



 
            DECLARE CONTINUE HANDLER FOR NOT FOUND SET L_NOT_FOUND = 1;

            SET L_STEP = 'Проверяю входные параметры';
            IF A_TRNID IS NULL THEN
                set L_MSG = concat(L_STEP , ': Не указан ID  транзакции!');
                signal L_EXCEPTION set message_text = L_MSG;
            END IF;

            SET L_STEP = 'ЧИТАЮ ТРАНЗАКЦИЮ ИЗ БД';
            SELECT A.TRNID, A.DTTRN, A.DBT_CUSTID, A.KRD_CUSTID, A.SUM, A.TRM_COMMENT, A.PROC_STATUS
            INTO L_TRNID, L_DTTRN, L_DBT_CUSTID, L_KRD_CUSTID, L_SUM, L_TRM_COMMENT, L_PROC_STATUS
            FROM APP2$TRN A
            WHERE A.TRNID = A_TRNID FOR UPDATE;
            IF L_NOT_FOUND = 1 THEN
                set L_MSG = concat(L_STEP , ': В БД ТРАНЗАКЦИЯ НЕ НАЙДЕНА!');
                signal L_EXCEPTION set message_text = L_MSG;
            END IF;

            SET L_STEP = 'ПРОВЕРЯЮ ДОПУСТИМОСТЬ СТАТУСА ТРАНЗАКЦИИ';
           
            IF L_PROC_STATUS <> 'N' THEN
               set L_MSG = concat(L_STEP , ': НЕ ДОПУСТИМЫЙ СТАТУС ТРАНЗАКЦИИ!');
               signal L_EXCEPTION set message_text = L_MSG;
            END IF;
           
            SET L_STEP = 'ЧИТАЮ ДАННЫЕ КЛИЕНТА ПО ДЕБЕТУ(СПИСАНИЮ)';
            SELECT  D.CUSTID, D.SUM, D.DS, D.DF
            INTO L_DCUSTID, L_DSUM, L_DDS, L_DDF    
            FROM APP2$CUST D
            WHERE D.CUSTID = L_DBT_CUSTID FOR UPDATE;
   
            IF L_NOT_FOUND = 1 THEN
                set L_MSG = concat(L_STEP , ': Клиент по дебету(списанию) не найден !');
                signal L_EXCEPTION set message_text = L_MSG;
            END IF;

            SET L_STEP = 'ПРОВЕРЯЮ АКТУАЛЬНОСТЬ КЛИЕНТА ПО ДЕБЕТУ(СПИСАНИЮ) НА ДАТУ ТРАНЗАКЦИИ';
            IF L_DTTRN  NOT BETWEEN L_DDS AND  IFNULL(L_DDF, CURRENT_DATE())    THEN
                set L_MSG = concat(L_STEP , ': Клиент по дебету(списанию) не действует !');
                signal L_EXCEPTION set message_text = L_MSG;
            END IF;
             
            SET L_STEP = 'ЧИТАЮ ДАННЫЕ КЛИЕНТА ПО КРЕДИТУ (ЗАЧИСЛЕНИЮ)';
            SELECT  D.CUSTID, D.SUM, D.DS, D.DF
            INTO L_KCUSTID, L_KSUM, L_KDS, L_KDF    
            FROM APP2$CUST D
            WHERE D.CUSTID = L_KRD_CUSTID FOR UPDATE;   
            IF L_NOT_FOUND = 1 THEN
                set L_MSG = concat(L_STEP , ': Клиент по кредиту(зачислению) не найден !');
                signal L_EXCEPTION set message_text = L_MSG;
            END IF;

            SET L_STEP = 'ПРОВЕРЯЮ АКТУАЛЬНОСТЬ КЛИЕНТА ПО КРЕДИТУ(ЗАЧИСЛЕНИЮ) НА ДАТУ ТРАНЗАКЦИИ';
            IF L_DTTRN  NOT BETWEEN L_KDS AND  IFNULL(L_KDF, CURRENT_DATE())    THEN
                set L_MSG = concat(L_STEP , ': Клиент по кредиту(кредиту) не действует !');
                signal L_EXCEPTION set message_text = L_MSG;
            END IF;

           SET L_STEP = 'ВЫПОЛНЯЮ СПИСАНИЕ';
           IF L_DSUM - L_SUM < 0 THEN
                set L_MSG = concat(L_STEP , ': После выполнения транзакции остаток < 0. Операция не возможна !');
                signal L_EXCEPTION set message_text = L_MSG;

           END IF;
           
           UPDATE APP2$CUST DD
           SET DD.SUM = DD.SUM -L_SUM
           WHERE DD.CUSTID= L_DBT_CUSTID;
                                 
           SET L_STEP = 'ВЫПОЛНЯЮ ЗАЧИСЛЕНИЕ';
           UPDATE APP2$CUST KK
           SET KK.SUM = KK.SUM + L_SUM
           WHERE KK.CUSTID= L_KRD_CUSTID;
            
           SET L_STEP = 'УСТАНАВЛИВАЮ СТАТУС ПРОВЕДЕННОСТИ ТРАНЗАКЦИИ';
           UPDATE APP2$TRN A
           SET A.PROC_STATUS = 'P'
           WHERE A.TRNID = A_TRNID;
           
           --  ХУУУХ все!!!
	       
	END//
  
DELIMITER ;