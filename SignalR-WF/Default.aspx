<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SignalR_WF._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div class="row" style="margin-top: 20px;">
        <div class="col-md">
            <%--<input id="btnid" type="button" value="我是按鈕">--%>
            <%--<input type="text" id="txb" />--%>

            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>&nbsp;
    
            <ul id="menu">
            </ul>
        </div>

    </div>



    <script src="Scripts/jquery-3.4.1.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.signalR-2.4.1.js" type="text/javascript"></script>
    <%--很重要的參考，一定要加這一行，這之前一定要先參考jQuery.js與signalR.js--%>
    <script src='<%= ResolveClientUrl("~/signalr/hubs") %>'></script>

    <script type="text/javascript">

        signalRChat = $.connection.signalRChat;

        if (signalRChat) { //判斷是否有建立成功
            registerClientMethods(signalRChat);

            $.connection.hub.start().done(function () {
                //signalRChat.server.userConnected(groupId, userId);  //向後端註冊 Clinet端（前端）使用者的 function
            });

        }
        //*** 向後端的Hub，註冊 Clinet端（前端）的 function
        function registerClientMethods(chatHub) {
            // 定義client端的javascript function，供server端hub，透過dynamic的方式，呼叫所有Clients的javascript function
            chatHub.client.alertMessage = function (message) {
                //當server端調用addMessage時，將server push的message資料，alert出來
                $("#menu").append('<li>' + message + '</li>');
                $("#MainContent_TextBox1").val(message);
            };

            //$("#btnid").click(function () {
            //    signalRChat.server.sendAllMessage($("#txb").val());
            //});


        }



    //**********************************************(end)

    //$.connection.hub.disconnected(function () {
    //        setTimeout(function () {
    //            $.connection.hub.start().done(function () {
    //                signalRChat.server.userConnected(groupId, userId);  //斷線後重新註冊
    //             });
    //        }, 5 * 1000); // Restart connection after 5 seconds.

    //    });

    </script>

</asp:Content>
