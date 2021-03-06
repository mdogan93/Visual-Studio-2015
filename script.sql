USE [master]
GO
/****** Object:  Database [PixAdvert]    Script Date: 10.8.2016 12:22:59 ******/
CREATE DATABASE [PixAdvert] ON  PRIMARY 
( NAME = N'Cavo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER2008\MSSQL\DATA\PixAdvert.mdf' , SIZE = 12288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Cavo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER2008\MSSQL\DATA\PixAdvert_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PixAdvert] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PixAdvert].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PixAdvert] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PixAdvert] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PixAdvert] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PixAdvert] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PixAdvert] SET ARITHABORT OFF 
GO
ALTER DATABASE [PixAdvert] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PixAdvert] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PixAdvert] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PixAdvert] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PixAdvert] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PixAdvert] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PixAdvert] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PixAdvert] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PixAdvert] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PixAdvert] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PixAdvert] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PixAdvert] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PixAdvert] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PixAdvert] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PixAdvert] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PixAdvert] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PixAdvert] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PixAdvert] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PixAdvert] SET  MULTI_USER 
GO
ALTER DATABASE [PixAdvert] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PixAdvert] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PixAdvert', N'ON'
GO
USE [PixAdvert]
GO
/****** Object:  User [PIXELSOFTOFFICE\PixLibrary Group]    Script Date: 10.8.2016 12:22:59 ******/
CREATE USER [PIXELSOFTOFFICE\PixLibrary Group] FOR LOGIN [PIXELSOFTOFFICE\PixLibrary Group]
GO
/****** Object:  User [PIXELSOFTOFFICE\mehmet]    Script Date: 10.8.2016 12:22:59 ******/
CREATE USER [PIXELSOFTOFFICE\mehmet] FOR LOGIN [PIXELSOFTOFFICE\mehmet] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PIXELSOFTOFFICE\can]    Script Date: 10.8.2016 12:22:59 ******/
CREATE USER [PIXELSOFTOFFICE\can] FOR LOGIN [PIXELSOFTOFFICE\can] WITH DEFAULT_SCHEMA=[PIXELSOFTOFFICE\can]
GO
ALTER ROLE [db_owner] ADD MEMBER [PIXELSOFTOFFICE\PixLibrary Group]
GO
ALTER ROLE [db_owner] ADD MEMBER [PIXELSOFTOFFICE\mehmet]
GO
/****** Object:  Schema [PIXELSOFTOFFICE\can]    Script Date: 10.8.2016 12:22:59 ******/
CREATE SCHEMA [PIXELSOFTOFFICE\can]
GO
/****** Object:  UserDefinedTableType [dbo].[MergeTable]    Script Date: 10.8.2016 12:22:59 ******/
CREATE TYPE [dbo].[MergeTable] AS TABLE(
	[Value] [nvarchar](250) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[GetMergeValues]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetMergeValues] 
(
	@SourceTable as MergeTable READONLY
)
RETURNS nvarchar(max)
AS
BEGIN
	
	declare @Return varchar(max)
	set @Return=''
	
    Select @Return = @Return + Convert(nvarchar(max),Value) + ',' 
	from  @SourceTable

	if (len(@Return)>0)
	begin
		set @Return = left(@Return,len(@Return)-1);
	end

	RETURN (@Return);

END


