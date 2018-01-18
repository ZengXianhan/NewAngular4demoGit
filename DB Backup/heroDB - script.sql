USE [master]
GO
/****** Object:  Database [pubs]    Script Date: 18/1/2018 5:03:49 PM ******/
CREATE DATABASE [pubs]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'pubs', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\pubs.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'pubs_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\pubs_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [pubs] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [pubs].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [pubs] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [pubs] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [pubs] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [pubs] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [pubs] SET ARITHABORT OFF 
GO
ALTER DATABASE [pubs] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [pubs] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [pubs] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [pubs] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [pubs] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [pubs] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [pubs] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [pubs] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [pubs] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [pubs] SET  ENABLE_BROKER 
GO
ALTER DATABASE [pubs] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [pubs] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [pubs] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [pubs] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [pubs] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [pubs] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [pubs] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [pubs] SET RECOVERY FULL 
GO
ALTER DATABASE [pubs] SET  MULTI_USER 
GO
ALTER DATABASE [pubs] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [pubs] SET DB_CHAINING OFF 
GO
ALTER DATABASE [pubs] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [pubs] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [pubs] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'pubs', N'ON'
GO
USE [pubs]
GO
/****** Object:  UserDefinedDataType [dbo].[empid]    Script Date: 18/1/2018 5:03:49 PM ******/
CREATE TYPE [dbo].[empid] FROM [char](9) NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[id]    Script Date: 18/1/2018 5:03:49 PM ******/
CREATE TYPE [dbo].[id] FROM [varchar](11) NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[tid]    Script Date: 18/1/2018 5:03:49 PM ******/
CREATE TYPE [dbo].[tid] FROM [varchar](6) NOT NULL
GO
/****** Object:  Table [dbo].[authors]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[authors](
	[au_id] [dbo].[id] NOT NULL,
	[au_lname] [varchar](40) NOT NULL,
	[au_fname] [varchar](20) NOT NULL,
	[phone] [char](12) NOT NULL DEFAULT ('UNKNOWN'),
	[address] [varchar](40) NULL,
	[city] [varchar](20) NULL,
	[state] [char](2) NULL,
	[zip] [char](5) NULL,
	[contract] [bit] NOT NULL,
 CONSTRAINT [UPKCL_auidind] PRIMARY KEY CLUSTERED 
(
	[au_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[discounts]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[discounts](
	[discounttype] [varchar](40) NOT NULL,
	[stor_id] [char](4) NULL,
	[lowqty] [smallint] NULL,
	[highqty] [smallint] NULL,
	[discount] [decimal](4, 2) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[employee]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[employee](
	[emp_id] [dbo].[empid] NOT NULL,
	[fname] [varchar](20) NOT NULL,
	[minit] [char](1) NULL,
	[lname] [varchar](30) NOT NULL,
	[job_id] [smallint] NOT NULL DEFAULT ((1)),
	[job_lvl] [tinyint] NULL DEFAULT ((10)),
	[pub_id] [char](4) NOT NULL DEFAULT ('9952'),
	[hire_date] [datetime] NOT NULL DEFAULT (getdate()),
 CONSTRAINT [PK_emp_id] PRIMARY KEY NONCLUSTERED 
(
	[emp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [employee_ind]    Script Date: 18/1/2018 5:03:49 PM ******/
