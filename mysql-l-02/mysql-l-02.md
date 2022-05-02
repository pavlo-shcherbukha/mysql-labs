# Основні операції  розробника баз даних


## Элементы ссылочной целостности FOREIGN KEY

Элементы защиты данных в реляционных БД есть:

- Декларативные ограничения ( CONSTARINTS )

```text
CREATE TABLE APP1$OWNERS
(
    IDOWNER INT,
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
)

```

- Ограниения ссылочной целостности, синонимы: Foreing keys, внешние ключи, foreigbs.


Физически этот тип ограничений на данные говорит что  значения в столбце одной из таблиц могут быть только значениями  из определенного столбца другой таблицы.

Для демонстрации возможностей Foreign Key модифицируем скрипт на создание таблицы APP$DISCRS,  добавиви ограничение FOREIGN KEY


```sql

/**************************************************************

Создать таблицу дисков и закрепить  диски за владельцами
****************************************************************
*/
CREATE TABLE APP1$DISCS
(
    IDDISC   INT,
    DISCNAME VARCHAR(20),
    IDOWNER  INT,
    IDT      DATETIME,
    IUSRNM  VARCHAR(32),
    MDT DATETIME,
    MUSRNM  VARCHAR(32),
    CONSTRAINT APP1$DISC_PK PRIMARY KEY( IDDISC ),
    CONSTRAINT APP1$DISC_DISCNAME_NNL CHECK( DISCNAME IS NOT NULL ) ,
    CONSTRAINT APP1$DISC_IDOWNER_FK FOREIGN KEY ( IDOWNER )  REFERENCES APP1$OWNERS ( IDOWNER )
);


```
В даном примере этот constraint 

```text
CONSTRAINT APP1$DISC_IDOWNER_FK FOREIGN KEY ( IDOWNER )  REFERENCES APP1$OWNERS ( IDOWNER )
```
 описывает то, что поле IDOWNER этой таблицы может принимать значения  из одноименнго поля талицы REFERENCES

В скрипте **data-ins2.sql** написан нормлаьный процесс вставки данных. Нормальный - когда все значения допустимы 

и дальше  показана выборка данных


- из таблицы APP1$OWNERS
- из таблицы APP1$DISCS
- из соединения обеих таблиц.

