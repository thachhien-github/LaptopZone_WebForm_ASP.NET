<%@ Page Title="Chi tiết Đơn Hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ChiTietDonHang.aspx.cs" Inherits="LaptopZone_project.Admin.ChiTietDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-fade-in {
            animation: fadeIn 0.4s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(8px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="flex flex-col gap-8 page-fade-in p-2 md:p-4">

        <%-- Header Section: Đồng bộ phong cách tiêu đề lớn --%>
        <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
            <div>
                <div class="flex items-center gap-2 text-[#0984e3] font-black text-[10px] uppercase tracking-[0.2em] mb-1">
                    <span class="material-symbols-outlined text-sm">receipt_long</span> Giao dịch chi tiết
                </div>
                <h2 class="text-2xl font-black text-slate-800 tracking-tight">Đơn hàng <span class="text-[#0984e3]">#<asp:Label ID="lblMaDH" runat="server" /></span></h2>
            </div>
            <a href="QuanLyDonHang.aspx" class="bg-white hover:bg-slate-50 text-slate-500 px-5 py-2.5 rounded-xl font-bold text-[11px] uppercase tracking-widest border border-slate-200 shadow-sm transition-all flex items-center gap-2 active:scale-95">
                <span class="material-symbols-outlined text-sm">arrow_back</span> Quay lại danh sách
            </a>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <%-- Cột trái: Thông tin khách hàng --%>
            <div class="space-y-6">
                <div class="bg-white rounded-[2rem] shadow-sm border border-slate-200 overflow-hidden">
                    <div class="p-6 border-b border-slate-50 bg-slate-50/50">
                        <h3 class="font-black text-slate-800 flex items-center gap-2 text-[11px] uppercase tracking-widest">
                            <span class="material-symbols-outlined text-[#0984e3] text-lg">person</span> Khách hàng
                        </h3>
                    </div>
                    <div class="p-8 space-y-6">
                        <div class="group">
                            <label class="block text-[9px] font-black text-slate-400 uppercase tracking-[0.2em] mb-2 ml-1">Người nhận hàng</label>
                            <div class="bg-slate-50 rounded-2xl p-4 border border-transparent group-hover:border-blue-100 transition-all">
                                <div class="text-sm font-black text-slate-800">
                                    <asp:Label ID="lblTenKH" runat="server" />
                                </div>
                            </div>
                        </div>

                        <div class="group flex items-center gap-4 px-1">
                            <div class="size-10 rounded-xl bg-blue-50 text-[#0984e3] flex items-center justify-center shrink-0">
                                <span class="material-symbols-outlined text-base font-bold">call</span>
                            </div>
                            <div>
                                <label class="block text-[9px] font-black text-slate-400 uppercase tracking-widest">Liên lạc</label>
                                <span class="text-sm font-bold text-slate-700">
                                    <asp:Label ID="lblSDT" runat="server" /></span>
                            </div>
                        </div>

                        <div class="group flex items-start gap-4 px-1">
                            <div class="size-10 rounded-xl bg-orange-50 text-orange-500 flex items-center justify-center shrink-0">
                                <span class="material-symbols-outlined text-base font-bold">location_on</span>
                            </div>
                            <div>
                                <label class="block text-[9px] font-black text-slate-400 uppercase tracking-widest">Địa chỉ nhận</label>
                                <span class="text-sm font-medium text-slate-600 leading-snug block mt-0.5">
                                    <asp:Label ID="lblDiaChi" runat="server" /></span>
                            </div>
                        </div>
                    </div>

                    <%-- Nút hành động nổi bật --%>
                    <div class="p-6 bg-blue-50/30 border-t border-blue-50">
                        <asp:Button ID="btnXacNhan" runat="server" Text="HOÀN TẤT ĐƠN HÀNG"
                            CssClass="w-full bg-[#0984e3] hover:bg-[#0873c4] text-white font-black py-4 rounded-xl shadow-lg shadow-blue-100 transition-all active:scale-[0.98] cursor-pointer disabled:opacity-50 disabled:bg-slate-300 text-xs tracking-widest"
                            OnClick="btnXacNhan_Click" />
                        <p class="text-[9px] text-center text-blue-400 mt-4 font-bold italic tracking-tight">Cập nhật đơn hàng sang trạng thái "Đã Giao"</p>
                    </div>
                </div>
            </div>

            <%-- Cột phải: Danh sách sản phẩm --%>
            <div class="lg:col-span-2 space-y-6">
                <div class="bg-white rounded-[2rem] shadow-sm border border-slate-200 overflow-hidden">
                    <div class="p-6 border-b border-slate-50 flex justify-between items-center">
                        <h3 class="font-black text-slate-800 text-[11px] uppercase tracking-widest">Sản phẩm trong đơn</h3>
                        <span class="px-3 py-1 bg-emerald-50 text-emerald-600 text-[10px] font-black uppercase rounded-lg border border-emerald-100">Xác thực</span>
                    </div>

                    <div class="overflow-x-auto">
                        <asp:GridView ID="gvChiTiet" runat="server" AutoGenerateColumns="False"
                            CssClass="w-full text-left" GridLines="None">
                            <HeaderStyle CssClass="bg-slate-50/50 border-b border-slate-100 text-[10px] font-black text-slate-400 uppercase tracking-widest" />
                            <RowStyle CssClass="border-b border-slate-50 last:border-none group hover:bg-slate-50/30 transition-colors" />
                            <Columns>
                                <asp:TemplateField HeaderText="Thông tin máy">
                                    <HeaderStyle CssClass="px-6 py-4" />
                                    <ItemStyle CssClass="px-6 py-5" />
                                    <ItemTemplate>
                                        <div class="flex items-center gap-4">
                                            <div class="size-14 bg-white rounded-xl flex items-center justify-center shrink-0 border border-slate-100 overflow-hidden shadow-sm">
                                                <asp:Image ID="imgLaptop" runat="server"
                                                    ImageUrl='<%# "~/Images/" + Eval("AnhBia") %>'
                                                    CssClass="w-full h-full object-cover" />
                                            </div>
                                            <div>
                                                <div class="font-bold text-slate-800 text-sm"><%# Eval("TenLaptop") %></div>
                                                <div class="text-[9px] text-[#0984e3] font-black mt-1 uppercase">ID: #<%# Eval("MaLaptop") %></div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="SoLuong" HeaderText="SL"
                                    ItemStyle-CssClass="px-6 py-5 text-center font-black text-slate-700"
                                    HeaderStyle-CssClass="px-6 py-4 text-center" />

                                <asp:TemplateField HeaderText="Thành tiền">
                                    <HeaderStyle CssClass="px-6 py-4 text-right" />
                                    <ItemStyle CssClass="px-6 py-5 text-right font-black text-[#0984e3] text-sm" />
                                    <ItemTemplate>
                                        <%# Eval("ThanhTien", "{0:N0}") %><span class="text-[10px] ml-0.5 font-bold">đ</span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>

                    <%-- Phần tổng kết hóa đơn --%>
                    <div class="p-8 bg-slate-50/30 border-t border-slate-100">
                        <div class="flex flex-col items-end gap-3">
                            <%-- 1. Tổng tiền hàng --%>
                            <div class="flex justify-between w-full max-w-[280px] text-[10px] font-black text-slate-400 uppercase tracking-widest">
                                <span>Tổng tiền hàng:</span>
                                <span class="text-slate-800">
                                    <asp:Label ID="lblTamTinh" runat="server" />đ
                                </span>
                            </div>

                            <%-- 2. Thuế VAT (10%) --%>
                            <div class="flex justify-between w-full max-w-[280px] text-[10px] font-black text-slate-400 uppercase tracking-widest">
                                <span>Thuế VAT (10%):</span>
                                <span class="text-slate-800">
                                    <asp:Label ID="lblVAT" runat="server" />đ
                                </span>
                            </div>

                            <%-- 3. Vận chuyển --%>
                            <div class="flex justify-between w-full max-w-[280px] text-[10px] font-black text-slate-400 uppercase tracking-widest">
                                <span>Vận chuyển:</span>
                                <span class="text-emerald-600">FREESHIP</span>
                            </div>

                            <div class="h-px w-full max-w-[280px] bg-slate-200 my-2"></div>

                            <%-- 4. Tổng thanh toán --%>
                            <div class="flex justify-between w-full max-w-[280px] items-center">
                                <span class="text-xs font-black text-slate-800 uppercase tracking-tighter">Thanh toán:</span>
                                <span class="text-3xl font-black text-red-500 tracking-tighter italic">
                                    <asp:Label ID="lblTongTien" runat="server" />
                                    <span class="text-sm font-bold not-italic">đ</span>
                                </span>
                            </div>

                            <div class="mt-8">
                                <a class="inline-flex items-center gap-2 px-8 py-3 bg-slate-800 text-white rounded-xl text-[10px] font-black hover:bg-black transition-all shadow-lg shadow-slate-200 uppercase tracking-widest"
                                    href='PrintDonHang.aspx?SoDH=<%= lblMaDH.Text %>' target="_blank">
                                    <span class="material-symbols-outlined text-base">print</span> In đơn hàng
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

