/****** Script for SelectTopNRows command from SSMS  ******/
DECLARE @stepIndex int
set @stepIndex = 1

CREATE TABLE #tmpJobInfo ([job_id] nvarchar(36), [name] nvarchar(128), [step_name] nvarchar(128), [command] nvarchar(max), [subsystem] nvarchar(40), [database_name] nvarchar(128), [output_file_name] nvarchar(200), [step_number] int)

INSERT INTO #tmpJobInfo
SELECT sj.[job_id]
      ,sj.[name]
	  ,sjs.[step_name]
	  ,sjs.[command]
	  ,sjs.[subsystem]
	  ,sjs.[database_name]
	  ,sjs.[output_file_name]
	  ,@stepIndex as [step_number]
  FROM [msdb].[dbo].[sysjobs] sj
  LEFT JOIN [msdb].[dbo].[sysjobsteps] sjs on sjs.[job_id] = sj.[job_id]
  Where [name] = 'DatabaseIntegrityCheck - SYSTEM_DATABASES'

SET @stepIndex = @stepIndex + 1

INSERT INTO #tmpJobInfo
SELECT sj.[job_id]
      ,sj.[name]
	  ,sjs.[step_name]
	  ,sjs.[command]
	  ,sjs.[subsystem]
	  ,sjs.[database_name]
	  ,sjs.[output_file_name]
	  ,@stepIndex as [step_number]
  FROM [msdb].[dbo].[sysjobs] sj
  LEFT JOIN [msdb].[dbo].[sysjobsteps] sjs on sjs.[job_id] = sj.[job_id]
  WHERE [Name] = 'DatabaseBackup - SYSTEM_DATABASES - FULL'

SET @stepIndex = @stepIndex + 1 

INSERT INTO #tmpJobInfo
SELECT sj.[job_id]
      ,sj.[name]
	  ,sjs.[step_name]
	  ,sjs.[command]
	  ,sjs.[subsystem]
	  ,sjs.[database_name]
	  ,sjs.[output_file_name]
	  ,@stepIndex as [step_number]
  FROM [msdb].[dbo].[sysjobs] sj
  LEFT JOIN [msdb].[dbo].[sysjobsteps] sjs on sjs.[job_id] = sj.[job_id]
  WHERE [Name] = 'DatabaseIntegrityCheck - USER_DATABASES'

SET @stepIndex = @stepIndex + 1 

INSERT INTO #tmpJobInfo
SELECT sj.[job_id]
      ,sj.[name]
	  ,sjs.[step_name]
	  ,sjs.[command]
	  ,sjs.[subsystem]
	  ,sjs.[database_name]
	  ,sjs.[output_file_name]
	  ,@stepIndex as [step_number]
  FROM [msdb].[dbo].[sysjobs] sj
  LEFT JOIN [msdb].[dbo].[sysjobsteps] sjs on sjs.[job_id] = sj.[job_id]
  WHERE [Name] = 'IndexOptimize - USER_DATABASES'

SET @stepIndex = @stepIndex + 1 

INSERT INTO #tmpJobInfo
SELECT sj.[job_id]
      ,sj.[name]
	  ,sjs.[step_name]
	  ,sjs.[command]
	  ,sjs.[subsystem]
	  ,sjs.[database_name]
	  ,sjs.[output_file_name]
	  ,@stepIndex as [step_number]
  FROM [msdb].[dbo].[sysjobs] sj
  LEFT JOIN [msdb].[dbo].[sysjobsteps] sjs on sjs.[job_id] = sj.[job_id]
  WHERE [Name] = 'DatabaseBackup - USER_DATABASES - FULL'

SET @stepIndex = @stepIndex + 1

