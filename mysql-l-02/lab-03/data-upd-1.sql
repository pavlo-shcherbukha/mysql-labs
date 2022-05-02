tee run_data.log
use test2

update APP1$OWNERS B 
set B.FIRSTNAME = '  ТИНА   ', 
    B.LASTNAME = '   КАРОЛЬ '
WHERE B.IDOWNER = 13;
commit;


update APP1$OWNERS B 
set B.FIRSTNAME = '  НАСТЯ  ', 
    B.LASTNAME = '   КАМЕНСКИ '
WHERE B.IDOWNER = 14;
commit;


update APP1$OWNERS B 
set B.FIRSTNAME = '  Верка  ', 
    B.LASTNAME = '   СЕРДЮЧКА '
WHERE B.IDOWNER = 15;
commit;





select A.* from  APP1$OWNERS A;

