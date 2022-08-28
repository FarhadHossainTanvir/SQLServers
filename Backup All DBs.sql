
--------------------------CODE START----------------------------------

DECLARE @name VARCHAR(50) -- database name 
DECLARE @path VARCHAR(256) -- path for backup files 
DECLARE @fileName VARCHAR(256) -- filename for backup 
DECLARE @fileDate VARCHAR(20) -- used for file name
SET @path = 'D:\Test Backup\' 
SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112)

DECLARE db_cursor CURSOR FOR 
SELECT name FROM master.dbo.sysdatabases
WHERE name NOT IN ('master','model','msdb','tempdb') 
OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @name  
WHILE @@FETCH_STATUS = 0  
BEGIN  
SET @fileName = @path + @name + '_' + @fileDate + '.BAK' 
BACKUP DATABASE @name TO DISK = @fileName  WITH COPY_ONLY
FETCH NEXT FROM db_cursor INTO @name  
END

CLOSE db_cursor  
DEALLOCATE db_cursor
--------------------------CODE END-----------------------------------------------------


You can follow this link too
--https://www.ubackup.com/enterprise-backup/mssql-backup-all-databases-1021.html
--https://www.mssqltips.com/sqlservertip/1070/simple-script-to-backup-all-sql-server-databases/
--https://medium.com/swlh/how-to-backup-all-databases-at-once-in-ms-sql-server-88ed2b6cbee9
Note: Always verify code before running on any environment.
