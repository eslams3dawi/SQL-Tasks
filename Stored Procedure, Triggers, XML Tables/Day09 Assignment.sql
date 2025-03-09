SELECT DB_NAME() AS [Current Database];

/*
	*----> Part [1] <----*
*/
------------------
USE ITI;--||||||||
------------------
--1
CREATE PROC DepStuCnt
AS 
	SELECT D.Dept_Id, D.Dept_Name,  COUNT(*) AS 'Number of students'
	FROM Department D INNER JOIN Student S
	ON D.Dept_Id = S.Dept_Id
	GROUP BY D.Dept_Id, D.Dept_Name;

	--Testing
DepStuCnt;

--2
CREATE TRIGGER t1
ON Department
INSTEAD OF INSERT
AS
	SELECT 'You can’t insert a new record in that table'

	--Testing
INSERT INTO Department(Dept_Id, Dept_Name) VALUES(120, 'SSCC');

--3
CREATE TABLE stuHistory([user_name] varchar(50), [date] date, [note] varchar(120))

CREATE TRIGGER t2
ON Student
AFTER INSERT
AS
	INSERT INTO stuHistory 
	VALUES(SUSER_NAME(), GETDATE(), CONCAT(SUSER_NAME(), 
				' inserted a new row with Key = ', 
				(SELECT St_Id FROM INSERTED), ' in table student.'));
	--Testing
INSERT INTO Student(St_Id, St_Fname, St_Age) 
VALUES(11, 'MEZO', 12);

SELECT * FROM Student WHERE St_Id = 11;
SELECT * FROM stuHistory;
--4
CREATE TRIGGER t3
ON Student 
INSTEAD OF DELETE
AS
	INSERT INTO stuHistory 
	VALUES(SUSER_NAME(), GETDATE(), CONCAT(SUSER_NAME(), 
				' tried to delete row with Key = ', 
				(SELECT St_Id FROM INSERTED), ' in table student.'));
	--Testing
DELETE FROM Student WHERE St_Id = 11;

SELECT * FROM Student WHERE St_Id = 11;
SELECT * FROM stuHistory;

--------------------------
USE Company_SD; --||||||||
--------------------------
--5
CREATE PROC EmpProj_100
AS
	DECLARE @cnt int = (SELECT COUNT(*) FROM Works_for WHERE Pno = 100)
	IF @cnt > 3
		SELECT 'The number of employees in the project 100 is 3 or more';
	ELSE
		BEGIN
			SELECT 'The following employees work for the project 100';
			SELECT Fname, Lname FROM Employee E INNER JOIN Works_for WF ON E.SSN = WF.ESSn WHERE Pno = 100;
		END
	--Testing
EmpProj_100;

--6
CREATE PROC NewEmpOldProj @oldId int, @newId int, @projNo int
AS
	UPDATE Works_for
	SET ESSn = @newId
	WHERE ESSn = @oldId AND Pno = @projNo
	
	--Testing
EXECUTE NewEmpOldProj 102672, 521634, 100;
		--Test the test
SELECT * FROM Works_for WHERE ESSn = 102672 AND Pno = 100;

--7
CREATE TABLE ProjHistory (
	Pno int,
	userName varchar(50),
	modifiedDate date,
	Hours_old int,
	Hours_new int
	)

CREATE TRIGGER t7
ON Works_for
AFTER UPDATE
AS
	IF UPDATE([Hours])
		INSERT INTO ProjHistory
		VALUES(
			(SELECT Pno FROM DELETED), SUSER_NAME(), GETDATE(), 
			(SELECT [Hours] FROM DELETED), 
			(SELECT [Hours] FROM INSERTED)
			)
	--Testing
UPDATE Works_for
SET [Hours] = 123
WHERE ESSn = 521634 AND Pno = 100
		--Test the test
SELECT * FROM ProjHistory;

--8
CREATE TRIGGER t8
ON Employee
INSTEAD OF INSERT
AS
	IF FORMAT(GETDATE(), 'MMMM') != 'February'
		INSERT INTO Employee
		SELECT * FROM INSERTED;
	ELSE
		SELECT CONCAT('The insertion is not allowed on ', FORMAT(GETDATE(), 'MMMM'));
	--Testing
INSERT INTO Employee(Fname, Lname, SSN, Sex, Salary, Dno)
VALUES('MAX', 'STEEL', 123321, 'M', 1200, 10)

		--Test the test
SELECT * FROM Employee
--DELETE FROM Employee WHERE SSN = 123321;

--9
CREATE TRIGGER t9
ON DATABASE
FOR ALTER_TABLE
AS
	BEGIN
		SELECT 'Not Allowed';
		ROLLBACK TRANSACTION
	END
	
	--Testing
CREATE TABLE alterTestTable([name] varchar(20));

ALTER TABLE alterTestTable ALTER COLUMN [name] varchar(26);

--DROP TRIGGER t9 ON DATABASE

/*
	*----> Part [2] <----*
*/
--1
	--A) Elements
SELECT * FROM Employee
FOR XML RAW('Emp'), ELEMENTS;

	--B) Attributes
SELECT * FROM Employee
FOR XML RAW('Emp');

--2
--A) Use XML Raw
SELECT Dept_Name, Ins_Id, Ins_Name
FROM ITI.dbo.Department Dep INNER JOIN ITI.dbo.Instructor Ins
ON Dep.Dept_Id = Ins.Dept_Id
FOR XML RAW('Dept'), ELEMENTS, ROOT('Departments');

--B) Use XML Auto
SELECT Dept_Name, Ins_Id, Ins_Name
FROM ITI.dbo.Department Dep INNER JOIN ITI.dbo.Instructor Ins
ON Dep.Dept_Id = Ins.Dept_Id
FOR XML AUTO, ELEMENTS, ROOT('Departments');

--C) Use XML Path
SELECT Dept_Name AS '@Name', Ins_Id AS 'Ins/id', Ins_Name AS 'Ins/name'
FROM ITI.dbo.Department Dep INNER JOIN ITI.dbo.Instructor Ins
ON Dep.Dept_Id = Ins.Dept_Id
FOR XML PATH('Dept'), ROOT('Departments');

--3
DECLARE @docHandle int;
declare @xmlDocument xml ='
		<customers>
              <customer FirstName="Bob" Zipcode="91126">
                     <order ID="12221">Laptop</order>
              </customer>
              <customer FirstName="Judy" Zipcode="23235">
                     <order ID="12221">Workstation</order>
              </customer>
              <customer FirstName="Howard" Zipcode="20009">
                     <order ID="3331122">Laptop</order>
              </customer>
              <customer FirstName="Mary" Zipcode="12345">
                     <order ID="555555">Server</order>
              </customer>
       </customers>'

EXECUTE SP_XML_PREPAREDOCUMENT @docHandle output, @xmlDocument;

SELECT *
FROM OPENXML(@docHandle, '/customers/customer')
WITH(
	fname varchar(20) '@FirstName',
	Zipcode int '@Zipcode',
	order_ID int 'order/@ID',
	order_name varchar(20) 'order'
)

EXECUTE SP_XML_REMOVEDOCUMENT @docHandle;
