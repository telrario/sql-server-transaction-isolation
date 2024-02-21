USE [isolation_level_db]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if not exists (select * from sysobjects where name='person' and xtype='U')
	CREATE TABLE [dbo].[person](
		[id] [bigint] IDENTITY(1,1) NOT NULL,
		[name] [varchar](255) NOT NULL,
		[last_name] [varchar](255) NOT NULL,
		[email] [varchar](255) NULL UNIQUE,
		[birth_date] [datetime2](7) NOT NULL,
		[sex] [char](1) NOT NULL,
		[tags] [nvarchar](max) NULL,
		[created_at] [datetime2](7) NULL,
		[updated_at] [datetime2](7) NULL,
	 CONSTRAINT [person_pk] PRIMARY KEY CLUSTERED 
	(
		[id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	GO
