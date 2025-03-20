using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace WebForm1
{
    public partial class result : System.Web.UI.Page
    {
        protected HtmlGenericControl message;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("signupform.aspx");
            }
            else
            {
                if (Session["RegistrationMessage"] != null)
                {
                    message.InnerText = Session["RegistrationMessage"].ToString();

                    if (Session["RegistrationMessage"].ToString() == "Successfully registered.")
                    {
                        message.Style["color"] = "green";
                    }
                    else if (Session["RegistrationMessage"].ToString() == "Already registered.")
                    {
                        message.Style["color"] = "red";
                    }

                    Session["RegistrationMessage"] = null;
                }
                else
                {
                    message.InnerText = "Welcome, " + Session["Username"].ToString() + "!";
                    message.Style["color"] = "black";
                }
            }
        }

        protected void Button_login(object sender, EventArgs e)
        {
            Response.Redirect("loginform.aspx");
        }
    }
}
