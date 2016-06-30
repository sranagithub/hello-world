--SIZE AND FREE SPACE IN DATA FILES
SELECT 
    [file_id] AS [File ID],
    [type] AS [File Type],
    substring([physical_name],1,1) AS [Drive],
    [name] AS [Logical Name],
    [physical_name] AS [Physical Name],
    CAST([size] as DECIMAL(38,0))/128. AS [File Size MB], 
    CAST(FILEPROPERTY([name],'SpaceUsed') AS DECIMAL(38,0))/128. AS [Space Used MB], 
    (CAST([size] AS DECIMAL(38,0))/128) - (CAST(FILEPROPERTY([name],'SpaceUsed') AS DECIMAL(38,0))/128.) AS [Free Space],
    [max_size] AS [Max Size],
    [is_percent_growth] AS [Percent Growth Enabled],
    [growth] AS [Growth Rate],
    SYSDATETIME() AS [Current Date]
FROM sys.database_files;
--DRIVE SPACE
SELECT DISTINCT
  vs.volume_mount_point AS [Drive],
  vs.logical_volume_name AS [Drive Name],
  vs.total_bytes/1024/1024 AS [Drive Size MB],
  vs.available_bytes/1024/1024 AS [Drive Free Space MB]
FROM sys.master_files AS f
CROSS APPLY sys.dm_os_volume_stats(f.database_id, f.file_id) AS vs
ORDER BY vs.volume_mount_point;