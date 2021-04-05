USE SignalRtry
ALTER DATABASE SignalRtry SET trustworthy ON

exec sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
 
exec sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO
 
exec sp_configure 'show advanced options', 0;
GO
RECONFIGURE;
GO

CREATE ASSEMBLY SqlDLL from
  'C:\Windows\Microsoft.NET\Framework\v4.0.30319\SqlDLL.dll'
WITH PERMISSION_SET = UNSAFE 