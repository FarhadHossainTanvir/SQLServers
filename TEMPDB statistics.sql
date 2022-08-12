-- number of pages allocated session wise
use tempdb 
GO

select distinct session_id,NumOfPagesAllocatedInTempDBforUserTask as Total_Pages,NumOfPagesAllocatedInTempDBforUserTask/128 as TotalMB,
s.program_name,
rtrim(ltrim(replace(replace(s.program_name,'SQLAgent - TSQL JobStep (Job ',''),' : Step 1)','')))  job_id
--,j.name as Job_Name
from
(SELECT session_id,
    SUM(internal_objects_alloc_page_count) AS NumOfPagesAllocatedInTempDBforInternalTask,
    SUM(internal_objects_dealloc_page_count) AS NumOfPagesDellocatedInTempDBforInternalTask,
    SUM(user_objects_alloc_page_count) AS NumOfPagesAllocatedInTempDBforUserTask,
    SUM(user_objects_dealloc_page_count) AS NumOfPagesDellocatedInTempDBforUserTask
FROM sys.dm_db_task_space_usage where session_id>50
GROUP BY session_id
--ORDER BY NumOfPagesAllocatedInTempDBforInternalTask DESC, NumOfPagesAllocatedInTempDBforUserTask DESC
)t1 inner join sys.sysprocesses s on t1.session_id=s.spid
--left join msdb..sysjobs j on j.job_id =rtrim(ltrim(replace(replace(s.program_name,'SQLAgent - TSQL JobStep (Job ',''),' : Step 1)','')))   
where NumOfPagesAllocatedInTempDBforUserTask>0


--Then check which statements are causing blockings
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