GO
/****** Object:  UserDefinedFunction [dbo].[ReplaceTurkishCharacters]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ReplaceTurkishCharacters]  (
	@Text nvarchar(max) 
)
RETURNS nvarchar(max)
AS
BEGIN
	
	Declare @Replaced nvarchar(max) = @Text

	Declare @TurkishCharacters nvarchar(50) = 'ığüşçö'
	Declare @MatchOfTurkishCharacters nvarchar(50) = 'igusco'

	Declare @Counter int = 1

	while @Counter <= len(@TurkishCharacters)
		Begin
			select @Replaced = Replace(@Replaced, substring(@TurkishCharacters, @Counter, 1), substring(@MatchOfTurkishCharacters, @Counter, 1))
			set @Counter = @Counter + 1
		End
		
	return @Replaced

END

GO
/****** Object:  UserDefinedFunction [dbo].[ReplaceWithSplitValues]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ReplaceWithSplitValues] (
	@SourceValue nvarchar(max),
	@ReplaceSplitValue nvarchar(max),
	@NewValue nvarchar(max)
)
RETURNS nvarchar(max)
AS
BEGIN
		
	select @SourceValue = replace(@SourceValue, ' ' + Value + ' ', @NewValue)
	from   Split(@ReplaceSplitValue, ',')
	
	return (select	substring((select ', ' + convert(nvarchar(10), Value) + ' '
							   from	  Split(@SourceValue, ',')
							   where  replace(Value, ' ', '') <> ''
							   for xml path('')), 3, 9999));

END

GO
/****** Object:  UserDefinedFunction [dbo].[Split]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[Split]
(
	@List nvarchar(max),
	@SplitOn nvarchar(5)
)  
RETURNS @RtnValue table 
(
		
	Id int identity(1,1),
	Value nvarchar(100)
) 
AS  
BEGIN

 



While (Charindex(@SplitOn,@List)>0)
Begin  




Insert Into @RtnValue (Value)
Select 
    Value = ltrim(rtrim(Substring(@List,1,Charindex(@SplitOn,@List)-1)))  




    Set @List = Substring(@List,Charindex(@SplitOn,@List)+len(@SplitOn),len(@List))
End  




    Insert Into @RtnValue (Value)
    Select Value = ltrim(rtrim(@List))

    Return
END

GO
/****** Object:  Table [dbo].[AdminMainMenus]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminMainMenus](
	[Id] [int] NOT NULL,
	[ToolId] [int] NULL,
	[MainMenuCode] [nvarchar](100) NULL,
	[Link] [nvarchar](500) NULL,
	[IconSet] [nvarchar](50) NULL,
	[IconString] [nvarchar](300) NULL,
	[Position] [nvarchar](10) NULL,
	[SortIndex] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Admins]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admins](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[Surname] [nvarchar](50) NULL,
	[RoleId] [int] NULL,
	[Email] [nvarchar](50) NULL,
	[DefaultLanguageId] [int] NULL,
	[MiniSitesBitwiseSum] [int] NULL,
	[Status] [smallint] NULL,
	[RegDate] [datetime] NULL,
 CONSTRAINT [PK_Admins] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdminSubMenus]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminSubMenus](
	[Id] [int] NOT NULL,
	[AdminMainMenuId] [int] NULL,
	[SubMenuCode] [nvarchar](500) NULL,
	[SubMenuLink] [nvarchar](500) NULL,
	[ShowInMenu] [int] NULL,
	[SortIndex] [int] NULL,
	[IconSet] [nvarchar](50) NULL,
	[IconString] [nvarchar](300) NULL,
	[NonAuthenticatable] [bit] NULL,
 CONSTRAINT [PK_AdminSubMenus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_AccountActivities]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_AccountActivities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[PaymentStyleId] [int] NOT NULL,
	[PaymentDate] [date] NOT NULL,
	[PaymentStatus] [int] NOT NULL,
	[Amount] [int] NOT NULL,
 CONSTRAINT [PK_AdvertManagement_AccountActivities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Addresses]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Addresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CountryId] [int] NOT NULL,
	[CityId] [int] NOT NULL,
	[TownId] [int] NOT NULL,
	[Neighboorhood] [nvarchar](50) NULL,
	[Detail] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_AdvertManagement_Addresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Admins]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Admins](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Status] [smallint] NULL,
	[RegDate] [datetime] NULL,
 CONSTRAINT [PK_AdvertManagement_Admins] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_AdvertPropertyRel]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_AdvertPropertyRel](
	[AdvertId] [int] NOT NULL,
	[PropertyId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Adverts]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Adverts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatorId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[IsGET] [bit] NULL CONSTRAINT [df_AdvertManagement_Adverts_IsGET]  DEFAULT ((0)),
	[DailyChance] [bit] NULL,
	[IsPriceChanged] [bit] NULL,
	[Details] [nvarchar](2000) NULL,
 CONSTRAINT [PK_AdvertManagement_Adverts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Blocks]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Blocks](
	[UserId] [int] NOT NULL,
	[BlockedUserId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Categories]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[ParentId] [int] NULL,
	[HasSubCategory] [bit] NOT NULL CONSTRAINT [DF_AdvertManagement_Categories_HasSubCategory]  DEFAULT ((0)),
	[AdvertCount] [int] NOT NULL CONSTRAINT [DF_AdvertManagement_Categories_AdvertCount]  DEFAULT ((0)),
	[DeterminerId] [int] NULL,
 CONSTRAINT [PK_AdvertManagement_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_CategoryPropertyRel]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_CategoryPropertyRel](
	[CategoryId] [int] NOT NULL,
	[PropertyTypeId] [int] NOT NULL,
	[PropertyId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Cities]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Cities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [nvarchar](50) NOT NULL,
	[CountryId] [int] NOT NULL,
 CONSTRAINT [PK_AdvertManagement_Cities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_CompletedTrades]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_CompletedTrades](
	[UserId] [int] NOT NULL,
	[AdvertId] [int] NOT NULL,
	[IsSold] [bit] NOT NULL,
	[RegDate] [date] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_ControlTypes]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_ControlTypes](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[ControlType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AdvertManagement_ControlTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Countries]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AdvertManagement_Countries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_CreditCards]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_CreditCards](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CardNumber] [nvarchar](16) NOT NULL,
	[DueDate] [date] NOT NULL,
	[CVC] [nvarchar](3) NOT NULL,
	[OwnerId] [int] NOT NULL,
 CONSTRAINT [PK_AdvertManagement_CreditCards] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [uq_CardNumber] UNIQUE NONCLUSTERED 
(
	[CardNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Educations]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Educations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EducationLevel] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AdvertManagement_Educations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Genders]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Genders](
	[Id] [int] NOT NULL,
	[GenderName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Genders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Jobs]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Jobs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[JobName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AdvertManagement_Jobs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_PaymentStatus]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_PaymentStatus](
	[Id] [int] NOT NULL,
	[PayStatus] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AdvertManagement_PaymentStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_PaymentStyles]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_PaymentStyles](
	[Id] [int] NOT NULL,
	[PaymentStyleName] [nvarchar](50) NULL,
 CONSTRAINT [PK_AdvertManagement_PaymentStyleId] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Properties]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Properties](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Value] [nvarchar](50) NULL,
 CONSTRAINT [PK_Properties] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_PropertyTypes]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_PropertyTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PropertyTypeName] [nvarchar](50) NOT NULL,
	[ControlTypeId] [smallint] NOT NULL,
 CONSTRAINT [PK_AdvertManagement_PropertyTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Searches]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Searches](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Notifications] [bit] NOT NULL,
	[Status] [smallint] NOT NULL,
	[RegDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[SearchText] [nvarchar](50) NULL,
 CONSTRAINT [PK_AdvertManagement_Searches] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_SearchPropertyRel]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_SearchPropertyRel](
	[SearchId] [int] NOT NULL,
	[SearchPropertyId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Towns]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Towns](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TownName] [nvarchar](50) NOT NULL,
	[CityId] [int] NOT NULL,
 CONSTRAINT [PK_AdvertManagement_Towns] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_UserActions]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_UserActions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[SellerId] [int] NULL,
	[AdvertId] [int] NULL,
	[SearchId] [int] NULL,
 CONSTRAINT [PK_AdvertManagement_UserActions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_UserAddressRel]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_UserAddressRel](
	[UserId] [int] NOT NULL,
	[AddressId] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AdvertManagement_Users]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdvertManagement_Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[GenderId] [int] NULL CONSTRAINT [df_Users_GenderId]  DEFAULT ((3)),
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[EducationId] [int] NULL,
	[JobId] [int] NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Birthday] [date] NULL,
 CONSTRAINT [PK_AdvertManagement_Users_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_AdvertManagement_Users_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_AdvertManagement_Users_Username] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ__AdvertMa__3214EC0671FCD09A] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[API_Application_Tokens]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[API_Application_Tokens](
	[Token] [uniqueidentifier] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[ApplicationId] [int] NOT NULL,
	[UserGuid] [uniqueidentifier] NOT NULL,
	[EnableLongTermStorage] [bit] NOT NULL,
 CONSTRAINT [PK_API_Application_Tokens] PRIMARY KEY CLUSTERED 
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[API_Applications]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[API_Applications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AppName] [nvarchar](100) NOT NULL,
	[ApiKey] [uniqueidentifier] NOT NULL,
	[ApiSecret] [uniqueidentifier] NOT NULL,
	[GlobalToken] [uniqueidentifier] NULL,
	[Status] [int] NOT NULL,
	[RegDate] [datetime] NOT NULL,
 CONSTRAINT [PK_API_Applications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Languages]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](5) NULL,
	[Name] [nvarchar](50) NULL,
	[IsDefault] [smallint] NULL,
	[Status] [smallint] NULL,
	[RegDate] [datetime] NULL,
	[AdminSupport] [bit] NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LogManagement_CodeTypes]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogManagement_CodeTypes](
	[Id] [int] NOT NULL,
	[CodeTypeName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_LogManagement_CodeTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LogManagement_LogLevels]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogManagement_LogLevels](
	[Id] [int] NOT NULL,
	[LogLevelName] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LogManagement_Logs]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogManagement_Logs](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NULL,
	[LogLevel] [int] NULL,
	[CodeTypeId] [int] NULL,
	[UserId] [int] NULL,
	[AdminId] [int] NULL,
	[Detail] [nvarchar](4000) NULL,
	[Description] [nvarchar](max) NULL,
	[Request] [nvarchar](max) NULL,
	[Response] [nvarchar](max) NULL,
	[Count] [int] NULL,
	[Url] [nvarchar](500) NULL,
	[HttpReferrer] [nvarchar](500) NULL,
	[UserAgent] [nvarchar](500) NULL,
	[IpAddress] [nvarchar](50) NULL,
	[LogDate] [datetime] NULL,
	[Etiquette] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LogManagement_Projects]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogManagement_Projects](
	[Id] [int] NOT NULL,
	[ProjectName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_LogManagement_Projects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoleAuthentications]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleAuthentications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AdminSubMenuId] [int] NULL,
	[RoleId] [int] NULL,
	[Status] [smallint] NULL,
	[RegDate] [datetime] NULL,
 CONSTRAINT [PK_RoleAuthentications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](250) NULL,
	[Status] [smallint] NULL,
	[RegDate] [datetime] NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tools]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tools](
	[Id] [int] NOT NULL,
	[ToolName] [nvarchar](50) NULL,
	[ToolCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tools] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AdvertManagement_Admins]    Script Date: 10.8.2016 12:23:00 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_AdvertManagement_Admins] ON [dbo].[AdvertManagement_Admins]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_AdvertManagement_Admins_1]    Script Date: 10.8.2016 12:23:00 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_AdvertManagement_Admins_1] ON [dbo].[AdvertManagement_Admins]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_AdvertManagement_UserAddressRel]    Script Date: 10.8.2016 12:23:00 ******/
