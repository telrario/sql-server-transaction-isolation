USE [isolation_level_db]
GO

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION

-- this should read all persons with the status reseted
SELECT * FROM [dbo].[person]
GO

WAITFOR DELAY '00:00:10'

-- this should resume all persons with the male status updated
SELECT
	GETDATE() as 'update-males',
	STATUS,
	COUNT(*) AS total,
	YEAR(GETDATE()) - YEAR(MAX(birth_date)) AS youngest,
	YEAR(GETDATE()) - YEAR(MIN(birth_date)) AS oldest
FROM [dbo].[person]
GROUP BY STATUS

WAITFOR DELAY '00:00:10'

-- this should resume all persons with the female status updated
SELECT
	GETDATE() as 'update-females',
	STATUS,
	COUNT(*) AS total,
	YEAR(GETDATE()) - YEAR(MAX(birth_date)) AS youngest,
	YEAR(GETDATE()) - YEAR(MIN(birth_date)) AS oldest
FROM [dbo].[person]
GROUP BY STATUS

-- committing the transaction
COMMIT TRANSACTION
GO
