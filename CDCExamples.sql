--CDC queries


--enable our database!
EXEC sys.sp_cdc_enable_db

--enable a specific table
exec sys.sp_cdc_enable_table @source_schema = 'HumanResources',@source_name = 'Employee',@role_name = null
;

SELECT * FROM cdc.HumanResources_Employee_CT

Update HumanResources.Employee
set JobTitle = 'Test Value!' where BusinessEntityID = 1

--lets look at the changes!
select * from cdc.HumanResources_Employee_CT




--what is the retention period?
--its in minutes!  Default is 3 days!
SELECT [retention]
  FROM [msdb].[dbo].[cdc_jobs]
  WHERE [database_id] = DB_ID()
  AND [job_type] = 'cleanup'

EXEC sp_cdc_change_job @job_type='cleanup', @retention=525600


--this is going to DELETE all your audit data!!!  Backup first!
EXEC sys.sp_cdc_disable_db