```text

+---------+------------+----------------------+------+-----------+------+--------+------+--------+
| IDOWNER | FIRSTNAME  | LASTNAME             | AGE  | PHONE     | IDT  | IUSRNM | MDT  | MUSRNM |
+---------+------------+----------------------+------+-----------+------+--------+------+--------+
|       1 | ПЕТРО      | ВАСЕЧКИН             |    2 | 222-33-44 | NULL | NULL   | NULL | NULL   |
|       2 | ЛЕЛИК      | БОЛИК                |   34 | 333-33-44 | NULL | NULL   | NULL | NULL   |
|       3 | МОНЯ       | СВЕТЛИЧНЫЙ           |   27 | 444-33-44 | NULL | NULL   | NULL | NULL   |
|       4 | СОНЯ       | КОШКИНА              |   10 | 555-33-44 | NULL | NULL   | NULL | NULL   |
+---------+------------+----------------------+------+-----------+------+--------+------+--------+
4 rows in set (0.00 sec)

--------------
select B.* from APP1$DISCS B
--------------

+--------+-----------------------------+---------+------+--------+------+--------+
| IDDISC | DISCNAME                    | IDOWNER | IDT  | IUSRNM | MDT  | MUSRNM |
+--------+-----------------------------+---------+------+--------+------+--------+
|      1 | НУ ПОГОДИ                   |       1 | NULL | NULL   | NULL | NULL   |
|      2 | CИМСОНЫ                     |       1 | NULL | NULL   | NULL | NULL   |
|      3 | ОДИН ДОМА                   |       2 | NULL | NULL   | NULL | NULL   |
|      4 | ПСиХОЛОГИНИ                 |       2 | NULL | NULL   | NULL | NULL   |
|      5 | ЗВЕЗДНЫЕ ВОЙНЫ              |       2 | NULL | NULL   | NULL | NULL   |
|      6 | ПЕСНИ 70х                   |       3 | NULL | NULL   | NULL | NULL   |
|      7 | ДИСКОТЕКА 80х               |       3 | NULL | NULL   | NULL | NULL   |
|      8 | ДИСКОТЕКА 90х               |       3 | NULL | NULL   | NULL | NULL   |
|      9 | RAMSHTAIN                   |       4 | NULL | NULL   | NULL | NULL   |
|     10 | THE KISS                    |       4 | NULL | NULL   | NULL | NULL   |
|     11 | ТИНА КАРОЛЬ                 |       4 | NULL | NULL   | NULL | NULL   |
+--------+-----------------------------+---------+------+--------+------+--------+
11 rows in set (0.00 sec)

--------------
select A.IDOWNER, A.FIRSTNAME, A.LASTNAME, A.AGE, A.PHONE, B.IDDISC, B.DISCNAME, B.IDOWNER
FROM APP1$OWNERS A, APP1$DISCS B
WHERE A.IDOWNER=B.IDOWNER
--------------

+---------+------------+----------------------+------+-----------+--------+-----------------------------+---------+
| IDOWNER | FIRSTNAME  | LASTNAME             | AGE  | PHONE     | IDDISC | DISCNAME                    | IDOWNER |
+---------+------------+----------------------+------+-----------+--------+-----------------------------+---------+
|       1 | ПЕТРО      | ВАСЕЧКИН             |    2 | 222-33-44 |      1 | НУ ПОГОДИ                   |       1 |
|       1 | ПЕТРО      | ВАСЕЧКИН             |    2 | 222-33-44 |      2 | CИМСОНЫ                     |       1 |
|       2 | ЛЕЛИК      | БОЛИК                |   34 | 333-33-44 |      3 | ОДИН ДОМА                   |       2 |
|       2 | ЛЕЛИК      | БОЛИК                |   34 | 333-33-44 |      4 | ПСиХОЛОГИНИ                 |       2 |
|       2 | ЛЕЛИК      | БОЛИК                |   34 | 333-33-44 |      5 | ЗВЕЗДНЫЕ ВОЙНЫ              |       2 |
|       3 | МОНЯ       | СВЕТЛИЧНЫЙ           |   27 | 444-33-44 |      6 | ПЕСНИ 70х                   |       3 |
|       3 | МОНЯ       | СВЕТЛИЧНЫЙ           |   27 | 444-33-44 |      7 | ДИСКОТЕКА 80х               |       3 |
|       3 | МОНЯ       | СВЕТЛИЧНЫЙ           |   27 | 444-33-44 |      8 | ДИСКОТЕКА 90х               |       3 |
|       4 | СОНЯ       | КОШКИНА              |   10 | 555-33-44 |      9 | RAMSHTAIN                   |       4 |
|       4 | СОНЯ       | КОШКИНА              |   10 | 555-33-44 |     10 | THE KISS                    |       4 |
|       4 | СОНЯ       | КОШКИНА              |   10 | 555-33-44 |     11 | ТИНА КАРОЛЬ                 |       4 |
+---------+------------+----------------------+------+-----------+--------+-----------------------------+---------+
11 rows in set (0.00 sec)
```

## Как FOREIGN KEY защищают данные

- Поробуем вставить в таблицу APP1$DISCS запись со значением IDOWNER, которого НЕТ В ТАБЛИЦЕ APP1$OWNERS.

скрипт находится в файле data-ins-fk1.sql

ниже показан результат выполнения команды 

```text
Database changed
--------------
insert into  APP1$DISCS (IDDISC,DISCNAME,IDOWNER)  values (20, 'НЕТ ТАКОГО IDOWNER', 5)
--------------

ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`test2`.`app1$discs`, CONSTRAINT `APP1$DISC_IDOWNER_FK` FOREIGN KEY (`IDOWNER`) REFERENCES `app1$owners` (`IDOWNER`))
```

База данных не позволила вставить запись со значением IDOWNER=5  так как его нет в таблице, на которую ссылается foreign key.


- Попробуем удалить запись из основной таблциы  APP$OWNERS,  если на нее ссылаются записи из таблицы APP$DOSCS

скрипт находится в файле data-ins-fk2.sql

Ниже показан результат отработки удаления

```text
Database changed
--------------
DELETE FROM  APP1$OWNERS  WHERE IDOWNER=1
--------------

ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`test2`.`app1$discs`, CONSTRAINT `APP1$DISC_IDOWNER_FK` FOREIGN KEY (`IDOWNER`) REFERENCES `app1$owners` (`IDOWNER`))
```

Как видим система не позволила удалить данные, так как в  подчиненной таблице сущесуьвуют записи, со ссылкой на основную.

**Как удалить?**

Сначала удаляем записи из подчиненной таблцие. Потом из основной.

скрипт находится в файле data-ins-fk3.sql

Ниже показан результат отработки скрипта

