USE Travel;

--1
SELECT Dependent_name, D.Sex
FROM Dependent D INNER JOIN Employee E
ON E.SSN = D.ESSN
WHERE D.Sex = 'F' AND E.Sex = 'F'
UNION ALL -- UNION
SELECT Dependent_name, D.Sex
FROM Dependent D, Employee E
WHERE E.SSN = D.ESSN AND E.Sex = 'M' AND D.Sex = 'M';
SELECT * FROM Employee;
SELECT * FROM Dependent;

--2
	--First Way
SELECT Pname, SUM(Hours) AS [Total hours per week]
FROM Project P, Works_for WF
WHERE P.Pnumber = WF.Pno
GROUP BY Pname
ORDER BY [Total hours per week];

	--Second Way --> Using Subquery
	use Travel
SELECT Pname, [Total hours per week]
FROM Project P INNER JOIN (SELECT Pno, SUM(Hours) AS [Total hours per week]
							FROM Works_for
							GROUP BY Pno) WF
ON P.Pnumber = WF.Pno
ORDER BY [Total hours per week];

--3
SELECT D.* 
FROM Departments D INNER JOIN (SELECT Dno FROM Employee 
								WHERE SSN = (SELECT MIN(SSN) FROM Employee)) E
ON D.Dnum = E.Dno;

--4
SELECT Dname, [MIN], [AVG], [MAX]
FROM Departments D, (SELECT Dno, MIN(Salary) AS [MIN],  AVG(Salary) AS [AVG], MAX(Salary) AS [MAX]
					FROM Employee
					GROUP BY Dno) E
WHERE D.Dnum = E.Dno;

--5
SELECT DISTINCT S.SSN, S.Lname
FROM Employee S INNER JOIN Employee E
ON S.SSN = E.Superssn
WHERE S.SSN NOT IN (SELECT DISTINCT ESSN FROM Dependent); 

--6
SELECT Dnum, Dname, [Employees]
FROM Departments D INNER JOIN (SELECT Dno, COUNT(SSN) AS [Employees]
								FROM Employee
								GROUP BY Dno
								HAVING AVG(Salary) < (SELECT AVG(Salary) FROM Employee)) E
ON D.Dnum = E.Dno;

--7
SELECT E.SSN, E.Fname, E.Lname, E.Dno, Pname
FROM Employee E, Works_for WF, Project P
WHERE E.SSN = WF.ESSn AND P.Pnumber = WF.Pno
ORDER BY E.Dno, E.Lname, E.Fname;

--8
	--First way
SELECT Salary 
FROM Employee
WHERE Salary >=	(SELECT Salary 
	FROM Employee 
	ORDER BY Salary DESC
	OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY)
ORDER BY Salary DESC;

	--Second way

SELECT TOP(2) Salary
FROM Employee
ORDER BY Salary DESC;

--9
SELECT Fname + ' ' + Lname AS [NAME]
FROM Employee E, Dependent D
WHERE E.SSN = D.ESSN AND Fname + ' ' + Lname = Dependent_name;

--10
	--a
INSERT INTO Departments
VALUES ('DP4', 100, 968574, GETDATE());

	--b
UPDATE Departments 
SET MGRSSN = 102672, [MGRStart Date] = GETDATE()
WHERE Dnum = 20;

	--c
UPDATE Employee
SET Superssn = 102672
WHERE SSN = 102660;

--11 --> MY SSN[102672]
	--a -->[Department Management]
UPDATE Departments
SET MGRSSN = 102672
WHERE MGRSSN = 223344;

		--RUN FOR TESTING
SELECT Fname + ' ' + Lname, Dname 
FROM Departments D, Employee E
WHERE E.SSN = D.MGRSSN;

	--b -->[Projects he working at]
UPDATE Works_for
SET ESSn = 102672, Hours = 0
FROM Works_for WF, Employee E
WHERE E.SSN = WF.ESSn AND Fname = 'Kamel';

		--RUN FOR TESTING
SELECT Fname + ' ' + Lname, Pname, Hours
FROM Project P, Works_for WF, Employee E
WHERE E.SSN = WF.ESSn AND P.Pnumber = WF.Pno AND Fname = 'Kamel';

	--c -->[Supervise at]
UPDATE Employee
SET Superssn = 102672
WHERE Superssn = 223344;

		--RUN FOR TESTING
SELECT E.*
FROM Employee S, Employee E
WHERE S.SSN = E.Superssn AND S.Fname = 'Kamel'

	--d -->[His dependents]
UPDATE Dependent
SET ESSN = 102672
WHERE ESSN = 223344;

		--RUN FOR TESTING
SELECT *
FROM Dependent
WHERE ESSN = 223344;

	--e -->[Delete 'Kamel Mohamed' row from (Employee)]
DELETE FROM Employee WHERE SSN = 223344;

		--RUN FOR TESTING
SELECT * FROM Employee WHERE SSN = 223344;

--12
UPDATE Employee
SET Salary *= 1.3
FROM Employee E INNER JOIN Works_for WF
ON E.SSN = WF.ESSn
				INNER JOIN  Project P
ON P.Pnumber = WF.Pno
WHERE Pname = 'Al Rawdah';
