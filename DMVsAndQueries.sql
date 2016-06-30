select * from sys.dm_exec_requests-- DMV Alternateive for SP_Who2 with 

Select * from 
(SELECT  OBJECT_SCHEMA_NAME(object_id,database_id) AS SCHEMA_NAME 
      ,OBJECT_NAME(object_id,database_id)AS OBJECT_NAME 
         , (max_worker_time/1000000) as in_seconds
      ,*  FROM sys.dm_exec_procedure_stats 
         where database_id = 7 ) as X--LCCA_Clinical_Database_Transaction_EA
         --Where X.in_seconds >0
         Order by X.in_seconds desc
--CREATE DROP SCRIPT FOR ALL THE PROCEDURES IN DB.
SELECT 'DROP PROCEDURE [' + SCHEMA_NAME(p.schema_id) + '].[' + p.NAME + ']' FROM sys.procedures p 
