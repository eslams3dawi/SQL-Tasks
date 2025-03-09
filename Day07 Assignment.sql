USE ITI;

--DROP FUNCTION dbo.getStudentName;

--1
CREATE FUNCTION getMonthName(@date date)
RETURNS varchar(10)
	BEGIN
		RETURN FORMAT(@date, 'MMMM')
	END

	--Testing
SELECT dbo.getMonthName(GETDATE());

--2
CREATE FUNCTION getValuesBetween(@mn int, @mx int)
RETURNS @t table(
			Nums int
			)
			AS
			BEGIN
				WHILE @mn < @mx - 1
					BEGIN
						SET @mn += 1
						INSERT INTO @t VALUES(@mn)
					END
				RETURN
			END

	--Testing
SELECT * FROM getValuesBetween(1, 10);

--3
CREATE FUNCTION getStudentInfo(@id int)
RETURNS table
	AS
		RETURN (
			SELECT Dept_Name, CONCAT(St_Fname, ' ', St_Lname) AS [Student Name]
			FROM Student S INNER JOIN Department D
			ON D.Dept_Id = S.Dept_Id
			WHERE St_Id = @id
		)

	--Testing
SELECT * FROM getStudentInfo(1);

--4
CREATE FUNCTION userMessage(@id int)
RETURNS varchar(35)
	BEGIN
		DECLARE @fName varchar(10), @lName varchar(10)

		SELECT @fName = St_Fname, @lName = St_Lname
		FROM Student
		WHERE St_Id = @id;

		DECLARE @message varchar(35)

		IF @fName IS NULL AND @lName IS NULL 
			SET @message = 'First name & last name are null'
		ELSE IF @fName IS NULL
			SET @message = 'first name is null'
		ELSE IF	@lName IS NULL
			SET @message = 'last name is null'
		ELSE
			SET @message = 'First name & last name are not null'

		RETURN @message
	END

	--Testing
SELECT dbo.userMessage(16) AS [Messages] --First Case
UNION ALL
SELECT dbo.userMessage(14) --Second Case
UNION ALL
SELECT dbo.userMessage(13) --Third Case
UNION ALL
SELECT dbo.userMessage(1); --Fourth Case

--5
	--Not able to understand the question.

--6
CREATE FUNCTION getStudentName(@col varchar(20))
RETURNS @t table([Name] varchar(50))
AS
	BEGIN
		IF @col = 'first name'
			INSERT INTO @t
			SELECT ISNULL(St_Fname, 'Default_First_Name')
			FROM Student
		ELSE IF @col = 'last name'
			INSERT INTO @t
			SELECT ISNULL(CONVERT(varchar(20), St_Lname), 'Default_Last_Name')
			FROM Student
		ELSE IF @col = 'full name'
			INSERT INTO @t
			SELECT CONCAT(ISNULL(St_Fname, 'Default_First_Name'), 
					' ', ISNULL(CONVERT(varchar(20), St_Lname), 'Default_Last_Name'))
			FROM Student
		RETURN
	END

	--Testing
--SELECT * FROM getStudentName('first name');
--SELECT * FROM getStudentName('last name');
SELECT * FROM getStudentName('full name');

--7
CREATE FUNCTION getModifiedStudentInfo()
RETURNS table
	AS
		RETURN(
			SELECT St_Id, SUBSTRING(St_Fname, 1, LEN(St_Fname) - 1) AS Fname
			FROM Student
		)

	--Testing
SELECT * FROM getModifiedStudentInfo();

--8
DECLARE @colList varchar(120), @table_name varchar(20)
SET @colList = 'St_Id, St_Fname, St_Lname, St_Age'
SET @table_name = 'Student'
EXECUTE ('SELECT ' + @colList +' FROM ' + @table_name)

--9 (Part 2: 1)
CREATE FUNCTION getEmpInfo(@Pno int)
RETURNS table
	AS
		RETURN(
			SELECT E.*
			FROM Company_SD.dbo.Employee E INNER JOIN
				Company_SD.dbo.Works_for WF
				ON E.SSN = WF.ESSn
				WHERE WF.Pno = @Pno
		)

	--Testing
SELECT * FROM getEmpInfo(300);
