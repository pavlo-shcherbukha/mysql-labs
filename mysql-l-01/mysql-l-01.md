# Основні операції  розробника баз даних


## стандртний конслольный клієнт

- Запуск обычной версии 

"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" "--defaults-file=C:\ProgramData\MySQL\MySQL Server 8.0\my.ini" "-uroot" "-p"

- запуск Юникодной версии 

"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" "--defaults-file=C:\ProgramData\MySQL\MySQL Server 8.0\my.ini" "-uroot" "-p" "--default-character-set=utf8mb4"


Опции которые используются при подключении.
```text
Usage: mysql [OPTIONS] [database]
  -?, --help          Display this help and exit.
  -I, --help          Synonym for -?
  --bind-address=name IP address to bind to.
  -D, --database=name Database to use.
  --delimiter=name    Delimiter to be used.
  --default-character-set=name Set the default character set.
  -f, --force         Continue even if we get an SQL error.
  -p, --password[=name] Password to use when connecting to server.
  -h, --host=name     Connect to host.
  -P, --port=#        Port number to use for connection or 0 for default to, in order of preference, my.cnf, $MYSQL_TCP_PORT, /etc/services, built-in default (3306).
  --protocol=name     The protocol to use for connection (tcp, socket, pipe,
  -s, --silent        Be more silent. Print results with a tab as separator, each row on new line.
  -v, --verbose       Write more. (-v -v -v gives the table output format).
  -V, --version       Output version information and exit.
  -w, --wait          Wait and retry if connection is down.
```

следует обратить внимание на опцию 

```
-v, --verbose       Write more. (-v -v -v gives the table output format)
```
которая позволяет детализировать пакетное выполенние DDL файла

- запуск winshell версии

"C:\Program Files\MySQL\MySQL Shell 8.0\bin\mysqlsh.exe"


Запустим эту программу. MySQL Shell поддерживает ввод команд на трех языках: JavaScript, Python и SQL. Для установки используемого языка применяются следующие команды: \js, \py и \sql. По умолчанию применяется JavaScript. Но поскольку мы будем использовать SQL, то переключимся на этот язык, введя команду \sql

## подключение к серверу, расположенному на другой машине

ля взаимодействия с сервером MySQL вначале необходимо подключиться к нему. Для этого применяется команда \connect, после которой указывается идентификатор (uri) в формате имя_пользователя@хост:порт. Поскольку в большинстве случае используют локальный сервер MySQL, который запущен на порту 3306, а для сервера mySQL доступен как минимум один пользователь - root, то можно использовать для подключения следующий идентификатор: root@localhost:3306. Иначе надо поправить либо имя пользователя, либо адрес, либо порт.


## робота с базой данных

- получить список баз данных

```text
 show databases

```

```text

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| world              |
+--------------------+
6 rows in set (0.00 sec)

mysql>
```

- создать  БД 

```text
create database test;
```

- удалить БД

```text
drop database test;

```

- переключится на выбранную БД

```text

    use test

```


## Запуск sql скриптов с комадной строки


