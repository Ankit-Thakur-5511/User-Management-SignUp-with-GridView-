<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="result.aspx.cs" Inherits="WebForm1.result" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Result Page</title>
    <link href="StyleSheet1.css" rel="stylesheet" />
    <style>
        #HyperLink1 {
            padding-top: 8px;
            margin-right: 30px;
            color: rgb(0,140,255);
            text-decoration: none;
            font-weight: 550;
        }

            #HyperLink1:hover {
                color: rgb(24 79 125);
            }

        .spn {
            display: flex;
            flex-direction: row;
            padding-top: 10px;
            justify-content: space-between;
            align-items: baseline;
        }

        #codiv {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            height: 130px;
            width: 300px;
            border: 2px solid #333;
            border-radius: 5px;
            background-color: #e1e1e1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 10px;
        }

        #message {
            padding: 17px;
            border-bottom: 2px solid #333;
            width: 100%;
            text-align: center;
            font-weight: 550;
        }

        .login-btn {
            padding: 5px;
            border-radius: 5px;
            color: black;
            font-size: 14px;
            font-weight: 550;
            border: 2px solid;
        }

            .login-btn:hover {
               color: rgb(0, 140, 255);
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="codiv" runat="server">
          <p id="message" runat="server" style="font-weight: bold; color: green;"></p>
            <span class="spn">
                <asp:HyperLink href="signupform.aspx" ID="HyperLink1" runat="server">Back to Sign Up</asp:HyperLink>
                <asp:Button ID="Button1" runat="server" Text="Log In" OnClick="Button_login" CssClass="login-btn" />
            </span>
        </div>
    </form>
</body>
</html>
