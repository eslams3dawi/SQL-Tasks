--1
USE ITI
CREATE VIEW VSTUD
AS
	SELECT St_Fname + ' ' + St_Lname AS [Full Name], Crs_Name, Grade
	FROM Student S INNER JOIN Stud_Course SC	
	ON S.St_Id = SC.St_Id
	INNER JOIN Course C
	ON C.Crs_Id = SC.Crs_Id
	WHERE Grade > 50
--TESTING 
SELECT * FROM VSTUD

--2
CREATE VIEW VINSCRS
WITH ENCRYPTION
AS
	SELECT Ins_Name, Top_Name
	FROM Instructor I INNER JOIN Ins_Course IC
	ON I.Ins_Id = IC.Crs_Id
	INNER JOIN Course C 
	ON C.Crs_Id = IC.Crs_Id
	INNER JOIN Topic T
	ON T.Top_Id = C.Top_Id
--TESTING
SELECT * FROM VINSCRS

--3
CREATE VIEW VINSDEPT
AS
	SELECT Ins_Name, Dept_Name
	FROM dbo.Instructor I INNER JOIN dbo.Department D
	ON I.Dept_Id = D.Dept_Id
	WHERE Dept_Name IN ('SD', 'JAVA')
--TESTING
SELECT * FROM VINSDEPT

--4
CREATE VIEW VCAI_ALEX
AS
	SELECT *
	FROM Student
	WHERE St_Address IN('Cairo', 'Alex')
	WITH CHECK OPTION
--TESTING
SELECT * FROM VCAI_ALEX

--5
USE CompanySD
CREATE VIEW VPRJ_EMP
AS
	SELECT PName, COUNT(SSN) AS [Number Of Employees]
	FROM Employee E INNER JOIN Works_for WF
	ON E.SSN = WF.ESSn
	INNER JOIN Project P
	ON P.Pnumber = WF.Pno
	GROUP BY Pname

--TESTING
SELECT * FROM VPRJ_EMP

--6
	--a
	CREATE SCHEMA Company;
	ALTER SCHEMA Company TRANSFER dbo.Departments
	ALTER SCHEMA Company TRANSFER dbo.Project

	--b
	CREATE SCHEMA HR;
	ALTER SCHEMA HR TRANSFER dbo.Employee

