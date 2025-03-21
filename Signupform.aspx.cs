using System;
using System.Data;
using System.Web;
using System.Web.UI;
using MySql.Data.MySqlClient;
using System.Text.RegularExpressions;
using System.Net;
using System.Net.Mail;
using System.IO;

namespace WebForm1
{
    public partial class Signupform : System.Web.UI.Page
    {
        protected void Button1_Click(object sender, EventArgs e)
        {
            // Clear previous errors
            pUsernameError.InnerText = string.Empty;
            pEmailError.InnerText = string.Empty;
            pNumberError.InnerText = string.Empty;
            pPasswordError.InnerText = string.Empty;
            pConfirmPasswordError.InnerText = string.Empty;
            error.Text = string.Empty;
            error.Visible = false;

            bool isError = false;

            // Validate fields
            if (string.IsNullOrWhiteSpace(Username.Text) ||
                string.IsNullOrWhiteSpace(Email.Text) ||
                string.IsNullOrWhiteSpace(Number.Text) ||
                string.IsNullOrWhiteSpace(Password.Text) ||
                string.IsNullOrWhiteSpace(Confirm.Text))
            {
                error.Text = "Please fill in all fields!";
                error.Visible = true;
                isError = true;
            }
            else
            {
                if (string.IsNullOrWhiteSpace(Username.Text))
                {
                    pUsernameError.InnerText = "Username cannot be empty!";
                    isError = true;
                }
                if (string.IsNullOrWhiteSpace(Email.Text) || !IsValidEmail(Email.Text))
                {
                    pEmailError.InnerText = "Invalid email address!";
                    isError = true;
                }
                if (string.IsNullOrWhiteSpace(Number.Text) || !IsNumeric(Number.Text))
                {
                    pNumberError.InnerText = "Mobile Number must contain only numbers!";
                    isError = true;
                }
                if (string.IsNullOrWhiteSpace(Password.Text) || !IsValidPassword(Password.Text))
                {
                    pPasswordError.InnerText = "At least 1 uppercase, 1 number, and 1 special character!";
                    isError = true;
                }
                if (Password.Text != Confirm.Text)
                {
                    pConfirmPasswordError.InnerText = "Passwords do not match!";
                    isError = true;
                }
            }

            if (isError) return;

            // Database connection
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySQLConnection"].ConnectionString;
            string username = Username.Text.Trim();
            string email = Email.Text.Trim();
            string number = Number.Text.Trim();
            string password = Password.Text.Trim();

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string checkUserQuery = "SELECT COUNT(*) FROM info WHERE Email=@Email";
                using (MySqlCommand checkCmd = new MySqlCommand(checkUserQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@Email", email);
                    int userExists = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (userExists > 0)
                    {
                        Session["RegistrationMessage"] = "Already registered.";
                        Response.Redirect("result.aspx", false);
                        Context.ApplicationInstance.CompleteRequest();
                        return;
                    }
                }

                // Insert user with unconfirmed status
                string insertQuery = "INSERT INTO info (Username, Email, Phn_Number, Password) VALUES (@Username, @Email, @Number, @Password)";
                using (MySqlCommand insertCmd = new MySqlCommand(insertQuery, conn))
                {
                    insertCmd.Parameters.AddWithValue("@Username", username);
                    insertCmd.Parameters.AddWithValue("@Email", email);
                    insertCmd.Parameters.AddWithValue("@Number", number);
                    insertCmd.Parameters.AddWithValue("@Password", password);
                    insertCmd.ExecuteNonQuery();
                }
            }

            // Send confirmation email
            SendConfirmationEmail(email, username, number, password, attachments);

            Session["Username"] = username;
            Session["RegistrationMessage"] = "Successfully registered.";
            Response.Redirect("result.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        string[] attachments = new string[]
        {
            @"C:\Users\HP\OneDrive\Documents\Doc1.pdf",
            @"C:\Users\HP\Downloads\IMG_20230128_113001.jpg"
        };
        private void SendConfirmationEmail(string recipientEmail, string username, string number, string password, string[] attachmentPaths)
        {
            try
            {
                string senderEmail = "your-email@gmail.com";
                string senderPassword = "your-password";
                string smtpServer = "smtp.gmail.com";
                int smtpPort = 587;

                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress(senderEmail, "Ankit");
                    mail.To.Add(recipientEmail);
                    mail.Subject = "Confirm Your Registration";
                    mail.IsBodyHtml = true;

                    
                    string tableHtml = @"
                <table style='border-collapse: collapse; width: 100%; font-family: Arial, sans-serif;' border='1'>
                    <tr style='background-color: #f2f2f2;'>
                        <th style='padding: 8px; text-align: left; border: 1px solid #ddd;'>Your Name</th>
                        <th style='padding: 8px; text-align: left; border: 1px solid #ddd;'>Phone Number</th>
                        <th style='padding: 8px; text-align: left; border: 1px solid #ddd;'>Password</th>
                    </tr>
                    <tr>
                        <td style='padding: 8px; border: 1px solid #ddd;'>" + username + @"</td>
                        <td style='padding: 8px; border: 1px solid #ddd;'>" + number + @"</td>
                        <td style='padding: 8px; border: 1px solid #ddd;'>" + password + @"</td>                   
                    </tr>
                </table>";

                   
                    mail.Body = $@"
                <h2>Hello {username},</h2>
                <p>Thank you for Signing Up💖</p>
                <p>We're excited to have you with us.</p>
                {tableHtml}"; 

                    
                    if (attachmentPaths != null && attachmentPaths.Length > 0)
                    {
                        foreach (string filePath in attachmentPaths)
                        {
                            if (!string.IsNullOrEmpty(filePath) && File.Exists(filePath))
                            {
                                mail.Attachments.Add(new Attachment(filePath));
                            }
                        }
                    }

                    // SMTP setup
                    using (SmtpClient smtp = new SmtpClient(smtpServer, smtpPort))
                    {
                        smtp.Credentials = new NetworkCredential(senderEmail, senderPassword);
                        smtp.EnableSsl = true;
                        smtp.Send(mail);
                    }
                }
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("Error sending email: " + ex.Message);
            }
        }

        private bool IsValidEmail(string email) => new Regex(@"^[^@\s]+@[^@\s]+\.[^@\s]+$").IsMatch(email);
        private bool IsNumeric(string input) => long.TryParse(input, out _);
        private bool IsValidPassword(string password) =>
            new Regex(@"^(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$").IsMatch(password);
    }
}
