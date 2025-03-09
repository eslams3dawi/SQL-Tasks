USE Travel
--1
SELECT Dnum, Dname, SSN, Fname + ' ' + Lname AS [Manager Name]
FROM Departments D, Employee E
WHERE E.SSN = D.MGRSSN;

--2
SELECT Dname, Pname
FROM Departments D, Project P
WHERE D.Dnum = P.Dnum
ORDER BY Dname;

--3
SELECT Fname + ' ' + Lname AS [Employee Name], D.*
FROM Employee E, Dependent D
WHERE E.SSN = D.ESSN;

--4
SELECT Pnumber, Pname, Plocation
FROM Project
WHERE City in('Cairo', 'Alex'); 

--5
SELECT *
FROM Project
WHERE Pname LIKE 'a%';

--6
SELECT *
FROM Employee
WHERE Dno = 30 AND Salary BETWEEN 1000 AND 2000; 

--7
		--First way
SELECT Fname + ' ' + Lname AS [Employee Name]
FROM Employee E, Works_for WF, Project P
WHERE E.SSN = WF.ESSn AND P.Pnumber = WF.Pno 
AND Pname = 'Al Rabwah' AND HOURS >= 10;

		--Second way
SELECT Fname + ' ' + Lname AS [Employee Name]
FROM Employee E INNER JOIN Works_for WF
ON E.SSN = WF.ESSn AND Hours >= 10
				INNER JOIN Project P
ON P.Pnumber = WF.Pno AND Pname = 'Al Rabwah';

--8
SELECT * FROM Employee;
SELECT E.Fname + ' ' + E.Lname AS [Employee Name]
FROM Employee E, Employee S
WHERE S.SSN = E.Superssn 
AND S.Fname + ' ' + S.Lname = 'Kamel Mohamed';

--9
SELECT Fname + ' ' + Lname AS [Employee Name], Pname
FROM Employee E INNER JOIN Works_for WF
ON E.SSN = WF.ESSn
				INNER JOIN Project P
ON P.Pnumber = WF.Pno
ORDER BY Pname;

--10
USE Travel
SELECT Pnumber, Dname, Lname, Address, Bdate
FROM Project P INNER JOIN Departments D
ON D.Dnum = P.Dnum AND City = 'Cairo'
				INNER JOIN Employee E
ON E.SSN = D.MGRSSN;

--11
SELECT DISTINCT S.*
FROM Employee E, Employee S
WHERE S.SSN = E.Superssn;

--12
SELECT *
FROM Employee E LEFT OUTER JOIN Dependent D
ON E.SSN = D.ESSN;


--13
USE Travel
INSERT INTO Employee
VALUES (30, 102672, 112233, 3000)

--14
INSERT INTO EmployeE (Dnum, SSN)
VALUES (30, 102660)

--15
UPDATE Employee
SET Salary *= 1.2;

SELECT * FROM Employee




























--13
INSERT INTO Employee
VALUES('Hllo', 'World', 102672, GETDATE(), '44 Hilopolis.Cairo', 'F', 3000, 112233, 30);

--14
INSERT INTO Employee
VALUES('Memo', 'Neno', 102660, GETDATE(), '269 El-Haram st. Giza', 'M', NULL, NULL, 30);

--15
UPDATE Employee
SET Salary *= 1.2;