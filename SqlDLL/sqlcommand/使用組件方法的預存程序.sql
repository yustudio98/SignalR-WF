CREATE PROCEDURE SendToHubProcedure
@message nvarchar(10)
AS
EXTERNAL NAME [SqlDLL].[SqlDLL.SignalRclient].SendToHub