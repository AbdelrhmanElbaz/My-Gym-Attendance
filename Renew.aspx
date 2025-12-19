<%@ page language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" inherits="Renew, App_Web_xfweqsz4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


	<div id="content">

		<div id="normalcontent">
	
			<div class="contentarea">
				
			   <div align="center" style="border: medium ridge #333333"> 
    
       <br />
                    <asp:HiddenField ID="HiddenFieldID" runat="server" Value="0" />
                <div style="border-style: ridge; border-width: medium; width:85% " >
                              <table bgcolor="Silver" bordercolordark="Black" cellpadding="2"  width="85%"
                        cellspacing="2">
                        <tr>
                            <td class="style1" align="center">
                                </td>
                            <td class="style1" colspan="4" align="center">
                                &nbsp;Trainee Search</td>
                            <td class="style1" align="center">
                                </td>
                        </tr>
                        <tr>
                            <td class="style1" align="center">
                                </td>
                            <td class="style1" colspan="4" align="center">
                                &nbsp;</td>
                            <td class="style1" align="center">
                                </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td class="style4">
                                <asp:Label ID="Label4" runat="server" Text="ID :" Font-Bold="True" 
                                    Font-Italic="False"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TextBoxID" runat="server" Font-Size="12pt"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="Label5" runat="server" Text="Female :" Font-Bold="True"></asp:Label>
                            </td>
                            <td>
                    <asp:CheckBox ID="CheckBoxFemale" runat="server" 
                        oncheckedchanged="CheckBoxFemale_CheckedChanged" Font-Size="12pt" />
                            </td>
                            <td width="20px">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td class="style4">
                                <asp:Label ID="Label20" runat="server" Text="Name : " Font-Bold="True"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TextBoxName" runat="server" Font-Size="12pt"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Label ID="Label6" runat="server" Text="Mobile :" Font-Bold="True"></asp:Label>
                                            </td>
                            <td>
                                <asp:TextBox ID="TextBoxMobile" runat="server" Font-Size="12pt"></asp:TextBox>
                            </td>
                            <td width="20px">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td class="style4" colspan="4" align="center">
                                <asp:Button ID="ButtonSearch" runat="server" onclick="ButtonSearch_Click" 
                                    Text="Search " />
                                            </td>
                            <td width="20px">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style8" colspan="6" align="center">
                                &nbsp;</td>
                        </tr>
                                                                        
                        
                        
                    </table>
                                 <br /> <asp:Label ID="LabelEr" runat="server" Font-Bold="True" ForeColor="Maroon"></asp:Label>
                                  
                    <table bgcolor="Silver" bordercolordark="Black" cellpadding="2" width="70%"
                        cellspacing="2">
                        <tr>
                            <td class="style1" align="center">
                                </td>
                            <td class="style1" colspan="4" align="center">
                                Renew&nbsp; Reservation</td>
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
                                &nbsp;</td>
                            <td class="style2">
                                <asp:Label ID="Label1" runat="server" Text="Trainee :"></asp:Label>
                            </td>
                            <td>
        <asp:DropDownList ID="DropDownListTrainee" runat="server" 
            AppendDataBoundItems="True" AutoPostBack="True" Width="350px" Font-Size="12pt" onselectedindexchanged="DropDownListTrainee_SelectedIndexChanged"
           >
            <asp:ListItem Value="0">choose Trainee</asp:ListItem>
        </asp:DropDownList>
                            </td>
                            <td class="style2">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td width="20px">
                                &nbsp;</td>
                        </tr>
                                                                        
                        
                        
                        <tr>
                            <td>
                    <asp:HiddenField ID="HiddenFieldNotes" runat="server" Value="" />
                                &nbsp;</td>
                            <td class="style2">
                                &nbsp;</td>
                            <td>
                                    <asp:Label ID="LabelnotesData" runat="server" Font-Bold="True"></asp:Label>
                                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td width="20px">
                                &nbsp;</td>
                        </tr>
                                                                        
                        
                        
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td class="style2">
                                Notes:</td>
                            <td>
                                <asp:TextBox ID="TextBoxNotes" runat="server" Height="50px" Width="350px" 
                                    MaxLength="2000" TextMode="MultiLine" ForeColor="#CC0000"></asp:TextBox>
                                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td width="20px">
                                &nbsp;</td>
                        </tr>
                                                                        
                        
                        
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td class="style2">
                                <asp:Label ID="Label3" runat="server" Text="Price List :"></asp:Label>
                                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownListType" runat="server" Width="350px" Font-Size="12pt"
                                    >
                                </asp:DropDownList>
                                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td width="20px">
                                &nbsp;</td>
                        </tr>
                                                                        
                        
                        
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td class="style2">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td width="20px">
                                &nbsp;</td>
                        </tr>
                                                                        
                        
                        
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td class="style2">
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Height="26px" onclick="Button1_Click2" 
                                    Text="RENEW" Width="93px" />
                                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td width="20px">
                                &nbsp;</td>
                        </tr>
                                                                        
                        
                        
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td class="style2">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td width="20px">
                                &nbsp;</td>
                        </tr>
                                                                        
                        
                        
                    </table>
                                    <br />
                    </div>
                                <br />
                                <br />
               
              
    
    </div>
			</div>
		</div>


	</div>
</asp:Content>
	