-- Enable CLR 

--tell SQL Server to allow you to list the more advanced server options
EXEC sp_configure 'show advanced options' , '1'
GO
RECONFIGURE
GO

--turn CLR on

EXEC sp_configure 'clr enabled' , '1'
GO
RECONFIGURE
GO

--hide the advanced options again
EXEC sp_configure 'show advanced options' , '0';
GO


-- Install Assembly
CREATE ASSEMBLY MyAwesomeAssembly FROM 'D:\Myfolder\SuperOriginalTestProjectName.dll'
GO

--LIST ASSEMBLIES
SELECT * FROM SYS.assemblies


--ASSEMBLY DEPENDENCIES
SELECT  am.object_id, am.assembly_id, am.assembly_class, am.assembly_method, o. name, o.type, o.type_desc
FROM SYS.ASSEMBLY_MODULES am
JOIN SYS.OBJECTS o ON am.object_id = o.object_id

DROP FUNCTION dbo.fnMatchRegex


DROP ASSEMBLY MyAwesomeAssembly
GO


-- Create function
CREATE FUNCTION dbo.[fnMatchRegex](@InputString nVARCHAR(MAX),@RegExpression nVARCHAR(MAX))
RETURNS bit
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME MyAwesomeAssembly.UserDefinedFunctions.DoesRegExMatch;
GO


select * from AdventureWorks2012.Person.Address a 
where dbo.fnMatchRegex(a.AddressLine1,'(\d)\1\1\1') = 1





