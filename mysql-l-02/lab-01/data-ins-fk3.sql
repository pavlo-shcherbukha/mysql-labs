tee fk3.log
use test2


/* сначала выберем все записи*/
SELECT A.* FROM  APP1$DISCS A WHERE  A.IDOWNER=1;

/* Удаляем записи из талицы для который IDOWNER=1 */
DELETE FROM  APP1$DISCS  WHERE IDOWNER=1;

/* опять делаем выборку и убеждается что их нет*/
SELECT A.* FROM  APP1$DISCS A WHERE  A.IDOWNER=1;

/*Выполняем удаление из основной таблицы*/
DELETE FROM  APP1$OWNERS  WHERE IDOWNER=1;

