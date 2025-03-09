USE AdventureWorks2016CTP3;

--1
SELECT SalesOrderID, ShipDate 
FROM Sales.SalesOrderHeader
WHERE ShipDate > '03/22/2014'; --MM/DD/YYYY (dummy date)

--2
SELECT ProductID, [Name] 
FROM Production.Product
WHERE StandardCost < 110;

--3
SELECT ProductID, [Name] 
FROM Production.Product
WHERE [Weight] IS NULL;

--4
SELECT *
FROM Production.Product
WHERE Color IN('Silver', 'Black', 'Red');

--5
SELECT *
FROM Production.Product
WHERE [Name] LIKE 'B%';

--6
	--Can't see the full question

--7
SELECT OrderDate, SUM(TotalDue)
FROM Sales.SalesOrderHeader
WHERE OrderDate > '05/15/2013' --MM/DD/YYYY  (dummy date)
GROUP BY OrderDate
ORDER BY OrderDate;

--8
SELECT DISTINCT HireDate
FROM HumanResources.Employee;

--9
SELECT AVG(ListPrice) AS [AVG]
FROM (SELECT DISTINCT ListPrice 
		FROM Production.Product) AS P;

--10
SELECT CONCAT('The ', [Name], ' is only! ', ListPrice,'$.') AS [Description]
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 120
ORDER BY ListPrice;

--11
	--a
SELECT rowguid, [Name], SalesPersonID, Demographics INTO Sales.store_Archive
FROM Sales.Store;

		--For testing
SELECT * FROM Sales.store_Archive;

	--b
SELECT rowguid, [Name], SalesPersonID, Demographics INTO Sales.store_Archive_Without_data
FROM Sales.Store
WHERE 1=2;

		--For testing
SELECT * FROM Sales.store_Archive_Without_data;

--12
SELECT FORMAT(GETDATE(), 'dd-MM-yyyy hh:mm:ss tt') AS [Today]
UNION ALL
SELECT FORMAT(GETDATE(), 'ddd (dd-MMM yyyy)')
UNION ALL
SELECT FORMAT(GETDATE(), 'dddd (dd-MMMM yyyy)');