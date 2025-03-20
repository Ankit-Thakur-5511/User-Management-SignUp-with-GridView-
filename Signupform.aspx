<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signupform.aspx.cs" Inherits="WebForm1.Signupform" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
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
    <h2 class="heading">REGISTRATION FORM</h2>
    <div class="cnt">
        <form id="signup" runat="server" method="post" class="signup">
        <asp:Label ID="error" runat="server" CssClass="error-msg"></asp:Label>           
            <div class="inp-div">
                <asp:Label ID="Label1" runat="server" Text="Enter Name:" CssClass="label" for="TextBox1"></asp:Label>
                <asp:TextBox ID="Username" runat="server" CssClass="input" placeholder="Your Name" aria-labelledby="Label1"></asp:TextBox>
                <p class="er" runat="server" id="pUsernameError"></p>
            </div>

            <div class="inp-div">
                <asp:Label ID="Label2" runat="server" Text="E-Mail:" CssClass="label" for="Email"></asp:Label>
                <asp:TextBox ID="Email" runat="server" CssClass="input" placeholder="Your Email" aria-labelledby="Label2"></asp:TextBox>
                <p class="er" runat="server" id="pEmailError"></p>
            </div>
            <div class="inp-div">
                <asp:Label ID="Label3" runat="server" Text="Mobile Number:" CssClass="label"></asp:Label>
                <asp:TextBox ID="Number" runat="server" CssClass="input" placeholder="Your Number"></asp:TextBox>
                <p class="er" runat="server" id="pNumberError"></p>
            </div>
            <div class="inp-div">
                <asp:Label ID="Label4" runat="server" Text="Password:" CssClass="label"></asp:Label>
                <div class="password-container">
                    <asp:TextBox ID="Password" runat="server" CssClass="input" placeholder="Enter Password"></asp:TextBox>
                    <i class="fa-solid fa-eye toggle-icon" id="togglePassword" onclick="togglePassword('<%= Password.ClientID %>', 'togglePassword')"></i>
                </div>
                <p class="er" runat="server" id="pPasswordError"></p>
            </div>

            <div class="inp-div">
                <asp:Label ID="Label5" runat="server" Text="Confirm Password:" CssClass="label"></asp:Label>
                <div class="password-container">
                    <asp:TextBox ID="Confirm" runat="server" CssClass="input" placeholder="Confirm Password"></asp:TextBox>
                    <i class="fa-solid fa-eye toggle-icon" id="toggleConfirm" onclick="togglePassword('<%= Confirm.ClientID %>', 'toggleConfirm')"></i>
                </div>
                <p class="er" runat="server" id="pConfirmPasswordError"></p>
            </div>            <div class="btn-div">
                <asp:Button ID="Button1" CssClass="button" runat="server" Text="Sign Up" OnClick="Button1_Click" />
                <asp:HyperLink ID="Login" runat="server" CssClass="login" NavigateUrl="Loginform.aspx">Log In </asp:HyperLink>
            </div>
        </form>
    </div>
</body>
</html>
