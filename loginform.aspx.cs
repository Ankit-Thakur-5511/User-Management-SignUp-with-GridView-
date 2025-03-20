using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Text.RegularExpressions;

namespace WebForm1
{
    public partial class loginform : System.Web.UI.Page
    {
        protected void Button2_Click(object sender, EventArgs e)
        {
            // Clear previous error messages
            emailerror.InnerText = string.Empty;
            passworderror.InnerText = string.Empty;
            error2.Text = string.Empty;
            error2.Visible = false;

            // Get user inputs
            string emailInput = email.Text.Trim();
            string passwordInput = password.Text.Trim();

            // Validate input fields
            if (string.IsNullOrEmpty(emailInput) && string.IsNullOrEmpty(passwordInput))
            {
                error2.Text = "Please fill in all fields!";
                error2.Visible = true;
                return;
            }

            if (string.IsNullOrEmpty(emailInput))
            {
                emailerror.InnerText = "Email cannot be empty!";
                return;
            }

            if (string.IsNullOrEmpty(passwordInput))
            {
                passworderror.InnerText = "Password cannot be empty!";
                return;
            }

            // Database connection string
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnection"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();

                // Check if email exists in the database
                string checkEmailQuery = "SELECT Password FROM info WHERE Email=@Email";
                using (MySqlCommand cmd = new MySqlCommand(checkEmailQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", emailInput);
                    object result = cmd.ExecuteScalar();

                    if (result == null)
                    {
                        // Email does not exist in database
                        error2.Text = "Email not found! Please sign up first.";
                        error2.Visible = true;
                        return;
                    }

                    // Check if the password matches 
                    string storedPassword = result.ToString();
                    if (storedPassword != passwordInput)
                    {
                        passworderror.InnerText = "Incorrect password!";
                        return;
                    }
                }

                // Successful login
                Session["UserEmail"] = emailInput;
                Response.Redirect("dashboard.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                email.Text = "";
                password.Text = "";
            }
        }
    }
}