```text

mysql> source data-ins-fk3.sql ;
Database changed
--------------
SELECT A.* FROM  APP1$DISCS A WHERE  A.IDOWNER=1
--------------

+--------+-------------------+---------+------+--------+------+--------+
| IDDISC | DISCNAME          | IDOWNER | IDT  | IUSRNM | MDT  | MUSRNM |
+--------+-------------------+---------+------+--------+------+--------+
|      1 | НУ ПОГОДИ         |       1 | NULL | NULL   | NULL | NULL   |
|      2 | CИМСОНЫ           |       1 | NULL | NULL   | NULL | NULL   |
+--------+-------------------+---------+------+--------+------+--------+
2 rows in set (0.00 sec)

--------------
DELETE FROM  APP1$DISCS  WHERE IDOWNER=1
--------------

Query OK, 2 rows affected (0.00 sec)

--------------
SELECT A.* FROM  APP1$DISCS A WHERE  A.IDOWNER=1
--------------

Empty set (0.00 sec)

--------------
DELETE FROM  APP1$OWNERS  WHERE IDOWNER=1
--------------

Query OK, 1 row affected (0.00 sec)

```

Выполнение удаление таким способом достаточно рутинно. Это хорошо что в пример только одна пдчиненная таблца. В реальной жизни сущетвуют гораздо более сложные ситуации. И тогода  ограничение FOREIGN KEY  дает разработчику определенный сервис, который назывется каскадным удалением

```
Каскадное удаление

Каскадное удаление позволяет при удалении строки из главной таблицы автоматически удалить все связанные строки из зависимой таблицы. Для этого применяется опция CASCADE:

	
CREATE TABLE Orders
(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    CustomerId INT,
    CreatedAt Date,
    FOREIGN KEY (CustomerId) REFERENCES Customers (Id) ON DELETE CASCADE
);

```

Поэтому модифицируем описание constraint в таблице APP$DISCS  добавив **ON DELETE CASCADE**.
модифицированная структура в db-build-2.sql. 

```sql

/**************************************************************

Создать таблицу дисков и закрепить  диски за владельцами
****************************************************************
*/
CREATE TABLE APP1$DISCS
(
    IDDISC   INT,
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


```

Теперь повторяем последовательность скриптов

```bash
source db-build-2.sql;
source data-ins2.sql;
source data-ins-fk2.sql  

```

И тут видно что удалнеие успешно выполнено, а проверочные запросы возвратили из обеих таблиц по 0 строк.

```text
mysql> source data-ins-fk2.sql
Logging to file 'fk2.log'
Database changed
--------------
DELETE FROM  APP1$OWNERS  WHERE IDOWNER=1
--------------

Query OK, 1 row affected (0.01 sec)

mysql>


mysql> SELECT A.* FROM  APP1$DISCS A WHERE  A.IDOWNER=1;
--------------
SELECT A.* FROM  APP1$DISCS A WHERE  A.IDOWNER=1
--------------

Empty set (0.00 sec)

mysql> SELECT A.* FROM  APP1$OWNERS A WHERE  A.IDOWNER=1;
--------------
SELECT A.* FROM  APP1$OWNERS A WHERE  A.IDOWNER=1
--------------

Empty set (0.00 sec)

```

## lab-03 Тригера базы даных

Реляционные базы данных позволяют часть логики по управлению данными в момент их изменения вынести на уровенть такого программного элемента как триггре.
Триггер  это уже программная единица  базы данных, которая срабатывает на события INSERT, UPDATE, DELETE и иметт модификаторы

BEFORE  -  значит запскает  перед INSERT, UPDATE, DELETE
AFTER - занчит запускаетс после INSERT, UPDATE, DELETE

Еще тригера  жедятся по запуску относитльено обьектов таблицы:
- табличные (БД ORACLE, в MYSQL я таких не нашел. Наверное собирались сделать но не сделали) 
- строчныие  ( Запускаются для каждой строки таблицы). В MYSQL  как и в ORACLE есть  модификатор FOR EACH ROW. Во многих других реляционных базах данных тригера только строчные.

Пример простого строчного пригера показан в файле: trg-01.sql 

