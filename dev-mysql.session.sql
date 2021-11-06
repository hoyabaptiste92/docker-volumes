CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
) default charset utf8 COMMENT '';

--drop table  COMPANY;

SELECT table_name
FROM information_schema.tables
--WHERE table_schema = 'public'
ORDER BY table_name;