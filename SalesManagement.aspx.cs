using System;
using System.Data;
using System.Data.Odbc;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;

public partial class SalesManagement : Page
{
    private const string CACHE_KEY = "SalesContacted";

    private OdbcConnection GetConnection()
    {
        string cs = System.Configuration.ConfigurationManager
                         .ConnectionStrings["ConStr"].ConnectionString;
        return new OdbcConnection(cs);
    }

    // --- Contacted set stored in Application memory (no DB table needed) ---
    private HashSet<int> GetContactedSet()
    {
        if (Application[CACHE_KEY] == null)
            Application[CACHE_KEY] = new HashSet<int>();
        return (HashSet<int>)Application[CACHE_KEY];
    }
    private void AddContacted(int id) { lock (Application) { GetContactedSet().Add(id); } }
    private bool IsContacted(int id)  { return GetContactedSet().Contains(id); }

    // -----------------------------------------------------------------------
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            TextBoxDays.Text = "14";
    }

    protected void ButtonSearch_Click(object sender, EventArgs e)
    {
        GridView1.PageIndex = 0;
        BindGrid();
    }

    protected void ButtonReset_Click(object sender, EventArgs e)
    {
        TextBoxDays.Text   = "14";
        TextBoxName.Text   = "";
        TextBoxMobile.Text = "";
        RadioButtonListGender.SelectedValue = "-1";
        CheckBoxShowContacted.Checked       = false;
        GridView1.DataSource = null;
        GridView1.DataBind();
        PanelStats.Visible = false;
        LabelError.Text    = "";
    }

    protected void ButtonExportCSV_Click(object sender, EventArgs e)
    {
        DataTable dt = GetExpiredTrainees();
        if (dt == null || dt.Rows.Count == 0) { LabelError.Text = "No data to export."; return; }

        Response.Clear();
        Response.ContentType     = "text/csv";
        Response.ContentEncoding = Encoding.UTF8;
        Response.AddHeader("Content-Disposition",
            "attachment; filename=SalesExpired_" + DateTime.Now.ToString("yyyyMMdd") + ".csv");
        Response.BinaryWrite(Encoding.UTF8.GetPreamble());

        var sb = new StringBuilder();
        sb.AppendLine("ID,Name,Mobile,Package,End Date,Days Since Expiry,Contacted");
        foreach (DataRow row in dt.Rows)
        {
            sb.AppendFormat("{0},\"{1}\",{2},\"{3}\",{4},{5},{6}\n",
                row["TraineeID"], row["Name"], row["Mobile"], row["Package"],
                Convert.ToDateTime(row["EndDate"]).ToString("yyyy-MM-dd"),
                row["DaysSinceExpiry"], row["ContactedLabel"]);
        }
        Response.Write(sb.ToString());
        Response.End();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindGrid();
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow) return;
        DataRowView drv    = (DataRowView)e.Row.DataItem;
        int         days   = Convert.ToInt32(drv["DaysSinceExpiry"]);

        if      (days >= 60) e.Row.CssClass = "row-absent-high";  // red  : 60+ days
        else if (days >= 30) e.Row.CssClass = "row-absent-med";   // yellow: 30-59 days
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MarkContacted")
        {
            AddContacted(Convert.ToInt32(e.CommandArgument));
            BindGrid();
        }
    }

    // -----------------------------------------------------------------------
    private void BindGrid()
    {
        DataTable dt = GetExpiredTrainees();
        if (dt == null) return;

        PanelStats.Visible   = true;
        LabelTotalCount.Text = dt.Rows.Count.ToString();

        int  contacted = 0;
        long totalDays = 0;
        foreach (DataRow row in dt.Rows)
        {
            if (row["ContactedLabel"].ToString() == "Done") contacted++;
            totalDays += Convert.ToInt32(row["DaysSinceExpiry"]);
        }
        LabelContactedCount.Text = contacted.ToString();
        LabelAvgAbsent.Text = dt.Rows.Count > 0
            ? Math.Round((double)totalDays / dt.Rows.Count, 1).ToString() : "0";

        GridView1.DataSource = dt;
        GridView1.DataBind();
    }

    // -----------------------------------------------------------------------
    //  CORE QUERY
    //  Logic: find the LATEST reservation per trainee that has already expired,
    //  and whose expiry date was at least N days ago.
    // -----------------------------------------------------------------------
    private DataTable GetExpiredTrainees()
    {
        LabelError.Text = "";

        int days;
        if (!int.TryParse(TextBoxDays.Text.Trim(), out days) || days < 1)
        {
            LabelError.Text = "Please enter a valid number of days (greater than 0).";
            return null;
        }

        var sql = new StringBuilder();
        sql.Append(@"
            SELECT
                t.ID                                    AS TraineeID,
                t.Name,
                t.Mobile,
                COALESCE(pl.Name, '')                   AS Package,
                MAX(r.EndDate)                          AS EndDate,
                DATEDIFF(NOW(), MAX(r.EndDate))         AS DaysSinceExpiry
            FROM reservation r
            INNER JOIN trainee   t  ON t.ID  = r.TraineeID
            LEFT  JOIN pricelist pl ON pl.ID = r.PriceListID
            WHERE r.EndDate < CURDATE()
        ");

        // Gender filter
        string gender = RadioButtonListGender.SelectedValue;
        if (gender == "0" || gender == "1")
            sql.Append(" AND t.male = " + gender);

        // Name filter
        if (!string.IsNullOrWhiteSpace(TextBoxName.Text))
            sql.Append(" AND t.Name LIKE '%" + Esc(TextBoxName.Text.Trim()) + "%'");

        // Mobile filter
        if (!string.IsNullOrWhiteSpace(TextBoxMobile.Text))
            sql.Append(" AND t.Mobile LIKE '%" + Esc(TextBoxMobile.Text.Trim()) + "%'");

        sql.Append(@"
            GROUP BY t.ID, t.Name, t.Mobile, pl.Name
            HAVING DaysSinceExpiry >= " + days);

        // Exclude trainees who renewed (have a current/future reservation)
        sql.Append(@"
            AND t.ID NOT IN (
                SELECT DISTINCT TraineeID FROM reservation
                WHERE EndDate >= CURDATE()
            )
        ");

        sql.Append(" ORDER BY DaysSinceExpiry DESC");

        var dt = new DataTable();
        try
        {
            using (OdbcConnection con = GetConnection())
            {
                con.Open();
                using (OdbcDataAdapter da = new OdbcDataAdapter(sql.ToString(), con))
                    da.Fill(dt);
            }
        }
        catch (Exception ex)
        {
            LabelError.Text = "Database error: " + ex.Message;
            return null;
        }

        // Add contacted label from memory cache
        dt.Columns.Add("ContactedLabel", typeof(string));
        foreach (DataRow row in dt.Rows)
            row["ContactedLabel"] = IsContacted(Convert.ToInt32(row["TraineeID"])) ? "Done" : "-";

        // Hide already-contacted if checkbox is unchecked
        if (!CheckBoxShowContacted.Checked)
            for (int i = dt.Rows.Count - 1; i >= 0; i--)
                if (dt.Rows[i]["ContactedLabel"].ToString() == "Done")
                    dt.Rows.RemoveAt(i);

        return dt;
    }

    private static string Esc(string s)
    {
        if (string.IsNullOrEmpty(s)) return "";
        return s.Replace("'", "''").Replace("\\", "\\\\");
    }
}
