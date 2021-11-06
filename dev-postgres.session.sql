
CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);

--drop table  COMPANY;

SELECT *
FROM information_schema.tables
--WHERE table_schema = 'public'
ORDER BY table_name;

