using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace SignalR_WF
{
    public class signalRChat : Hub
    {
        //發送訊息給所有人
        public void sendAllMessage(string message)
        {
            Clients.All.alertMessage(message); //alertMessage 為client端 function名稱
        }


        //當使用者斷線時呼叫
        public override Task OnDisconnected(bool stopCalled)
        {
            //當使用者離開時，移除在清單內的 ConnectionId
            Clients.All.removeList(Context.ConnectionId);
            //UserHandler.ConnectedIds.Remove(Context.ConnectionId);
            return base.OnDisconnected(stopCalled);
        }
    }
}