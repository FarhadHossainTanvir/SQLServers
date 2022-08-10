--Dropping a database after checking if it exists and has active connections
USE tempdb;
GO
DECLARE @SQL nvarchar(1000);
IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = N'Sales')
BEGIN
    SET @SQL = N'USE [Sales];

                 ALTER DATABASE Sales SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
                 USE [tempdb];

                 DROP DATABASE Sales;';
    EXEC (@SQL);
END;