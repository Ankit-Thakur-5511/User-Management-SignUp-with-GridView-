<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="WebForm1.WebForm3" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard</title>
    <link href="StyleSheet1.css" rel="stylesheet" />
    <link href="StyleSheet2.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="dash-div max-wid">
            <h2>DASHBOARD</h2>
            <asp:Button ID="Button1" Text="Log Out" CssClass="button" runat="server" OnClick="Button1_Click" />
        </div>

        <div class="border max-wid">
            <div class="btn-div">
                <asp:Button ID="Button2" runat="server" Text="Add User" CssClass="btn" OnClick="Button2_Click" />
            </div>

            <div class="data">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    EmptyDataText="No data found." AllowPaging="True" PageSize="5" OnPageIndexChanging="GridView1_PageIndexChanging"
                    CellPadding="4" ForeColor="#333333" GridLines="None"
                    OnRowEditing="GridView1_RowEditing" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowUpdating="GridView1_RowUpdating" OnRowDeleting="GridView1_RowDeleting"
                    DataKeyNames="ID" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">

                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" />

                        <asp:TemplateField HeaderText="Username">
                            <ItemTemplate>
                                <asp:Label ID="lblUsername" runat="server" Text='<%# Eval("Username") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtUsername" runat="server" Text='<%# Eval("Username") %>' CssClass="form-control" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEmail" runat="server" Text='<%# Eval("Email") %>' CssClass="form-control" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Phone Number">
                            <ItemTemplate>
                                <asp:Label ID="lblNumber" runat="server" Text='<%# Eval("Phn_Number") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNumber" runat="server" Text='<%# Eval("Phn_Number") %>' CssClass="form-control" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Password">
                            <ItemTemplate>
                                <asp:Label ID="lblPassword" runat="server" Text='<%# Eval("Password") %>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPassword" runat="server" Text='<%# Eval("Password") %>' CssClass="form-control" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ButtonType="Button" DeleteText="Delete">
                        <ControlStyle BackColor="#D8D8D8" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Size="13.5px" ForeColor="Black" />
                        </asp:CommandField>
                    </Columns>

                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
