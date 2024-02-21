USE [isolation_level_db]
GO

-- reset the original unknow status
UPDATE [dbo].[person]
SET status = 'unknown'
GO

SELECT * FROM [dbo].[person]
GO

WAITFOR DELAY '00:00:10'

SELECT GETDATE() as 'update-males'
GO

-- set the status for males
UPDATE [dbo].[person]
SET status = IIF((id % 2) = 1, 'odd-male', 'even-male')
WHERE sex = 'M'
GO

BEGIN TRANSACTION

INSERT INTO person (name, last_name, birth_date, sex, status) values ('name-1', 'last-name-1', GETDATE(), 'M', 'unknown')
GO

WAITFOR DELAY '00:00:10'

COMMIT TRANSACTION
GO

SELECT GETDATE() as 'update-males'
GO

-- set status for females
UPDATE [dbo].[person]
SET status = IIF((id % 2) = 1, 'odd-female', 'even-female')
WHERE sex = 'F'
GO

BEGIN TRANSACTION

INSERT INTO person (name, last_name, birth_date, sex, status) values ('name-2', 'last-name-2', GETDATE(), 'F', 'unknown')
GO

WAITFOR DELAY '00:00:10'

COMMIT TRANSACTION
GO

-- get the new values
SELECT
	STATUS,
	COUNT(*) AS total,
	YEAR(GETDATE()) - YEAR(MAX(birth_date)) AS youngest,
	YEAR(GETDATE()) - YEAR(MIN(birth_date)) AS oldest
FROM [dbo].[person]
GROUP BY STATUS
