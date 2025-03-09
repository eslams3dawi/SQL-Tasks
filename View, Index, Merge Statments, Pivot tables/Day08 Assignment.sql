--1 (Part-1)
SELECT St_Id, St_Fname, St_Age, Dept_Id, ROW_NUMBER() OVER(PARTITION BY Dept_Id ORDER BY St_Age) AS RN
FROM ITI.dbo.Student

--2 (Part-1)
USE AdventureWorks2022
SELECT ProductNumber, [Name], [Weight],
NTIlE(30) OVER(ORDER BY [Weight]) AS NT
FROM AdventureWorks2022.Production.Product;

--3 (Part-1)
SELECT * 
FROM (SELECT Ins_Name, Dept_Id, Salary, DENSE_RANK() OVER(PARTITION BY Dept_Id ORDER BY Salary DESC) AS DR
		FROM ITI.dbo.Instructor) AS Ins
WHERE DR <= 2; 

--4 (Part-1)
USE CompanySD
SELECT *
FROM (SELECT *, ROW_NUMBER() OVER(ORDER BY [Hours] DESC)  AS RN
		FROM Works_for) AS WF
WHERE RN = 3;

--5 (Part-1)
	--The index enhances the selection query that uses the 
		--[Manager_hiredate] as a check condition. 

CREATE NONCLUSTERED INDEX idx1
ON ITI.dbo.Department(Manager_hiredate);

--6 (Part-1)
CREATE UNIQUE INDEX idx10
ON ITI.dbo.Student(St_Age);

--We can't add that index Constraint as the current data violate it [Uniqueness], 
	--there is more than one student that has the same age.

--7 (Part-1)
CREATE UNIQUE INDEX idx20
ON ITI.dbo.Department(Dept_Manager);

--1 (Part-2)
USE ITI;
-----------------
CREATE VIEW StuCrsGrd([Student Name], [Course Name], Grade)
AS
	SELECT CONCAT(St_Fname, St_Lname), Crs_Name, Grade 
	FROM Course C INNER JOIN Stud_Course SC ON C.Crs_Id = SC.Crs_Id
					INNER JOIN Student S ON S.St_Id = SC.St_Id
	WHERE Grade > 50;
--Testing
SELECT * FROM StuCrsGrd;

--2 (Part-2)
CREATE VIEW InsCrs([Instructor Name], [Course])
WITH ENCRYPTION
AS
	SELECT Ins_Name, Crs_Name
	FROM Department D INNER JOIN Instructor Ins ON Ins.Ins_Id = D.Dept_Manager
					INNER JOIN Ins_Course IC ON Ins.Ins_Id = IC.Ins_Id

					INNER JOIN Course C ON C.Crs_Id = IC.Crs_Id;
--Testing
SELECT * FROM InsCrs;
------
SP_HELPTEXT 'dbo.InsCrs';

--3 (Part-2)
CREATE VIEW InsDep
WITH SCHEMABINDING
AS
	SELECT Ins_Name, Dept_Name
	FROM dbo.Instructor Ins INNER JOIN dbo.Department D ON D.Dept_Id = Ins.Dept_Id
	WHERE Dept_Name IN('SD', 'Java');

--Testing
SELECT * FROM InsDep;

--Schema binding refers to the process of associating a database 
 --view to underlying tables in order to put indexes directly on 
  --the view. This may lead to great performance benefits when 
   --using the view; however, this tighter coupling is not without drawbacks.

--4 (Part-2)
CREATE VIEW V1
AS
	SELECT * 
	FROM Student
	WHERE St_Address IN('Cairo', 'Alex')
	WITH CHECK OPTION;

--Testing
Select * FROM V1;
--Update Test--
UPDATE V1
SET St_Address = 'Alex'
WHERE St_Address = 'Mansoura';
--Insertion Test--
INSERT INTO V1
VALUES(1010, 'V1FN', 'V1LN', 'Mansoura', 22, 10, 1)

--5 (Part-2)
CREATE TABLE #tempTable(id int, [Name] varchar);
--Testing--
INSERT INTO #tempTable
VALUES(1, 'H'), (2, 'E'), (3, 'L');

SELECT * FROM #tempTable;
--6 (Part-2)
	--First Way.
CREATE TABLE ##tempGlobalTable([Name] varchar(50), Salary int);

INSERT INTO ##tempGlobalTable
SELECT Ins_Name, Salary FROM Instructor;
--Testing.
SELECT * FROM ##tempGlobalTable;

--Second Way.
SELECT Ins_Name, Salary INTO ##tempGlobalTable2 FROM Instructor;
--Testing.
SELECT * FROM ##tempGlobalTable2;

--1 (Part-3)
USE Company_SD;
---------
CREATE VIEW PrjEmpCnt([Project Name], [Employees Count])
AS
	SELECT Pname, COUNT(ESSn) 
	FROM Project P INNER JOIN Works_for WF
	ON P.Pnumber = WF.Pno
	GROUP BY Pname;

--Testing.
SELECT * FROM PrjEmpCnt;

--2 (Part-3)
CREATE VIEW V_Count([Project Name], [Total Worked Hours])
AS
	SELECT Pname, Sum([Hours]) 
	FROM Project P LEFT OUTER JOIN Works_for WF
	ON P.Pnumber = WF.Pno
	GROUP BY Pname;

--Testing.
SELECT * FROM V_Count;

--3 (Part-3)
CREATE VIEW V_D30
AS
	SELECT WF.*
	FROM Project P INNER JOIN Works_for WF
	ON P.Pnumber = WF.Pno
	WHERE Dnum = 30;

--Testing.
SELECT * FROM V_D30;

--4 (Part-3)
CREATE VIEW V_Project_500
AS
	SELECT ESSn
	FROM V_D30
	WHERE Pno = 500;

--Testing
SELECT * FROM V_Project_500;

--5 (Part-3)
DROP VIEW V_D30, V_Count;

--Testing.
SELECT * FROM V_D30;
SELECT * FROM V_Count;

--6 (Part-3)
SELECT [Project Name]
FROM PrjEmpCnt 
WHERE [Project Name] LIKE '%c%';

--7 (Part-3)
	--a
ALTER TABLE Works_For ADD Enter_Date date;

	--b
UPDATE Works_for
SET Enter_Date = FORMAT(GETDATE(), 'MM-dd-yyyy');

--Testing;
SELECT * FROM Works_for;

	--c
CREATE VIEW v_2021_check
AS
	SELECT *
	FROM Works_for
	WHERE Enter_Date >= '01-01-2021' AND
			Enter_Date <= '12-31-2021'
	WITH CHECK OPTION;

--Testing.
SELECT * FROM v_2021_check;
--Insertion Test--
	--1 -----> Will not work as it does violate the check option (within the year 2021)
INSERT INTO v_2021_check
VALUES(521634, 500, 11, '01-01-2022');
	--2 ---> Will work.
INSERT INTO v_2021_check
VALUES(521634, 700, 11, '05-05-2021');

--Testing.
SELECT * FROM v_2021_check;

--SELECT EOMONTH('12-30-2021');
