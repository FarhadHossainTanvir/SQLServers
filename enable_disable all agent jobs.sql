--Disable All SQL Server Agent Jobs
USE MSDB;
GO
UPDATE MSDB.dbo.sysjobs
SET Enabled = 0
WHERE Enabled = 1;
GO

--Enable All SQL Server Agent Jobs
USE MSDB;
GO
UPDATE MSDB.dbo.sysjobs
SET Enabled = 1
WHERE Enabled = 0;
GO