CREATE CLUSTERED INDEX [employee_ind] ON [dbo].[employee]
(
	[lname] ASC,
	[fname] ASC,
	[minit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hero]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hero](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_hero] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[jobs]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[jobs](
	[job_id] [smallint] IDENTITY(1,1) NOT NULL,
	[job_desc] [varchar](50) NOT NULL DEFAULT ('New Position - title not formalized yet'),
	[min_lvl] [tinyint] NOT NULL,
	[max_lvl] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[job_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[pub_info]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pub_info](
	[pub_id] [char](4) NOT NULL,
	[logo] [image] NULL,
	[pr_info] [text] NULL,
 CONSTRAINT [UPKCL_pubinfo] PRIMARY KEY CLUSTERED 
(
	[pub_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[publishers]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[publishers](
	[pub_id] [char](4) NOT NULL,
	[pub_name] [varchar](40) NULL,
	[city] [varchar](20) NULL,
	[state] [char](2) NULL,
	[country] [varchar](30) NULL DEFAULT ('USA'),
 CONSTRAINT [UPKCL_pubind] PRIMARY KEY CLUSTERED 
(
	[pub_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[roysched]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[roysched](
	[title_id] [dbo].[tid] NOT NULL,
	[lorange] [int] NULL,
	[hirange] [int] NULL,
	[royalty] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sales]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sales](
	[stor_id] [char](4) NOT NULL,
	[ord_num] [varchar](20) NOT NULL,
	[ord_date] [datetime] NOT NULL,
	[qty] [smallint] NOT NULL,
	[payterms] [varchar](12) NOT NULL,
	[title_id] [dbo].[tid] NOT NULL,
 CONSTRAINT [UPKCL_sales] PRIMARY KEY CLUSTERED 
(
	[stor_id] ASC,
	[ord_num] ASC,
	[title_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[stores]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[stores](
	[stor_id] [char](4) NOT NULL,
	[stor_name] [varchar](40) NULL,
	[stor_address] [varchar](40) NULL,
	[city] [varchar](20) NULL,
	[state] [char](2) NULL,
	[zip] [char](5) NULL,
 CONSTRAINT [UPK_storeid] PRIMARY KEY CLUSTERED 
(
	[stor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[titleauthor]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[titleauthor](
	[au_id] [dbo].[id] NOT NULL,
	[title_id] [dbo].[tid] NOT NULL,
	[au_ord] [tinyint] NULL,
	[royaltyper] [int] NULL,
 CONSTRAINT [UPKCL_taind] PRIMARY KEY CLUSTERED 
(
	[au_id] ASC,
	[title_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[titles]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[titles](
	[title_id] [dbo].[tid] NOT NULL,
	[title] [varchar](80) NOT NULL,
	[type] [char](12) NOT NULL DEFAULT ('UNDECIDED'),
	[pub_id] [char](4) NULL,
	[price] [money] NULL,
	[advance] [money] NULL,
	[royalty] [int] NULL,
	[ytd_sales] [int] NULL,
	[notes] [varchar](200) NULL,
	[pubdate] [datetime] NOT NULL DEFAULT (getdate()),
 CONSTRAINT [UPKCL_titleidind] PRIMARY KEY CLUSTERED 
(
	[title_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[titleview]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[titleview]
AS
select title, au_ord, au_lname, price, ytd_sales, pub_id
from authors, titles, titleauthor
where authors.au_id = titleauthor.au_id
   AND titles.title_id = titleauthor.title_id


GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [aunmind]    Script Date: 18/1/2018 5:03:49 PM ******/
CREATE NONCLUSTERED INDEX [aunmind] ON [dbo].[authors]
(
	[au_lname] ASC,
	[au_fname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [titleidind]    Script Date: 18/1/2018 5:03:49 PM ******/
CREATE NONCLUSTERED INDEX [titleidind] ON [dbo].[roysched]
(
	[title_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [titleidind]    Script Date: 18/1/2018 5:03:49 PM ******/
CREATE NONCLUSTERED INDEX [titleidind] ON [dbo].[sales]
(
	[title_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [auidind]    Script Date: 18/1/2018 5:03:49 PM ******/
CREATE NONCLUSTERED INDEX [auidind] ON [dbo].[titleauthor]
(
	[au_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [titleidind]    Script Date: 18/1/2018 5:03:49 PM ******/
CREATE NONCLUSTERED INDEX [titleidind] ON [dbo].[titleauthor]
(
	[title_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [titleind]    Script Date: 18/1/2018 5:03:49 PM ******/
CREATE NONCLUSTERED INDEX [titleind] ON [dbo].[titles]
(
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[discounts]  WITH CHECK ADD FOREIGN KEY([stor_id])
REFERENCES [dbo].[stores] ([stor_id])
GO
ALTER TABLE [dbo].[employee]  WITH CHECK ADD FOREIGN KEY([job_id])
REFERENCES [dbo].[jobs] ([job_id])
GO
ALTER TABLE [dbo].[employee]  WITH CHECK ADD FOREIGN KEY([pub_id])
REFERENCES [dbo].[publishers] ([pub_id])
GO
ALTER TABLE [dbo].[pub_info]  WITH CHECK ADD FOREIGN KEY([pub_id])
REFERENCES [dbo].[publishers] ([pub_id])
GO
ALTER TABLE [dbo].[roysched]  WITH CHECK ADD FOREIGN KEY([title_id])
REFERENCES [dbo].[titles] ([title_id])
GO
ALTER TABLE [dbo].[sales]  WITH CHECK ADD FOREIGN KEY([stor_id])
REFERENCES [dbo].[stores] ([stor_id])
GO
ALTER TABLE [dbo].[sales]  WITH CHECK ADD FOREIGN KEY([title_id])
REFERENCES [dbo].[titles] ([title_id])
GO
ALTER TABLE [dbo].[titleauthor]  WITH CHECK ADD FOREIGN KEY([au_id])
REFERENCES [dbo].[authors] ([au_id])
GO
ALTER TABLE [dbo].[titleauthor]  WITH CHECK ADD FOREIGN KEY([title_id])
REFERENCES [dbo].[titles] ([title_id])
GO
ALTER TABLE [dbo].[titles]  WITH CHECK ADD FOREIGN KEY([pub_id])
REFERENCES [dbo].[publishers] ([pub_id])
GO
ALTER TABLE [dbo].[authors]  WITH CHECK ADD CHECK  (([au_id] like '[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[authors]  WITH CHECK ADD CHECK  (([zip] like '[0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[employee]  WITH CHECK ADD  CONSTRAINT [CK_emp_id] CHECK  (([emp_id] like '[A-Z][A-Z][A-Z][1-9][0-9][0-9][0-9][0-9][FM]' OR [emp_id] like '[A-Z]-[A-Z][1-9][0-9][0-9][0-9][0-9][FM]'))
GO
ALTER TABLE [dbo].[employee] CHECK CONSTRAINT [CK_emp_id]
GO
ALTER TABLE [dbo].[jobs]  WITH CHECK ADD CHECK  (([max_lvl]<=(250)))
GO
ALTER TABLE [dbo].[jobs]  WITH CHECK ADD CHECK  (([min_lvl]>=(10)))
GO
ALTER TABLE [dbo].[publishers]  WITH CHECK ADD CHECK  (([pub_id]='1756' OR [pub_id]='1622' OR [pub_id]='0877' OR [pub_id]='0736' OR [pub_id]='1389' OR [pub_id] like '99[0-9][0-9]'))
GO
/****** Object:  StoredProcedure [dbo].[byroyalty]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[byroyalty] @percentage int
AS
select au_id from titleauthor
where titleauthor.royaltyper = @percentage


GO
/****** Object:  StoredProcedure [dbo].[DeleteEmployee]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Zeng Xianhan
-- Create date: 23/10/2017
-- Description:	test
-- =============================================
CREATE PROCEDURE [dbo].[DeleteEmployee] 
	-- Add the parameters for the stored procedure here
	@id [dbo].[empid] = 000000000
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DELETE FROM employee WHERE emp_id = @id;
    -- Insert statements for procedure here
	SELECT @id
END

GO
/****** Object:  StoredProcedure [dbo].[reptq1]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[reptq1] AS
select 
	case when grouping(pub_id) = 1 then 'ALL' else pub_id end as pub_id, 
	avg(price) as avg_price
from titles
where price is NOT NULL
group by pub_id with rollup
order by pub_id


GO
/****** Object:  StoredProcedure [dbo].[reptq2]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[reptq2] AS
select 
	case when grouping(type) = 1 then 'ALL' else type end as type, 
	case when grouping(pub_id) = 1 then 'ALL' else pub_id end as pub_id, 
	avg(ytd_sales) as avg_ytd_sales
from titles
where pub_id is NOT NULL
group by pub_id, type with rollup


GO
/****** Object:  StoredProcedure [dbo].[reptq3]    Script Date: 18/1/2018 5:03:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[reptq3] @lolimit money, @hilimit money,
@type char(12)
AS
select 
	case when grouping(pub_id) = 1 then 'ALL' else pub_id end as pub_id, 
	case when grouping(type) = 1 then 'ALL' else type end as type, 
	count(title_id) as cnt
from titles
where price >@lolimit AND price <@hilimit AND type = @type OR type LIKE '%cook%'
group by pub_id, type with rollup


GO
USE [master]
GO
ALTER DATABASE [pubs] SET  READ_WRITE 
GO
