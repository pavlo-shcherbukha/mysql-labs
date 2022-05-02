tee run_data.log
use test2

/**
Удаляем предыдущие данные
*/
delete from APP1$OWNERS;
commit ;

insert into APP1$OWNERS( IDOWNER, FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
1, 'ПЕТРО', 'ВАСЕЧКИН', 2, '222-33-44'

);


insert into APP1$OWNERS( IDOWNER, FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
2, 'ЛЕЛИК', 'БОЛИК', 34, '333-33-44'

);


insert into APP1$OWNERS( IDOWNER, FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
3, 'МОНЯ', 'СВЕТЛИЧНЫЙ', 27, '444-33-44'

);


insert into APP1$OWNERS( IDOWNER, FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
4, 'СОНЯ', 'КОШКИНА', 10, '555-33-44'

);

insert into APP1$OWNERS( IDOWNER, FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
5, 'ПОСОМТРИ', 'ТЕЛЕФОН', 43, '222-33-44'

);


insert into APP1$OWNERS( IDOWNER, FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
7, 'ПОСОМТРИ', 'NULL AGE', null, '666-33-44'

);



insert into APP1$OWNERS( IDOWNER, FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
8, 'ПОСОМТРИ', 'КАКОЙ-ДОЛГОЖИТЕЛЬ', 120, '666-33-44'

);





commit;

select A.* from  APP1$OWNERS A;

