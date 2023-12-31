USE [master]
GO
/****** Object:  Database [BTL_LTTQ]    Script Date: 11/9/2023 7:30:35 AM ******/
--CREATE DATABASE [BTL_LTTQ]
-- CONTAINMENT = NONE
-- ON  PRIMARY 
--( NAME = N'BTL_LTTQ', FILENAME = N'D:\SQL_server\MSSQL16.SQLEXPRESS03\MSSQL\DATA\BTL_LTTQ.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
-- LOG ON 
--( NAME = N'BTL_LTTQ_log', FILENAME = N'D:\SQL_server\MSSQL16.SQLEXPRESS03\MSSQL\DATA\BTL_LTTQ_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
-- WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BTL_LTTQ] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BTL_LTTQ].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BTL_LTTQ] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET ARITHABORT OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BTL_LTTQ] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BTL_LTTQ] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BTL_LTTQ] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BTL_LTTQ] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BTL_LTTQ] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BTL_LTTQ] SET  MULTI_USER 
GO
ALTER DATABASE [BTL_LTTQ] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BTL_LTTQ] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BTL_LTTQ] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BTL_LTTQ] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BTL_LTTQ] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BTL_LTTQ] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BTL_LTTQ] SET QUERY_STORE = ON
GO
ALTER DATABASE [BTL_LTTQ] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BTL_LTTQ]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 11/9/2023 7:30:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[Bill_ID] [int] IDENTITY(1,1) NOT NULL,
	[CreateTime] [datetime] NULL,
	[SubTotal] [float] NULL,
	[Status] [nvarchar](50) NULL,
	[PaymentMethod] [nvarchar](50) NULL,
	[StaffName] [nvarchar](50) NULL,
	[Cart_ID] [int] NOT NULL,
	[TotalDiscountAmount] [float] NULL,
	[TotalAmount] [float] NULL,
	[TotalItem] [int] NULL,
 CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED 