CREATE NONCLUSTERED INDEX [idx_AdvertManagement_UserAddressRel] ON [dbo].[AdvertManagement_UserAddressRel]
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdvertManagement_AccountActivities]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_AccountActivities_AdvertManagement_PaymentStatus] FOREIGN KEY([PaymentStatus])
REFERENCES [dbo].[AdvertManagement_PaymentStatus] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_AccountActivities] CHECK CONSTRAINT [FK_AdvertManagement_AccountActivities_AdvertManagement_PaymentStatus]
GO
ALTER TABLE [dbo].[AdvertManagement_AccountActivities]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_AccountActivities_AdvertManagement_PaymentStyles] FOREIGN KEY([PaymentStyleId])
REFERENCES [dbo].[AdvertManagement_PaymentStyles] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_AccountActivities] CHECK CONSTRAINT [FK_AdvertManagement_AccountActivities_AdvertManagement_PaymentStyles]
GO
ALTER TABLE [dbo].[AdvertManagement_AccountActivities]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_AccountActivities_AdvertManagement_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[AdvertManagement_Users] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_AccountActivities] CHECK CONSTRAINT [FK_AdvertManagement_AccountActivities_AdvertManagement_Users]
GO
ALTER TABLE [dbo].[AdvertManagement_Addresses]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_Addresses_AdvertManagement_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[AdvertManagement_Countries] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_Addresses] CHECK CONSTRAINT [FK_AdvertManagement_Addresses_AdvertManagement_Countries]
GO
ALTER TABLE [dbo].[AdvertManagement_AdvertPropertyRel]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_AdvertPropertyRel_AdvertManagement_Adverts] FOREIGN KEY([AdvertId])
REFERENCES [dbo].[AdvertManagement_Adverts] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_AdvertPropertyRel] CHECK CONSTRAINT [FK_AdvertManagement_AdvertPropertyRel_AdvertManagement_Adverts]
GO
ALTER TABLE [dbo].[AdvertManagement_AdvertPropertyRel]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_AdvertPropertyRel_AdvertManagement_Properties] FOREIGN KEY([PropertyId])
REFERENCES [dbo].[AdvertManagement_Properties] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_AdvertPropertyRel] CHECK CONSTRAINT [FK_AdvertManagement_AdvertPropertyRel_AdvertManagement_Properties]
GO
ALTER TABLE [dbo].[AdvertManagement_Adverts]  WITH NOCHECK ADD  CONSTRAINT [FK_AdvertManagement_Adverts_AdvertManagement_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[AdvertManagement_Categories] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_Adverts] CHECK CONSTRAINT [FK_AdvertManagement_Adverts_AdvertManagement_Categories]
GO
ALTER TABLE [dbo].[AdvertManagement_Adverts]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_Adverts_AdvertManagement_Users] FOREIGN KEY([CreatorId])
REFERENCES [dbo].[AdvertManagement_Users] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_Adverts] CHECK CONSTRAINT [FK_AdvertManagement_Adverts_AdvertManagement_Users]
GO
ALTER TABLE [dbo].[AdvertManagement_Blocks]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_BlockedUsers_AdvertManagement_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[AdvertManagement_Users] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_Blocks] CHECK CONSTRAINT [FK_AdvertManagement_BlockedUsers_AdvertManagement_Users]
GO
ALTER TABLE [dbo].[AdvertManagement_Blocks]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_BlockedUsers_AdvertManagement_Users1] FOREIGN KEY([BlockedUserId])
REFERENCES [dbo].[AdvertManagement_Users] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_Blocks] CHECK CONSTRAINT [FK_AdvertManagement_BlockedUsers_AdvertManagement_Users1]
GO
ALTER TABLE [dbo].[AdvertManagement_Categories]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_Categories_AdvertManagement_Categories] FOREIGN KEY([ParentId])
REFERENCES [dbo].[AdvertManagement_Categories] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_Categories] CHECK CONSTRAINT [FK_AdvertManagement_Categories_AdvertManagement_Categories]
GO
ALTER TABLE [dbo].[AdvertManagement_Categories]  WITH NOCHECK ADD  CONSTRAINT [FK_AdvertManagement_Categories_AdvertManagement_Categories2] FOREIGN KEY([DeterminerId])
REFERENCES [dbo].[AdvertManagement_Categories] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_Categories] CHECK CONSTRAINT [FK_AdvertManagement_Categories_AdvertManagement_Categories2]
GO
ALTER TABLE [dbo].[AdvertManagement_CategoryPropertyRel]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_CategoryPropertyRel_AdvertManagement_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[AdvertManagement_Categories] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_CategoryPropertyRel] CHECK CONSTRAINT [FK_AdvertManagement_CategoryPropertyRel_AdvertManagement_Categories]
GO
ALTER TABLE [dbo].[AdvertManagement_CategoryPropertyRel]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_CategoryPropertyRel_AdvertManagement_Properties] FOREIGN KEY([PropertyId])
REFERENCES [dbo].[AdvertManagement_Properties] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_CategoryPropertyRel] CHECK CONSTRAINT [FK_AdvertManagement_CategoryPropertyRel_AdvertManagement_Properties]
GO
ALTER TABLE [dbo].[AdvertManagement_CategoryPropertyRel]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_CategoryPropertyRel_AdvertManagement_PropertyTypes] FOREIGN KEY([PropertyTypeId])
REFERENCES [dbo].[AdvertManagement_PropertyTypes] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_CategoryPropertyRel] CHECK CONSTRAINT [FK_AdvertManagement_CategoryPropertyRel_AdvertManagement_PropertyTypes]
GO
ALTER TABLE [dbo].[AdvertManagement_Cities]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_Cities_AdvertManagement_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[AdvertManagement_Countries] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_Cities] CHECK CONSTRAINT [FK_AdvertManagement_Cities_AdvertManagement_Countries]
GO
ALTER TABLE [dbo].[AdvertManagement_CompletedTrades]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_CompletedTrades_AdvertManagement_Adverts] FOREIGN KEY([AdvertId])
REFERENCES [dbo].[AdvertManagement_Adverts] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_CompletedTrades] CHECK CONSTRAINT [FK_AdvertManagement_CompletedTrades_AdvertManagement_Adverts]
GO
ALTER TABLE [dbo].[AdvertManagement_CompletedTrades]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_CompletedTrades_AdvertManagement_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[AdvertManagement_Users] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_CompletedTrades] CHECK CONSTRAINT [FK_AdvertManagement_CompletedTrades_AdvertManagement_Users]
GO
ALTER TABLE [dbo].[AdvertManagement_CreditCards]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_CreditCards_AdvertManagement_Users] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[AdvertManagement_Users] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_CreditCards] CHECK CONSTRAINT [FK_AdvertManagement_CreditCards_AdvertManagement_Users]
GO
ALTER TABLE [dbo].[AdvertManagement_PropertyTypes]  WITH NOCHECK ADD  CONSTRAINT [FK_AdvertManagement_PropertyTypes_AdvertManagement_ControlTypes] FOREIGN KEY([ControlTypeId])
REFERENCES [dbo].[AdvertManagement_ControlTypes] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_PropertyTypes] CHECK CONSTRAINT [FK_AdvertManagement_PropertyTypes_AdvertManagement_ControlTypes]
GO
ALTER TABLE [dbo].[AdvertManagement_Searches]  WITH NOCHECK ADD  CONSTRAINT [FK_AdvertManagement_Searches_AdvertManagement_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[AdvertManagement_Categories] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_Searches] CHECK CONSTRAINT [FK_AdvertManagement_Searches_AdvertManagement_Categories]
GO
ALTER TABLE [dbo].[AdvertManagement_SearchPropertyRel]  WITH CHECK ADD  CONSTRAINT [FK_SearchPropertyRel_AdvertManagement_Properties] FOREIGN KEY([SearchPropertyId])
REFERENCES [dbo].[AdvertManagement_Properties] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_SearchPropertyRel] CHECK CONSTRAINT [FK_SearchPropertyRel_AdvertManagement_Properties]
GO
ALTER TABLE [dbo].[AdvertManagement_SearchPropertyRel]  WITH CHECK ADD  CONSTRAINT [FK_SearchPropertyRel_AdvertManagement_Searches] FOREIGN KEY([SearchId])
REFERENCES [dbo].[AdvertManagement_Searches] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_SearchPropertyRel] CHECK CONSTRAINT [FK_SearchPropertyRel_AdvertManagement_Searches]
GO
ALTER TABLE [dbo].[AdvertManagement_Towns]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_Towns_AdvertManagement_Cities] FOREIGN KEY([CityId])
REFERENCES [dbo].[AdvertManagement_Cities] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_Towns] CHECK CONSTRAINT [FK_AdvertManagement_Towns_AdvertManagement_Cities]
GO
ALTER TABLE [dbo].[AdvertManagement_UserActions]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_UserActions_AdvertManagement_Adverts] FOREIGN KEY([AdvertId])
REFERENCES [dbo].[AdvertManagement_Adverts] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_UserActions] CHECK CONSTRAINT [FK_AdvertManagement_UserActions_AdvertManagement_Adverts]
GO
ALTER TABLE [dbo].[AdvertManagement_UserActions]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_UserActions_AdvertManagement_UserActions] FOREIGN KEY([Id])
REFERENCES [dbo].[AdvertManagement_UserActions] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_UserActions] CHECK CONSTRAINT [FK_AdvertManagement_UserActions_AdvertManagement_UserActions]
GO
ALTER TABLE [dbo].[AdvertManagement_UserActions]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_UserActions_AdvertManagement_Users] FOREIGN KEY([SellerId])
REFERENCES [dbo].[AdvertManagement_Users] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_UserActions] CHECK CONSTRAINT [FK_AdvertManagement_UserActions_AdvertManagement_Users]
GO
ALTER TABLE [dbo].[AdvertManagement_UserAddressRel]  WITH NOCHECK ADD  CONSTRAINT [FK_AdvertManagement_UserAddressRel_AdvertManagement_Addresses] FOREIGN KEY([AddressId])
REFERENCES [dbo].[AdvertManagement_Addresses] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_UserAddressRel] CHECK CONSTRAINT [FK_AdvertManagement_UserAddressRel_AdvertManagement_Addresses]
GO
ALTER TABLE [dbo].[AdvertManagement_UserAddressRel]  WITH NOCHECK ADD  CONSTRAINT [FK_AdvertManagement_UserAddressRel_AdvertManagement_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[AdvertManagement_Users] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_UserAddressRel] CHECK CONSTRAINT [FK_AdvertManagement_UserAddressRel_AdvertManagement_Users]
GO
ALTER TABLE [dbo].[AdvertManagement_Users]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_Users_AdvertManagement_Educations] FOREIGN KEY([EducationId])
REFERENCES [dbo].[AdvertManagement_Educations] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_Users] CHECK CONSTRAINT [FK_AdvertManagement_Users_AdvertManagement_Educations]
GO
ALTER TABLE [dbo].[AdvertManagement_Users]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_Users_AdvertManagement_Genders] FOREIGN KEY([GenderId])
REFERENCES [dbo].[AdvertManagement_Genders] ([Id])
ON DELETE SET DEFAULT
GO
ALTER TABLE [dbo].[AdvertManagement_Users] CHECK CONSTRAINT [FK_AdvertManagement_Users_AdvertManagement_Genders]
GO
ALTER TABLE [dbo].[AdvertManagement_Users]  WITH CHECK ADD  CONSTRAINT [FK_AdvertManagement_Users_AdvertManagement_Jobs] FOREIGN KEY([JobId])
REFERENCES [dbo].[AdvertManagement_Jobs] ([Id])
GO
ALTER TABLE [dbo].[AdvertManagement_Users] CHECK CONSTRAINT [FK_AdvertManagement_Users_AdvertManagement_Jobs]
GO
ALTER TABLE [dbo].[AdvertManagement_Users]  WITH CHECK ADD  CONSTRAINT [CK_AdvertManagement_Users_JobId] CHECK  (([JobId]>(0)))
GO
ALTER TABLE [dbo].[AdvertManagement_Users] CHECK CONSTRAINT [CK_AdvertManagement_Users_JobId]
GO
/****** Object:  StoredProcedure [dbo].[Admin_Login]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Admin_Login]
(
	@UserName nvarchar(50),
	@Password nvarchar(50),
	@Message nvarchar(4000) output,
	@MessageType int output
)

AS
SET NOCOUNT ON 
BEGIN
	
DECLARE @AdminId as int
DECLARE @IsExists as int
	
	 Select @IsExists = Count(*), 
		    @AdminId = Id
		    
	 From   Admins
	 
	 Where  UserName = @UserName 
			and [Password] = @Password 
			and [Status] = 1
			
	  Group By Admins.Id;

	  if (@IsExists > 0)
		Begin
				set @Message = 'dbmLoginSuccessful';
				set @MessageType = 1;	

			 Select Admins.Id, 
					Admins.Name, 
					Admins.Surname, 
					Admins.Email, 
					Admins.RoleId, 
					Admins.DefaultLanguageId, 
					Admins.UserName, 
					Admins.Password, 
					Languages.Name as LanguageName,
					MiniSitesBitwiseSum
					
			   From Admins 
			   
				 Inner Join Languages on 
					Admins.DefaultLanguageId = Languages.Id
					
			  Where Admins.Id = @AdminId
		End
	Else
		Begin
			set @Message = 'dbmLoginUnSuccessful';
			set @MessageType = 0;
		  End

END

GO
/****** Object:  StoredProcedure [dbo].[Delete_Admin]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_Admin](
	@AdminId int,

	@Message nvarchar(4000) output,
	@MessageType int output
)
AS
SET NOCOUNT ON 
BEGIN
	
	Update Admins set 
		[Status] = -1
	where Id = @AdminId

	set @Message = 'dbmAdminDeleteSuccessful';
	set @MessageType = 1;
		
END

GO
/****** Object:  StoredProcedure [dbo].[Delete_AdvertManagement_CategoryById]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Delete_AdvertManagement_CategoryById] 
	-- Add the parameters for the stored procedure here
	@categoryId int
AS
BEGIN
	declare @parentId as int 

	select @parentId= ParentId
	from AdvertManagement_Categories
	where Id=@categoryId;
	
	delete  
	from AdvertManagement_Categories
	where Id=@categoryId;
	
	declare @childcount as int
	select  @childcount=Count(*)
	from AdvertManagement_Categories 
	where ParentId=@parentId;

	if(@childcount=0)
		update AdvertManagement_Categories
		set HasSubCategory=0 where Id=@parentId
	
END
GO
/****** Object:  StoredProcedure [dbo].[Delete_LogManagement_Log]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Delete_LogManagement_Log](
		@LogId int,
		@Message nvarchar(4000) output,
	@MessageType int output
)

AS
SET NOCOUNT ON 
BEGIN
	
	delete LogManagement_Logs
	where LogManagement_Logs.Id = @LogId
	
	set @Message = 'dbm_LogDelete_Successful';
	set @MessageType = 1;


		
END


GO
/****** Object:  StoredProcedure [dbo].[Delete_Role]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_Role](
	@RoleId int,
	@Message nvarchar(4000) output,
	@MessageType int output
)

AS
SET NOCOUNT ON 
BEGIN
	
	declare @RoleAdminCount as int

	Select @RoleAdminCount = Count(*)
	From Admins
	Where RoleId = @RoleId

	If (@RoleAdminCount = 0)
		begin

			delete Roles
			Where Id = @RoleId

			delete RoleAuthentications
			Where RoleId = @RoleId

		end
	else
		begin

			Update Roles Set 
				[Status] = -1 
			Where Id = @RoleId

			Update RoleAuthentications Set 
				[Status] = -1 
			Where RoleId = @RoleId

		end
			
	set @Message = 'dbmRoleDeleteSuccessful';
	set @MessageType = 1;


		
END




GO
/****** Object:  StoredProcedure [dbo].[Get_AdminById]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_AdminById]
(
	@AdminId int
)

AS
SET NOCOUNT ON 
BEGIN
	
	 Select Id, 
			UserName, 
			Password, 
			[Name], 
			Surname, 
			Email, 
			RoleId, 
			DefaultLanguageId,
			MiniSitesBitwiseSum
	 
	 From Admins
	 
	 Where Admins.Id = @AdminId
		
END




GO
/****** Object:  StoredProcedure [dbo].[Get_AdminLanguages]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_AdminLanguages]	
AS
SET NOCOUNT ON 
BEGIN
	
	 Select Id, 
			Code, 
			[Name],
			IsDefault
	 
	 From  Languages
	 
	 Where [Status] = 1 AND AdminSupport = 1
	 
	 Order By IsDefault desc,
			  Id asc

END




GO
/****** Object:  StoredProcedure [dbo].[Get_AdminMainPagesByRoleId]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_AdminMainPagesByRoleId](
       @RoleId as int,
       @Position as nvarchar(10)= 'Left'
)
AS
SET NOCOUNT ON 

BEGIN
       
       select  distinct
                    AdminMainMenus.MainMenuCode, 
                    AdminMainMenus.Id, 
                    AdminMainMenus.Link,
                    isnull(Tools.ToolCode, '') as ToolCode,
                    AdminMainMenus.IconSet,
                    AdminMainMenus.IconString,
					isnull(AdminMainMenus.SortIndex,999999) as SortIndex
       from   AdminMainMenus
       inner join AdminSubMenus on AdminMainMenus.Id = AdminSubMenus.AdminMainMenuId 
       left join RoleAuthentications on AdminSubMenus.Id = RoleAuthentications.AdminSubMenuId
       left join Tools on AdminMainMenus.ToolId = Tools.Id   
       where (RoleAuthentications.RoleId = @RoleId or NonAuthenticatable = 1) and AdminMainMenus.Position = @Position     
       order by SortIndex

END

GO
/****** Object:  StoredProcedure [dbo].[Get_Admins]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Admins]
AS
SET NOCOUNT ON 
BEGIN
	
	select	r.RoleName, 
			a.Id, 
			a.UserName, 
			(a.Name + ' ' + a.Surname) as AdminName, 
			a.Email	  
	from	Admins as a
	inner Join Roles as r on r.Id = a.RoleId
	where a.Id <> 1 and a.Status = 1
	order by AdminName
		
END
GO
/****** Object:  StoredProcedure [dbo].[Get_AdminSubPagesByRoleId]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_AdminSubPagesByRoleId]
(
	@RoleId int,
	@ShowInMenu int,
	@MainMenuId int = null
)
AS
SET NOCOUNT ON 
BEGIN
	
	SELECT AdminSubMenus.SubMenuCode, 
		   AdminSubMenus.SubMenuLink, 
		   AdminSubMenus.Id, 
		   AdminSubMenus.SortIndex, 
		   AdminSubMenus.AdminMainMenuId,
		   isnull(Tools.ToolCode, '') as ToolCode,
		   RoleId,
		   AdminSubMenus.IconSet,
		   AdminSubMenus.IconString,
		   AdminSubMenus.NonAuthenticatable
	
	FROM  AdminSubMenus  
	
		inner join AdminMainMenus on AdminSubMenus.AdminMainMenuId = AdminMainMenus.Id
		left JOIN  RoleAuthentications
			ON RoleAuthentications.AdminSubMenuId = AdminSubMenus.Id
		left join Tools on AdminMainMenus.ToolId = Tools.Id
	
	WHERE (AdminSubMenus.ShowInMenu = @ShowInMenu or @ShowInMenu is null) 
		   and (RoleAuthentications.RoleId = @RoleId or NonAuthenticatable = 1 )
		   and (AdminSubMenus.AdminMainMenuId = @MainMenuId or @MainMenuId is null)
	
	ORDER BY AdminSubMenus.AdminMainMenuId, AdminSubMenus.SortIndex

END
GO
/****** Object:  StoredProcedure [dbo].[Get_AdvertManagement_CategoryById]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <5.8.2016>
-- Description:	<Procedure to get SubCategories of a category by giving categoryId>
-- =============================================
CREATE PROCEDURE [dbo].[Get_AdvertManagement_CategoryById] 
	-- Add the parameters for the stored procedure here
	@categoryId int
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	select Id,CategoryName,ParentId,HasSubCategory,AdvertCount,DeterminerId 
	from AdvertManagement_Categories
	where Id=@categoryId 
END

GO
/****** Object:  StoredProcedure [dbo].[Get_AdvertManagement_Educations]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <5.8.2016>
-- Description:	<Procedure to get Educations>
-- =============================================
Create PROCEDURE [dbo].[Get_AdvertManagement_Educations] 
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	select Id,EducationLevel 
	from AdvertManagement_Educations;
	
END


GO
/****** Object:  StoredProcedure [dbo].[Get_AdvertManagement_Jobs]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <8.8.2016>
-- Description:	<Procedure to get Jobs>
-- =============================================
CREATE PROCEDURE [dbo].[Get_AdvertManagement_Jobs] 
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	select Id,JobName 
	from AdvertManagement_Jobs;
	
END
GO
/****** Object:  StoredProcedure [dbo].[Get_AdvertManagement_MainCategories]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <4.8.2016>
-- Description:	<Procedure to get SubCategories of a category by giving categoryId>
-- =============================================
CREATE PROCEDURE [dbo].[Get_AdvertManagement_MainCategories] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	SELECT Id,CategoryName,ParentId,HasSubCategory,AdvertCount,DeterminerId  
	from AdvertManagement_Categories 
	where ParentId is NULL
END


GO
/****** Object:  StoredProcedure [dbo].[Get_AdvertManagement_ParentCategories]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <5.8.2016>
-- Description:	<Procedure to get breadcrumb of the category with given Id>
-- =============================================

Create PROCEDURE [dbo].[Get_AdvertManagement_ParentCategories] 
	-- Add the parameters for the stored procedure here
	@categoryId int
AS
BEGIN
WITH cte(Id, CategoryName, ParentId)  
AS (SELECT child.Id, child.CategoryName, child.ParentId        
    FROM AdvertManagement_Categories AS child  
    WHERE child.Id= @categoryId 
    UNION ALL  
    SELECT child.Id, child.CategoryName, child.ParentId        
    FROM AdvertManagement_Categories AS child  
    JOIN cte AS cteItem ON child.Id = cteItem.ParentId  
    )  
SELECT Id, CategoryName, ParentId  
FROM cte    
END

GO
/****** Object:  StoredProcedure [dbo].[Get_AdvertManagement_PropertiesByAdvertId]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <5.8.2016>
-- Description:	<Procedure to get properties of an advert by advert ID>
-- =============================================
CREATE PROCEDURE [dbo].[Get_AdvertManagement_PropertiesByAdvertId] 
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	select propTypes.PropertyTypeName,prop.Value
	from AdvertManagement_Adverts as advItem 
			inner join AdvertManagement_AdvertPropertyRel as advPropRel on advPropRel.AdvertId=advItem.Id
			inner join AdvertManagement_Properties as prop on advPropRel.PropertyId=prop.Id
			inner join AdvertManagement_CategoryPropertyRel as catProperty on advPropRel.PropertyId=catProperty.PropertyId
			inner join AdvertManagement_PropertyTypes as propTypes on propTypes.Id=catProperty.PropertyTypeId
			where advItem.Id=@Id
	group by propTypes.PropertyTypeName,prop.Value;
END
GO
/****** Object:  StoredProcedure [dbo].[Get_AdvertManagement_PropertyTypesByCategoryId]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <9.8.2016>
-- Description:	<Procedure to get propertyTypes by Category Id >
-- =============================================
create PROCEDURE [dbo].[Get_AdvertManagement_PropertyTypesByCategoryId] 
	-- Add the parameters for the stored procedure here
	@categoryId as int 
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
select propertyType.Id, propertyType.PropertyTypeName 
from AdvertManagement_Categories as category 
		inner join AdvertManagement_Categories as determiner on determiner.Id=category.DeterminerId
		inner join AdvertManagement_CategoryPropertyRel as relation on determiner.Id=relation.CategoryId 
		inner join AdvertManagement_PropertyTypes as propertyType on propertyType.Id=relation.PropertyTypeId

where category.Id=@categoryId
group by propertyType.Id, propertyType.PropertyTypeName  ;

END


GO
/****** Object:  StoredProcedure [dbo].[Get_AdvertManagement_SubcategoriesByCategoryId]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <4.8.2016>
-- Description:	<Procedure to get SubCategories of a category by giving categoryId>
-- =============================================
CREATE PROCEDURE [dbo].[Get_AdvertManagement_SubcategoriesByCategoryId] 
	-- Add the parameters for the stored procedure here
	@CategoryId as int
	
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	select Id,CategoryName,ParentId,HasSubCategory,AdvertCount,DeterminerId  
	from AdvertManagement_Categories 
	where ParentId=@CategoryId
END

GO
/****** Object:  StoredProcedure [dbo].[Get_AdvertManagement_UserById]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <5.8.2016>
-- Description:	<Procedure to get User by ID>
-- =============================================
Create PROCEDURE [dbo].[Get_AdvertManagement_UserById] 
	-- Add the parameters for the stored procedure here
	@Id int
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	select Id,UserName,FirstName,LastName,GenderId,EducationId,JobId, Phone,Birthday 
	from AdvertManagement_Users
	where Id=@Id 
END
GO
/****** Object:  StoredProcedure [dbo].[Get_API_GlobalTokens]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Get_API_GlobalTokens]
as
	Select ApiKey,ApiSecret,GlobalToken from API_Applications Where GlobalToken is not null
GO
/****** Object:  StoredProcedure [dbo].[Get_API_IsAuthorized]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Get_API_IsAuthorized]
(
	@Token uniqueidentifier,
	@ShortTermStorageMinutes int,
	@LongTermStorageMinutes int
)
as
begin
	declare @Now datetime = getdate()

	declare @EnableLongTermStorage bit
	declare @UserGuid uniqueidentifier
	declare @ExpirationDate datetime

	Select	@UserGuid=UserGuid,
			@EnableLongTermStorage = EnableLongTermStorage 
	from API_Application_Tokens Where Token = @Token and ExpirationDate>=@Now
	
	if @UserGuid is not null --token hala geçerli süresini uzat
	begin
		if(@EnableLongTermStorage=1)
			set @ExpirationDate = dateadd(minute, @LongTermStorageMinutes, @Now)
		else
			set @ExpirationDate = dateadd(minute, @ShortTermStorageMinutes, @Now)

		update API_Application_Tokens set ExpirationDate = @ExpirationDate
		Where Token = @Token
	end
	
	select @UserGuid as UserGuid
end
GO
/****** Object:  StoredProcedure [dbo].[Get_API_Token]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Get_API_Token]
(
	@ApiKey uniqueidentifier,
	@ApiSecret uniqueidentifier
)
as
begin
	declare @Id int
	declare @token uniqueidentifier


	Select @Id=Id,@token=GlobalToken from API_Applications Where ApiKey=@ApiKey and ApiSecret=@ApiSecret and Status=1
	
	if @Id is not null and @token is null
	begin
		set @token=NEWID()
		Update API_Applications set GlobalToken=@token Where Id=@Id
	end
	
	select @token as Token
end


GO
/****** Object:  StoredProcedure [dbo].[Get_Languages]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Languages]	
AS
SET NOCOUNT ON 
BEGIN
	
	 Select Id, 
			Code, 
			[Name],
			IsDefault
	 
	 From  Languages
	 
	 Where [Status] = 1
	 
	 Order By IsDefault desc,
			  Id asc

END




GO
/****** Object:  StoredProcedure [dbo].[Get_LogManagement_CodeTypes]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Get_LogManagement_CodeTypes]
AS
SET NOCOUNT ON 
BEGIN

	SELECT  ID, 
			CodeTypeName
	
	FROM    LogManagement_CodeTypes
	
	ORDER By ID


END



GO
/****** Object:  StoredProcedure [dbo].[Get_LogManagement_LogLevels]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Get_LogManagement_LogLevels]
AS
SET NOCOUNT ON 
BEGIN

	SELECT  ID, 
			LogLevelName
	
	FROM    LogManagement_LogLevels
	
	ORDER By ID


END



GO
/****** Object:  StoredProcedure [dbo].[Get_LogManagement_Logs]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Get_LogManagement_Logs] 
(
	@UserName as nvarchar(50),
	@FirstName as nvarchar(50),
	@LastName as nvarchar(50),
	@LogDate as datetime,
	@LogLevel as int,
	@CodeTypeId as int,
	@AdminId as int,
	@Detail as nvarchar(4000),
	@Url as nvarchar(500),
	@HttpReferrer as nvarchar(500),
	@UserAgent as nvarchar(500),
	@Etiquette as nvarchar(max)
)
AS
SET NOCOUNT ON 
BEGIN
	
	declare @TableName nvarchar(255)

	select @TableName = name from sys.tables where name in ('Users','UserManagement_Users')
	
	create table #Users(
			Id int,
			FirstName nvarchar(max),
			LastName nvarchar(max),
			UserName nvarchar(max)
		)

	if @TableName is not null
		begin
			declare @sql nvarchar(max) = N'select Id, FirstName, LastName, UserName from ' + QUOTENAME(@TableName) + ' where 1=1'
			
			if @FirstName is not null
				set @sql = @sql + ' and FirstName like ''%'+ @FirstName +'%'' '

			if @LastName is not null
				set @sql = @sql + ' and LastName like ''%'+ @LastName +'%'' '

			if @UserName is not null
				set @sql = @sql + ' and UserName like ''%'+ @UserName +'%'' '

			insert into #Users
			exec sp_executesql @sql
		end


	select  LogManagement_Logs.Id,
			LogManagement_Logs.Url,
			LogManagement_Logs.HttpReferrer,
			LogManagement_Logs.UserAgent,
			LogManagement_Projects.ProjectName,
			LogManagement_Logs.Detail, 
			LogManagement_Logs.Request,
			LogManagement_Logs.Response,
			LogManagement_Logs.IpAddress, 
			LogManagement_Logs.LogDate, 
			LogManagement_Logs.Description,
			LogManagement_Logs.Count,
			-- Geçici olarak admin log listesi sayfasında hata olmaması için User yerine Admin bilgileri çekiliyor.
			-- User tablosuna bağlantıların bir şekilde planlanması gerekiyor.
			--Admins.UserName,
			--Admins.Name as FirstName,
			--Admins.Surname as LastName,
			isnull(#Users.UserName,Admins.UserName) as UserName,
			isnull(#Users.FirstName,Admins.Name) as FirstName,
			isnull(#Users.LastName,Admins.Surname) as LastName,
			--Users.FirstName,
			--Users.LastName,
			Etiquette,
			LogManagement_LogLevels.LogLevelName,
			CodeTypeName
			
	from    LogManagement_Logs
	
		left join #Users 
			on LogManagement_Logs.UserId = #Users.Id
		
		left join Admins 
			on LogManagement_Logs.AdminId = Admins.Id
		
		left join LogManagement_LogLevels 
			on LogManagement_Logs.LogLevel = LogManagement_LogLevels.Id
			
		left join LogManagement_CodeTypes 
			on LogManagement_Logs.CodeTypeId = LogManagement_CodeTypes.Id
		
		left join LogManagement_Projects 
			on LogManagement_Logs.ProjectId = LogManagement_Projects.Id
	
	where	((
			(Admins.UserName like '%'+@UserName+'%' or @UserName is null)
			and (Admins.Name like '%'+@FirstName+'%' or @FirstName is null)
			and (Admins.Surname like '%'+@LastName+'%' or @LastName is null)
			)
			or
			(
			(#Users.UserName like '%'+@UserName+'%' or @UserName is null)
			and (#Users.FirstName like '%'+@FirstName+'%' or @FirstName is null)
			and (#Users.LastName like '%'+@LastName+'%' or @LastName is null)
			))

			and 
			(dateadd(dd,0, datediff(dd,0, LogDate)) = @LogDate  or @LogDate is null)
			and (LogManagement_Logs.LogLevel = @LogLevel  or @LogLevel is null)
			and (LogManagement_Logs.CodeTypeId = @CodeTypeId  or @CodeTypeId is null)
			and (LogManagement_Logs.AdminId = @AdminId  or @AdminId is null)
			and (LogManagement_Logs.Detail like '%'+@Detail+'%' or @Detail is null)
			and (LogManagement_Logs.Url like '%'+@Url+'%' or @Url is null)
			and (LogManagement_Logs.HttpReferrer like '%'+@HttpReferrer+'%' or @HttpReferrer is null)
			and (LogManagement_Logs.UserAgent like '%'+@UserAgent+'%' or @UserAgent is null)
				and (Etiquette like '%'+@Etiquette +'%' or @Etiquette is null)
			
	order by Id desc

	drop table #Users
END




GO
/****** Object:  StoredProcedure [dbo].[Get_LogManagement_TypeNameById]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Get_LogManagement_TypeNameById]
(
	@TypeId as int,
	@Type as nvarchar(10)
)
AS
SET NOCOUNT ON 
BEGIN

	if @Type = 'log'
		begin
			SELECT  LogLevelName as TypeName 		
			FROM    LogManagement_LogLevels
			where Id = @TypeId
		end
	else if @Type = 'code'
		begin
			SELECT  CodeTypeName as TypeName 		
			FROM    LogManagement_CodeTypes
			where  Id = @TypeId
		end

END



GO
/****** Object:  StoredProcedure [dbo].[Get_MenusByRoleId]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_MenusByRoleId](
	@RoleId int,
	@AdminRoleId int
)
AS
SET NOCOUNT ON 
BEGIN
	
	select	case when isnull(ra.Id, 0) = 0 then 'false' 
			    else 'true' end as IsChecked,
            asm.Id, 
            asm.AdminMainMenuId, 
            asm.SubMenuCode, 
            amm.MainMenuCode,
            Tools.ToolCode,
            asm.NonAuthenticatable              
	from	AdminMainMenus as amm
    inner join AdminSubMenus as asm on asm.AdminMainMenuId = amm.Id 
    inner join Tools ON amm.ToolId = Tools.Id
	left outer Join RoleAuthentications as ra on ra.RoleId = @RoleId and asm.Id = ra.AdminSubMenuId
    /*where asm.Id in (select AdminSubMenus.Id 
					 from   AdminSubMenus 
                     inner join RoleAuthentications on AdminSubMenus.Id = RoleAuthentications.AdminSubMenuId and RoleAuthentications.RoleId = @AdminRoleId)*/                                                            
	order by asm.AdminMainMenuId, asm.SubMenuCode

