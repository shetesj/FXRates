<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FXMain.aspx.cs" Inherits="FXRate.WebForm1" %>

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
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
        </asp:ScriptManager>
        <div class="container">
            <asp:Table runat="server" ID="tblMain">
                <asp:TableRow VerticalAlign="Top">
                    <asp:TableCell>
                        <asp:DropDownList ID="ddSource" runat="server">
                        </asp:DropDownList>
                    </asp:TableCell>
                    <asp:TableCell>

                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:ListBox EnableViewState="true" ID="lstCurrencies" runat="server" SelectionMode="Multiple" Height="200px"></asp:ListBox>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell ColumnSpan="3" HorizontalAlign="Center">
                        <asp:Button ID="btnGetFXRates" runat="server" Text="Button" OnClick="btnGetFXRates_Click" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <hr />
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
                                    <asp:BoundField DataField="Key" HeaderText="Target Currency   " />
                                    <asp:BoundField DataField="Value" HeaderText="Rate" ItemStyle-HorizontalAlign="Right" />
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>
    <!-- Latest compiled and minified JavaScript -->
    <script src="http://code.jquery.com/jquery-1.12.2.min.js" integrity="sha256-lZFHibXzMHo3GGeehn1hudTAP3Sc0uKXBXAzHX1sjtk=" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
    <script type="text/javascript">
        //Called this method on any button click  event for Testing
        function processJSON(Param1) {
            PageMethods.ParseJSON(Param1);
            //$.ajax({
            //    type: "POST",
            //    url: "FXMain.aspx/ProcessJSON",
            //    data: "{ Param1: '" + Param1 + "'}",
            //    contentType: "application/json; charset=utf-8",
            //    dataType: "json",
            //    async: "true",
            //    cache: "false"
            //});
            console.write('In callback function');
        }
    </script>

</body>
</html>
