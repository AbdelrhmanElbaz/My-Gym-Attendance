<%@ page language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" inherits="_Default, App_Web_xfweqsz4" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <style type="text/css">
        .WindowsStyle .ajax__combobox_inputcontainer .ajax__combobox_textboxcontainer input
        {
            margin: 0;
            border: solid 1px #7F9DB9;
            border-right: 0px none;
            padding: 1px 0px 0px 5px;
            font-size: 13px;
            height: 18px;
        }
        .WindowsStyle .ajax__combobox_inputcontainer .ajax__combobox_buttoncontainer button
        {
            margin: 0;
            padding: 0;
           
            border: 0px none;
            height: 21px;
            width: 21px;
        }
        .WindowsStyle .ajax__combobox_itemlist
        {
            border-color: #7F9DB9;
           margin-left:-7px;
           margin-top:-6px;
        }
    </style>
                <div align="center"  >
                     
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <asp:HiddenField ID="HiddenFieldID" runat="server" Value="0" />
                    <div style="border-style: ridge; border-width: medium; ">
                        <table bgcolor="Silver" bordercolordark="Black" cellpadding="2" width="85%" cellspacing="2">
                            <tr>
                                <td class="style1" align="center">
                                </td>
                                <td class="style1" colspan="4" align="center">
                                   <b> Trainee Search </b>
                                </td>
                                <td class="style1" align="center">
                                </td>
                            </tr>
                            <tr>
                                <td class="style1" align="center">
                                </td>
                                <td class="style1" colspan="4" align="center">
                                </td>
                                <td class="style1" align="center">
                                </td>
                            </tr>
                            <tr>
                                <td> 
                                </td>
                                <td class="style4">
                                    <asp:Label ID="Label2" runat="server" Text="ID :"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBoxID" runat="server" Font-Size="12pt"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text="Female :" Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxFemale" runat="server" OnCheckedChanged="CheckBoxFemale_CheckedChanged" />
                                </td>
                                <td width="20px">
                                     
                                </td>
                            </tr>
                            <tr>
                                <td>
                                     
                                </td>
                                <td class="style4">
                                    <asp:Label ID="Label20" runat="server" Text="Name : "></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBoxName" runat="server" Font-Size="12pt"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="Label3" runat="server" Text="Mobile :" Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBoxMobile" runat="server" Font-Size="12pt"></asp:TextBox>
                                </td>
                                <td width="20px">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td class="style4" align="center" colspan="4">
                                    <asp:Button ID="ButtonSearch" runat="server" OnClick="ButtonSearch_Click" Text="Search "
                                        Height="34px" Width="89px" />
                                </td>
                                <td width="20px">
                                    &nbsp;
                                </td>
                            </tr>
                           
                        </table>
                      
                        <table bgcolor="Silver" bordercolordark="Black" cellpadding="0" width="85%" cellspacing="5" style="border-width:3px;border-color:Black;border-style:solid"
                            cellspacing="5" style="background-color: #C0C0C0">
                            <tr>
                                <td class="style1" colspan="4" align="center">
                                   <b>Trainee Attend</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Trainee :
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownListTrainee" runat="server" AppendDataBoundItems="True"
                                        AutoPostBack="True" Height="24px" OnSelectedIndexChanged="DropDownListTrainee_SelectedIndexChanged"
                                        Width="213px" Font-Size="12pt">
                                        <asp:ListItem Value="0">choose Trainee</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td rowspan="3" class="style4">
                                    <asp:Label ID="LabelPriceList1" runat="server" Text="Note :" Font-Bold="True"></asp:Label>
                                </td>
                                <td rowspan="3">
                                    <asp:TextBox ID="TextBoxNotes" runat="server" Height="67px" TextMode="MultiLine"
                                        Width="224px" Font-Size="12pt"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="CheckBoxNormal" runat="server" Text="Normal" Checked="true" />
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxSauna" runat="server" Text="Sauna" />
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <asp:CheckBox ID="CheckBoxJacuzzi" runat="server" Text="Jacuzzi" />
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBoxSpa" runat="server" Text="Spa" />
                                </td>
                            </tr>
                            <tr>

                                <td align="center"  >
                                    <asp:CheckBox ID="CheckBoxInvitation" runat="server" Text="Invitation" />
                                </td>

                                <td align="center"  >
                                    <ajaxToolkit:ComboBox ID="ComboBoxGuest" runat="server" CssClass="WindowsStyle"  Width="213px" Font-Size="12pt" placeholder="Guest name">
                                     
                                    </ajaxToolkit:ComboBox>
                                </td>

                                <td align="center"  >
                                Date : 
                                  
                                   <%-- <asp:Calendar ID="Calendar10000000000" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" Visible="false">
                                    </asp:Calendar>--%>
                                </td>

                                <td align="center"  >
                                  <asp:TextBox ID="TextBoxDate" runat="server" CssClass="text" Height="22px" 
                                Width="150px"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy-MM-dd" TargetControlID="TextBoxDate">
                            </ajaxToolkit:CalendarExtender>

                                </td>
                            </tr>
                            <tr>

                                <td align="center" colspan="4"  >
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="Button1" runat="server" Text="Attend" Enabled="False" OnClientClick="return confirm('Are you sure you want to Attend This Trainee ?')"
                                        OnClick="Button1_Click" Height="36px" Width="181px" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Label ID="LabelError" runat="server" Font-Bold="True" ForeColor="#993333"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table bgcolor="Silver" bordercolordark="Black" cellpadding="2" width="75%" cellspacing="2" style="border-width:3px;border-color:Black;border-style:solid">
                            <tr>
                                <td class="style1" colspan="7" align="center">
                                   <b>Trainee Info</b>
                                </td>
                            </tr>
                            <tr>
                                <td class="style1" colspan="7" align="center">
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/traineeImg/Tulips.jpg" Visible="false"
                                        Width="300px" style="border-radius:40px;" />
                                </td>
                            </tr>
                            <tr>
                                <td class="style1" colspan="7" align="center">
                                    <asp:Label ID="LabelNotes" runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="style2">
                                    &nbsp;Price:
                                </td>
                                <td>
                                    <asp:Label ID="LabelPrice" runat="server" Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td bgcolor="Black" width="2">
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td class="style3">
                                    <asp:Label ID="LabelAddress0" runat="server" Text="Date :" Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="LabelDate" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td width="4">
                                    &nbsp;
                                </td>
                                <td bgcolor="Black">
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td class="style3">
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="LabelPriceList2" runat="server" Text="Normal :" Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="LabelNormal" runat="server"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td bgcolor="Black">
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td class="style3">
                                    <asp:Label ID="LabelPriceList3" runat="server" Text="Invitation :" Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="LabelInv" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td bgcolor="Black">
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td class="style3">
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="LabelPriceList4" runat="server" Text="End date: " Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="LabelEnd" runat="server"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td bgcolor="Black">
                                    &nbsp;
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <td class="style3">
                                    <asp:Label ID="LabelPriceList5" runat="server" Text="Max Attend : " Font-Bold="True"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Labelmax" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />
                </div>
        
    <div id="footer">
        <div class="left">
            © 2012 GYMApp. All rights reserved.</div>
        <div class="right">
            Design by En Haitham
        </div>
    </div>
</asp:Content>
