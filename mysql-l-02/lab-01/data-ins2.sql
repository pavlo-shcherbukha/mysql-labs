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

commit;


insert into  APP1$DISCS (IDDISC,DISCNAME,IDOWNER)  values (1, 'НУ ПОГОДИ', 1);
insert into  APP1$DISCS (IDDISC,DISCNAME,IDOWNER)  values (2, 'CИМСОНЫ', 1);
insert into  APP1$DISCS (IDDISC,DISCNAME,IDOWNER)  values (3, 'ОДИН ДОМА', 2);
insert into  APP1$DISCS (IDDISC,DISCNAME,IDOWNER)  values (4, 'ПСиХОЛОГИНИ', 2);
insert into  APP1$DISCS (IDDISC,DISCNAME,IDOWNER)  values (5, 'ЗВЕЗДНЫЕ ВОЙНЫ', 2);
insert into  APP1$DISCS (IDDISC,DISCNAME,IDOWNER)  values (6, 'ПЕСНИ 70х', 3);
insert into  APP1$DISCS (IDDISC,DISCNAME,IDOWNER)  values (7, 'ДИСКОТЕКА 80х', 3);
insert into  APP1$DISCS (IDDISC,DISCNAME,IDOWNER)  values (8, 'ДИСКОТЕКА 90х', 3);
insert into  APP1$DISCS (IDDISC,DISCNAME,IDOWNER)  values (9, 'RAMSHTAIN', 4);
insert into  APP1$DISCS (IDDISC,DISCNAME,IDOWNER)  values (10, 'THE KISS', 4);
insert into  APP1$DISCS (IDDISC,DISCNAME,IDOWNER)  values (11, 'ТИНА КАРОЛЬ', 4);




select A.* from  APP1$OWNERS A;

select B.* from APP1$DISCS B;


select A.IDOWNER, A.FIRSTNAME, A.LASTNAME, A.AGE, A.PHONE, B.IDDISC, B.DISCNAME, B.IDOWNER
FROM APP1$OWNERS A, APP1$DISCS B
WHERE A.IDOWNER=B.IDOWNER ;

