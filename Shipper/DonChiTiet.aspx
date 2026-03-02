<%@ Page Title="Chi tiết đơn hàng"
    Language="C#"
    MasterPageFile="~/Shipper/Shipper.master"
    AutoEventWireup="true"
    CodeBehind="DonChiTiet.aspx.cs"
    Inherits="LaptopZone_project.Shipper.DonChiTiet" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">

<h2 class="text-3xl font-bold mb-8 text-gray-800">
    🚚 Chi tiết đơn hàng
</h2>

<div class="grid grid-cols-1 lg:grid-cols-2 gap-8">

    <!-- THÔNG TIN ĐƠN -->
    <div class="bg-white p-8 rounded-2xl shadow-lg">

        <h3 class="text-xl font-semibold mb-6 border-b pb-3 text-gray-700">
            Thông tin đơn hàng
        </h3>

        <div class="space-y-4 text-gray-700">

            <div class="flex justify-between">
                <span class="font-semibold">Mã đơn</span>
                <asp:Label ID="lblSoDH" runat="server"
                    CssClass="font-bold text-gray-900" />
            </div>

            <div class="flex justify-between">
                <span class="font-semibold">Khách hàng</span>
                <asp:Label ID="lblKhachHang" runat="server" />
            </div>

            <div class="flex justify-between">
                <span class="font-semibold">Ngày đặt</span>
                <asp:Label ID="lblNgayDat" runat="server" />
            </div>

            <div>
                <span class="font-semibold block mb-1">Địa chỉ giao</span>
                <asp:Label ID="lblDiaChi" runat="server"
                    CssClass="text-gray-800" />
            </div>

            <div class="flex justify-between text-lg">
                <span class="font-semibold">Tổng tiền</span>
                <asp:Label ID="lblTriGia" runat="server"
                    CssClass="text-red-600 font-bold" />
            </div>

            <div class="flex justify-between items-center">
                <span class="font-semibold">Trạng thái</span>
                <asp:Label ID="lblTrangThai" runat="server"
                    CssClass="px-3 py-1 rounded-full text-sm font-semibold" />
            </div>

        </div>

        <div class="mt-8 text-center">
            <asp:Button ID="btnHoanThanh"
                runat="server"
                Text="✔ Xác nhận đã giao"
                CssClass="bg-green-600 hover:bg-green-700 text-white px-6 py-3 rounded-xl font-semibold transition"
                OnClick="btnHoanThanh_Click"
                Visible="false" />
        </div>

    </div>

    <!-- GOOGLE MAP -->
    <div class="bg-white p-8 rounded-2xl shadow-lg">

        <h3 class="text-xl font-semibold mb-6 border-b pb-3 text-gray-700">
            📍 Vị trí giao hàng
        </h3>

        <iframe id="iframeMap"
            runat="server"
            width="100%"
            height="420"
            style="border:0; border-radius:15px;"
            loading="lazy">
        </iframe>

        <div class="mt-6 text-center">
            <asp:HyperLink ID="lnkMoMap"
                runat="server"
                Target="_blank"
                CssClass="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-xl font-semibold inline-block transition">
                🗺 Mở Google Maps
            </asp:HyperLink>
        </div>

    </div>

</div>

</asp:Content>