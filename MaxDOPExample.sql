


--how to change max degree of parallelism on a instance-wide basis

--turn on advanced options
EXEC dbo.sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO

exec dbo.sp_configure


EXEC dbo.sp_configure 'max degree of parallelism',8;
GO
RECONFIGURE;
GO

