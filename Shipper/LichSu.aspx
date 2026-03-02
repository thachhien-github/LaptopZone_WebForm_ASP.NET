<%@ Page Title="Lịch sử giao hàng"
    Language="C#"
    MasterPageFile="~/Shipper/Shipper.master"
    AutoEventWireup="true"
    CodeBehind="LichSu.aspx.cs"
    Inherits="LaptopZone_project.Shipper.LichSu" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">

<div class="py-6">
    <h2 class="text-2xl md:text-3xl font-bold">
        📜 Lịch sử giao hàng
    </h2>
</div>

<!-- Bộ lọc ngày -->
<div class="bg-white p-4 rounded-xl shadow mb-6 flex flex-col sm:flex-row gap-3 items-center">

    <asp:TextBox ID="txtTuNgay" runat="server"
        TextMode="Date"
        CssClass="border px-3 py-2 rounded w-full sm:w-auto" />

    <asp:TextBox ID="txtDenNgay" runat="server"
        TextMode="Date"
        CssClass="border px-3 py-2 rounded w-full sm:w-auto" />

    <asp:Button ID="btnLoc"
        runat="server"
        Text="Lọc"
        OnClick="btnLoc_Click"
        CssClass="bg-blue-600 text-white px-5 py-2 rounded w-full sm:w-auto" />

</div>

<!-- Tổng tiền -->
<div class="bg-emerald-50 border border-emerald-200 p-4 rounded-xl mb-6">
    <p class="text-sm text-emerald-600 font-semibold">
        Tổng tiền đã thu:
    </p>
    <asp:Label ID="lblTongTien"
        runat="server"
        CssClass="text-2xl font-bold text-emerald-700" />
</div>

<!-- Danh sách đơn -->
<asp:Repeater ID="rptLichSu" runat="server">
<ItemTemplate>

<div class="bg-white p-5 shadow border rounded-xl mb-5">

    <div class="flex flex-col sm:flex-row sm:justify-between gap-3">

        <div>
            <span class="text-xs text-slate-400 font-bold uppercase">
                #<%# Eval("SoDH") %>
            </span>

            <h4 class="font-bold">
                <%# Eval("HoTenKH") %>
            </h4>

            <p class="text-sm text-slate-500 break-words">
                <%# Eval("DiaChi") %>
            </p>
        </div>

        <span class="px-3 py-1 text-xs rounded bg-emerald-100 text-emerald-600 font-semibold">
            Đã giao
        </span>

    </div>

    <div class="text-sm text-slate-500 mt-3">
        Ngày giao:
        <%# Convert.ToDateTime(Eval("NgayGiao")).ToString("dd/MM/yyyy HH:mm") %>
    </div>

    <div class="flex justify-between items-center border-t pt-3 mt-3">
        <span class="font-bold text-red-600 text-lg">
            <%# string.Format("{0:N0} đ", Eval("TriGia")) %>
        </span>

        <a href='DonChiTiet.aspx?id=<%# Eval("SoDH") %>'
           class="bg-blue-600 text-white text-sm px-4 py-2 rounded">
            Chi tiết
        </a>
    </div>

</div>

</ItemTemplate>
</asp:Repeater>

</asp:Content>