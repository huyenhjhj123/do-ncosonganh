--Đặt tên Database là  QuanLyQuanCafe
 
/****** Object:  Table [dbo].[Account]    Script Date: 6/17/2022 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[DisplayName] [nvarchar](100) NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[PassWord1] [nvarchar](1000) NOT NULL,
	[Type1] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 6/17/2022 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NULL,
	[idTable] [int] NOT NULL,
	[status1] [int] NOT NULL,
	[discount] [int] NULL,
	[totalPrice] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillInfo]    Script Date: 6/17/2022 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idBill] [int] NOT NULL,
	[idFood] [int] NOT NULL,
	[count1] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Food]    Script Date: 6/17/2022 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Food](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name1] [nvarchar](100) NOT NULL,
	[idCategory] [int] NOT NULL,
	[price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FoodCategory]    Script Date: 6/17/2022 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FoodCategory](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name1] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableFood]    Script Date: 6/17/2022 2:21:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableFood](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[status1] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([DisplayName], [UserName], [PassWord1], [Type1]) VALUES (N'Bùi Chi Thiện', N'ChiThien', N'0', 1)
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (48, CAST(N'2022-05-22' AS Date), CAST(N'2022-05-22' AS Date), 36385, 1, 30, 141400)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (49, CAST(N'2022-05-22' AS Date), CAST(N'2022-05-22' AS Date), 36395, 1, 20, 184000)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (50, CAST(N'2022-05-22' AS Date), CAST(N'2022-05-22' AS Date), 36399, 1, 20, 56000)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (51, CAST(N'2022-05-23' AS Date), CAST(N'2022-05-23' AS Date), 36390, 1, 20, 28800)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (52, CAST(N'2022-05-27' AS Date), CAST(N'2022-05-27' AS Date), 36391, 1, 0, 551000)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (53, CAST(N'2022-05-27' AS Date), CAST(N'2022-05-27' AS Date), 36395, 1, 0, 0)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (54, CAST(N'2022-05-27' AS Date), NULL, 36395, 0, 0, 0)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (55, CAST(N'2022-05-27' AS Date), NULL, 36391, 0, 0, 0)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (56, CAST(N'2022-05-29' AS Date), CAST(N'2022-05-30' AS Date), 36385, 1, 0, 95000)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (57, CAST(N'2022-05-29' AS Date), CAST(N'2022-05-29' AS Date), 36399, 1, 0, 190000)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (58, CAST(N'2022-05-29' AS Date), CAST(N'2022-05-30' AS Date), 36386, 1, 0, 84000)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (59, CAST(N'2022-05-29' AS Date), NULL, 36387, 0, 0, 0)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (60, CAST(N'2022-05-29' AS Date), NULL, 36404, 0, 0, 0)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (61, CAST(N'2022-05-29' AS Date), CAST(N'2022-05-30' AS Date), 36394, 1, 0, 122000)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (62, CAST(N'2022-05-31' AS Date), CAST(N'2022-05-31' AS Date), 36385, 1, 0, 95000)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (63, CAST(N'2022-05-31' AS Date), CAST(N'2022-06-17' AS Date), 36386, 1, 0, 95000)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (64, CAST(N'2022-06-01' AS Date), CAST(N'2022-06-17' AS Date), 36393, 1, 0, 95000)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (65, CAST(N'2022-06-07' AS Date), CAST(N'2022-06-07' AS Date), 36398, 1, 0, 95000)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (66, CAST(N'2022-06-17' AS Date), CAST(N'2022-06-17' AS Date), 36392, 1, 0, 15000)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (67, CAST(N'2022-06-17' AS Date), NULL, 36399, 0, 0, 0)
GO
INSERT [dbo].[Bill] ([id], [DateCheckIn], [DateCheckOut], [idTable], [status1], [discount], [totalPrice]) VALUES (68, CAST(N'2022-06-17' AS Date), CAST(N'2022-06-17' AS Date), 36394, 1, 0, 232000)
GO
SET IDENTITY_INSERT [dbo].[Bill] OFF
GO
SET IDENTITY_INSERT [dbo].[BillInfo] ON 
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (46, 48, 3, 3)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (47, 48, 2, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (48, 49, 2, 2)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (49, 50, 5, 2)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (50, 51, 31, 2)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (51, 52, 3, 3)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (52, 52, 2, 2)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (57, 56, 1, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (58, 57, 1, 2)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (59, 58, 26, 2)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (60, 61, 6, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (61, 61, 1, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (62, 62, 1, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (63, 63, 1, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (64, 64, 1, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (65, 65, 1, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (66, 66, 17, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (67, 67, 4, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (68, 68, 5, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (69, 68, 7, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (70, 68, 9, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (71, 68, 11, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (72, 68, 32, 1)
GO
INSERT [dbo].[BillInfo] ([id], [idBill], [idFood], [count1]) VALUES (73, 68, 36, 1)
GO
SET IDENTITY_INSERT [dbo].[BillInfo] OFF
GO
SET IDENTITY_INSERT [dbo].[Food] ON 
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (1, N'Tôm chiên xù', 1, 95000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (2, N'Bánh xếp nhân thịt heo chiên giòn', 1, 115000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (3, N'Bánh KOROKKE nhân thịt bò', 1, 87000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (4, N'Mực hấp rim mắm tỏi', 1, 76000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (5, N'Salad hải sản chua cay', 1, 35000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (6, N'Mực chiên nước mắm', 2, 27000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (7, N'Thịt kho tiêu', 2, 35000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (8, N'Gà luộc', 2, 69000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (9, N'Vịt kho gừng', 2, 85000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (10, N'Cá hấp bia', 2, 65000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (11, N'Gà nấu nấm', 2, 45000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (12, N'Thịt đông', 2, 55000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (13, N'Gà xào sả ớt', 2, 66000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (14, N'Thịt rang cháy cạnh', 2, 45000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (15, N'Chả lá lốt', 2, 50000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (16, N'Ếch xào sả ớt', 2, 35000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (17, N'Thịt xông khói', 3, 15000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (18, N'Xúc xích', 3, 17000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (19, N'Shushi cá hồi', 3, 28000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (20, N'Chả bò', 3, 25000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (21, N'Gỏi cuốn', 3, 21000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (22, N'Bò úc xe với xoài xanh', 3, 29000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (23, N'Bún ốc nóng', 4, 55000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (24, N'Gà kho nấm', 4, 53000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (25, N'Cá bống kho tiêu', 4, 39000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (26, N'Sườn kho dưa chua', 4, 42000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (27, N'Thịt heo xào kim chi', 4, 35000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (28, N'Canh chân giò hầm măng', 4, 34000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (29, N'Chè vải hạt sen', 5, 15000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (30, N'Bánh chuối nướng', 5, 34500)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (31, N'Sương sáo nước cốt dừa', 5, 18000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (32, N'Chè khúc bạch', 5, 18500)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (33, N'Rau câu dừa', 5, 13000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (34, N'Kem chuối', 5, 14500)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (36, N'Cà phê sữa đá', 6, 13500)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (37, N'Cà phê trứng ', 6, 14000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (38, N'Trà mót Hội An', 6, 14500)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (39, N'Nước mía Mỹ Tho', 6, 14000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (40, N'Cà phê muối', 6, 23000)
GO
INSERT [dbo].[Food] ([id], [name1], [idCategory], [price]) VALUES (41, N'Gong Cha', 6, 45000)
GO
SET IDENTITY_INSERT [dbo].[Food] OFF
GO
SET IDENTITY_INSERT [dbo].[FoodCategory] ON 
GO
INSERT [dbo].[FoodCategory] ([id], [name1]) VALUES (1, N'Món khai vị')
GO
INSERT [dbo].[FoodCategory] ([id], [name1]) VALUES (2, N'Món chính')
GO
INSERT [dbo].[FoodCategory] ([id], [name1]) VALUES (3, N'Món nguội')
GO
INSERT [dbo].[FoodCategory] ([id], [name1]) VALUES (4, N'Món nóng')
GO
INSERT [dbo].[FoodCategory] ([id], [name1]) VALUES (5, N'Món tráng miệng')
GO
INSERT [dbo].[FoodCategory] ([id], [name1]) VALUES (6, N'Nước uống')
GO
SET IDENTITY_INSERT [dbo].[FoodCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[TableFood] ON 
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36385, N'Bàn 1', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36386, N'Bàn 2', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36387, N'Bàn 3', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36388, N'Bàn 4', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36389, N'Bàn 5', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36390, N'Bàn 6', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36391, N'Bàn 7', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36392, N'Bàn 8', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36393, N'Bàn 9', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36394, N'Bàn 10', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36395, N'Bàn 11', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36396, N'Bàn 12', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36397, N'Bàn 13', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36398, N'Bàn 14', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36399, N'Bàn 15', N'Có người')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36400, N'Bàn 16', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36401, N'Bàn 17', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36402, N'Bàn 18', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36403, N'Bàn 19', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36404, N'Bàn 20', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36405, N'Bàn 21', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36406, N'Bàn 22', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36407, N'Bàn 23', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36408, N'Bàn 24', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36409, N'Bàn 25', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36410, N'Bàn 26', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36411, N'Bàn 27', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36412, N'Bàn 28', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36413, N'Bàn 29', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36414, N'Bàn 30', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36415, N'Bàn 31', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36416, N'Bàn 32', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36417, N'Bàn 33', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36418, N'Bàn 34', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36419, N'Bàn 35', N'Trống')
GO
INSERT [dbo].[TableFood] ([id], [name], [status1]) VALUES (36420, N'Bàn 36', N'Trống')
GO
SET IDENTITY_INSERT [dbo].[TableFood] OFF
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT (N'Admin') FOR [DisplayName]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [PassWord1]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateCheckIn]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [status1]
GO
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [DF_Bill_discount]  DEFAULT ((0)) FOR [discount]
GO
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [DF_Bill_totalPrice]  DEFAULT ((0)) FOR [totalPrice]
GO
ALTER TABLE [dbo].[BillInfo] ADD  DEFAULT ((0)) FOR [count1]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT (N'Chưa đặt tên') FOR [name1]
GO
ALTER TABLE [dbo].[Food] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[FoodCategory] ADD  DEFAULT (N'chưa đặt tên') FOR [name1]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'chưa đặt tên') FOR [name]
GO
ALTER TABLE [dbo].[TableFood] ADD  DEFAULT (N'Trống') FOR [status1]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([idTable])
REFERENCES [dbo].[TableFood] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idBill])
REFERENCES [dbo].[Bill] ([id])
GO
ALTER TABLE [dbo].[BillInfo]  WITH CHECK ADD FOREIGN KEY([idFood])
REFERENCES [dbo].[Food] ([id])
GO
ALTER TABLE [dbo].[Food]  WITH CHECK ADD FOREIGN KEY([idCategory])
REFERENCES [dbo].[FoodCategory] ([id])
GO
