# SQLServers common queries
Hope this helps a bit!

:maple_leaf:Disk Space

:grapes:Read/Write/Execute access

:watermelon:DROP a database

:pineapple:Blocking check

:apple:Service account check

:lemon:How long jobs are running

:tomato:Check user access on DBs

:mango:TEMPDB statistics

:pear:Job compeletion rate check

🌺 Backup all DBs at a time

:maple_leaf:Always on AG Dashboard report




# SQL Server Migration Plan
## Migration Plan
The main goal of many organizations, today, is reducing costs while maintaining the highest degree of stability and efficiency. To this end, we should think out of the box about how we can help to achieve this as DBAs. The approaches include:

   - Centralization
   - Curtailment the SAN storage
   - Reducing the Microsoft license for Windows and SQL Server

Database Migration is a possible solution to achieve this goal. However, some DBA’s do not have a clear view of the requirements, and the actual steps for how to accomplish this with minimum risks and zero downtime. 

Check this [link](https://www.sqlshack.com/sql-server-database-migration-best-practices-low-risk-downtime/) for more info.

#  Locking in SQL Server
Locking is the way that SQL Server manages transaction concurrency. Essentially, locks are in-memory structures which have owners, types, and the hash of the resource that it should protect. A lock as an in-memory structure is 96 bytes in size. 

To understand better the locking in SQL Server, it is important to understand that locking is designed to ensure the integrity of the data in the database, as it forces every SQL Server transaction to pass the ACID test. 

ACID test consists of 4 requirements that every transaction have to pass successfully: 

   - Atomicity – requires that a transaction that involves two or more discrete parts of information must commit all parts or none
   - Consistency – requires that a transaction must create a valid state of new data, or it must roll back all data to the state that existed before the transaction was executed
   - Isolation – requires that a transaction that is still running and did not commit all data yet, must stay isolated from all other transactions
   - Durability – requires that committed data must be stored using method that will preserve all data in correct state and available to a user, even in case of a failure

## Lock modes
Lock mode considers various lock types that can be applied to a resource that has to be locked:
 
    - Exclusive (X)
    - Shared (S)
    - Update (U)
    - Intent (I)
    - Schema (Sch)
    - Bulk update (BU)
    
[SQLShack](https://www.sqlshack.com/locking-sql-server/) has a great article on Locks. Please have a look.

# SQL SERVER – Most Used Database Files – [Script](https://blog.sqlauthority.com/2022/01/04/sql-server-most-used-database-files-script/) by Pinal Dave
```SQL
SELECT
   DB_NAME(dbid) 'Database Name',
   physical_name 'File Location',
   NumberReads 'Number of Reads',
   BytesRead 'Bytes Read',
   NumberWrites 'Number of Writes',
   BytesWritten 'Bytes Written',   
   IoStallReadMS 'IO Stall Read',
   IoStallWriteMS 'IO Stall Write',
   IoStallMS as 'Total IO Stall (ms)'
FROM
   fn_virtualfilestats(NULL,NULL) fs INNER JOIN
    sys.master_files mf ON fs.dbid = mf.database_id 
    AND fs.fileid = mf.file_id
ORDER BY
   DB_NAME(dbid)
```

# SQL Server Agent Missing in [SSMS](https://blog.sqlauthority.com/2018/11/29/sql-server-sql-server-agent-missing-in-sql-server-management-studio-ssms/)
#### POSSIBLE CAUSES
- If the Login account connecting to SSMS is not a part of SysAdmin role in SQL Server, then SQL Server Agent would not be visible? To verify, you can run below query in SQL Server Management Studio and check the output.
```SQL	
SELECT IS_SRVROLEMEMBER('SYSADMIN')
```
If a value is zero, then you are not a Sysadmin and hence you can’t see SQL Server Agent. Image shows the same behavior.
- Another possible reason would be that SQL Server in not an edition which supports SQL Server Agent. Typically, SQL Server Express edition could be another cause. To verify, you can run below query in SQL Server Management studio and check the output.
```SQL
SELECT SERVERPROPERTY('Edition')
```
If above returns “Express” or “Express Edition with Advanced Services”, then you would not see SQL Server Agent node in SSMS.

# [Create Linked Server](https://docs.microsoft.com/en-us/sql/relational-databases/linked-servers/create-linked-servers-sql-server-database-engine?view=sql-server-ver16)
Linked servers enable the SQL Server database engine and Azure SQL Managed Instance to read data from the remote data sources and execute commands against the remote database servers (for example, OLE DB data sources) outside of the instance of SQL Server.

## Permissions

When using Transact-SQL statements, requires ALTER ANY LINKED SERVER permission on the server or membership in the setupadmin fixed server role. When using Management Studio requires CONTROL SERVER permission or membership in the sysadmin fixed server role.
Create a linked server with SSMS

## Create a linked server with SSMS using the following procedure:
Open the New Linked Server dialog

### In SQL Server Management Studio (SSMS):
- Open Object Explorer.
- Expand Server Objects.
- Right-click Linked Servers.
- Select New Linked Server.

### Edit the General page for the linked server properties
### Edit the Security page for the linked server properties
### Add login mappings
### Specify the default security context for logins not present in the mapping list
### Edit the Server Options page in linked server properties (optional)
### Save the linked server

## View or edit linked server provider options in SSMS
To open the linked server Providers Options page in SSMS:
- Open Object Explorer.
- Expand Server Objects.
- Expand Linked Servers.
- Expand Providers.
- Right-click a provider and select Properties.

##  Create a linked server with Transact-SQL
To create a linked server by using Transact-SQL, use the sp_addlinkedserver (Transact-SQL), CREATE LOGIN (Transact-SQL), and sp_addlinkedsrvlogin (Transact-SQL) statements.

This example creates a linked server to another instance of SQL Server using Transact-SQL:
1. In Query Editor, enter the following Transact-SQL command to link to an instance of SQL Server named SRVR002\ACCTG:
```SQL
USE [master]  
GO  
EXEC master.dbo.sp_addlinkedserver   
    @server = N'SRVR002\ACCTG',   
    @srvproduct=N'SQL Server';  
GO
```
2. Execute the following code to configure the linked server to use the domain credentials of the login that is using the linked server.
```SQL
EXEC master.dbo.sp_addlinkedsrvlogin   
    @rmtsrvname = N'SRVR002\ACCTG',   
    @locallogin = NULL ,   
    @useself = N'True';  
GO
```
# Find Owner or Change Owner of Database
### Script – Find Owner of Database
```SQL
SELECT
    name AS [Database Name], 
    suser_sname( owner_sid ) AS [Database Owner Name]
FROM
    sys.databases
```
### Script – Change Owner of Database

```SQL
USE [YourDB]
GO
EXEC sp_changedbowner 'sa'
GO
```
# Daily Sql Server Health Check
This is a good [link](https://github.com/rogersdba/SQL-SERVER-DAILY-HEALTH-CHECK) to check your SQL SERVER Health
