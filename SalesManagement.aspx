<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" 
    CodeFile="SalesManagement.aspx.cs" Inherits="SalesManagement" Title="Sales Management"
    ContentType="text/html" ResponseEncoding="UTF-8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style type="text/css">
        .filter-table { width: 90%; background: Silver; border-collapse: collapse; }
        .filter-table td { padding: 6px 10px; }
        .section-title { font-weight: bold; font-size: 14pt; text-align: center; padding: 10px;
                         background: #8B0000; color: white; }
        .stats-box { background: #f0f0f0; border: 2px solid #999; padding: 10px 24px;
                     display: inline-block; margin: 5px; text-align: center; }
        .stats-number { font-size: 24pt; font-weight: bold; color: #8B0000; }
        .stats-label  { font-size: 10pt; color: #555; }
        .btn-done { background: #FF9800; color: white; border: none; padding: 5px 14px;
                    cursor: pointer; border-radius: 3px; font-weight: bold; }
        .row-absent-high { background-color: #FFCCCC !important; }  /* 60+ days  - red    */
        .row-absent-med  { background-color: #FFF3CD !important; }  /* 30-59 days - yellow */
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div align="center" style="border: medium ridge #333333; padding-bottom: 20px;">
        <br />
        <asp:HiddenField ID="HiddenFieldID" runat="server" Value="0" />

        <div style="border-style: ridge; border-width: medium; width: 92%;">

            <!-- FILTER TABLE -->
            <table class="filter-table" align="center" cellpadding="4" cellspacing="3">
                <tr>
                    <td colspan="6" class="section-title">
                        Sales Management &mdash; Expired Subscriptions
                    </td>
                </tr>
                <tr>
                    <td><b>Expired since (days) &gt;=</b></td>
                    <td>
                        <asp:TextBox ID="TextBoxDays" runat="server" Width="80px" Font-Size="12pt" Text="14" />
                    </td>
                    <td><b>Gender:</b></td>
                    <td>
                        <asp:RadioButtonList ID="RadioButtonListGender" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="All"    Value="-1" Selected="True" />
                            <asp:ListItem Text="Male"   Value="0" />
                            <asp:ListItem Text="Female" Value="1" />
                        </asp:RadioButtonList>
                    </td>
                    <td><b>Name:</b></td>
                    <td>
                        <asp:TextBox ID="TextBoxName" runat="server" Width="160px" Font-Size="12pt" />
                    </td>
                </tr>
                <tr>
                    <td><b>Mobile:</b></td>
                    <td>
                        <asp:TextBox ID="TextBoxMobile" runat="server" Width="140px" Font-Size="12pt" />
                    </td>
                    <td><b>Show contacted:</b></td>
                    <td>
                        <asp:CheckBox ID="CheckBoxShowContacted" runat="server" Text="Show already contacted" />
                    </td>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="6" align="center">
                        <asp:Button ID="ButtonSearch"    runat="server" Text="Search"     Width="120px" Height="34px"
                            Font-Bold="True" OnClick="ButtonSearch_Click" />
                        &nbsp;
                        <asp:Button ID="ButtonReset"     runat="server" Text="Reset"      Width="100px" Height="34px"
                            OnClick="ButtonReset_Click" />
                        &nbsp;
                        <asp:Button ID="ButtonExportCSV" runat="server" Text="Export CSV" Width="120px" Height="34px"
                            OnClick="ButtonExportCSV_Click" />
                    </td>
                </tr>
            </table>

            <br />

            <!-- STATS -->
            <asp:Panel ID="PanelStats" runat="server" Visible="false">
                <div style="text-align:center; margin:10px 0;">
                    <div class="stats-box">
                        <div class="stats-number"><asp:Label ID="LabelTotalCount" runat="server" Text="0" /></div>
                        <div class="stats-label">Total Expired</div>
                    </div>
                    <div class="stats-box">
                        <div class="stats-number" style="color:#c47a00;">
                            <asp:Label ID="LabelContactedCount" runat="server" Text="0" />
                        </div>
                        <div class="stats-label">Contacted</div>
                    </div>
                    <div class="stats-box">
                        <div class="stats-number" style="color:#2196F3;">
                            <asp:Label ID="LabelAvgAbsent" runat="server" Text="0" />
                        </div>
                        <div class="stats-label">Avg Days Since Expiry</div>
                    </div>
                </div>
                <div style="text-align:center; font-size:9pt; color:#666; margin-bottom:6px;">
                    <span style="background:#FFF3CD; padding:2px 8px; border:1px solid #ccc;">30-59 days</span>
                    &nbsp;
                    <span style="background:#FFCCCC; padding:2px 8px; border:1px solid #ccc;">60+ days</span>
                </div>
            </asp:Panel>

            <asp:Label ID="LabelError" runat="server" Font-Bold="True" ForeColor="Maroon" />
            <br />

            <!-- GRID -->
            <asp:GridView ID="GridView1" runat="server"
                BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px"
                CellPadding="4" CellSpacing="2" Width="98%"
                Font-Bold="True" Font-Names="Verdana" Font-Size="10pt" ForeColor="Black"
                AllowPaging="True" PageSize="30"
                AutoGenerateColumns="False"
                OnPageIndexChanging="GridView1_PageIndexChanging"
                OnRowDataBound="GridView1_RowDataBound"
                OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:BoundField DataField="TraineeID"       HeaderText="ID"                 ItemStyle-Width="50px" />
                    <asp:BoundField DataField="Name"            HeaderText="Name"               ItemStyle-Width="180px" />
                    <asp:BoundField DataField="Mobile"          HeaderText="Mobile"             ItemStyle-Width="130px" />
                    <asp:BoundField DataField="Package"         HeaderText="Package"            ItemStyle-Width="140px" />
                    <asp:BoundField DataField="EndDate"         HeaderText="Expiry Date"
                        DataFormatString="{0:yyyy-MM-dd}"       ItemStyle-Width="120px" />
                    <asp:BoundField DataField="DaysSinceExpiry" HeaderText="Days Since Expiry"  ItemStyle-Width="110px" />

                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="BtnMarkContacted" runat="server"
                                CommandName="MarkContacted"
                                CommandArgument='<%# Eval("TraineeID") %>'
                                OnClientClick="return confirm('Mark this trainee as contacted?');"
                                CssClass="btn-done">
                                Mark Contacted
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="ContactedLabel"  HeaderText="Status"             ItemStyle-Width="80px" />
                </Columns>
                <PagerSettings FirstPageText="First" LastPageText="Last"
                    NextPageText="Next" PreviousPageText="Previous" Mode="NextPreviousFirstLast" />
                <RowStyle BackColor="White" />
                <FooterStyle BackColor="#CCCCCC" />
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <EmptyDataTemplate>
                    <div style="padding:20px; font-size:13pt; color:#555;">No expired subscriptions found.</div>
                </EmptyDataTemplate>
            </asp:GridView>
            <br />
        </div>
        <br />
    </div>

</asp:Content>
