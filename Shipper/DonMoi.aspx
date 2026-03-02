<%@ Page Title="Đơn mới"
    Language="C#"
    MasterPageFile="~/Shipper/Shipper.Master"
    AutoEventWireup="true"
    CodeBehind="DonMoi.aspx.cs"
    Inherits="LaptopZone_project.Shipper.DonMoi" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">

    <h2 class="text-3xl font-bold mb-8 text-gray-800">📦 Đơn cần giao
    </h2>

    <asp:Repeater ID="rptDonMoi" runat="server"
        OnItemCommand="rptDonMoi_ItemCommand">

        <itemtemplate>

            <div class="bg-white p-6 rounded-2xl shadow-lg mb-6 hover:shadow-xl transition">

                <div class="flex justify-between items-center mb-4">
                    <div>
                        <p class="text-lg font-bold text-gray-800">
                            Đơn #<%# Eval("SoDH") %>
                        </p>
                        <p class="text-sm text-gray-500">
                            <%# Convert.ToDateTime(Eval("NgayDH")).ToString("dd/MM/yyyy HH:mm") %>
                        </p>
                    </div>

                    <span class="bg-yellow-100 text-yellow-700 px-3 py-1 rounded-full text-sm font-semibold">Đơn mới
                    </span>
                </div>

                <div class="space-y-2 text-gray-700">

                    <p><strong>Người nhận:</strong> <%# Eval("HoTenKH") %></p>
                    <p><strong>SĐT:</strong> <%# Eval("DienThoai") %></p>
                    <p><strong>Địa chỉ:</strong> <%# Eval("DiaChi") %></p>

                    <p class="text-lg font-bold text-red-600 mt-3">
                        <%# String.Format("{0:N0} đ", Eval("TriGia")) %>
                    </p>

                </div>

                <div class="mt-5 flex gap-3">

                    <asp:Button ID="btnNhan"
                        runat="server"
                        Text="✔ Nhận đơn"
                        CssClass="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg font-semibold"
                        CommandName="Nhan"
                        CommandArgument='<%# Eval("SoDH") %>' />

                    <asp:HyperLink ID="lnkChiTiet"
                        runat="server"
                        NavigateUrl='<%# "DonChiTiet.aspx?id=" + Eval("SoDH") %>'
                        CssClass="bg-gray-200 hover:bg-gray-300 px-4 py-2 rounded-lg font-semibold">
                        Xem chi tiết
                    </asp:HyperLink>

                    <asp:HyperLink ID="lnkGoi"
                        runat="server"
                        NavigateUrl='<%# "tel:" + Eval("DienThoai") %>'
                        CssClass="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg font-semibold">
                        📞 Gọi
                    </asp:HyperLink>

                </div>

            </div>

        </itemtemplate>

    </asp:Repeater>

</asp:Content>
