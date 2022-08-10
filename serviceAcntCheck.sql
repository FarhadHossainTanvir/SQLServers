--Incase you don't know what serice accounts are for this SQL Server.
--You may check it from SQL Server Configuration Manager also.
SELECT servicename, service_account
FROM sys.dm_server_services
GO