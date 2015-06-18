
--Here's your average aggregate function, using group by
SELECT 
TerritoryGroup,
TerritoryName,
SUM(SalesLastYear)  AS SalesCount,
AVG(SalesLastYear) AS SalesAvg
FROM Sales.vSalesPerson
WHERE TerritoryGroup IS NOT NULL	
GROUP BY TerritoryGroup,TerritoryName

--Now let's do it slightly differently, allowing us to do aggegrates
--almost like we're grouping on two different fields simultaneously - notice no Group By clause at the end
SELECT distinct
TerritoryGroup,
TerritoryName,
SUM(SalesLastYear) OVER (PARTITION BY TerritoryGroup) AS SalesCount,
AVG(SalesLastYear) OVER (PARTITION BY TerritoryName) AS SalesAvg
FROM Sales.vSalesPerson
WHERE TerritoryGroup IS NOT NULL



--Windowing functions - basic examples for comparison
SELECT 
BusinessEntityID,
FirstName + ' ' + LastName AS FullName,
SalesLastYear,
ROW_NUMBER() OVER (ORDER BY SalesLastYear ASC) AS RowNumber
FROM Sales.vSalesPerson


SELECT 
BusinessEntityID,
FirstName + ' ' + LastName AS FullName,
SalesLastYear,
RANK() OVER (ORDER BY SalesLastYear ASC) AS RankExample
FROM Sales.vSalesPerson


SELECT 
BusinessEntityID,
FirstName + ' ' + LastName AS FullName,
SalesLastYear,
DENSE_RANK() OVER (ORDER BY SalesLastYear ASC) AS DenseRank
FROM Sales.vSalesPerson


SELECT 
BusinessEntityID,
FirstName + ' ' + LastName AS FullName,
SalesLastYear,
NTILE(4) OVER (ORDER BY SalesLastYear ASC) AS NtileExample
FROM Sales.vSalesPerson

--a combined window function query that you can use for comparison of how each works
SELECT 
BusinessEntityID,
FirstName + ' ' + LastName AS FullName,
SalesLastYear,
TerritoryName,
TerritoryGroup,
ROW_NUMBER() OVER (PARTITION BY TerritoryName ORDER BY SalesLastYear ASC) AS RowNumber,
Rank() OVER (PARTITION BY TerritoryGroup ORDER BY SalesLastYear ASC) AS RankExample,
DENSE_RANK() OVER (PARTITION BY TerritoryGroup ORDER BY SalesLastYear ASC) AS DenseRank,
NTile(4) OVER (PARTITION BY TerritoryName ORDER BY SalesLastYear ASC) AS NTileExample
FROM Sales.vSalesPerson


