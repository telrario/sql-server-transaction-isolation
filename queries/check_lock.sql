SELECT * FROM sys.dm_tran_locks WHERE resource_associated_entity_id = OBJECT_ID('person')
GO

WAITFOR DELAY '00:00:10'

SELECT * FROM sys.dm_tran_locks WHERE resource_associated_entity_id = OBJECT_ID('person')
GO

WAITFOR DELAY '00:00:10'

SELECT * FROM sys.dm_tran_locks WHERE resource_associated_entity_id = OBJECT_ID('person')
GO

WAITFOR DELAY '00:00:10'