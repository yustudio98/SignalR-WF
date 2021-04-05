using Microsoft.AspNet.SignalR.Client;
using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace SqlDLL
{
    public class SignalRclient
    {
        internal static HubConnection hubConnection = null;
        internal static IHubProxy hubProxy = null;
        internal static string severURL = "http://localhost:52093/";
        internal static string hubName = "signalRChat";
        internal static string hubMethod = "sendAllMessage";

        [SqlFunction()]
        public static void SendToHub(string message)
        {
            try
            {
                if (hubConnection == null || isConnectionClosed())
                {
                    SqlContext.Pipe.Send("開始建立連線");
                    hubConnection = new HubConnection(severURL)
                    { Credentials = CredentialCache.DefaultNetworkCredentials };
                    SqlContext.Pipe.Send("已建立連線");
                }
                if (hubProxy == null || isConnectionClosed())
                {
                    SqlContext.Pipe.Send("開始建立Proxy");
                    hubProxy = hubConnection.CreateHubProxy(hubName);
                    SqlContext.Pipe.Send("已建立Proxy");
                }
                if (isConnectionClosed())
                {
                    SqlContext.Pipe.Send("開始建立溝通");
                    hubConnection.Start().Wait();
                    SqlContext.Pipe.Send("已建立溝通");
                }

                hubProxy.Invoke(hubMethod, message).Wait();
            }
            catch (Exception exc)
            {
                SqlContext.Pipe.Send(string.Format("{0}.{1} error: '{2}'{3}",
                    hubName.Trim(), hubMethod.Trim(), exc, Environment.NewLine));
            }
        }

        private static bool isConnectionClosed()
        {
            return !(hubConnection.State == ConnectionState.Connected
                || hubConnection.State == ConnectionState.Reconnecting
                || hubConnection.State == ConnectionState.Connecting);
        }
    }
}
