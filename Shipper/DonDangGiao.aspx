<%@ Page Title="Đang giao"
    Language="C#"
    MasterPageFile="~/Shipper/Shipper.Master"
    AutoEventWireup="true"
    CodeBehind="DonDangGiao.aspx.cs"
    Inherits="LaptopZone_project.Shipper.DonDangGiao" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">

<h2 class="text-xl font-bold mb-4">Đơn đang giao</h2>

<asp:Repeater ID="rptDangGiao" runat="server"
    OnItemCommand="rptDangGiao_ItemCommand">

<ItemTemplate>
<div class="bg-white p-4 rounded shadow mb-4">

    <p class="font-bold">Đơn #<%# Eval("SoDH") %></p>
    <p>Trị giá: <%# String.Format("{0:N0} đ", Eval("TriGia")) %></p>

    <asp:Button runat="server"
        Text="Xác nhận đã giao"
        CssClass="bg-green-600 text-white px-3 py-1 rounded mt-2"
        CommandName="HoanThanh"
        CommandArgument='<%# Eval("SoDH") %>' />

</div>
</ItemTemplate>

</asp:Repeater>

</asp:Content>