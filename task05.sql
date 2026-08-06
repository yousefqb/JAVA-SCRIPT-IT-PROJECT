--1
--using max
select max(salary)
from Instructor
union all
select max(salary)
from Instructor
where Salary != (select max(salary)
from Instructor)
union all
select max(salary)
from Instructor
where Salary not in
(
(select max(salary)from Instructor)
,
(select max(salary) from Instructor where Salary != (select max(salary) from Instructor))
)
--using top
select top(3) salary
from Instructor
order by salary desc
--using Rank
select Salary
from 
(select Salary , Rank()  over (order by Salary desc) as Rr
from Instructor) as new
where Rr <=3
--**************************************************************
--2
--using max
select max(salary)
from Instructor
where Salary not in
(
(select max(salary)from Instructor)
,
(select max(salary) from Instructor where Salary != (select max(salary) from Instructor))
)
--using top
select Top(1) salary
from(
select top(3) salary
from Instructor
order by Salary desc) as newtable
order by salary asc
--using rank
select salary 
from(
select * , rank()over (order by salary desc) as r
from Instructor) as newtt
where r=3;
--**********************************************************************
--3
SELECT TOP 3 *
FROM Student
ORDER BY NEWID();
--**********************************************************************
--4
select *
from(
SELECT St_Fname, St_Age, Dept_Id,
ROW_NUMBER() OVER (PARTITION BY Dept_Id ORDER BY St_Age DESC) AS RN
FROM Student
WHERE Dept_Id IS NOT NULL AND St_Age IS NOT NULL
) as st
where rn =1
--***********************************************************************
--5
SELECT *
FROM Instructor
WHERE Salary >(SELECT MIN(Salary)FROM Instructor)AND Salary< (SELECT MAX(Salary) FROM Instructor);
--***********************************************************************
--6
create schema Pr;
alter schema Pr transfer dbo.Student;
alter schema dbo transfer Pr.Student;
drop schema Pr;
--***********************************************************************
--7

CREATE DATABASE Test

SELECT * 
INTO Test.dbo.Employee
FROM MyCompany.dbo.Employee;

SELECT * 
INTO Test.dbo.Project
FROM MyCompany.dbo.Project
WHERE 1 = 0;

INSERT INTO Test.dbo.Project
SELECT * 
FROM MyCompany.dbo.Project;
--**************************************************************************
--8
CREATE TABLE employees
(
    fname    VARCHAR(50) NOT NULL,                            
    lname    VARCHAR(50) NOT NULL,                            
    Id       INT IDENTITY(1,1),                               
    Age      INT,                                             
    address  VARCHAR(50) CONSTRAINT C4 DEFAULT 'cairo',                     
    gender   CHAR(1),                                         
    salary   MONEY,
    DNo      INT,
    CONSTRAINT C1 PRIMARY KEY (Id),
    CONSTRAINT C2 UNIQUE (Age),
    CONSTRAINT C3 CHECK (Age > 18),
    CONSTRAINT C5 CHECK (gender IN ('M', 'F')),
    CONSTRAINT C6 FOREIGN KEY (DNo) REFERENCES Departments(Dnumber)
    ON DELETE SET NULL 
   ON UPDATE CASCADE
);
CREATE TABLE Departments (
    number INT PRIMARY KEY,                      
    name VARCHAR(50) NOT NULL UNIQUE,             
    Mgrstartdate DATE DEFAULT GETDATE()           
);
--*******************************************************************************