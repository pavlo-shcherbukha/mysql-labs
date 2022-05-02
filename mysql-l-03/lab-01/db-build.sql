/* Записываем output ввыхоной файл  */
tee db-build.log

/*удалить БД если существует*/
drop database IF EXISTS test3;

/*Создать БД*/
create database test3;

/*показать список БД*/
show databases;

/* переключиться на нужную БД */
use test3 

/**
***********************************************************************

создать таблицу владельцев дисков

***********************************************************************
*/
CREATE TABLE APP2$BRANCHES
(
    IDBRN    INT AUTO_INCREMENT,
    CODEBRN  VARCHAR(2),
    NAMEBRN  VARCHAR(40),
    DS       DATE,
    DF       DATE,
    IDT DATETIME,
    IUSRNM  VARCHAR(32),
    MDT DATETIME,
    MUSRNM  VARCHAR(32),
    CONSTRAINT APP2$BRANCHES_PK           PRIMARY KEY( IDBRN ),
    CONSTRAINT APP2$BRANCHES_CODEBRN_NNL  CHECK(CODEBRN IS NOT NULL),
    CONSTRAINT APP2$BRANCHES_CODEBRN_UNI  UNIQUE( CODEBRN ),
    CONSTRAINT APP2$BRANCHES_NAMEBRN_NNL  CHECK(  NAMEBRN IS NOT NULL),
    CONSTRAINT APP2$BRANCHES_DS_NNL       CHECK(DS IS NOT NULL),
    CONSTRAINT APP2$BRANCHES_IDT_NNL      CHECK(IDT IS NOT NULL),
    CONSTRAINT APP2$BRANCHES_IUSRNM_NNL   CHECK(IUSRNM IS NOT NULL)
);


SHOW TABLES ;


/**************************************************************

Создать таблицу дисков и закрепить  диски за владельцами
****************************************************************
*/
CREATE TABLE APP2$CUST
(
    CUSTID   INT AUTO_INCREMENT,
    IDBRN    INT,
    CUSTCODE VARCHAR(3),
    CUSTNAME VARCHAR(50),
    ISACTIVE VARCHAR(1),
    DS       DATE,
    DF       DATE,
    IDT      DATETIME,
    IUSRNM  VARCHAR(32),
    MDT DATETIME,
    MUSRNM  VARCHAR(32),
    CONSTRAINT APP2$CUST_PK PRIMARY KEY( CUSTID ),
    CONSTRAINT APP2$CUST_CUSTCODE_NNL CHECK( CUSTCODE IS NOT NULL ) ,
    CONSTRAINT APP2$CUST_IDBRN_NNL    CHECK( IDBRN IS NOT NULL ) ,
    CONSTRAINT APP2$CUST_IDBRN_FK FOREIGN KEY ( IDBRN )  REFERENCES APP2$BRANCHES ( IDBRN ) ON DELETE CASCADE,
    CONSTRAINT APP2$CUST_CUSTCODE_UN  UNIQUE( CUSTCODE  ) ,
    CONSTRAINT APP2$CUST_CUSTNAME_NNL CHECK( CUSTNAME IS NOT NULL   ) ,
    CONSTRAINT APP2$CUST_ISACTIVE_NNL CHECK( ISACTIVE IS NOT NULL   ) ,
    CONSTRAINT APP2$CUST_ISACTIVE_RNG CHECK( ISACTIVE IN ('Y', 'N') ) ,
    CONSTRAINT APP2$CUST_DS_NNL       CHECK(DS IS NOT NULL),
    CONSTRAINT APP2$CUST_IDT_NNL      CHECK(IDT IS NOT NULL),
    CONSTRAINT APP2$CUST_IUSRNM_NNL   CHECK(IUSRNM IS NOT NULL)
    
);

SHOW TABLES ;


-- ======================================================================
-- =============== СОЗДАЮ ТРИГЕРА НА  APP2$BRANCHES =====================

DROP TRIGGER IF EXISTS APP2$BRANCHES_BI_TRG;

delimiter |

CREATE TRIGGER APP2$BRANCHES_BI_TRG BEFORE INSERT ON APP2$BRANCHES
  FOR EACH ROW
  BEGIN
    SET NEW.IDT = CURRENT_TIMESTAMP();
    SET NEW.IUSRNM = USER();
    SET NEW.NAMEBRN = TRIM(NEW.NAMEBRN) ;   
  END;
|

delimiter ;


DROP TRIGGER IF EXISTS APP2$BRANCHES_BU_TRG;

delimiter |

CREATE TRIGGER APP2$BRANCHES_BU_TRG BEFORE UPDATE ON APP2$BRANCHES
  FOR EACH ROW
  BEGIN
    SET NEW.MDT = CURRENT_TIMESTAMP();
    SET NEW.MUSRNM = USER();
    SET NEW.NAMEBRN = TRIM(NEW.NAMEBRN) ;   
  END;
|

delimiter ;

-- ======================================================================
-- =============== СОЗДАЮ ТРИГЕРА НА  APP2$CUST     =====================

DROP TRIGGER IF EXISTS APP2$CUST_BI_TRG;

delimiter |

CREATE TRIGGER APP2$CUST_BI_TRG BEFORE INSERT ON APP2$CUST
  FOR EACH ROW
  BEGIN
    SET NEW.IDT = CURRENT_TIMESTAMP();
    SET NEW.IUSRNM = USER();
    SET NEW.CUSTNAME = TRIM(NEW.CUSTNAME) ;   
  END;
|

delimiter ;


DROP TRIGGER IF EXISTS APP2$CUST_BU_TRG;

delimiter |

CREATE TRIGGER APP2$CUST_BU_TRG BEFORE UPDATE ON APP2$CUST
  FOR EACH ROW
  BEGIN
    SET NEW.MDT = CURRENT_TIMESTAMP();
    SET NEW.MUSRNM = USER();
    SET NEW.CUSTNAME = TRIM(NEW.CUSTNAME) ;   
  END;
|

delimiter ;
