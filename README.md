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
