USE SignalRtry
GO
CREATE TRIGGER notice_Changed ON notice     -- �إ� Trigger�AĲ�o�{�ǦW�� notice_Changed �@�Φb��ƪ� notice
AFTER INSERT                        
AS
     DECLARE @message nvarchar(10);
	
	 SELECT @message=message FROM inserted;
exec dbo.SendToHubProcedure @message
GO