```text

?         (\?) Synonym for `help'.
clear     (\c) Clear the current input statement.
connect   (\r) Reconnect to the server. Optional arguments are db and host.
delimiter (\d) Set statement delimiter.
ego       (\G) Send command to mysql server, display result vertically.
exit      (\q) Exit mysql. Same as quit.
go        (\g) Send command to mysql server.
help      (\h) Display this help.
notee     (\t) Don't write into outfile.
print     (\p) Print current command.
prompt    (\R) Change your mysql prompt.
quit      (\q) Quit mysql.
rehash    (\#) Rebuild completion hash.
source    (\.) Execute an SQL script file. Takes a file name as an argument.
status    (\s) Get status information from the server.
system    (\!) Execute a system shell command.
tee       (\T) Set outfile [to_outfile]. Append everything into given outfile.
use       (\u) Use another database. Takes database name as argument.
charset   (\C) Switch to another charset. Might be needed for processing binlog with multi-byte charsets.
warnings  (\W) Show warnings after every statement.
nowarning (\w) Don't show warnings after every statement.
resetconnection(\x) Clean session context.
query_attributes Sets string parameters (name1 value1 name2 value2 ...) for the next query to pick up.

For server side help, type 'help contents'

```

## Выполняем с помощью bat (cmd) файлов

### lab-01 Простой командный файл для запуска скриптов БД

- mysqlrun.cmd 
Подключается к БД 

- db.sql 

простой скрипт для проверки работы, который возвращает список БД

- db-build.sql 

Создание БД и в ней 2 таблицы

Результат выполнения скрипта на консоле
```text
mysql> source db-build.sql
Logging to file 'run.log'
--------------
drop database IF EXISTS test2
--------------

Query OK, 2 rows affected (0.04 sec)

--------------
create database test2
--------------

Query OK, 1 row affected (0.01 sec)

--------------
show databases
--------------

+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| test1              |
| test2              |
| world              |
+--------------------+
8 rows in set (0.00 sec)

Database changed
--------------
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
--------------

Query OK, 0 rows affected (0.03 sec)

--------------
SHOW TABLES
--------------

+-----------------+
| Tables_in_test2 |
+-----------------+
| app1$owners     |
+-----------------+
1 row in set (0.00 sec)

--------------
CREATE TABLE APP1$DISCS
(
    IDDISC INT,
    DISCNAME VARCHAR(20),
    IDOWNER  VARCHAR(20),
    IDT DATETIME,
    IUSRNM  VARCHAR(32),
    MDT DATETIME,
    MUSRNM  VARCHAR(32),
    CONSTRAINT APP1$DISC_PK PRIMARY KEY( IDDISC )
)
--------------

Query OK, 0 rows affected (0.02 sec)

--------------
SHOW TABLES
--------------

+-----------------+
| Tables_in_test2 |
+-----------------+
| app1$discs      |
| app1$owners     |
+-----------------+
2 rows in set (0.00 sec)

mysql>

```



- db-getstru.sql

Анализ структуры существуюущей БД и вывод ее отдельный файл


```text

--------------
show databases
--------------

+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| test1              |
| test2              |
| world              |
+--------------------+
8 rows in set (0.00 sec)

Database changed
--------------
DESCRIBE APP1$OWNERS
--------------

+-----------+-------------------+------+-----+---------+-------+
| Field     | Type              | Null | Key | Default | Extra |
+-----------+-------------------+------+-----+---------+-------+
| IDOWNER   | int               | NO   | PRI | NULL    |       |
| FIRSTNAME | varchar(20)       | YES  |     | NULL    |       |
| LASTNAME  | varchar(20)       | YES  |     | NULL    |       |
| AGE       | smallint unsigned | YES  |     | NULL    |       |
| PHONE     | varchar(20)       | YES  | UNI | NULL    |       |
| IDT       | datetime          | YES  |     | NULL    |       |
| IUSRNM    | varchar(32)       | YES  |     | NULL    |       |
| MDT       | datetime          | YES  |     | NULL    |       |
| MUSRNM    | varchar(32)       | YES  |     | NULL    |       |
+-----------+-------------------+------+-----+---------+-------+
9 rows in set (0.00 sec)

--------------
DESCRIBE TABLE APP1$DISCS
--------------

+----+-------------+------------+------------+------+---------------+------+---------+------+------+----------+-------+
| id | select_type | table      | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra |
+----+-------------+------------+------------+------+---------------+------+---------+------+------+----------+-------+
|  1 | SIMPLE      | APP1$DISCS | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    1 |   100.00 | NULL  |
+----+-------------+------------+------------+------+---------------+------+---------+------+------+----------+-------+
1 row in set, 1 warning (0.00 sec)

mysql> source db-build.sql


```


- data-ins.sql

Тут выполняются операции вставки строк в таблицу.


Ниже показана она ошибка, когда сработал уникальный констреинт и не позволил двум разным людям присвоить один и тот же телефон

``` text
--------------
insert into APP1$OWNERS( IDOWNER, FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
4, 'СОНЯ', 'КОШКИНА', 10, '555-33-44'

)
--------------

Query OK, 1 row affected (0.01 sec)

--------------
insert into APP1$OWNERS( IDOWNER, FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
5, 'ПОСОМТРИ', 'ТЕЛЕФОН', 43, '222-33-44'

)
--------------

ERROR 1062 (23000): Duplicate entry '222-33-44' for key 'app1$owners.APP1$OWNERS_PHONE_UK'
--------------
insert into APP1$OWNERS( IDOWNER, FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
7, 'ПОСОМТРИ', 'NULL AGE', null, '666-33-44'

)
--------------

ERROR 3819 (HY000): Check constraint 'APP1$OWNERS_AGE_NNL' is violated.
--------------
insert into APP1$OWNERS( IDOWNER, FIRSTNAME, LASTNAME, AGE, PHONE )
VALUES (
8, 'ПОСОМТРИ', 'КАКОЙ-ДОЛГОЖИТЕЛЬ', 120, '666-33-44'

)
--------------

ERROR 3819 (HY000): Check constraint 'APP1$OWNERS_AGE_RNG' is violated.
--------------
commit
--------------

Query OK, 0 rows affected (0.00 sec)

--------------
select A.* from  APP1$OWNERS A
--------------

+---------+------------+----------------------+------+-----------+------+--------+------+--------+
| IDOWNER | FIRSTNAME  | LASTNAME             | AGE  | PHONE     | IDT  | IUSRNM | MDT  | MUSRNM |
+---------+------------+----------------------+------+-----------+------+--------+------+--------+
|       1 | ПЕТРО      | ВАСЕЧКИН             |    2 | 222-33-44 | NULL | NULL   | NULL | NULL   |
|       2 | ЛЕЛИК      | БОЛИК                |   34 | 333-33-44 | NULL | NULL   | NULL | NULL   |
|       3 | МОНЯ       | СВЕТЛИЧНЫЙ           |   27 | 444-33-44 | NULL | NULL   | NULL | NULL   |
|       4 | СОНЯ       | КОШКИНА              |   10 | 555-33-44 | NULL | NULL   | NULL | NULL   |
+---------+------------+----------------------+------+-----------+------+--------+------+--------+
4 rows in set (0.00 sec)


```


- data-modify.sql 

```text

mysql> source data-modify.sql;
Database changed
--------------
select A.* from  APP1$OWNERS A
--------------

+---------+------------+----------------------+------+-----------+------+--------+------+--------+
| IDOWNER | FIRSTNAME  | LASTNAME             | AGE  | PHONE     | IDT  | IUSRNM | MDT  | MUSRNM |
+---------+------------+----------------------+------+-----------+------+--------+------+--------+
|       1 | ПЕТРО      | ВАСЕЧКИН             |    2 | 222-33-44 | NULL | NULL   | NULL | NULL   |
|       2 | ЛЕЛИК      | БОЛИК                |   34 | 333-33-44 | NULL | NULL   | NULL | NULL   |
|       3 | МОНЯ       | СВЕТЛИЧНЫЙ           |   18 | 555-55-55 | NULL | NULL   | NULL | NULL   |
|       4 | СОНЯ       | КОШКИНА              |   10 | 555-33-44 | NULL | NULL   | NULL | NULL   |
+---------+------------+----------------------+------+-----------+------+--------+------+--------+
4 rows in set (0.00 sec)

--------------
update APP1$OWNERS B 
set B.AGE = 15, 
    B.PHONE = '111-11-11'
WHERE B.IDOWNER = 3
--------------

Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

--------------
commit
--------------

Query OK, 0 rows affected (0.00 sec)

--------------
select A.IDOWNER, A.AGE, A.PHONE from  APP1$OWNERS A WHERE A.IDOWNER=3
--------------

+---------+------+-----------+
| IDOWNER | AGE  | PHONE     |
+---------+------+-----------+
|       3 |   15 | 111-11-11 |
+---------+------+-----------+
1 row in set (0.00 sec)

--------------
update APP1$OWNERS B 
set B.AGE = 18, 
    B.PHONE = '555-55-55'
WHERE B.IDOWNER = 3
--------------

Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

--------------
rollback
--------------

Query OK, 0 rows affected (0.00 sec)

--------------
select A.IDOWNER, A.AGE, A.PHONE from  APP1$OWNERS A WHERE A.IDOWNER=3
--------------

+---------+------+-----------+
| IDOWNER | AGE  | PHONE     |
+---------+------+-----------+
|       3 |   18 | 555-55-55 |
+---------+------+-----------+
1 row in set (0.00 sec)

--------------
DELETE FROM  APP1$OWNERS C WHERE C.IDOWNER IN (2,3)
--------------

Query OK, 2 rows affected (0.00 sec)

--------------
commit
--------------

Query OK, 0 rows affected (0.00 sec)



```

Обновление и модификация данных.

## Тренировочное зазадние


На основании приведенных примеров создать базу данных xcustomer

В базе данных создать 3 таблицы под такие сущности:

- Таблица филиалов или отделений

Должана соодержать поля

    - внутренний идентификатор филиала, число, первичный ключ 
   
    - Код филиала (будт виден пользователям). Строка в 2 символа, всегда должна быть заплнен 2мя занками, уникальный
    
    - Наименование филиала. Строка до 40 знаков. ВСегда должна ыть заполнена
   
    - Дата начала действия. Дата (без времени), обязательный для заполения
    
    - Дата окончания действия. Не обязательный для заполнения. Если дата окончания введена, то она  должна быть больше или равна дате старта
    
    - Кол-во клиентов. число 5 дес. знаков. от 0 и до максимума. NULL не допустим.

Написать скипт для вставки в таблицу 5 филиалов - скажем так, первичная загрузка данных


- Таблица Клиентов филиалов

Должна содержать поля:

    - код клиента (чисо, первичный ключ), оно же ID клиента
    
    - Внутренний идентификаторв филиала (см табличку филиалов)
    
    - Натменование клиента строка (50 знаков)
    
    - признак активный или не активный. Допустимы логичечкие значения YES/NO, TRUE/FALSE, 1/0
   
    - Дата заведения
    
    - дата закрытия
    


    В созданную таблицу вставить 10 записей.



    ВСе офрмитьв в одном или несколькоих файлах скриптах, чтобы код был повторяемый и можно было постоянно запукать


