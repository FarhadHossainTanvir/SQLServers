USE [master]
CREATE LOGIN [domain\loginname] FROM WINDOWS WITH DEFAULT_DATABASE=[master]

USE []

CREATE USER [domain\loginname] FOR LOGIN [domain\loginname]

ALTER ROLE [db_datareader] ADD MEMBER [domain\loginname]

ALTER ROLE [db_datawriter] ADD MEMBER [domain\loginname]

ALTER ROLE [db_executor] ADD MEMBER [domain\loginname]

ALTER ROLE [db_ddladmin] ADD MEMBER [domain\loginname]

GRANT ALTER ON SCHEMA::dbo TO [domain\loginname];

GRANT CONTROL ON SCHEMA :: [dbo] TO [domain\loginname];

GRANT CONTROL ON DATABASE::[db_name] TO [domain\loginname];