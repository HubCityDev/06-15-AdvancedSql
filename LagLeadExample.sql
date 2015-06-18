
--Lag / Lead
set statistics io on;

SELECT TerritoryName, BusinessEntityID, SalesYTD, 
       LAG (SalesYTD, 1, 0) OVER (PARTITION BY TerritoryName ORDER BY SalesYTD DESC) AS PrevRepSales
FROM Sales.vSalesPerson
WHERE TerritoryName IN (N'Northwest', N'Canada') 
ORDER BY TerritoryName;
