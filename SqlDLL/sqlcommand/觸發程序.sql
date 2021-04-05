USE SignalRtry
GO
CREATE TRIGGER notice_Changed ON notice     -- 建立 Trigger，觸發程序名稱 notice_Changed 作用在資料表 notice
AFTER INSERT                        
AS
     DECLARE @message nvarchar(10);
	
	 SELECT @message=message FROM inserted;
exec dbo.SendToHubProcedure @message
GO