--INSERT INTO #tmpJobInfo
--SELECT NULL as [job_id]
--      ,'BackupErrorCheck' as [name]
--	  ,'BackupErrorCheck' as [step_name]
--	  , 'IF EXISTS(
--  SELECT * FROM msdb.dbo.sysjobhistory
--  WHERE UPPER(master.dbo.fn_varbintohexstr(job_id)) = UPPER(''$(ESCAPE_SQUOTE(JOBID))'')
--  AND msdb.dbo.agent_datetime(run_date, run_time) >= msdb.dbo.agent_datetime($(ESCAPE_SQUOTE(STRTDT)), $(ESCAPE_SQUOTE(STRTTM)))
--  AND run_status <> 1
--)
--BEGIN
--  RAISERROR(''One or more job steps have failed.'',16,1)
--END' as [command]
--	  , 'TSQL' AS [subsystem]
--	  , 'master' AS [database_name]
--	  , '$(ESCAPE_SQUOTE(SQLLOGDIR))\WeeklyBackupErrorCheck_$(ESCAPE_SQUOTE(JOBID))_$(ESCAPE_SQUOTE(STEPID))_$(ESCAPE_SQUOTE(STRTDT))_$(ESCAPE_SQUOTE(STRTTM)).txt' as [output_file_name]
--	  ,@stepIndex as [step_number]

--SET @stepIndex = @stepIndex + 1

INSERT INTO #tmpJobInfo
SELECT sj.[job_id]
      ,sj.[name]
	  ,sjs.[step_name]
	  ,sjs.[command]
	  ,sjs.[subsystem]
	  ,sjs.[database_name]
	  ,sjs.[output_file_name]
	  ,@stepIndex as [step_number]
  FROM [msdb].[dbo].[sysjobs] sj
  LEFT JOIN [msdb].[dbo].[sysjobsteps] sjs on sjs.[job_id] = sj.[job_id]
  WHERE [Name] = 'sp_delete_backuphistory'

SET @stepIndex = @stepIndex + 1 

INSERT INTO #tmpJobInfo
SELECT sj.[job_id]
      ,sj.[name]
	  ,sjs.[step_name]
	  ,sjs.[command]
	  ,sjs.[subsystem]
	  ,sjs.[database_name]
	  ,sjs.[output_file_name]
	  ,@stepIndex as [step_number]
  FROM [msdb].[dbo].[sysjobs] sj
  LEFT JOIN [msdb].[dbo].[sysjobsteps] sjs on sjs.[job_id] = sj.[job_id]
  WHERE [Name] = 'sp_purge_jobhistory'

SET @stepIndex = @stepIndex + 1 

INSERT INTO #tmpJobInfo
SELECT sj.[job_id]
      ,sj.[name]
	  ,sjs.[step_name]
	  ,sjs.[command]
	  ,sjs.[subsystem]
	  ,sjs.[database_name]
	  ,sjs.[output_file_name]
	  ,@stepIndex as [step_number]
  FROM [msdb].[dbo].[sysjobs] sj
  LEFT JOIN [msdb].[dbo].[sysjobsteps] sjs on sjs.[job_id] = sj.[job_id]
  WHERE [Name] = 'CommandLog Cleanup'

SET @stepIndex = @stepIndex + 1 

INSERT INTO #tmpJobInfo
SELECT sj.[job_id]
      ,sj.[name]
	  ,sjs.[step_name]
	  ,sjs.[command]
	  ,sjs.[subsystem]
	  ,sjs.[database_name]
	  ,sjs.[output_file_name]
	  ,@stepIndex as [step_number]
  FROM [msdb].[dbo].[sysjobs] sj
  LEFT JOIN [msdb].[dbo].[sysjobsteps] sjs on sjs.[job_id] = sj.[job_id]
  WHERE [Name] = 'Output File Cleanup'

--SET @stepIndex = @stepIndex + 1

