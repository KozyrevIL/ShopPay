using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using ShopPay.Models;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;


public class CustomerInfo
{

    public string FIO = string.Empty;
    public string phone = string.Empty;
    public string Info = string.Empty;
    public CustomerInfo()
    {

    }
    public CustomerInfo(string customer)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
        {
            con.Open();
            try
            {

                SqlCommand cmd = new SqlCommand(@"select customer, FIO, phone, info from Docs_customers where customer=@customer", con);
                cmd.Parameters.AddWithValue("customer", customer);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    FIO = dr["FIO"].ToString();
                    phone = dr["phone"].ToString();
                    Info = dr["info"].ToString();
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

    }
    public void UpdateCustomerInfo(string customer)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
        {
            con.Open();
            try
            {

                SqlCommand cmd = new SqlCommand(@"If Not Exists(select * from Docs_customers where customer=@customer)
Begin
insert into Docs_Customers (customer, FIO, phone, info) values (@customer, @FIO, @phone, @info)
End
Else
Begin
update Docs_customers set FIO=@FIO, phone=@phone, info=@info where customer=@customer
End", con);
                cmd.Parameters.AddWithValue("customer", customer);
                cmd.Parameters.AddWithValue("FIO", FIO);
                cmd.Parameters.AddWithValue("phone", phone);
                cmd.Parameters.AddWithValue("info", Info);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    FIO = dr["FIO"].ToString();
                    phone = dr["phone"].ToString();
                    Info = dr["info"].ToString();
                }
                dr.Close();
            }
            finally
            {
                con.Close();
            }
        }

    }


}

public class ClassCustomer
{

    public string customer;
    public IList<string> roles;
    public CustomerInfo customerInfo;

    public string appealTo { get { return getAppeal(); } }
    public ClassCustomer()
    {
        customerInfo = new CustomerInfo();
    }
    public ClassCustomer(string _customer, HttpContext _context)
    {
        customer = _customer;
        var manager = _context.GetOwinContext().GetUserManager<ShopPay.ApplicationUserManager>();
        try
        {
            roles = manager.GetRoles(manager.FindByName(customer).Id);
        }
        catch { }
        customerInfo = new CustomerInfo(customer);
    }
    private string getAppeal()
    {
        if (customerInfo.FIO == string.Empty) return customer;
        return customerInfo.FIO;
    }
    public bool ExistsRole(string roleName)
    { 
        if (roles!=null)
            if (roles.Contains(roleName)) return true;
        return false;
    }


}
