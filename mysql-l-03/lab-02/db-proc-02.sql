/*тергера*/
tee db-proc-02.log

use test3; 

DROP PROCEDURE IF EXISTS IMPORT_CUST;


DELIMITER // 

	CREATE PROCEDURE `IMPORT_CUST` () 
	LANGUAGE SQL 
	DETERMINISTIC 
	SQL SECURITY DEFINER 
	COMMENT 'Импорт данных клиентов' 
	BEGIN 

            DECLARE L_IDBRN INT;
            DECLARE L_NAMEBRN CHAR(50) ;
            DECLARE L_CUSTCODE INT DEFAULT 1 ;

            DECLARE DONE INT DEFAULT 0;
            DECLARE cur CURSOR FOR SELECT IDBRN, NAMEBRN  FROM APP2$BRANCHES;
            DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

            OPEN cur;
            REPEAT
                 FETCH CUR INTO L_IDBRN, L_NAMEBRN;
                 IF NOT DONE THEN
                     SET L_CUSTCODE = L_CUSTCODE + 1 ;  
                     INSERT INTO APP2$CUST(IDBRN, CUSTCODE, CUSTNAME, ISACTIVE, DS, SUM )
                     VALUES ( L_IDBRN, 
                              LPAD( TRIM( CAST( L_CUSTCODE AS CHAR )), 3, '0' ), 
                              CONCAT('КЛИЕНТ ' , LPAD( TRIM( CAST( L_CUSTCODE AS CHAR )), 3, '0' ) ), 
                              'Y', 
                              '2021-03-01',
                              1000.56 ) ;

                 END IF;
            UNTIL DONE END REPEAT;
            CLOSE CUR;



	       
	END//
  
DELIMITER ;