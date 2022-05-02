tee run_data.log
use test2

/**
Удаляем предыдущие данные
*/
delete from APP1$OWNERS;
commit ;

insert into APP1$OWNERS(  FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
 'ПЕТРО', 'ВАСЕЧКИН', 2, '222-33-44'

);


insert into APP1$OWNERS(  FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES ( 'ЛЕЛИК', 'БОЛИК', 34, '333-33-44'

);


insert into APP1$OWNERS( FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
 'МОНЯ', 'СВЕТЛИЧНЫЙ', 27, '444-33-44'

);


insert into APP1$OWNERS(  FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
 'СОНЯ', 'КОШКИНА', 10, '555-33-44'

);

commit;


insert into  APP1$DISCS (DISCNAME,IDOWNER)  values ('НУ ПОГОДИ', 1);
insert into  APP1$DISCS (DISCNAME,IDOWNER)  values ('CИМСОНЫ', 1);
insert into  APP1$DISCS (DISCNAME,IDOWNER)  values ('ОДИН ДОМА', 2);
insert into  APP1$DISCS (DISCNAME,IDOWNER)  values ('ПСиХОЛОГИНИ', 2);
insert into  APP1$DISCS (DISCNAME,IDOWNER)  values ('ЗВЕЗДНЫЕ ВОЙНЫ', 2);
insert into  APP1$DISCS (DISCNAME,IDOWNER)  values ('ПЕСНИ 70х', 3);
insert into  APP1$DISCS (DISCNAME,IDOWNER)  values ('ДИСКОТЕКА 80х', 3);
insert into  APP1$DISCS (DISCNAME,IDOWNER)  values ('ДИСКОТЕКА 90х', 3);
insert into  APP1$DISCS (DISCNAME,IDOWNER)  values ('RAMSHTAIN', 4);
insert into  APP1$DISCS (DISCNAME,IDOWNER)  values ( 'THE KISS', 4);
insert into  APP1$DISCS (DISCNAME,IDOWNER)  values ( 'ТИНА КАРОЛЬ', 4);




select A.* from  APP1$OWNERS A;

select B.* from APP1$DISCS B;


select A.IDOWNER, A.FIRSTNAME, A.LASTNAME, A.AGE, A.PHONE, B.IDDISC, B.DISCNAME, B.IDOWNER
FROM APP1$OWNERS A, APP1$DISCS B
WHERE A.IDOWNER=B.IDOWNER ;

