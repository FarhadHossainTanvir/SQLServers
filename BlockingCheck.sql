--Check first whcih Jobs are Running by SPIDs
;WITH JobDetails
AS (
    SELECT DISTINCT Job_Id = left(intr1, charindex(':', intr1) - 1)
        ,Step = substring(intr1, charindex(':', intr1) + 1, charindex(')', intr1) - charindex(':', intr1) - 1)
        ,SessionId = spid
    FROM master.dbo.sysprocesses x
    CROSS APPLY (
        SELECT replace(x.program_name, 'SQLAgent - TSQL JobStep (Job ', '')
        ) cs(intr1)
    WHERE spid > 50
        AND x.program_name LIKE 'SQLAgent - TSQL JobStep (Job %'
    )
SELECT name,SessionId
FROM msdb.dbo.sysjobs j
INNER JOIN JobDetails jd ON jd.Job_Id = convert(VARCHAR(max), convert(BINARY (16), j.job_id), 1)


--Then check Who is blocking who by which STATEMENT
;WITH cteBL (session_id, blocking_these) AS 
(SELECT s.session_id, blocking_these = x.blocking_these FROM sys.dm_exec_sessions s 
CROSS APPLY    (SELECT isnull(convert(varchar(6), er.session_id),'') + ', '  
                FROM sys.dm_exec_requests as er
                WHERE er.blocking_session_id = isnull(s.session_id ,0)
                AND er.blocking_session_id <> 0
                FOR XML PATH('') ) AS x (blocking_these)
)
SELECT s.session_id, blocked_by = r.blocking_session_id, bl.blocking_these
, batch_text = t.text, input_buffer = ib.event_info, * 
FROM sys.dm_exec_sessions s 
LEFT OUTER JOIN sys.dm_exec_requests r on r.session_id = s.session_id
INNER JOIN cteBL as bl on s.session_id = bl.session_id
OUTER APPLY sys.dm_exec_sql_text (r.sql_handle) t
OUTER APPLY sys.dm_exec_input_buffer(s.session_id, NULL) AS ib
WHERE blocking_these is not null or r.blocking_session_id > 0
ORDER BY len(bl.blocking_these) desc, r.blocking_session_id desc, r.session_id;