--INSERT INTO #tmpJobInfo
--SELECT NULL as [job_id]
--      ,'FinalErrorCheck' as [name]
--	  ,'FinalErrorCheck' as [step_name]
--	  , 'IF EXISTS(
--  SELECT * FROM msdb.dbo.sysjobhistory
--  WHERE UPPER(master.dbo.fn_varbintohexstr(job_id)) = UPPER(''$(ESCAPE_SQUOTE(JOBID))'')
--  AND msdb.dbo.agent_datetime(run_date, run_time) >= msdb.dbo.agent_datetime($(ESCAPE_SQUOTE(STRTDT)), $(ESCAPE_SQUOTE(STRTTM)))
--  AND run_status <> 1
--)
--BEGIN
--  RAISERROR(''One or more job steps have failed.'',16,1)
--END' as [command]
--	  , 'TSQL' AS [subsystem]
--	  , 'master' AS [database_name]
--	  , '$(ESCAPE_SQUOTE(SQLLOGDIR))\WeeklyBackupFinalErrorCheck_$(ESCAPE_SQUOTE(JOBID))_$(ESCAPE_SQUOTE(STEPID))_$(ESCAPE_SQUOTE(STRTDT))_$(ESCAPE_SQUOTE(STRTTM)).txt' as [output_file_name]
--	  ,@stepIndex as [step_number]

DECLARE @CurrentJobName nvarchar(255)
      , @JobDescription nvarchar(max)
	  , @JobCategory nvarchar(max)
	  , @CurrentStepName nvarchar(255)
	  , @CurrentJobStepCommand nvarchar(max)
	  , @stepNumber int
	  , @JobOwner nvarchar(max)
	  , @CurrentJobStepSubSystem nvarchar(max)
	  , @CurrentJobStepDatabaseName nvarchar(max)
	  , @CurrentOutputFileName nvarchar(max)
	  , @DatabaseName nvarchar(max)


SET @CurrentJobName= 'DatabaseBackup - WEEKLY_BACKUP'
SET @JobDescription = 'Weekly backup and maintenance tasks. Adapted from https://ola.hallengren.com'
SET @JobCategory = 'Database Maintenance'

EXECUTE msdb.dbo.sp_add_job @job_name = @CurrentJobName,
	@description = @JobDescription,
	@category_name = @JobCategory,
	@owner_login_name = @JobOwner


DECLARE step_cursor CURSOR FOR
SELECT [step_name]
	 , [command]
	 , [subsystem]
	 , [database_name]
	 , [output_file_name]
	 , [step_number]
FROM #tmpJobInfo
ORDER BY [step_number]


OPEN step_cursor
FETCH NEXT FROM step_cursor INTO @CurrentStepName, @CurrentJobStepCommand, @CurrentJobStepSubSystem, @CurrentJobStepDatabaseName, @CurrentOutputFileName, @stepNumber

WHILE @@FETCH_STATUS = 0
BEGIN
      EXECUTE msdb.dbo.sp_add_jobstep @job_name = @CurrentJobName, @step_name = @CurrentStepName, @subsystem = @CurrentJobStepSubSystem, @command = @CurrentJobStepCommand, @output_file_name = @CurrentOutputFileName, @database_name = @CurrentJobStepDatabaseName, @on_success_action=3

	FETCH NEXT FROM step_cursor INTO @CurrentStepName, @CurrentJobStepCommand, @CurrentJobStepSubSystem, @CurrentJobStepDatabaseName, @CurrentOutputFileName, @stepNumber

	IF @@FETCH_STATUS != 0
	BEGIN
		DECLARE @CurrentStepNumber int
		SELECT @CurrentStepNumber = MAX(step_id)
		FROM msdb.dbo.sysjobs sj
		INNER JOIN msdb.dbo.sysjobsteps sjs on sjs.job_id = sj.job_id
		WHERE sj.[name] = @CurrentJobName

		EXEC msdb.dbo.sp_update_jobstep  
		@job_name = @CurrentJobName,  
		@step_id = @CurrentStepNumber,
		@on_success_action = 1
	END
END

CLOSE step_cursor
DEALLOCATE step_cursor

EXECUTE msdb.dbo.sp_add_jobserver @job_name = @CurrentJobName

DROP TABLE #tmpJobInfo