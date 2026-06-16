CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NULL,
    DepartmentID INT NOT NULL
);

INSERT INTO Employees
(EmployeeID, FirstName, LastName, Salary, DepartmentID)
VALUES
(1,'Іван','Петренко',65000,1),
(2,'Марія','Коваль',58000,1),
(3,'Олег','Шевченко',72000,1),
(4,'Анна','Бондар',45000,2),
(5,'Василь','Мельник',52000,2),
(6,'Наталія','Ткаченко',61000,2),
(7,'Андрій','Сидоренко',40000,3),
(8,'Юлія','Гриценко',47000,3),
(9,'Максим','Лисенко',68000,3),
(10,'Оксана','Демченко',NULL,4);

--1
DECLARE @ITDepartmentID INT = 1; UPDATE Employees SET Salary = Salary * 1.10 WHERE DepartmentID = @ITDepartmentID;

--2
DECLARE @Counter INT = 1; DECLARE @MaxID INT; SELECT @MaxID = MAX(EmployeeID) FROM Employees;
WHILE @Counter <= @MaxID
BEGIN
    SELECT FirstName
    FROM Employees
    WHERE EmployeeID = @Counter;

    SET @Counter = @Counter + 1;
END

--3
SELECT FirstName, LastName,Salary,
 CASE
        WHEN Salary >= 70000 THEN 'Висока'
        WHEN Salary >= 50000 THEN 'Середня'
        ELSE 'Низька'
    END AS SalaryStatus
FROM Employees;

--4
DECLARE @MinSalary DECIMAL(10,2) = 60000; SELECT * FROM Employees WHERE Salary > @MinSalary;

--5


--6
DECLARE @DepartmentID INT = 1;
DECLARE @MaxDepartmentID INT;

SELECT @MaxDepartmentID = MAX(DepartmentID) FROM Employees;
WHILE @DepartmentID <= @MaxDepartmentID
BEGIN
    SELECT
        CONCAT('Department ', @DepartmentID,
        ': Total salary = ',
        ISNULL(SUM(Salary),0)) AS Result
    FROM Employees
    WHERE DepartmentID = @DepartmentID;

    SET @DepartmentID = @DepartmentID + 1;
END

--7
SELECT *
FROM Employees e WHERE Salary > (SELECT AVG(Salary) FROM Employees WHERE DepartmentID = e.DepartmentID) AND ( SELECT AVG(Salary) FROM Employees WHERE DepartmentID = e.DepartmentID) > 55000;

--8


--9
SELECT DepartmentID,SUM(Salary) AS TotalSalary FROM Employees GROUP BY DepartmentID;

--10
UPDATE Employees SET Salary = ( SELECT AVG(Salary) FROM Employees WHERE Salary IS NOT NULL) WHERE Salary IS NULL;
SELECT * FROM Employees;