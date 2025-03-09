USE MyCompany

--part 1
--1
SELECT * 
FROM Employee

--2
SELECT CONCAT(Fname, Lname) AS [Full Name], Salary, Dno
FROM Employee

--3
SELECT Pname, Plocation, Dnum
FROM Project 

--4***
SELECT CONCAT(Fname, Lname) AS [Full Name], Salary*0.10 AS [Annual comm]
FROM Employee

--5
SELECT SSN 
FROM Employee
WHERE Salary > 1000

--6
SELECT SSN
FROM Employee
WHERE Salary * 12 > 10000

--7
SELECT CONCAT(Fname, Lname) AS [Full Name], Salary
FROM Employee
WHERE Sex = 'F'

--8
SELECT Dnum, Dname 
FROM Departments D 
WHERE D.MGRSSN = 968574

--9
SELECT Pnumber, Pname, Plocation
FROM Project
WHERE Dnum = 10




--part 2
USE ITI
--1
SELECT DISTINCT Ins_Name
FROM Instructor

--2
SELECT DISTINCT Ins_Name, Dept_Name 
FROM Instructor I INNER JOIN Department D
ON I.Dept_Id = D.Dept_Id

--3
SELECT CONCAT(St_Fname, St_Lname) AS [Full Name], C.Crs_Name
FROM Student S INNER JOIN Stud_Course SC
ON S.St_Id = SC.St_Id 
INNER JOIN Course C 
ON SC.Crs_Id = C.Crs_Id
WHERE SC.Grade  NULL

--4
-- Returns the error number of the last T-SQL statement executed
SELECT @@ERROR;

-- Returns the number of packet errors encountered by SQL Server
SELECT @@PACKET_ERRORS;

-- Returns the total number of errors encountered by SQL Server since the last restart
SELECT @@TOTAL_ERRORS;

-- Returns the name of the local SQL Server instance
SELECT @@SERVERNAME;

-- Returns the name of the SQL Server service (e.g., MSSQLSERVER)
SELECT @@SERVICENAME;

-- Returns the last-inserted identity value in the current session
SELECT @@IDENTITY;

-- Returns the number of connections to the current SQL Server instance
SELECT @@CONNECTIONS;

-- Returns the current setting of the first day of the week (1 = Monday, 7 = Sunday)
SELECT @@DATEFIRST;

-- Returns the current version of SQL Server, including build number and edition
SELECT @@VERSION;

-- Returns the percentage of time the CPU has been busy processing SQL Server requests
SELECT @@CPU_BUSY;

-- Returns the number of rows affected by the last cursor operation
SELECT @@CURSOR_ROWS;

-- Returns the current timestamp for the database
SELECT @@DBTS;

-- Returns the ID of the default sort order for the current session
SELECT @@DEF_SORTORDER_ID;

-- Returns the language ID used by the current session
SELECT @@DEFAULT_LANGID;

-- Returns the status of the last cursor fetch (0 = success, -1 = failure)
SELECT @@FETCH_STATUS;

-- Returns the total amount of idle time in SQL Server since the last reset
SELECT @@IDLE;

-- Returns the percentage of time SQL Server has spent handling I/O requests
SELECT @@IO_BUSY;



--part 3
USE MyCompany

--1
SELECT Dnum, Dname, E.Superssn
FROM Departments D INNER JOIN Employee E
ON D.MGRSSN = E.Superssn

--2
SELECT Dname, Pname
FROM Departments D INNER JOIN Project P
ON D.Dnum = P.Dnum

--3
SELECT *, CONCAT(Fname, Lname) as [Full Name]
FROM Dependent D INNER JOIN Employee E
ON D.ESSN = E.SSN

--4
SELECT Pnumber, Pname, Plocation
FROM Project P 
WHERE City IN( 'Cairo', 'Alex' )

--5
SELECT *
FROM Project
WHERE Pname LIKE 'a%'

--6
SELECT *
FROM EMPLOYEE
WHERE Dno = 30 AND Salary BETWEEN 1000 AND 2000

--7
SELECT CONCAT(Fname, Lname) AS [Full Name]
FROM EMPLOYEE E INNER JOIN Works_for WF
ON E.SSN = WF.ESSn AND E.Dno = 30 AND WF.Hours > 10

--8
SELECT CONCAT(X.Fname, X.Lname) AS [Full Name]
FROM Employee X INNER JOIN Employee Y
ON X.Superssn = Y.SSN AND CONCAT(Y.Fname, Y.Lname) = 'KamelMohamed'

--9
SELECT CONCAT(Fname, Lname) AS [Full Name], Pname 
FROM Employee E
INNER JOIN Works_for WF ON E.SSN = WF.ESSn
INNER JOIN Project P ON P.Pnumber = WF.Pno
ORDER BY Pname

--10
SELECT Pnumber, Dname, E.Lname, E.Bdate
FROM Project P 
INNER JOIN Departments D ON D.Dnum = P.Dnum
INNER JOIN Employee E ON  E.Dno = D.Dnum

--11
SELECT *
FROM Employee E 
INNER JOIN Employee M ON M.SSN = E.Superssn

--12
SELECT *
FROM Employee E
INNER JOIN Dependent D ON D.ESSN = E.SSN




--part 4
USE ITI

--1
SELECT I.Ins_Name, COUNT(St_Id)
FROM Instructor I 
INNER JOIN Student S ON S.St_super = I.Ins_Id
GROUP BY Ins_Name

--2
SELECT Top_name, COUNT(Crs_Id) AS [Numbe Of Courses]
FROM Course C 
INNER JOIN Topic T ON T.Top_Id = C.Top_Id
GROUP BY Top_name

--3
SELECT MAX(Salary) AS [Maximum Salary] , MIN(Salary) AS [Minimun Salary]
FROM Instructor 

--4
SELECT * 
FROM Instructor I 
WHERE Salary < (SELECT AVG(Salary)
				FROM Instructor)

--5
SELECT Dept_Name
FROM Department D
INNER JOIN Instructor I
ON D.Dept_Id = I.Dept_Id AND I.Salary IN (SELECT MIN(Salary)
										  FROM Instructor)

--6
SELECT TOP(2) Salary
FROM Instructor
ORDER BY Salary DESC

--7
SELECT AVG(Salary)
FROM Instructor










