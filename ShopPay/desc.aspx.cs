using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShopPay
{
    public partial class desc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow &&
              (e.Row.RowState == DataControlRowState.Normal || e.Row.RowState == DataControlRowState.Alternate))
            {
                String type_img = "image_lowCA"; //"news";
                String w = "250";
                String h = "200";

                String type_img_big = "image_bigCA";
                String items = ((Label)e.Row.FindControl("LabelItemItems")).Text;


                if (((Label)e.Row.FindControl("LabelItemHave_img")).Text == "True")
                {
                   // ((Encosia.HighslideImage)e.Row.FindControl("ImageItem")).Visible = true;
                   // ((Encosia.HighslideImage)e.Row.FindControl("ImageItem")).ImageUrl = "~/photoDB.ashx?type_img=" + type_img + "&items=" + items + "&w=" + w + "&h=" + h;
                   // ((Encosia.HighslideImage)e.Row.FindControl("ImageItem")).FullImageURL = "~/photoDB.ashx?type_img=" + type_img_big + "&items=" + items;
                }
                else
                {
                   // ((System.Web.UI.WebControls.Image)e.Row.FindControl("ImageItem")).Visible = false;
                   // ((Panel)e.Row.FindControl("PanelImageRight")).Visible = false;
                }
            }
        }
    }
}