```sql
/*тергера*/
-- однострочный комментарий
/*
много строчный 
комментарий

*/
tee trg.log

use test2; 

DROP TRIGGER IF EXISTS APP1$OWNERS_BI_TRG;

-- чтобы резделить  программный код тригера от одинчных SQL команд
-- По молчанию одиночные SQL команды завершаются знаком ';'


-- переключаем ;  на | и пришем код тригера. Интерпритатор его выполняет 
delimiter |

CREATE TRIGGER APP1$OWNERS_BI_TRG BEFORE INSERT ON APP1$OWNERS
  FOR EACH ROW
  BEGIN
    SET NEW.IDT = CURRENT_TIMESTAMP();
    SET NEW.IUSRNM = USER();
    SET NEW.FIRSTNAME = TRIM(NEW.FIRSTNAME) ;   
  END;
|

-- после окончания кода тригера нужно не забыть поставить "|" как признако того, что программная единица закончилась 

-- так как дальше будем выполнять другие sql команды, возвращаем ";"  назад
delimiter ;

```

Даный тригер срабатывает перед вставкой сроки в БД для каждой строки.
В тригерах есть специальные  указатели, на какую переменную ссылаемся  "NEW.<имя поля>" и "OLD.<имя поля>".

- NEW указывает, что обращаемся к значению поля, которая еще в БД не попала.
- OLD - обращается к значению поля, которое уже есть в таблице (к старому значению)

- В даном случае строку:

```text
    SET NEW.IDT = CURRENT_TIMESTAMP()
```

 интерпетируем как  перед вставкой в поле IDT ему присвоется значение текуще системной даты + времени

- Строка: 
```text
     SET NEW.IUSRNM = USER();
```

интерпретируем как перед вставкой в БД значение поля IUSRNM  просатвиться значение текущего пользователя базы данных.

- Строка 

```text
 SET NEW.FIRSTNAME = TRIM(NEW.FIRSTNAME) ;   

```

В даном случае выполним очистку  входных данных  и переданное пользователем текстовой поле, которое может иметь лидирующие и хвостовые пробелы - уберем  с помощью встроенной функции trim;

Теперь опять создадим струкуру данных, создадим триггер, выполним вставку записей в таблицу APP1$OWNERS и увидим что поменялось. Для этого выполняем команды в такой последовательности:

```text
  -- создать структуру
  source db-build-3.sql;

  -- создать тригера   
  source trg-01.sql;

  -- вставить записи, причем в поля FIRSTNAME, LASTNAME  добавлены пробелы для лучшей демонстрации что сделает триггер 
  source data-ins-3.sql;

```

Ниже показан результат выполнения:

```text


--------------
select A.* from  APP1$OWNERS A
--------------

+---------+------------+-------------------------+------+-----------+---------------------+----------------+------+--------+
| IDOWNER | FIRSTNAME  | LASTNAME                | AGE  | PHONE     | IDT                 | IUSRNM         | MDT  | MUSRNM |
+---------+------------+-------------------------+------+-----------+---------------------+----------------+------+--------+
|       9 | ПЕТРО      |       ВАСЕЧКИН          |    2 | 222-33-44 | 2021-07-23 12:36:26 | root@localhost | NULL | NULL   |
|      10 | ЛЕЛИК      |   БОЛИК                 |   34 | 333-33-44 | 2021-07-23 12:36:26 | root@localhost | NULL | NULL   |
|      11 | МОНЯ       |  СВЕТЛИЧНЫЙ             |   27 | 444-33-44 | 2021-07-23 12:36:26 | root@localhost | NULL | NULL   |
|      12 | СОНЯ       | КОШКИНА                 |   10 | 555-33-44 | 2021-07-23 12:36:26 | root@localhost | NULL | NULL   |
+---------+------------+-------------------------+------+-----------+---------------------+----------------+------+--------+
4 rows in set (0.00 sec)


```

Триггер был настроен только на поле FIRSTNAME - и в нем все значения находятся ровненько. А вот в поле LASTNAME, которое триггер не обработал - беспорядок.
Дальше, у нас автоматичаски заполнились поля idt,  датой вставки, и IUSRNM  логином пользоватля кто встаивл запись. Уже появился какой то вариант журнализации действий пользователя.

А вот при обновлении записи у нас эти поля не заполняются. Зполним их, написав тригер на **BEFORE UPDATE** , файл **trg-02.sql** ;
создадит триггер командой:

```text
    source trg-02.sql;

-- =====================РЕЗУЛЬТАТ====================
mysql> source trg-02.sql;
Logging to file 'trg.log'
Database changed
--------------
DROP TRIGGER IF EXISTS APP1$OWNERS_BU_TRG
--------------

Query OK, 0 rows affected, 1 warning (0.00 sec)

--------------
CREATE TRIGGER APP1$OWNERS_BU_TRG BEFORE UPDATE ON APP1$OWNERS
  FOR EACH ROW
  BEGIN
    SET NEW.MDT = CURRENT_TIMESTAMP();
    SET NEW.MUSRNM = USER();
    SET NEW.FIRSTNAME = TRIM(NEW.FIRSTNAME) ;
    SET NEW.LASTNAME = TRIM(NEW.LASTNAME) ;
  END;
--------------

Query OK, 0 rows affected (0.01 sec)
```

