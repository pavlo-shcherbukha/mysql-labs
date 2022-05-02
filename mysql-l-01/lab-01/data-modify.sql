tee run_data_sel.log
use test2

/************************************/
select A.* from  APP1$OWNERS A;



update APP1$OWNERS B 
set B.AGE = 15, 
    B.PHONE = '111-11-11'
WHERE B.IDOWNER = 3;
commit;



select A.IDOWNER, A.AGE, A.PHONE from  APP1$OWNERS A WHERE A.IDOWNER=3 ;



update APP1$OWNERS B 
set B.AGE = 18, 
    B.PHONE = '555-55-55'
WHERE B.IDOWNER = 3;
rollback;



select A.IDOWNER, A.AGE, A.PHONE from  APP1$OWNERS A WHERE A.IDOWNER=3 ;

/***************************************/

DELETE FROM  APP1$OWNERS C WHERE C.IDOWNER IN (2,3);

commit;


select A.* from  APP1$OWNERS A;