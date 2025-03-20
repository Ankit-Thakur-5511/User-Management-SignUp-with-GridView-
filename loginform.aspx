<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="loginform.aspx.cs" Inherits="WebForm1.loginform" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Log In</title>
       <link href="StyleSheet1.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <script type="text/javascript">
        function togglePassword(inputId, iconId) {
            var passwordField = document.getElementById(inputId);
            var icon = document.getElementById(iconId);

            if (passwordField.type === "password") {
                passwordField.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                passwordField.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }
    </script>

</head>
<body>
   <h2 class="heading2">LOG IN</h2>
   <div class="cnt">
    <form id="login" runat="server">
        <asp:Label ID="error2" runat="server" CssClass="error-msg"></asp:Label>
        <div class="inp-div">
            <asp:Label ID="Username2" runat="server" Text="E-Mail:"></asp:Label>
            <asp:TextBox ID="email" runat="server" CssClass="input" placeholder="Your Email"></asp:TextBox>
            <p class="er" runat="server" id="emailerror"></p>
        </div>
            <div class="inp-div">
                <asp:Label ID="Passoword2" runat="server" Text="Password:"></asp:Label>
                <div class="password-container">
                    <asp:TextBox ID="password" runat="server" CssClass="input" placeholder="Your Password"></asp:TextBox>
                    <i class="fa-solid fa-eye toggle-icon" id="togglePassword" onclick="togglePassword('<%= password.ClientID %>', 'togglePassword')"></i>
                </div>
              <p class="er" runat="server" id="p1"></p>
            </div>
              <div class="btn-div">
                <asp:Button ID="Button1" CssClass="button" runat="server" Text="Log In" OnClick="Button2_Click" />
                <asp:HyperLink ID="HyperLink1" runat="server" CssClass="login" NavigateUrl="Signupform.aspx">Sign Up</asp:HyperLink>

            </div>
    </form>
</div>
</body>
</html>