Теперь попробуем сдеалть  несколько обновлений.

```text

update APP1$OWNERS B 
set B.FIRSTNAME = '  ТИНА   ', 
    B.LASTNAME = '   КАРОЛЬ '
WHERE B.IDOWNER = 1;
commit;


update APP1$OWNERS B 
set B.FIRSTNAME = '  НАСТЯ  ', 
    B.LASTNAME = '   КАМЕНСКИ '
WHERE B.IDOWNER = 2;
commit;


update APP1$OWNERS B 
set B.FIRSTNAME = '  Верка  ', 
    B.LASTNAME = '   СЕРДЮЧКА '
WHERE B.IDOWNER = 3;
commit;

```

Ну и результат:

```text

--------------
select A.* from  APP1$OWNERS A
--------------

+---------+------------+-------------------------+------+-----------+---------------------+----------------+------+--------+
| IDOWNER | FIRSTNAME  | LASTNAME                | AGE  | PHONE     | IDT                 | IUSRNM         | MDT  | MUSRNM |
+---------+------------+-------------------------+------+-----------+---------------------+----------------+------+--------+
|      13 | ПЕТРО      |       ВАСЕЧКИН          |    2 | 222-33-44 | 2021-07-23 13:25:25 | root@localhost | NULL | NULL   |
|      14 | ЛЕЛИК      |   БОЛИК                 |   34 | 333-33-44 | 2021-07-23 13:25:25 | root@localhost | NULL | NULL   |
|      15 | МОНЯ       |  СВЕТЛИЧНЫЙ             |   27 | 444-33-44 | 2021-07-23 13:25:25 | root@localhost | NULL | NULL   |
|      16 | СОНЯ       | КОШКИНА                 |   10 | 555-33-44 | 2021-07-23 13:25:25 | root@localhost | NULL | NULL   |
+---------+------------+-------------------------+------+-----------+---------------------+----------------+------+--------+
4 rows in set (0.00 sec)

mysql> source data-upd-1.sql;
Logging to file 'run_data.log'
Database changed
--------------
update APP1$OWNERS B
set B.FIRSTNAME = '  ТИНА   ',
    B.LASTNAME = '   КАРОЛЬ '
WHERE B.IDOWNER = 13
--------------

Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

--------------
commit
--------------

Query OK, 0 rows affected (0.00 sec)

--------------
update APP1$OWNERS B
set B.FIRSTNAME = '  НАСТЯ  ',
    B.LASTNAME = '   КАМЕНСКИ '
WHERE B.IDOWNER = 14
--------------

Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

--------------
commit
--------------

Query OK, 0 rows affected (0.00 sec)

--------------
update APP1$OWNERS B
set B.FIRSTNAME = '  Верка  ',
    B.LASTNAME = '   СЕРДЮЧКА '
WHERE B.IDOWNER = 15
--------------

Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

--------------
commit
--------------

Query OK, 0 rows affected (0.00 sec)

--------------
select A.* from  APP1$OWNERS A
--------------

+---------+------------+------------------+------+-----------+---------------------+----------------+---------------------+----------------+
| IDOWNER | FIRSTNAME  | LASTNAME         | AGE  | PHONE     | IDT                 | IUSRNM         | MDT                 | MUSRNM         |
+---------+------------+------------------+------+-----------+---------------------+----------------+---------------------+----------------+
|      13 | ТИНА       | КАРОЛЬ           |    2 | 222-33-44 | 2021-07-23 13:25:25 | root@localhost | 2021-07-23 13:26:09 | root@localhost |
|      14 | НАСТЯ      | КАМЕНСКИ         |   34 | 333-33-44 | 2021-07-23 13:25:25 | root@localhost | 2021-07-23 13:26:09 | root@localhost |
|      15 | Верка      | СЕРДЮЧКА         |   27 | 444-33-44 | 2021-07-23 13:25:25 | root@localhost | 2021-07-23 13:26:09 | root@localhost |
|      16 | СОНЯ       | КОШКИНА          |   10 | 555-33-44 | 2021-07-23 13:25:25 | root@localhost | NULL                | NULL           |
+---------+------------+------------------+------+-----------+---------------------+----------------+---------------------+----------------+
4 rows in set (0.00 sec)

```

