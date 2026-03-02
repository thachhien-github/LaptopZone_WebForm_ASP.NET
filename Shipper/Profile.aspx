<%@ Page Title="Hồ sơ"
    Language="C#"
    MasterPageFile="~/Shipper/Shipper.Master"
    AutoEventWireup="true"
    CodeBehind="Profile.aspx.cs"
    Inherits="LaptopZone_project.Shipper.Profile" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">

<div class="max-w-xl mx-auto mt-8">

    <div class="bg-white shadow rounded-xl p-6">

        <div class="text-center mb-6">
            <div class="w-24 h-24 mx-auto rounded-full bg-blue-600 
                        flex items-center justify-center text-white 
                        text-3xl font-bold">
                <%: Session["TenDN"] != null 
                    ? Session["TenDN"].ToString().Substring(0,1).ToUpper() 
                    : "S" %>
            </div>

            <h2 class="text-2xl font-bold mt-4">
                <asp:Label ID="lblTenDN" runat="server" />
            </h2>

            <p class="text-slate-500 text-sm">
                Tài xế nội bộ
            </p>
        </div>

        <div class="border-t pt-4 space-y-3">

            <div class="flex justify-between">
                <span class="text-slate-500">Tên đăng nhập</span>
                <asp:Label ID="lblTenDN2" runat="server"
                    CssClass="font-semibold" />
            </div>

            <div class="flex justify-between">
                <span class="text-slate-500">Vai trò</span>
                <span class="font-semibold text-blue-600">
                    Shipper
                </span>
            </div>

            <div class="flex justify-between">
                <span class="text-slate-500">Trạng thái</span>
                <span class="text-emerald-600 font-semibold">
                    Đang hoạt động
                </span>
            </div>

        </div>

        <div class="mt-6 text-center">
            <asp:Button ID="btnDangXuat"
                runat="server"
                Text="Đăng xuất"
                CssClass="bg-red-500 text-white px-5 py-2 rounded"
                OnClick="btnDangXuat_Click" />
        </div>

    </div>

</div>

</asp:Content>