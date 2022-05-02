/*тергера*/
tee db-proc-01.log

use test3; 

DROP PROCEDURE IF EXISTS IMPORT_DATA;


DELIMITER // 

	CREATE PROCEDURE `IMPORT_DATA` () 
	LANGUAGE SQL 
	DETERMINISTIC 
	SQL SECURITY DEFINER 
	COMMENT 'Импорт данных филиалов' 
	BEGIN 
	    DECLARE L_BRNID INT DEFAULT 10; 

            INSERT INTO APP2$BRANCHES( IDBRN, CODEBRN, NAMEBRN, DS ) 
                   VALUES (L_BRNID, LPAD( TRIM( CAST( L_BRNID AS CHAR )), 2, '0' ), 'ФИЛИАЛ 1', '2021-02-25'); 

            SET L_BRNID =  L_BRNID + 10 ;
            INSERT INTO APP2$BRANCHES( IDBRN, CODEBRN, NAMEBRN, DS ) 
                   VALUES (L_BRNID, LPAD( TRIM( CAST( L_BRNID AS CHAR )), 2, '0' ), 'ФИЛИАЛ ЛЕВЫЙ', '2021-03-05'); 


            SET L_BRNID =  L_BRNID + 10;
            INSERT INTO APP2$BRANCHES( IDBRN, CODEBRN, NAMEBRN, DS ) 
                   VALUES (L_BRNID, LPAD( TRIM( CAST( L_BRNID AS CHAR )), 2, '0' ), 'ФИЛИАЛ ПРАВЫЙ', '2021-03-15'); 

            SET L_BRNID =  L_BRNID + 10;
            INSERT INTO APP2$BRANCHES( IDBRN, CODEBRN, NAMEBRN, DS ) 
                   VALUES (L_BRNID, LPAD( TRIM( CAST( L_BRNID AS CHAR )), 2, '0' ), 'ФИЛИАЛ СКРЫТНЫЙ', '2021-06-25'); 


	       
	END//
  
DELIMITER ;