<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FXMain.aspx.cs" Inherits="FXRates.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous" />

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="jumbotron"><h1>Real time FX Rate Finder</h1></div>
            <asp:Table runat="server" ID="tblMain">
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell>
                        Base Currency
                    </asp:TableHeaderCell>
                    <asp:TableHeaderCell>

                    </asp:TableHeaderCell>
                    <asp:TableHeaderCell>
                        Target Currencies
                    </asp:TableHeaderCell>
                </asp:TableHeaderRow>
                <asp:TableRow VerticalAlign="Top">
                    <asp:TableCell>
                        <asp:DropDownList ID="ddSource" runat="server">
                        </asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>
                        &nbsp;&nbsp;&nbsp;&nbsp;<img height="15" width="15" src="https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSHO1Ww-1auKIC_cqK9Gap1LAQ5Ub_xAYOH_4NmsJ94O7Ez54mjceYG1Ng" />&nbsp;&nbsp;&nbsp;&nbsp;
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:ListBox ID="lstCurrencies" runat="server" SelectionMode="Multiple" Height="200px"></asp:ListBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3" HorizontalAlign="Center">
                        <br />
                        <asp:Button ID="btnGetFXRates" runat="server" Text="Get Rates" OnClick="btnGetFXRates_Click" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <hr />
            <div id="divLbls" runat="server">
                <asp:Label ID="lblTime" runat="server">Time: </asp:Label>
                <asp:Label ID="lblTimestamp" runat="server"></asp:Label>
                <br />
                <asp:Label ID="lblBase" runat="server">Base Currency: </asp:Label>
                <asp:Label ID="lblBaseValue" runat="server"></asp:Label>
                <br />
            </div>
            <table>
                <tbody>
                    <tr>
                        <td>
                            <asp:GridView ID="grdResults" AutoGenerateColumns="false" runat="server" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="2px" CellPadding="6" CellSpacing="6" ForeColor="Black" GridLines="Vertical">
                                <AlternatingRowStyle BackColor="White" />
                                <FooterStyle BackColor="#CCCC99" />
                                <HeaderStyle HorizontalAlign="Center" BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                <RowStyle BackColor="#F7F7DE" />
                                <Columns>
                                    <asp:BoundField DataField="Currency" HeaderText="Target Currency   " />
                                    <asp:BoundField DataField="Rate" HeaderText="Rate" ItemStyle-HorizontalAlign="Right" />
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>
    <!-- Latest compiled and minified JavaScript -->
    <script   src="https://code.jquery.com/jquery-2.2.2.min.js"   integrity="sha256-36cp2Co+/62rEAAYHLmRCPIych47CvdM+uTBJwSzWjI="   crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
</body>
</html>