(
	[Bill_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 11/9/2023 7:30:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[Cart_ID] [int] IDENTITY(1,1) NOT NULL,
	[TotalItem] [int] NULL,
	[Customer_ID] [int] NOT NULL,
	[SelectedItem_ID] [int] NOT NULL,
	[TotalDiscountAmount] [float] NULL,
	[TotalAmount] [float] NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[Cart_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 11/9/2023 7:30:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Customer_ID] [int] NOT NULL,
	[BirthDate] [datetime] NULL,
	[Address] [nvarchar](50) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
	[CustomerType] [nvarchar](50) NULL,
	[Point] [int] NULL,
	[CreateTime] [datetime] NULL,
	[Email] [nvarchar](50) NULL,
	[FullName] [nvarchar](50) NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discount]    Script Date: 11/9/2023 7:30:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discount](
	[Discount_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[DiscountType] [nvarchar](50) NULL,
	[DiscountPercent] [int] NULL,
	[DiscountPriceAmount] [int] NULL,
	[MinPriceToUseDiscount] [int] NULL,
 CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED 
(
	[Discount_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 11/9/2023 7:30:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[Inventory_id] [int] IDENTITY(1,1) NOT NULL,
	[Item_ID] [int] NULL,
	[Inven_number] [int] NULL,
	[Inven_sold_revenue] [decimal](18, 2) NULL,
	[Inven_sold_quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Inventory_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 11/9/2023 7:30:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[Item_ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](50) NULL,
	[ItemType] [nvarchar](50) NULL,
	[Quantity] [int] NULL,
	[Brand] [nvarchar](50) NULL,
	[ReleaseDate] [datetime] NULL,
	[Price] [int] NULL,
	[Discount_ID] [int] NOT NULL,
	[Image] [nvarchar](100) NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[Item_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SelectedItem]    Script Date: 11/9/2023 7:30:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SelectedItem](
	[SelectedItem_ID] [int] IDENTITY(1,1) NOT NULL,
	[NumberOfSelectedItem] [int] NULL,
	[PriceAfterDiscount] [decimal](10, 2) NULL,
	[Item_ID] [int] NOT NULL,
	[TotalAmount] [decimal](10, 2) NULL,
 CONSTRAINT [PK_SelectedItem] PRIMARY KEY CLUSTERED 
(
	[SelectedItem_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (44, CAST(N'2023-10-23T09:13:42.000' AS DateTime), 61700, N'Đã thanh toán', N'Thanh toán tiền mặt', N'Nguyễn Văn Hải', 84, 6300, 61700, 5)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (45, CAST(N'2023-10-23T09:15:24.000' AS DateTime), 129400, N'Đã thanh toán', N'Thanh toán chuyển khoản', N'Vũ Nguyễn Trường Giang', 85, 22600, 129400, 9)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (46, CAST(N'2023-10-23T09:16:34.000' AS DateTime), 49080, N'Đã thanh toán', N'Thanh toán quẹt thẻ', N'Nguyễn Tiến Toàn', 86, 15920, 49080, 7)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (47, CAST(N'2023-10-23T09:18:41.000' AS DateTime), 25500, N'Đã thanh toán', N'Thanh toán quẹt thẻ', N'Trịnh Viết hân', 87, 3500, 25500, 2)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (48, CAST(N'2023-10-23T09:19:24.000' AS DateTime), 15500, N'Đã thanh toán', N'Thanh toán tiền mặt', N'Trịnh Viết hân', 88, 3500, 15500, 2)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (49, CAST(N'2023-10-23T09:21:55.000' AS DateTime), 24500, N'Đã thanh toán', N'Thanh toán chuyển khoản', N'Vũ Nguyễn Trường Giang', 89, 10500, 24500, 3)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (50, CAST(N'2023-10-23T09:22:51.000' AS DateTime), 46000, N'Đã thanh toán', N'Thanh toán chuyển khoản', N'Nguyễn Tiến Toàn', 90, 14000, 46000, 8)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (51, CAST(N'2023-10-23T22:08:29.000' AS DateTime), 57200, N'Đã thanh toán', N'Thanh toán quẹt thẻ', N'Vũ Nguyễn Trường Giang', 91, 8800, 57200, 4)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (52, CAST(N'2023-10-23T22:18:03.000' AS DateTime), 31500, N'Đã thanh toán', N'Thanh toán tiền mặt', N'Nguyễn Tiến Toàn', 92, 4500, 31500, 3)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (53, CAST(N'2023-10-23T22:18:29.000' AS DateTime), 63000, N'Đã thanh toán', N'Thanh toán tiền mặt', N'Trịnh Viết hân', 93, 9000, 63000, 6)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (54, CAST(N'2023-10-23T22:19:19.000' AS DateTime), 37200, N'Đã thanh toán', N'Thanh toán quẹt thẻ', N'Vũ Nguyễn Trường Giang', 94, 12800, 37200, 4)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (55, CAST(N'2023-10-25T21:16:15.000' AS DateTime), 52500, N'Đang chờ thanh toán', N'Thanh toán quẹt thẻ', N'Vũ Nguyễn Trường Giang', 95, 13500, 52500, 6)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (56, CAST(N'2023-10-25T21:20:49.000' AS DateTime), 10000, N'Mua hàng trả sau', N'Thanh toán tiền mặt', N'Nguyễn Tiến Toàn', 96, 0, 10000, 1)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (57, CAST(N'2023-10-26T16:12:28.000' AS DateTime), 10000, N'Đã thanh toán', N'Thanh toán chuyển khoản', N'Nguyễn Văn Hải', 97, 0, 10000, 1)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (58, CAST(N'2023-10-27T21:24:16.000' AS DateTime), 55000, N'Đã thanh toán', N'Thanh toán chuyển khoản', N'Nguyễn Văn Hải', 98, 9000, 55000, 6)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (59, CAST(N'2023-11-01T07:25:43.000' AS DateTime), 123500, N'Mua hàng trả sau', N'Thanh toán tiền mặt', N'Nguyễn Tiến Toàn', 99, 6500, 123500, 9)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (60, CAST(N'2023-11-02T13:45:50.000' AS DateTime), 13500, N'Đã thanh toán', N'Thanh toán chuyển khoản', N'Vũ Nguyễn Trường Giang', 100, 31500, 13500, 9)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (61, CAST(N'2023-11-02T14:55:16.000' AS DateTime), 152620, N'Đã thanh toán', N'Thanh toán chuyển khoản', N'Nguyễn Tiến Toàn', 101, 26380, 152620, 19)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (62, CAST(N'2023-11-03T16:23:51.000' AS DateTime), 263000, N'Đã thanh toán', N'Thanh toán tiền mặt', N'Nguyễn Văn Hải', 102, 37000, 263000, 18)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (63, CAST(N'2023-11-08T21:18:20.000' AS DateTime), 46000, N' Đã thanh toán', N'Thanh toán tiền mặt', N'Nguyễn Tiến Toàn', 109, 17000, 46000, 8)
INSERT [dbo].[Bill] ([Bill_ID], [CreateTime], [SubTotal], [Status], [PaymentMethod], [StaffName], [Cart_ID], [TotalDiscountAmount], [TotalAmount], [TotalItem]) VALUES (64, CAST(N'2023-11-08T21:32:44.000' AS DateTime), 57000, N' Đã thanh toán', N'Thanh toán chuyển khoản', N'Trịnh Viết hân', 110, 9000, 57000, 5)
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (83, 1, 12345678, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (84, 1, 12345678, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (85, 1, 12345678, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (86, 1, 23201485, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (87, 1, 23456789, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (88, 1, 27203003, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (89, 1, 34567890, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (90, 1, 45678901, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (91, 1, 90123456, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (92, 1, 45678902, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (93, 1, 56789012, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (94, 1, 78901234, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (95, 1, 78901234, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (96, 1, 90123456, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (97, 1, 34567890, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (98, 1, 89012345, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (99, 1, 89012345, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (100, 1, 12345678, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (101, 1, 27203003, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (102, 1, 45678902, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (103, 1, 43215678, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (104, 1, 43215678, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (105, 1, 43215678, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (106, 1, 43215678, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (107, 1, 43215678, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (108, 1, 43215678, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (109, 1, 43215678, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (110, 1, 43215678, 33, 0, 80000)
INSERT [dbo].[Cart] ([Cart_ID], [TotalItem], [Customer_ID], [SelectedItem_ID], [TotalDiscountAmount], [TotalAmount]) VALUES (111, 1, 43215678, 33, 0, 80000)
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (12345678, CAST(N'1994-08-19T00:00:00.000' AS DateTime), N'Đà Nẵng', N'0956789123', N'Khách mua lẻ', 80, CAST(N'2022-08-14T00:00:00.000' AS DateTime), N'linh012345678900@gmail.com', N'Phạm Thị Linh', N'LinhBiuti', N'123456')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (23201485, CAST(N'1984-07-11T00:00:00.000' AS DateTime), N'TP HCM', N'0995412241', N'Khách mua lẻ', 50, CAST(N'2022-11-05T00:00:00.000' AS DateTime), N'bich023201485621@gmail.com', N'Trần Thị Bích', N'BichSanh', N'123456')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (23456789, CAST(N'1982-12-31T00:00:00.000' AS DateTime), N'TP HCM', N'0887654321', N'Khách mua buôn', 125, CAST(N'2022-07-10T00:00:00.000' AS DateTime), N'nam023456789012@gmail.com', N'Nguyễn Văn Nam', N'Nam12345', N'123456')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (27203003, CAST(N'1999-05-20T00:00:00.000' AS DateTime), N'Hà Nội', N'0354857894', N'Khách mua buôn', 100, CAST(N'2022-10-25T00:00:00.000' AS DateTime), N'hai027203003102@gmail.com', N'Nguyễn Văn Hải', N'Hai12345', N'123456')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (31072003, CAST(N'2003-07-31T00:00:00.000' AS DateTime), N'Hà Nội', N'956789123', N'Khách mua lẻ', 0, CAST(N'2022-11-05T00:00:00.000' AS DateTime), N'admin', N'admin', N'admin', N'admin')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (34567890, CAST(N'1990-07-06T00:00:00.000' AS DateTime), N'Hà Nội', N'0967890123', N'Khách mua lẻ', 70, CAST(N'2022-12-05T00:00:00.000' AS DateTime), N'hien034567890123@gmail.com', N'Nguyễn Thị Hiền', N'Hien1234', N'123456')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (43215678, CAST(N'2023-09-01T13:17:48.000' AS DateTime), N'Ha Noi', N'0123456688', N'Khách mua lẻ', 0, CAST(N'2023-10-26T13:19:26.000' AS DateTime), N'toan@gmail.com', N'Nguyen Tien Toan', N'toan', N'123456')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (45678901, CAST(N'1993-11-08T00:00:00.000' AS DateTime), N'Đà Nẵng', N'0956781234', N'Khách mua lẻ', 60, CAST(N'2022-07-22T00:00:00.000' AS DateTime), N'thanh045678901234@gmail.com', N'Lê Thanh', N'Thanh123', N'123456')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (45678902, CAST(N'1986-05-28T00:00:00.000' AS DateTime), N'Nha Trang', N'0856789012', N'Khách mua buôn', 115, CAST(N'2022-11-19T00:00:00.000' AS DateTime), N'tuan045678901234@gmail.com', N'Phan Văn Tuấn', N'Tuan1234', N'123456')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (56789012, CAST(N'1980-09-17T00:00:00.000' AS DateTime), N'Hà Nội', N'0865432109', N'Khách mua buôn', 85, CAST(N'2022-12-15T00:00:00.000' AS DateTime), N'hoang056789012345@gmail.com', N'Phạm Văn Hoàng', N'Hoang123', N'123456')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (67890123, CAST(N'1995-03-25T00:00:00.000' AS DateTime), N'TP HCM', N'0978901234', N'Khách mua lẻ', 70, CAST(N'2022-06-30T00:00:00.000' AS DateTime), N'my067890123456@gmail.com', N'Nguyễn Thị Mỹ', N'My123456', N'123456')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (78901234, CAST(N'1987-02-14T00:00:00.000' AS DateTime), N'Đà Lạt', N'0823456789', N'Khách mua buôn', 110, CAST(N'2022-11-28T00:00:00.000' AS DateTime), N'thien078901234567@gmail.com', N'Nguyễn Văn Thiện', N'Thien123', N'123456')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (89012345, CAST(N'1991-06-10T00:00:00.000' AS DateTime), N'Hà Nội', N'0987651234', N'Khách mua lẻ', 55, CAST(N'2022-10-01T00:00:00.000' AS DateTime), N'phuong089012345678@gmail.com', N'Nguyễn Thị Phương', N'Phuong12', N'123456')
INSERT [dbo].[Customer] ([Customer_ID], [BirthDate], [Address], [PhoneNumber], [CustomerType], [Point], [CreateTime], [Email], [FullName], [Username], [Password]) VALUES (90123456, CAST(N'1983-04-12T00:00:00.000' AS DateTime), N'Hải Phòng', N'0934567890', N'Khách mua buôn', 100, CAST(N'2022-09-18T00:00:00.000' AS DateTime), N'trung090123456789@gmail.com', N'Vũ Trọng Trung', N'Trung123', N'123456')
GO
SET IDENTITY_INSERT [dbo].[Discount] ON 

INSERT [dbo].[Discount] ([Discount_ID], [Name], [StartTime], [EndTime], [DiscountType], [DiscountPercent], [DiscountPriceAmount], [MinPriceToUseDiscount]) VALUES (1, N'Back to School', CAST(N'2023-09-01T00:00:00.000' AS DateTime), CAST(N'2023-09-30T00:00:00.000' AS DateTime), N'Không áp dụng', 5, 5000, 15000)
INSERT [dbo].[Discount] ([Discount_ID], [Name], [StartTime], [EndTime], [DiscountType], [DiscountPercent], [DiscountPriceAmount], [MinPriceToUseDiscount]) VALUES (2, N'Black Friday', CAST(N'2023-11-25T00:00:00.000' AS DateTime), CAST(N'2023-11-27T00:00:00.000' AS DateTime), N'Giảm giá trực tiếp', 6, 3500, 10000)
INSERT [dbo].[Discount] ([Discount_ID], [Name], [StartTime], [EndTime], [DiscountType], [DiscountPercent], [DiscountPriceAmount], [MinPriceToUseDiscount]) VALUES (3, N'Tet Holiday', CAST(N'2024-01-20T00:00:00.000' AS DateTime), CAST(N'2024-01-25T00:00:00.000' AS DateTime), N'Khuyến mãi theo % giá bán', 8, 3700, 10000)
INSERT [dbo].[Discount] ([Discount_ID], [Name], [StartTime], [EndTime], [DiscountType], [DiscountPercent], [DiscountPriceAmount], [MinPriceToUseDiscount]) VALUES (4, N'Summer Sale', CAST(N'2023-06-15T00:00:00.000' AS DateTime), CAST(N'2023-07-15T00:00:00.000' AS DateTime), N'Giảm giá trực tiếp', 5, 5500, 18000)
INSERT [dbo].[Discount] ([Discount_ID], [Name], [StartTime], [EndTime], [DiscountType], [DiscountPercent], [DiscountPriceAmount], [MinPriceToUseDiscount]) VALUES (5, N'Christmas Special', CAST(N'2023-12-10T00:00:00.000' AS DateTime), CAST(N'2023-12-25T00:00:00.000' AS DateTime), N'Khuyến mãi theo % giá bán', 5, 2500, 25000)
INSERT [dbo].[Discount] ([Discount_ID], [Name], [StartTime], [EndTime], [DiscountType], [DiscountPercent], [DiscountPriceAmount], [MinPriceToUseDiscount]) VALUES (6, N'Teachers Day', CAST(N'2023-11-15T00:00:00.000' AS DateTime), CAST(N'2023-11-25T00:00:00.000' AS DateTime), N'Giảm giá trực tiếp', 4, 4500, 20000)
SET IDENTITY_INSERT [dbo].[Discount] OFF
GO
SET IDENTITY_INSERT [dbo].[Inventory] ON 

INSERT [dbo].[Inventory] ([Inventory_id], [Item_ID], [Inven_number], [Inven_sold_revenue], [Inven_sold_quantity]) VALUES (1, 1, 10, CAST(80000.00 AS Decimal(18, 2)), 1)
INSERT [dbo].[Inventory] ([Inventory_id], [Item_ID], [Inven_number], [Inven_sold_revenue], [Inven_sold_quantity]) VALUES (2, 22, 76, CAST(230000.00 AS Decimal(18, 2)), 23)
INSERT [dbo].[Inventory] ([Inventory_id], [Item_ID], [Inven_number], [Inven_sold_revenue], [Inven_sold_quantity]) VALUES (3, 23, 68, CAST(132000.00 AS Decimal(18, 2)), 11)
INSERT [dbo].[Inventory] ([Inventory_id], [Item_ID], [Inven_number], [Inven_sold_revenue], [Inven_sold_quantity]) VALUES (4, 24, 27, CAST(154000.00 AS Decimal(18, 2)), 11)
INSERT [dbo].[Inventory] ([Inventory_id], [Item_ID], [Inven_number], [Inven_sold_revenue], [Inven_sold_quantity]) VALUES (5, 25, 20, CAST(210000.00 AS Decimal(18, 2)), 15)
INSERT [dbo].[Inventory] ([Inventory_id], [Item_ID], [Inven_number], [Inven_sold_revenue], [Inven_sold_quantity]) VALUES (6, 26, 99, CAST(85000.00 AS Decimal(18, 2)), 17)
INSERT [dbo].[Inventory] ([Inventory_id], [Item_ID], [Inven_number], [Inven_sold_revenue], [Inven_sold_quantity]) VALUES (7, 27, 60, CAST(195000.00 AS Decimal(18, 2)), 13)
INSERT [dbo].[Inventory] ([Inventory_id], [Item_ID], [Inven_number], [Inven_sold_revenue], [Inven_sold_quantity]) VALUES (8, 28, 70, CAST(360000.00 AS Decimal(18, 2)), 20)
INSERT [dbo].[Inventory] ([Inventory_id], [Item_ID], [Inven_number], [Inven_sold_revenue], [Inven_sold_quantity]) VALUES (9, 29, 30, CAST(50000.00 AS Decimal(18, 2)), 10)
INSERT [dbo].[Inventory] ([Inventory_id], [Item_ID], [Inven_number], [Inven_sold_revenue], [Inven_sold_quantity]) VALUES (10, 30, 36, CAST(54000.00 AS Decimal(18, 2)), 9)
INSERT [dbo].[Inventory] ([Inventory_id], [Item_ID], [Inven_number], [Inven_sold_revenue], [Inven_sold_quantity]) VALUES (11, 31, 50, CAST(35000.00 AS Decimal(18, 2)), 5)
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO
SET IDENTITY_INSERT [dbo].[Item] ON 

INSERT [dbo].[Item] ([Item_ID], [ItemName], [ItemType], [Quantity], [Brand], [ReleaseDate], [Price], [Discount_ID], [Image]) VALUES (1, N'Birth Cake', N'Đồ ăn', 10, N'ByCake', CAST(N'2023-06-05T00:00:00.000' AS DateTime), 80000, 1, N'cake1.jpg')
INSERT [dbo].[Item] ([Item_ID], [ItemName], [ItemType], [Quantity], [Brand], [ReleaseDate], [Price], [Discount_ID], [Image]) VALUES (22, N'Snack Swing', N'Đồ ăn', 76, N'Oishi', CAST(N'2023-06-15T00:00:00.000' AS DateTime), 10000, 1, N'SnackSwing.jpg')
INSERT [dbo].[Item] ([Item_ID], [ItemName], [ItemType], [Quantity], [Brand], [ReleaseDate], [Price], [Discount_ID], [Image]) VALUES (23, N'Cocacola', N'Đồ uống', 68, N'Coca', CAST(N'2023-07-10T00:00:00.000' AS DateTime), 12000, 6, N'Cocacola.jpg')
INSERT [dbo].[Item] ([Item_ID], [ItemName], [ItemType], [Quantity], [Brand], [ReleaseDate], [Price], [Discount_ID], [Image]) VALUES (24, N'Bột canh', N'Gia vị', 30, N'Quảng Tĩnh', CAST(N'2023-09-11T00:00:00.000' AS DateTime), 14000, 1, N'BotCanh.jpg')
INSERT [dbo].[Item] ([Item_ID], [ItemName], [ItemType], [Quantity], [Brand], [ReleaseDate], [Price], [Discount_ID], [Image]) VALUES (25, N'Mì chính', N'Gia vị', 20, N'Quảng Tĩnh', CAST(N'2023-09-11T00:00:00.000' AS DateTime), 14000, 3, N'MiChinh.jpg')
INSERT [dbo].[Item] ([Item_ID], [ItemName], [ItemType], [Quantity], [Brand], [ReleaseDate], [Price], [Discount_ID], [Image]) VALUES (26, N'Mì tôm', N'Đồ ăn', 99, N'Brinks', CAST(N'2023-10-16T00:00:00.000' AS DateTime), 5000, 2, N'MiTom.jpg')
INSERT [dbo].[Item] ([Item_ID], [ItemName], [ItemType], [Quantity], [Brand], [ReleaseDate], [Price], [Discount_ID], [Image]) VALUES (27, N'Socala thanh', N'Đồ ăn', 60, N'Hershey''s', CAST(N'2023-08-20T00:00:00.000' AS DateTime), 15000, 2, N'Socola.jpg')
INSERT [dbo].[Item] ([Item_ID], [ItemName], [ItemType], [Quantity], [Brand], [ReleaseDate], [Price], [Discount_ID], [Image]) VALUES (28, N'Green Tea', N'Đồ uống', 70, N'Teavana', CAST(N'2023-07-25T00:00:00.000' AS DateTime), 18000, 5, N'TraXanh.jpg')
INSERT [dbo].[Item] ([Item_ID], [ItemName], [ItemType], [Quantity], [Brand], [ReleaseDate], [Price], [Discount_ID], [Image]) VALUES (29, N'Muối', N'Gia vị', 30, N'Văn Hải', CAST(N'2023-09-05T00:00:00.000' AS DateTime), 5000, 3, N'Muoi.jpg')
INSERT [dbo].[Item] ([Item_ID], [ItemName], [ItemType], [Quantity], [Brand], [ReleaseDate], [Price], [Discount_ID], [Image]) VALUES (30, N'Tiêu đen', N'Gia vị', 36, N'Văn Hải', CAST(N'2023-10-10T00:00:00.000' AS DateTime), 6000, 6, N'TieuDen.jpg')
INSERT [dbo].[Item] ([Item_ID], [ItemName], [ItemType], [Quantity], [Brand], [ReleaseDate], [Price], [Discount_ID], [Image]) VALUES (31, N'Chanh muối', N'Đồ ăn', 50, N'Phương Nam', CAST(N'2023-07-05T00:00:00.000' AS DateTime), 7000, 4, N'ChanhMuoi.jpg')
SET IDENTITY_INSERT [dbo].[Item] OFF
GO
SET IDENTITY_INSERT [dbo].[SelectedItem] ON 

INSERT [dbo].[SelectedItem] ([SelectedItem_ID], [NumberOfSelectedItem], [PriceAfterDiscount], [Item_ID], [TotalAmount]) VALUES (33, 0, CAST(80000.00 AS Decimal(10, 2)), 1, CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[SelectedItem] ([SelectedItem_ID], [NumberOfSelectedItem], [PriceAfterDiscount], [Item_ID], [TotalAmount]) VALUES (203, 1, CAST(80000.00 AS Decimal(10, 2)), 1, CAST(80000.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[SelectedItem] OFF
GO
ALTER TABLE [dbo].[Item] ADD  DEFAULT ('') FOR [Image]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Cart] FOREIGN KEY([Cart_ID])
REFERENCES [dbo].[Cart] ([Cart_ID])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Cart]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Customer] FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customer] ([Customer_ID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Customer]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_SelectedItem] FOREIGN KEY([SelectedItem_ID])
REFERENCES [dbo].[SelectedItem] ([SelectedItem_ID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_SelectedItem]
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD FOREIGN KEY([Item_ID])
REFERENCES [dbo].[Item] ([Item_ID])
GO
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_Discount] FOREIGN KEY([Discount_ID])
REFERENCES [dbo].[Discount] ([Discount_ID])
GO
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_Discount]
GO
ALTER TABLE [dbo].[SelectedItem]  WITH CHECK ADD  CONSTRAINT [FK_SelectedItem_Item] FOREIGN KEY([Item_ID])
REFERENCES [dbo].[Item] ([Item_ID])
GO
ALTER TABLE [dbo].[SelectedItem] CHECK CONSTRAINT [FK_SelectedItem_Item]
GO
/****** Object:  StoredProcedure [dbo].[UpdateItemInventory]    Script Date: 11/9/2023 7:30:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- tạo procedure tính hàng tồn
CREATE   PROCEDURE [dbo].[UpdateItemInventory]
AS
BEGIN
    -- Cập nhật số lượng tồn cho từng mặt hàng trong bảng [Item]
    UPDATE it
    SET it.Quantity = it.Quantity - ISNULL((
        SELECT SUM(sel.NumberOfSelectedItem)
        FROM [dbo].[SelectedItem] as sel
        WHERE sel.Item_ID = it.Item_ID
    ), 0)
    FROM [dbo].[Item] AS it;

	-- update inventory
	UPDATE inven
	SET inven.Inven_number = it.Quantity
	FROM [dbo].[Inventory] inven
		JOIN [dbo].[Item] AS it ON it.Item_ID = inven.Item_ID

		-- update Inven_sold_quantity
	UPDATE inven
	SET inven.Inven_sold_quantity = inven.Inven_sold_quantity + ISNULL((
        SELECT SUM(sel.NumberOfSelectedItem)
        FROM [dbo].[SelectedItem] as sel
        WHERE sel.Item_ID = it.Item_ID
    ), 0)
	FROM [dbo].[Inventory] inven
		JOIN [dbo].[Item] AS it ON it.Item_ID = inven.Item_ID	

	-- update Inven_sold_revenue
	UPDATE inven
	SET inven.Inven_sold_revenue = isnull((inven.Inven_sold_quantity * it.Price), 0)
	FROM [dbo].[Inventory] inven
		JOIN [dbo].[Item] AS it ON it.Item_ID = inven.Item_ID
	WHERE it.Item_ID = inven.Item_ID
END;
GO
USE [master]
GO
ALTER DATABASE [BTL_LTTQ] SET  READ_WRITE 
GO
