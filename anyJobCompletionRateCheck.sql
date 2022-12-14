-- Any Job status specially for BACKUP & RESTORE Status. It will give an estimated_completion_time.
SELECT r.session_id , sp.loginame
,DB_NAME(r.database_id) [Database]
    ,r.command 
    ,CONVERT(NUMERIC(32, 2), r.percent_complete)  [Complete (%)]
    ,GETDATE()  [Current Database Time]
    ,CONVERT(NUMERIC(32, 2), r.total_elapsed_time / 1000.0 / 60.0) [Running Time (Minute)]
    ,CONVERT(NUMERIC(32, 2), r.estimated_completion_time / 1000.0 / 60.0) [Required Time (Minute)]
	,(select t.text FROM sys.dm_exec_sql_text(r.sql_handle) t ) 'Statement text'
FROM master.sys.dm_exec_requests r
left join sys.sysprocesses sp on sp.spid = r.session_id and ltrim(sp.loginame) <> ''
WHERE command like 'RESTORE%' ---('UPDATE STATISTICS', 'DbccFilesCompact', 'DbccLOBCompact', 'ALTER INDEX', 'DBCC', 'CREATE INDEX', 'RESTORE DATABASE', 'BACKUP DATABASE') or any command that is running