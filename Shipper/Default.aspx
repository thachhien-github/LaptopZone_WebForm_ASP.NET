<%@ Page Title="Tổng quan"
    Language="C#"
    MasterPageFile="~/Shipper/Shipper.master"
    AutoEventWireup="true"
    CodeBehind="Default.aspx.cs"
    Inherits="LaptopZone_project.Shipper.Default" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">

<!-- Welcome -->
<div class="py-6">
    <h2 class="text-2xl md:text-3xl font-bold">Tổng quan</h2>
    <p class="text-slate-500 text-sm mt-1">
        Xin chào,
        <asp:Literal ID="ltrTen" runat="server" />
    </p>
</div>

<!-- Summary Cards -->
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 mb-10">

    <div class="rounded-xl p-5 bg-white shadow border">
        <p class="text-xs font-bold uppercase text-slate-400">
            Chờ giao (Hệ thống)
        </p>
        <asp:Label ID="ltrChoGiao" runat="server"
            CssClass="text-2xl font-bold text-blue-600" />
    </div>

    <div class="rounded-xl p-5 bg-white shadow border">
        <p class="text-xs font-bold uppercase text-slate-400">
            Đang giao (Của bạn)
        </p>
        <asp:Label ID="ltrDangGiao" runat="server"
            CssClass="text-2xl font-bold text-amber-500" />
    </div>

    <div class="rounded-xl p-5 bg-white shadow border">
        <p class="text-xs font-bold uppercase text-slate-400">
            💰 Tổng tiền đã thu
        </p>
        <asp:Label ID="ltrDaGiao" runat="server"
            CssClass="text-2xl font-bold text-emerald-600" />
    </div>

</div>

<!-- Lộ trình -->
<div class="mb-6">
    <button onclick="openRoute()"
        class="w-full sm:w-auto bg-blue-600 hover:bg-blue-700 text-white px-5 py-3 rounded-lg text-sm font-semibold">
        🗺 Tạo lộ trình giao hàng
    </button>
</div>

<!-- Đơn đang giao -->
<h3 class="text-lg md:text-xl font-bold mb-4">
    Đơn đang giao
</h3>

<asp:Repeater ID="rptDonGanDay" runat="server">
<ItemTemplate>

<div class="bg-white p-5 shadow border rounded-xl mb-5">

    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:justify-between sm:items-start gap-3 mb-3">

        <div>
            <span class="text-xs text-slate-400 font-bold uppercase">
                #<%# Eval("SoDH") %>
            </span>

            <h4 class="font-bold text-base md:text-lg">
                <%# Eval("HoTenKH") %>
            </h4>

            <p class="text-sm text-slate-500 diachi break-words">
                <%# Eval("DiaChi") %>
            </p>
        </div>

        <span class="px-3 py-1 text-xs rounded bg-amber-100 text-amber-600 font-semibold self-start">
            Đang giao
        </span>

    </div>

    <!-- Date -->
    <div class="text-sm text-slate-500 mb-3">
        Ngày đặt:
        <%# Convert.ToDateTime(Eval("NgayDH")).ToString("dd/MM/yyyy HH:mm") %>
    </div>

    <!-- Footer -->
    <div class="flex flex-col sm:flex-row sm:justify-between sm:items-center gap-3 border-t pt-3">

        <span class="font-bold text-red-600 text-lg">
            <%# string.Format("{0:N0} đ", Eval("TriGia")) %>
        </span>

        <a href='DonChiTiet.aspx?id=<%# Eval("SoDH") %>'
           class="w-full sm:w-auto text-center bg-blue-600 hover:bg-blue-700 text-white text-sm px-4 py-2 rounded-lg">
            Chi tiết
        </a>

    </div>

</div>

</ItemTemplate>
</asp:Repeater>

<!-- SCRIPT LỘ TRÌNH -->
<script>
    function openRoute() {

        if (!navigator.geolocation) {
            alert("Trình duyệt không hỗ trợ định vị.");
            return;
        }

        navigator.geolocation.getCurrentPosition(function (position) {

            var lat = position.coords.latitude;
            var lng = position.coords.longitude;

            var waypoints = [];
            document.querySelectorAll(".diachi").forEach(function (el) {
                waypoints.push(encodeURIComponent(el.innerText));
            });

            if (waypoints.length === 0) {
                alert("Không có đơn đang giao.");
                return;
            }

            var destination = waypoints[0];

            var url =
                "https://www.google.com/maps/dir/?api=1" +
                "&origin=" + lat + "," + lng +
                "&destination=" + destination;

            if (waypoints.length > 1) {
                url += "&waypoints=" + waypoints.slice(1).join("|");
            }

            window.open(url, "_blank");
        });
    }
</script>

</asp:Content>
