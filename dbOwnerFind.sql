Script – Find Owner of Database
	
SELECT
    name AS [Database Name], 
    suser_sname( owner_sid ) AS [Database Owner Name]
FROM
    sys.databases

Now if you see any database without any owner, you can easily change the owner to your preferred owner. Here is the script for the same.
Script – Change Owner of Database

	
USE [YourDB]
GO
EXEC sp_changedbowner 'sa'