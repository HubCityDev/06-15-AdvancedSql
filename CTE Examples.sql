  set statistics time on
  
SELECT SalesPersonID, Count(SalesOrderID) as TotalSales, YEAR(OrderDate) AS SalesYear
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
Group by YEAR(OrderDate),SalesPersonID
ORDER BY SalesPersonID,SalesYear



WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS
-- Define the CTE query.
(
    SELECT SalesPersonID, SalesOrderID, YEAR(OrderDate) AS SalesYear
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
)
-- Define the outer query referencing the CTE name.
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;


with averagesByMonth  
as
(
select 
avg(unitprice) as averageOrders, 
month(orderdate) as month, 
year(orderdate) as year 
from sales.salesorderdetail sod 
inner join  sales.salesorderheader soh on soh.salesorderid = sod.salesorderid
group by year(orderdate), month(orderdate)
),
averagesByYear as
(
select avg(unitprice) as averageOrders, year(orderdate) as year from sales.salesorderdetail sod 
inner join  sales.salesorderheader soh on soh.salesorderid = sod.salesorderid
group by year(orderdate)
)
select m.AverageOrders as AverageByMonth, 
y.AverageOrders as AverageByYear, m.Month, m.year  from averagesByMonth m
inner join averagesByYear y on m.year = y.year
 order by m.year, m.month





WITH OrgPath (BusinessEntityID, ManagerID, lv) 
AS (
   -- Anchor
      SELECT BusinessEntityID, ManagerID, 1
        FROM HumanResources.Employee
        WHERE ManagerID IS NULL -- should only be EmployeeID 1
        -- WHERE EmployeeID = 1 -- the CEO
 
    -- Recursive Call
    UNION ALL
      SELECT E.BusinessEntityID, E.ManagerID, lv + 1
        FROM HumanResources.Employee E
          JOIN OrgPath
            ON E.ManagerID = OrgPath.BusinessEntityID
    )
SELECT Emp.BusinessEntityID, Emp.JobTitle,
    C.FirstName + ' ' + C.LastName AS [Name],
    M.FirstName + ' ' + M.LastName AS [Manager], Lv
  FROM HumanResources.Employee Emp
    JOIN OrgPath
      ON Emp.BusinessEntityID = OrgPath.BusinessEntityID
    JOIN Person.Person AS C
      ON C.BusinessEntityID = Emp.BusinessEntityID
    Left Join Person.Person AS M
      ON Emp.ManagerID = M.BusinessEntityID
  ORDER BY Lv
  OPTION(MAXDOP 3)


  DECLARE @Start datetime = '1/1/2014'
  DECLARE @End datetime = '12/31/2014'
  ;WITH Months as 
	(
	SELECT convert(datetime,convert(varchar(2),MONTH(@Start)) + '/1/' + convert(varchar(4),YEAR(@Start))) as MonthStart
	UNION ALL
	SELECT DATEADD(MONTH,1,MonthStart) as MonthStart from Months
	WHERE MonthStart <= @End
	),q as 
	(
	select MonthStart,DATEADD(DAY,-1,DATEADD(MONTH,1,MonthStart)) as MonthEnd from Months
	)
	select * from q where MonthStart between @Start and @End
	OPTION(MAXRECURSION 150)
