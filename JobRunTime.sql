---Long running jobs
SELECT  j.originating_server AS 'Server',
		j.name AS 'Job Name',
    --j.job_id AS 'Job ID',
    a.run_requested_date AS 'Execution Date',
    DATEDIFF(HOUR, a.run_requested_date, GETDATE()) AS 'Elapsed (hour)', --how many hours it's running, you may change it to minutes and seconds
    CASE WHEN a.last_executed_step_id is null
        THEN 'Step 1 executing'
        ELSE 'Step ' + CONVERT(VARCHAR(25), last_executed_step_id + 1)
                  + ' executing'
        END AS 'Progress'
FROM msdb.dbo.sysjobs_view j
    INNER JOIN msdb.dbo.sysjobactivity a ON j.job_id = a.job_id
    INNER JOIN msdb.dbo.syssessions s ON s.session_id = a.session_id
    INNER JOIN (SELECT MAX(agent_start_date) AS max_agent_start_date
          FROM msdb.dbo.syssessions) s2 ON s.agent_start_date = s2.max_agent_start_date
WHERE stop_execution_date IS NULL
AND run_requested_date IS NOT NULL