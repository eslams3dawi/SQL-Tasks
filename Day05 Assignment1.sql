USE ITI;

SELECT * FROM Student;
SELECT * FROM Instructor;
--1
SELECT COUNT(St_Age) 
FROM Student;

--2
SELECT DISTINCT Ins_Name
FROM Instructor;

--3
SELECT St_Id, CONCAT(ISNULL(St_Fname, 'No_Fname'), ' ', ISNULL(St_Lname, 'No_Lname')) AS [NAME], Dept_Name
FROM Student S INNER JOIN Department D
ON D.Dept_Id = S.Dept_Id;

--4
SELECT Ins_Name, Dept_Name
FROM Instructor I LEFT OUTER JOIN Department D
ON D.Dept_Id = I.Dept_Id;

--5
SELECT CONCAT(ISNULL(St_Fname, 'No_Fname'), ' ', ISNULL(St_Lname, 'No_Lname')) AS [NAME], Crs_Name
FROM Student S INNER JOIN Stud_Course SC
ON s.St_Id = SC.St_Id AND Grade IS NOT NULL
				INNER JOIN Course C
				ON C.Crs_Id = SC.Crs_Id;

--6
SELECT Top_Name, COUNT(Crs_Id) AS [COUNT]
FROM Course C INNER JOIN Topic T
ON T.Top_Id = C.Top_Id
GROUP BY Top_Name
ORDER BY [COUNT];

--7
SELECT MIN(Salary), MAX(Salary)
FROM Instructor;

--8
SELECT * 
FROM Instructor
WHERE Salary < (SELECT AVG(Salary) FROM Instructor);

--9
SELECT TOP(1) Dept_Name
FROM Instructor I, Department D
WHERE D.Dept_Id = I.Dept_Id
ORDER BY Salary;

--10
SELECT TOP(2) Salary
FROM Instructor
ORDER BY Salary DESC;

--11
SELECT Ins_Name, ISNULL(Salary, 777)
FROM Instructor;

--12
SELECT AVG(Salary)
FROM Instructor;

--13
SELECT S.St_Fname, Sup.*
FROM Student S, Student Sup
WHERE Sup.St_Id = S.St_super

--14
SELECT Dept_Id, Salary
FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY Dept_Id ORDER BY Salary DESC) AS RN
		FROM Instructor
		WHERE Salary IS NOT NULL) AS S
WHERE RN <= 2;

--15
SELECT *
FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY Dept_Id ORDER BY NEWID()) AS RN
		FROM Student
		WHERE Dept_Id IS NOT NULL) AS S
WHERE RN=1;

