tee run_data.log
use test2

/**
Удаляем предыдущие данные
*/
delete from APP1$OWNERS;
commit ;

insert into APP1$OWNERS(  FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
 '      ПЕТРО', '      ВАСЕЧКИН', 2, '222-33-44'

);


insert into APP1$OWNERS(  FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES ( '  ЛЕЛИК   ', '  БОЛИК', 34, '333-33-44'

);


insert into APP1$OWNERS( FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
 '  МОНЯ', ' СВЕТЛИЧНЫЙ  ', 27, '444-33-44'

);


insert into APP1$OWNERS(  FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
 'СОНЯ', 'КОШКИНА', 10, '555-33-44'

);

commit;


select A.* from  APP1$OWNERS A;

