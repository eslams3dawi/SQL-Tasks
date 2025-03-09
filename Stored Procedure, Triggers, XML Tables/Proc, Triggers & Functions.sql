--1
USE ITI
CREATE TABLE Employee
(
ID INT PRIMARY KEY IDENTITY(1,1),
Name VARCHAR(40) NOT NULL,
Salary DECIMAL NOT NULL	
)
--TESTING
INSERT INTO Employee
VALUES
('Eslam',10,30000)

SELECT * FROM Employee

--2
CREATE PROCEDURE InsertEmp @NAME VARCHAR(40), @DEPTiD INT, @SALARY DECIMAL
AS
	IF @SALARY > 0
		INSERT INTO Employee
		VALUES( @NAME, @DEPTiD, @SALARY)
	ELSE
		SELECT 'Invalid salary, can not inserting'
--TESTING
InsertEmp 'Ziad', 20, 20000

--3
CREATE FUNCTION ANNSAL (@MONSAL DECIMAL)
RETURNS DECIMAL 
BEGIN
	DECLARE @ANNUAL DECIMAL
	SET @ANNUAL = @MONSAL * 12
	RETURN @ANNUAL
END
--TESTING
SELECT dbo.ANNSAL(12000)

--4
CREATE FUNCTION DEPT_EMPs (@DeptId INT)
RETURNS TABLE
AS
RETURN
(
	SELECT * 
	FROM Employee E INNER JOIN DEPARTMENT D
	ON E.Dept_Id = D.Dept_Id
	WHERE Dept_Id = @DeptId
)
--TESTING
SELECT * FROM DEPT_EMPs

--5
CREATE PROCEDURE UPDATE_SAL @EID INT, @NEW DECIMAL
AS
	IF @NEW > (SELECT Salary FROM Employee WHERE ID = @EID)
		UPDATE Employee
		SET Salary = @NEW
		WHERE ID = @EID
	ELSE
		SELECT 'Salary must be greater'
--TESTING
UPDATE_SAL 1, 50000

--6
CREATE PROC BONUS @DeptID INT, @Bouns DECIMAL
AS
	DECLARE @EID INT
	DECLARE @CURRENTSAL DECIMAL

	SELECT @EID = MIN(ID)
	FROM Employee
	WHERE Dept_Id = @DeptID

	WHILE @EID NOT NULL 
		BEGIN
			SELECT @CURRENTSAL = Salary
			FROM Employee
			WHERE ID = @EID

			UPDATE Employee
			SET Salary = @CURRENTSAL + (@BounsPrecent / 100 * @CURRENTSAL)
			WHERE ID = @EID

			SELECT @EID = MIN(ID)
			FROM Employee
			WHERE Dept_Id = @DeptID AND ID > @EID
		END
END




