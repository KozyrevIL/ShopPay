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
        private int qtyTime;
        private string customer;
        public int idOrder = -1;


        public Orders(string customer) // Просто создаем объект
        {
            this.customer = customer;
        }
        public Orders(int idOrder) // читаем заказ по id
        {

        }
        public Orders(string customer, int qtyTime, bool fromCart = true) // Создаем объект одновременно с созданием 
        {

            bool result = true;
            this.qtyTime = qtyTime;
            this.customer = customer;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();
                try
                {
                    // Создаем новый заказ
                    SqlCommand cmd = new SqlCommand("insert into Docs_Orders (status,date_order,customer) values (@status,GETDATE(),@customer)", con);
                    cmd.CommandType = CommandType.Text;
                    cmd.Transaction = transaction;
                    cmd.Parameters.AddWithValue("status", "Сформирован");
                    cmd.Parameters.AddWithValue("customer", customer);
                    cmd.ExecuteNonQuery();
                    // Запоминаем ID заказа
                    this.idOrder = int.Parse(new SqlCommand("select @@IDENTITY",con,transaction).ExecuteScalar()?.ToString() ?? "0");
                    if (fromCart) // Если в заказ надо перенести из корзины
                    {
                        cmd.CommandText = "insert into Docs_OrderItems (id_order,id_doc,qty_time) select @id_order, id_doc, qty_time from Docs_Cart where customer=@customer";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("id_order", idOrder);
                        cmd.Parameters.AddWithValue("qtyTime", qtyTime);
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