END
GO
/****** Object:  StoredProcedure [dbo].[Get_RoleById]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_RoleById](
	@RoleId int
)
	
AS
SET NOCOUNT ON 
BEGIN
	
 Select Id, RoleName
   From Roles
  Where Id = @RoleId
	
END




GO
/****** Object:  StoredProcedure [dbo].[Get_Roles]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_Roles](
	@AdminRoleId int
)
	
AS
SET NOCOUNT ON 
BEGIN
	
	Select Id, RoleName
	From Roles
	Where Id <> 1 and Id <> @AdminRoleId and [Status] = 1

END
GO
/****** Object:  StoredProcedure [dbo].[Insert_Admin]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Admin](
	@UserName nvarchar(50),
	@Password nvarchar(50),
	@Name nvarchar(50),
	@Surname nvarchar(50),
	@Email nvarchar(50),
	@RoleId int,
	@DefaultLanguageId int,
	@MiniSitesBitwiseSum as int,
	@RegDate datetime,
	@Message nvarchar(4000) output,
	@MessageType int output
)
AS
SET NOCOUNT ON 
BEGIN

	If Not Exists(Select Id From Admins Where UserName = @UserName and [Status] = 1)
		Begin
			Insert Into Admins(
					UserName,
					[Password],
					[Name],
					Surname,
					Email,
					RoleId,
					DefaultLanguageId,
					MiniSitesBitwiseSum,
					[Status],
					RegDate
			)
			Values(
					@UserName,
					@Password,
					@Name,
					@Surname,
					@Email,
					@RoleId,
					@DefaultLanguageId,
					@MiniSitesBitwiseSum,
					1,
					@RegDate
			)

			set @Message = 'dbmAdminAddSuccessful';
			set @MessageType = 1			
		End
	Else
		Begin
			set @Message = 'dbmAdminAddUnSuccessful';
			set @MessageType = 0;
		End

END




GO
/****** Object:  StoredProcedure [dbo].[Insert_AdvertManagement_Advert]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[Insert_AdvertManagement_Advert] 
	-- Add the parameters for the stored procedure here
	@CreatorId as int,
	@CategoryId as int,
	@Title as nvarchar(50),
	@IsGet as bit,
	@DailyChance as bit,
	@IsPriceChanged as bit,
	@Details as nvarchar(2000)
		
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	Insert into AdvertManagement_Adverts(
			CreatorId,
			CategoryId, 
			Title,
			IsGet,
			DailyChance,
			IsPriceChanged,
			Details
			)
	VALUES(
			@CreatorId,
			@CategoryId, 
			@Title,
			@IsGet,
			@DailyChance,
			@IsPriceChanged,
			@Details)

	SELECT SCOPE_IDENTITY();	
END



GO
/****** Object:  StoredProcedure [dbo].[Insert_AdvertManagement_Category]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Insert_AdvertManagement_Category] 
	-- Add the parameters for the stored procedure here
	@CategoryName as nvarchar(50),
	@ParentId as int,
	@DeterminerId as int
		
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	Insert into AdvertManagement_Categories(
			CategoryName,
			ParentId,
			DeterminerId)
	VALUES(
			@CategoryName, 
			@ParentId,
			@DeterminerId);
	SELECT SCOPE_IDENTITY();	
END


GO
/****** Object:  StoredProcedure [dbo].[Insert_AdvertManagement_Property]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <4.8.2016>
-- Description:	<Procedure to insert a category >
-- =============================================
CREATE PROCEDURE [dbo].[Insert_AdvertManagement_Property] 
	-- Add the parameters for the stored procedure here
	@Value as nvarchar(50)
		
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	Insert into AdvertManagement_Properties(Value)
	VALUES(@Value);
	SELECT SCOPE_IDENTITY();	
	
END



GO
/****** Object:  StoredProcedure [dbo].[Insert_AdvertManagement_PropertyType]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <4.8.2016>
-- Description:	<Procedure to insert a category >
-- =============================================
CREATE PROCEDURE [dbo].[Insert_AdvertManagement_PropertyType] 
	-- Add the parameters for the stored procedure here
	@PropertyTypeName as nvarchar(50),
	@ControlTypeId as int
		
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	Insert into AdvertManagement_PropertyTypes(PropertyTypeName,ControlTypeId)
	VALUES(@PropertyTypeName,@ControlTypeId);
	SELECT SCOPE_IDENTITY();	
	
END



GO
/****** Object:  StoredProcedure [dbo].[Insert_AdvertManagement_User]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_AdvertManagement_User] 
	-- Add the parameters for the stored procedure here
	@Username as nvarchar(50),
	@FirstName as nvarchar(50),
	@LastName as nvarchar(50),
	@GenderId as int,
	@Email as nvarchar(50),
	@Password as nvarchar(50),
	@EducationId as int,
	@JobId as int,
	@Phone as nvarchar(50),
	@Birthday as date
		
AS
	SET NOCOUNT ON
BEGIN
	If Not Exists(Select Id From AdvertManagement_Users Where UserName = @UserName or Email = @Email)
	Begin
		Insert Into [dbo].[AdvertManagement_Users](
				[UserName]
			   ,[FirstName]
			   ,[LastName]
			   ,[GenderId]
			   ,[Email]
			   ,[Password]
			   ,[EducationId]
			   ,[JobId]
			   ,[Phone]
			   ,[Birthday])
		 values(
				@Username,
				@FirstName,
				@LastName,
				@GenderId,
				@Email,
				@Password,
				@EducationId,
				@JobId,
				@Phone,
				@Birthday
		 )
		return 0;
	end
	else
	begin
		return 1;
	End

END





GO
/****** Object:  StoredProcedure [dbo].[Insert_API_Application]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Insert_API_Application] 
(
	@AppName nvarchar(100)
)
as
begin
	if not exists (Select 1 from API_Applications Where Status=1 and AppName=@AppName)
	begin

		insert into API_Applications(AppName,ApiKey,ApiSecret,GlobalToken,Status,RegDate)
		values(@AppName,NEWID(),NEWID(),NEWID(),1,GETDATE())

	end
	select * from API_Applications where Id=SCOPE_IDENTITY()
end

GO
/****** Object:  StoredProcedure [dbo].[Insert_API_UserToken]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Insert_API_UserToken]
(
	@EnableLongTermStorage bit,
	@ShortTermStorageMinutes int,
	@LongTermStorageMinutes int,
	@UserGuid uniqueidentifier
)
as
begin
	declare @Now datetime = getdate()

	declare @token uniqueidentifier = NEWID()
	declare @ExpirationDate datetime

	if(@EnableLongTermStorage=1)
		set @ExpirationDate = dateadd(minute, @LongTermStorageMinutes, @Now)
	else
		set @ExpirationDate = dateadd(minute, @ShortTermStorageMinutes, @Now)

	
	--daha evvel expire olmuş veya üstüste birden fazla kez login çağrılmasına karşı kontrol
	--Kullanıcı birden fazla kez farklı yerlerden login olabilir. Bu engellenmemeli. --can
	delete API_Application_Tokens where UserGuid = @UserGuid and ExpirationDate<@Now
	

	insert into API_Application_Tokens(Token,ExpirationDate,ApplicationId,UserGuid,EnableLongTermStorage)
	values (@token, @ExpirationDate,1,@UserGuid,@EnableLongTermStorage)

	select @token as Token
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_LogManagement_Log]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Insert_LogManagement_Log] (
	@ProjectId int,
	@LogLevel int,
	@CodeTypeId int,
	@UserId int,
	@AdminId int,
	@Url nvarchar(500),
	@HttpReferrer nvarchar(500),
	@UserAgent nvarchar(500) = null,
	@Detail nvarchar(4000),
	@Request nvarchar(4000),
	@Response nvarchar(4000),
	@Description nvarchar(max),
	@IpAddress nvarchar(50),
	@Etiquette nvarchar(max),
	@Count int,
	@LogDate datetime)
AS
SET NOCOUNT ON 
BEGIN
	  
	  declare @LogId int
	  select @LogId=Id from LogManagement_Logs where CodeTypeId = 2 and Description = @Description
	  
	  if @LogId is null	
		begin			
			Insert Into LogManagement_Logs (
				ProjectId,
				LogLevel,
				CodeTypeId,
				UserId,
				AdminId,
				Url,
				HttpReferrer,
				UserAgent,
				Detail,
				Request,
				Response,
				Description,
				IpAddress,
				Etiquette,
				[Count],
				LogDate)
			Values (
				@ProjectId,
				@LogLevel,
				@CodeTypeId,
				@UserId,
				@AdminId,
				@Url,
				@HttpReferrer,
				@UserAgent,
				@Detail,
				@Request,
				@Response,
				@Description,
				@IpAddress,
				@Etiquette,
				@Count,
				@LogDate 
			)
		end
	else
		begin
			Update LogManagement_Logs set
				[Count] = [Count] + @Count
			where  Id = @LogId
		end
END



GO
/****** Object:  StoredProcedure [dbo].[Insert_Role]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Role] (
	@RoleName nvarchar(250),
	@RegDate datetime,
	@Message nvarchar(4000) output,
	@MessageType int output
)

AS
SET NOCOUNT ON 
BEGIN

	If Not Exists(Select Id From Roles Where RoleName = @RoleName and Status = 1)
		Begin

			Insert Into Roles(
				RoleName,
				[Status],
				RegDate
			)
			Values(
				@RoleName,
				1,
				@RegDate
			)
						
			set @Message = 'dbmRoleInsertSuccessful';
			set @MessageType = 1

		End
					
	Else
		Begin

			set @Message = 'dbmRoleInsertUnSuccessful';
			set @MessageType = 0;

		End
		
END


GO
/****** Object:  StoredProcedure [dbo].[Insert_RoleAuthentication]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_RoleAuthentication](
	@RoleId int,
	@MenuIds nvarchar(4000),
	@RegDate datetime,
	@Message nvarchar(4000) output,
	@MessageType int output
)
AS
SET NOCOUNT ON 
BEGIN
		
	Delete From RoleAuthentications 
	Where RoleAuthentications.RoleId = @RoleId
	And AdminSubMenuId NOT IN (select value from split(@MenuIds,','))

	Insert Into RoleAuthentications(AdminSubMenuId,RoleId,Status,RegDate)
	Select  Id as AdminSubMenuId, @RoleId AS RoleId, 1 as [Status], @RegDate as RegDate
	From AdminSubMenus 
	Where Id IN ( select value from split(@MenuIds,',')) 
	AND Id NOT IN (select AdminSubMenuId from RoleAuthentications WHERE RoleId=@RoleId)

	set @Message = 'dbmRoleAuthenticationInsertSuccessful';
	set @MessageType = 1;
		
END




GO
/****** Object:  StoredProcedure [dbo].[InsertUpdate_AdvertManagement_Category]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <4.8.2016>
-- Description:	<Procedure to insert a category >
-- =============================================
CREATE PROCEDURE [dbo].[InsertUpdate_AdvertManagement_Category] 
	-- Add the parameters for the stored procedure here
	@CategoryName as nvarchar(50),
	@ParentId as int,
	@DeterminerId as int
		
AS
BEGIN
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	Insert into AdvertManagement_Categories(CategoryName,ParentId,DeterminerId)
	values(@CategoryName, @ParentId,@DeterminerId)

	Update AdvertManagement_Categories
	Set HasSubCategory=1 where Id=@ParentId 	
	
END



GO
/****** Object:  StoredProcedure [dbo].[Update_Admin]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_Admin](
	@AdminId int,
	@UserName nvarchar(50),
	@Password nvarchar(50),
	@Name nvarchar(50),
	@Surname nvarchar(50),
	@Email nvarchar(50),
	@RoleId int,
	@DefaultLanguageId int,
	@MiniSitesBitwiseSum as int,
	@RegDate datetime,
	@Message nvarchar(4000) output,
	@MessageType int output
)
AS
SET NOCOUNT ON 
BEGIN

	If Not Exists(Select Id From Admins Where UserName = @UserName and [Status] = 1 and Id <> @AdminId)
		Begin

			Update Admins Set 
				UserName = @UserName,
				[Password] = @Password,
				[Name] = @Name,
				Surname = @Surname,
				Email = @Email,
				RoleId = @RoleId,
				DefaultLanguageId = @DefaultLanguageId,
				MiniSitesBitwiseSum = @MiniSitesBitwiseSum,
				[Status] = 1
			Where Id = @AdminId
						
			set @Message = 'dbmAdminEditSuccessful';
			set @MessageType = 1

		END
	ELSE
		BEGIN
			set @Message = 'dbmAdminEditUnSuccessful';
			set @MessageType = 0;
		END

END




GO
/****** Object:  StoredProcedure [dbo].[Update_AdvertManagement_AdvertCount]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <5.8.2016>
-- Description:	<Procedure to get breadcrumb of the category with given Id>
-- =============================================

CREATE PROCEDURE [dbo].[Update_AdvertManagement_AdvertCount] 
	-- Add the parameters for the stored procedure here
	@categoryId int
AS
BEGIN
;WITH cte
AS (SELECT child.Id, child.AdvertCount, child.ParentId        
    FROM AdvertManagement_Categories AS child  
    WHERE child.Id= @categoryId 
    UNION ALL  
    SELECT child.Id, child.AdvertCount, child.ParentId        
    FROM AdvertManagement_Categories AS child  
    JOIN cte AS cteItem ON child.Id = cteItem.ParentId  
    )  
Update AdvertManagement_Categories set AdvertManagement_Categories.AdvertCount=AdvertManagement_Categories.AdvertCount+1 where Id in (select Id from cte)
END
 


GO
/****** Object:  StoredProcedure [dbo].[Update_AdvertManagement_CategoryByDeterminerId]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Mehmet Dogan>
-- Create date: <4.8.2016>
-- Description:	<Procedure to insert a category >
-- =============================================
CREATE PROCEDURE [dbo].[Update_AdvertManagement_CategoryByDeterminerId] 
	-- Add the parameters for the stored procedure here
	@CategoryId as int,
	@DeterminerId as int
		
AS
BEGIN
	SET NOCOUNT ON;

	Update AdvertManagement_Categories
	Set DeterminerId=@DeterminerId where Id=@CategoryId 	
	
END



GO
/****** Object:  StoredProcedure [dbo].[Update_Role]    Script Date: 10.8.2016 12:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_Role](
	@RoleId int,
	@RoleName nvarchar(250),
	@Message nvarchar(4000) output,
	@MessageType int output
)

AS
SET NOCOUNT ON 
BEGIN

	If Not Exists(Select Id From Roles Where RoleName = @RoleName and Id <> @RoleId and [Status] = 1)
		Begin

			Update Roles Set 
				RoleName = @RoleName 
			Where Id = @RoleId
					
			set @Message = 'dbmRoleUpdateSuccessful';
			set @MessageType = 1;

		End
	Else
		Begin

			set @Message = 'dbmRoleUpdateUnSuccessful';
			set @MessageType = 0;

		End

END




GO
USE [master]
GO
ALTER DATABASE [PixAdvert] SET  READ_WRITE 
GO
