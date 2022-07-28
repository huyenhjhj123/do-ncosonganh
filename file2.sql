USE [QuanLyQuanCafe]
GO
/****** Object:  UserDefinedFunction [dbo].[fuConvertToUnsign1]    Script Date: 6/17/2022 2:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetAccountByUserName]    Script Date: 6/17/2022 2:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetAccountByUserName]
@userName nvarchar(100)
as
begin 
	select * from dbo.Account where UserName=@userName;
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetListBillByDate]    Script Date: 6/17/2022 2:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetListBillByDate]
@checkIn date, @checkOut date
as
begin 
	select t.name as [Tên bàn],b.totalPrice as [Tổng tiền], DateCheckIn as [Ngày vào], DateCheckOut as [Ngày ra], b.discount as [Giảm giá(%)]
	from dbo.Bill as b, dbo.TableFood as t
	where DateCheckIn >=@checkIn and DateCheckOut<=@checkOut and b.status1=1 and b.idTable=t.id
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetTableList]    Script Date: 6/17/2022 2:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetTableList]
As select * from dbo.TableFood
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 6/17/2022 2:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_InsertBill]
@idTable int
as
begin
	insert dbo.Bill (DateCheckIn, DateCheckOut, idTable, status1,discount)
	values (GETDATE(),NULL, @idTable,0,0)
end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillInfo]    Script Date: 6/17/2022 2:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_InsertBillInfo]
@idBill int, @idFood int, @count int
as
begin
	Declare @isExitsBillInfo int;
	declare @foodCount int =1;
	select @isExitsBillInfo =id, @foodCount=count1 from dbo.BillInfo where idBill = @idBill and idFood=@idFood
	if(@isExitsBillInfo > 0)
	begin 
		declare @newCount int = @foodCount + @count
		if(@newCount>0)
			update dbo.BillInfo set count1= @foodCount+@count where idFood=@idFood
		else
			delete dbo.BillInfo where idBill=@idBill and idFood=@idFood
	end 
	else 
	begin
		insert dbo.BillInfo (idBill,idFood,count1)
		values (@idBill,@idFood,@count)
	end
	
end
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 6/17/2022 2:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_Login]
@userName nvarchar(100), @passWord nvarchar(100)
as
begin 
	select * from dbo.Account where UserName=@userName and PassWord1=@passWord
end
GO
/****** Object:  StoredProcedure [dbo].[USP_SwitchTable]    Script Date: 6/17/2022 2:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_SwitchTable]
@idTable1 int, @idTable2 int
as begin
	declare @idFirstBill int
	declare @idSeconrdBill int
	declare @isFirstTableEmpty int = 1
	declare @isSecondTableEmpty int = 1
	select @idSeconrdBill=id from dbo.Bill where idTable=@idTable2 and status1=0
	select @idFirstBill=id from dbo.Bill where idTable=@idTable1 and status1=0
	if(@idFirstBill is null)
	begin
		insert dbo.Bill(DateCheckIn,DateCheckOut,idTable,status1)
		values (GETDATE(),null,@idTable1,0)
		select @idFirstBill =Max(id) from dbo.Bill where idTable =@idTable1 and status1=0
	end
	select @isFirstTableEmpty=count(*) from dbo.BillInfo where idBill=@idFirstBill
	if(@idSeconrdBill is null)
	begin
		insert dbo.Bill(DateCheckIn,DateCheckOut,idTable,status1)
		values (GETDATE(),null,@idTable2,0)
		select @idSeconrdBill =Max(id) from dbo.Bill where idTable =@idTable2 and status1=0
	end
	select @isSecondTableEmpty=count(*) from dbo.BillInfo where idBill=@idSeconrdBill
	select id into IDBillInfoTable from dbo.BillInfo where idBill=@idSeconrdBill
	update dbo.BillInfo set idBill=@idSeconrdBill where idBill=@idFirstBill
	update dbo.BillInfo set idBill=@idFirstBill where id in(select * from IDBillInfoTable)
	drop table IDBillInfoTable
	if(@isFirstTableEmpty=0)
		update dbo.TableFood set status1=N'Trống' where id=@idTable2
	if(@isSecondTableEmpty=0)
		update dbo.TableFood set status1=N'Trống' where id=@idTable1
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount]    Script Date: 6/17/2022 2:38:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_UpdateAccount]
@userName nvarchar(100), @displayName nvarchar(100), @password nvarchar(100), @newPassword nvarchar(100)
as
begin 
	declare @isRightPass int =0
	select @isRightPass =count(*) from dbo.Account where UserName=@userName and PassWord1 =@password
	if(@isRightPass =1)
	begin 
		if(@newPassword is null or @newPassword ='')
		begin
			Update dbo.Account set DisplayName = @displayName where UserName =@userName
		end
		else
			Update dbo.Account set DisplayName = @displayName, PassWord1=@newPassword where UserName =@userName
	end
end
GO

create trigger UTG_UpdateBillInfo
on dbo.BillInfo for insert, update
as
begin
	declare @idBill int
	select @idBill = idBill from inserted
	declare @idTable int
	select @idTable=idTable  from dbo.Bill where id=@idBill and status1 =0
	declare @count int
	select @count =count(*) from dbo.BillInfo where idBill=@idBill
	if(@count> 0)
		update dbo.TableFood set status1=N'Có người' where id=@idTable
	else 
		update dbo.TableFood set status1=N'Trống' where id=@idTable
end
go

create trigger UTG_UpdateBill
on dbo.Bill for update
as
begin
	declare @idBill int
	select @idBill=id from inserted
	declare @idTable int
	select @idTable = idTable from dbo.Bill where id=@idBill
	declare @count int =0
	select @count =count(*) from dbo.Bill where idTable=@idTable and status1=0
	if(@count =0)
		update dbo.TableFood set status1=N'Trống' where id=@idTable
end
go

create trigger UTG_DeleteBillInfo
on dbo.BillInfo for delete
as
begin
	declare @idBillInfo int
	declare @idBill int
	select @idBillInfo=id, @idBill=deleted.idBill from deleted
	declare @idTable int
	select @idTable=idTable from dbo.Bill where id=@idBill
	declare @count int=0
	select @count=count(*) from dbo.BillInfo as bi,dbo.Bill as b where b.id=bi.idBill and b.id=@idBill and b.status1=0
	if(@count=0) update dbo.TableFood set status1=N'Trống' where id =@idTable
end
go