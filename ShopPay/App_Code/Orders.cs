using Newtonsoft.Json.Linq;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net;
using System.Text;

namespace ShopPay.App_Code
{

    //Для интеграции по API используйте:
    //Логин: t7203486413-api
    //Пароль: YNI1WM5w

    //Для авторизации в личном кабинете используйте:
    //Логин: t7203486413-operator
    //Пароль: wAUb9LAz

    public class Orders
    {
        // test
        //private const string api_url = "https://3dsec.sberbank.ru";
        //private string login_do = "t7203486413-api";
        //private string password_do = "YNI1WM5w";

        //prom
        private const string api_url = "https://securepayments.sberbank.ru";
        private const string login_do = "p7203486413-api";
        private const string password_do = "PuTH2W7g";



        private string customer = string.Empty;
        public int idOrder = -1;
        public string status = string.Empty;
        public DateTime dateOrder = DateTime.Now;
        public float Cost = -1;
        public string orderInternalID = string.Empty;
        public string orderID = string.Empty;
        public string formURL = string.Empty;


        private string register_do = api_url + "/payment/rest/register.do";
        private string orderStatus_do = api_url + "/payment/rest/getOrderStatusExtended.do";

        //public string urlPay = "https://3dsec.sberbank.ru/payment/merchants/test/payment_ru.html?mdOrder=";



        public Orders() // Просто создаем объект
        {

        }
        public Orders(string customer) // создаем объект с указанием клиента
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
                        orderInternalID = sdr["orderInternalId"].ToString();
                        orderID = sdr["orderID"].ToString();
                        formURL = sdr["formUrl"].ToString();

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
                    this.idOrder = int.Parse(new SqlCommand("select @@IDENTITY", con, transaction).ExecuteScalar()?.ToString() ?? "0");
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
        public bool updateOrderInfo()
        {
            bool result = true;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                try
                {
                    SqlCommand cmdOrder = new SqlCommand("update Docs_Orders set  orderInternalId=@orderInternalId, orderID=@orderID, formUrl=@formURL, status=@status where id_order=@id_order", con);
                    cmdOrder.Parameters.AddWithValue("orderInternalId", orderInternalID);
                    cmdOrder.Parameters.AddWithValue("orderID", orderID);
                    cmdOrder.Parameters.AddWithValue("formURL", formURL);
                    cmdOrder.Parameters.AddWithValue("status", status);
                    cmdOrder.Parameters.AddWithValue("id_order", idOrder);
                    cmdOrder.ExecuteNonQuery();
                }
                catch
                {
                    result = false;
                }
                finally
                {
                    con.Close();
                }
            }
            return result;
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
        public bool PayOrder(int id_order)
        {
            bool result = true;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SQLConnectionString"].ToString()))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();
                try
                {
                    DataTable dt = new DataTable();
                    SqlDataAdapter sda = new SqlDataAdapter("select oi.id_item, oi.id_doc, dd.id_typeProduct, oi.qty_time, o.customer from Docs_OrderItems oi, Docs_Orders o, Docs_Docs dd where oi.id_order=@id_order and oi.id_order=o.id_order and oi.id_doc=dd.id_doc", con);
                    sda.SelectCommand.Parameters.AddWithValue("id_order", id_order);
                    sda.SelectCommand.Transaction = transaction;
                    sda.Fill(dt);

                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr["id_typeProduct"].ToString() == "1")
                        {
                            string id_item = dr["id_item"].ToString();
                            string id_doc = dr["id_doc"].ToString();
                            string customer = dr["customer"].ToString();
                            int qtyTime = int.Parse(dr["qty_time"].ToString());
                            SqlCommand cmd = new SqlCommand("Select dbo.Docs_EndDocPeriod(@id_doc,@customer)", con);
                            cmd.Parameters.AddWithValue("id_doc", id_doc);
                            cmd.Parameters.AddWithValue("customer", customer);
                            cmd.Transaction = transaction;
                            DateTime dStartPeriod = DateTime.Parse(cmd.ExecuteScalar().ToString());
                            DateTime dEndPeriod = dStartPeriod.AddMonths(qtyTime);
                            cmd = new SqlCommand("update Docs_OrderItems set period_start=@pStart, period_end=@pEnd where id_item=@id_item", con);
                            cmd.Parameters.AddWithValue("pStart", dStartPeriod);
                            cmd.Parameters.AddWithValue("pEnd", dEndPeriod);
                            cmd.Parameters.AddWithValue("id_item", id_item);
                            cmd.Transaction = transaction;
                            cmd.ExecuteNonQuery();
                        }
                    }

                    SqlCommand cmdOrder = new SqlCommand("update Docs_Orders set isPaid=1, date_pay=GETDATE(), status='Оплачен' where id_order=@id_order", con);
                    cmdOrder.Parameters.AddWithValue("id_order", id_order);
                    cmdOrder.Transaction = transaction;
                    cmdOrder.ExecuteNonQuery();
                    status = "Оплачен";
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
            return result;
        }

        private string OrderPost(string url, string postData)
        {
            var request = (HttpWebRequest)WebRequest.Create(url);

            var data = Encoding.ASCII.GetBytes(postData);

            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = data.Length;

            using (var stream = request.GetRequestStream())
            {
                stream.Write(data, 0, data.Length);
            }
            var response = (HttpWebResponse)request.GetResponse();
            var responseString = new StreamReader(response.GetResponseStream()).ReadToEnd();
            return responseString;
        }

        public string payOrderSber(string callBackUrl = "")
        {
            if (Cost > 0)
            {

                if (orderID != string.Empty)
                {
                    string respStatus = OrderPost(orderStatus_do, "userName=" + login_do + "&" + "password=" + password_do + "&" + "orderId=" + orderID);
                    JObject jStatus = JObject.Parse(respStatus);
                    switch (jStatus["orderStatus"].ToString())
                    {
                        case "0":
                            return string.Empty;
                        case "1":
                            PayOrder(idOrder);
                            return "Оплата произведена!";
                        case "2":
                            PayOrder(idOrder);
                            return "Оплата произведена!";
                    }
                }

                orderInternalID = Guid.NewGuid().ToString().Replace("-", string.Empty);
                string param = "userName=" + login_do + "&" + "password=" + password_do + "&" + "orderNumber=" + orderInternalID + "&" + "amount=" + (Cost * 100).ToString() + "&" + "returnUrl=" + callBackUrl;
                string resp = OrderPost(register_do, param);
                JObject jResp = JObject.Parse(resp);
                orderID = jResp["orderId"].ToString();
                formURL = jResp["formUrl"].ToString();
                updateOrderInfo();
                return string.Empty;
            }
            return "Не указана стоимость!";
        }
        public void CheckPayOrder()
        {
            if (status == "Сформирован")
            {
                if (orderID != string.Empty)
                {
                    string respStatus = OrderPost(orderStatus_do, "userName=" + login_do + "&" + "password=" + password_do + "&" + "orderId=" + orderID);
                    JObject jStatus = JObject.Parse(respStatus);
                    switch (jStatus["orderStatus"].ToString())
                    {
                        case "1":
                            PayOrder(idOrder);
                            break;
                        case "2":
                            PayOrder(idOrder);
                            break;
                    }
                }
            }
        }

    }


}

