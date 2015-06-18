USE master
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'SQLServerInstanceLevelMasterPassword';
GO
CREATE CERTIFICATE MasterCertForTDE WITH SUBJECT = 'Master Cert for TDE Sample'
GO

use AdventureWorks2012
CREATE DATABASE ENCRYPTION KEY WITH ALGORITHM = AES_256 ENCRYPTION BY SERVER CERTIFICATE MasterCertForTDE
GO
ALTER DATABASE AdventureWorks2012 SET ENCRYPTION ON
GO	

--To monitor encryption progress you can use this query
SELECT db_name(database_id), encryption_state,   percent_complete, key_algorithm, key_length
FROM sys.dm_database_encryption_keys