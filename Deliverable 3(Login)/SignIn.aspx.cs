using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;



namespace LibraryProjectComplete
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["MyCon"].ToString());
                string id = TextBox1.Text;
                string pass = TextBox2.Text;
                con.Open();
                string query = "select StudentInfo.Name from StudentInfo where id=" + id + "and where Password=" +pass ;
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader sdr = cmd.ExecuteReader();

                if (sdr.Read())
                {
                    Label1.Text = "Login Successful";
                    Response.Redirect("Books.aspx");
                }
                else
                {
                    Label1.Text = "Incorrect Credentials";
                }
                con.Close();
            }
            catch(Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}