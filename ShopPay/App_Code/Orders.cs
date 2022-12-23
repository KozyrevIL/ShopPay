using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using Microsoft.Ajax.Utilities;

namespace ShopPay.App_Code
{
    public class Orders
    {
        private string customer = string.Empty;
        public int idOrder = -1;
        public string status = string.Empty;
        public DateTime dateOrder = DateTime.Now;
        public float Cost=-1;


        public Orders(string customer) // Просто создаем объект
        {
            this.customer = customer;
        }
        public Orders(int idOrder) // читаем заказ по id
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();
                try
                {
                    // Создаем новый заказ
                    SqlCommand cmd = new SqlCommand("select * from Docs_Orders where id_order=@id", con);
                    cmd.CommandType = CommandType.Text;
                    cmd.Transaction = transaction;
                    cmd.Parameters.AddWithValue("id", idOrder);
                    SqlDataReader sdr = cmd.ExecuteReader();
                    if (sdr.Read())
                    {
                        this.idOrder = idOrder;
                        dateOrder = (DateTime)sdr["date_order"];
                        customer = sdr["customer"].ToString();
                        status = sdr["status"].ToString();

                        if (!float.TryParse(sdr["AllCost"].ToString(), out Cost)) Cost = -1f;
                    }
                    sdr.Close();
                }
                catch
                {
                }
                finally
                {
                    con.Close();
                }
            }

        }
        private bool CheckData()
        {
            if (Cost <= 0) return false;
            if (customer == String.Empty) return false;
            return true;
        }

        public Orders(string customer, int qtyTime, float Cost, bool fromCart = true) // Создаем объект одновременно с созданием 
        {

            bool result = true;
            this.customer = customer;
            this.Cost = Cost;
            if (!CheckData()) return;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();
                try
                {
                    // Создаем новый заказ
                    SqlCommand cmd = new SqlCommand("insert into Docs_Orders (status,date_order,customer,allCost) values (@status,GETDATE(),@customer,@allCost)", con);
                    cmd.CommandType = CommandType.Text;
                    cmd.Transaction = transaction;
                    cmd.Parameters.AddWithValue("status", "Сформирован");
                    cmd.Parameters.AddWithValue("customer", customer);
                    cmd.Parameters.AddWithValue("allCost", Cost);
                    cmd.ExecuteNonQuery();
                    // Запоминаем ID заказа
                    this.idOrder = int.Parse(new SqlCommand("select @@IDENTITY",con,transaction).ExecuteScalar()?.ToString() ?? "0");
                    if (fromCart) // Если в заказ надо перенести из корзины
                    {
                        cmd.CommandText = "insert into Docs_OrderItems (id_order,id_doc,qty_time) select @id_order, id_doc, qty_time from Docs_Cart where customer=@customer";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("id_order", idOrder);
                        cmd.Parameters.AddWithValue("customer", customer);
                        cmd.ExecuteNonQuery();
                        // Чистим корзину
                        cmd.CommandText = "delete from Docs_Cart where customer=@customer";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("customer", customer);
                        cmd.ExecuteNonQuery();
                    }
                    transaction.Commit();
                }
                catch 
                {
                    transaction.Rollback();
                    result = false;
                }
                finally
                {
                    con.Close();
                }
            }
            if (!result) idOrder = -1;
        }
        private bool AddDocsToOrderFromCart(SqlConnection con)
        {
            try
            {
                // Из корзины переносим в Заказ

            }
            catch
            {
                return false;
            }
            return true;
        }

    }
    
}