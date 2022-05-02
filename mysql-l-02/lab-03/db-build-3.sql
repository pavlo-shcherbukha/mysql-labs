/* Записываем output ввыхоной файл  */
tee run.log

/*удалить БД если существует*/
drop database IF EXISTS test2;

/*Создать БД*/
create database test2;

/*показать список БД*/
show databases;

/* переключиться на нужную БД */
use test2 

/**
***********************************************************************

создать таблицу владельцев дисков

***********************************************************************
*/
CREATE TABLE APP1$OWNERS
(
    IDOWNER INT AUTO_INCREMENT,
    FIRSTNAME VARCHAR(20),
    LASTNAME  VARCHAR(20),
    AGE SMALLINT UNSIGNED,
    PHONE  VARCHAR(20),
    IDT DATETIME,
    IUSRNM  VARCHAR(32),
    MDT DATETIME,
    MUSRNM  VARCHAR(32),
    CONSTRAINT APP1$OWNERS_PK PRIMARY KEY( IDOWNER ),
    CONSTRAINT APP1$OWNERS_FIRSTNAME_NNL CHECK(FIRSTNAME IS NOT NULL),
    CONSTRAINT APP1$OWNERS_LASTNAME_NNL  CHECK(LASTNAME IS NOT NULL),
    CONSTRAINT APP1$OWNERS_AGE_NNL  CHECK(AGE IS NOT NULL),
    CONSTRAINT APP1$OWNERS_AGE_RNG  CHECK(AGE>0 AND AGE<100),
    CONSTRAINT APP1$OWNERS_PHONE_UK  UNIQUE(Phone)
);


SHOW TABLES ;


/**************************************************************

Создать таблицу дисков и закрепить  диски за владельцами
****************************************************************
*/
CREATE TABLE APP1$DISCS
(
    IDDISC   INT AUTO_INCREMENT,
    DISCNAME VARCHAR(20),
    IDOWNER  INT,
    IDT      DATETIME,
    IUSRNM  VARCHAR(32),
    MDT DATETIME,
    MUSRNM  VARCHAR(32),
    CONSTRAINT APP1$DISC_PK PRIMARY KEY( IDDISC ),
    CONSTRAINT APP1$DISC_DISCNAME_NNL CHECK( DISCNAME IS NOT NULL ) ,
    CONSTRAINT APP1$DISC_IDOWNER_FK FOREIGN KEY ( IDOWNER )  REFERENCES APP1$OWNERS ( IDOWNER ) ON DELETE CASCADE
);

SHOW TABLES ;

