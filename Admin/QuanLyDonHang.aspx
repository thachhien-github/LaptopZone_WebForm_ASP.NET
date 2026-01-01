<%@ Page Title="Quản lý Đơn Hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyDonHang.aspx.cs" Inherits="LaptopZone_project.Admin.QuanLyDonHang" %>

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

        /* Tùy chỉnh phân trang đồng bộ style hiện đại */
        .pager-style table {
            margin: 24px auto; /* Căn giữa cụm phân trang */
            display: flex;
            justify-content: center;
        }

        .pager-style td {
            border: none;
            padding: 0 4px;
        }

        .pager-style a, .pager-style span {
            width: 38px;
            height: 38px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.2s;
        }

        .pager-style a {
            background: white;
            color: #64748b;
            border: 1px solid #e2e8f0;
        }

            .pager-style a:hover {
                background: #f1f5f9;
                color: #0984e3;
                border-color: #0984e3;
                transform: translateY(-2px);
            }

        .pager-style span {
            background: #0984e3;
            color: white;
            box-shadow: 0 4px 12px rgba(9, 132, 227, 0.25);
            border: 1px solid #0984e3;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="flex flex-col gap-6 page-fade-in">

        <%-- Header Section --%>
        <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
            <div>
                <h2 class="text-2xl font-extrabold text-[#2d3436] tracking-tight">Quản Lý Giao Dịch</h2>
                <p class="text-[13px] text-slate-500 font-medium">Theo dõi luồng đơn hàng và doanh thu hệ thống</p>
            </div>
            <div class="flex gap-2">
                <button type="button" class="bg-white border border-slate-200 text-slate-600 px-5 py-2.5 rounded-xl font-bold text-sm hover:bg-slate-50 transition-all flex items-center gap-2 shadow-sm">
                    <span class="material-symbols-outlined text-[20px]">file_export</span> Xuất File Excel
                </button>
            </div>
        </div>

        <%-- Filter Bar --%>
        <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-100 flex flex-wrap gap-5 items-end">
            <div class="flex-1 min-w-[300px] group">
                <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Tìm kiếm đơn hàng</label>
                <div class="relative">
                    <span class="material-symbols-outlined absolute left-3 top-2.5 text-slate-400 text-sm group-focus-within:text-[#0984e3]">search</span>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-100 rounded-xl text-sm focus:bg-white focus:ring-4 focus:ring-blue-50 focus:border-[#0984e3] outline-none transition-all" placeholder="Mã đơn hàng hoặc tên khách hàng..."></asp:TextBox>
                </div>
            </div>

            <div class="w-full md:w-[180px]">
                <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Trạng thái giao</label>
                <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="w-full bg-slate-50 border border-slate-100 rounded-xl text-sm px-4 py-2.5 focus:ring-4 focus:ring-blue-50 outline-none font-medium text-slate-600 cursor-pointer">
                    <asp:ListItem Value="-1">Tất cả đơn hàng</asp:ListItem>
                    <asp:ListItem Value="0">Chờ xử lý</asp:ListItem>
                    <asp:ListItem Value="1">Đã hoàn thành</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="w-full md:w-[180px]">
                <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Thời gian từ</label>
                <asp:TextBox ID="txtTuNgay" runat="server" TextMode="Date" CssClass="w-full bg-slate-50 border border-slate-100 rounded-xl text-sm px-4 py-2.5 outline-none text-slate-600"></asp:TextBox>
            </div>

            <asp:LinkButton ID="btnLoc" runat="server" OnClick="btnLoc_Click" CssClass="bg-[#0984e3] text-white px-6 py-2.5 rounded-xl hover:bg-[#0873c4] transition-all flex items-center justify-center gap-2 shadow-md shadow-blue-100 h-[42px]">
                <span class="material-symbols-outlined text-[20px]">tune</span>
                <span class="text-xs font-extrabold uppercase tracking-wider">Lọc Đơn</span>
            </asp:LinkButton>
        </div>

        <%-- GridView Table --%>
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="overflow-x-auto">
                <asp:GridView ID="gvDonHang" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="SoDH" GridLines="None"
                    CssClass="w-full text-left"
                    OnRowCommand="gvDonHang_RowCommand"
                    AllowPaging="True" PageSize="4" OnPageIndexChanging="gvDonHang_PageIndexChanging">

                    <HeaderStyle CssClass="bg-slate-50 border-b border-slate-100 text-[11px] font-bold text-slate-400 uppercase tracking-widest" />
                    <RowStyle CssClass="border-b border-slate-50 last:border-none hover:bg-slate-50/50 transition-all" />

                    <%-- Phần phân trang quan trọng --%>
                    <PagerStyle CssClass="pager-style" />
                    <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last" PreviousPageText="Prev" NextPageText="Next" />

                    <Columns>
                        <asp:TemplateField HeaderText="Mã đơn">
                            <HeaderStyle CssClass="px-6 py-4" />
                            <ItemStyle CssClass="px-6 py-5" />
                            <ItemTemplate>
                                <span class="font-bold text-slate-700 bg-slate-100 px-3 py-1.5 rounded-lg text-[11px] border border-slate-200/50">#<%# Eval("SoDH") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Khách hàng & Ngày đặt">
                            <HeaderStyle CssClass="px-6 py-4" />
                            <ItemStyle CssClass="px-6 py-5" />
                            <ItemTemplate>
                                <div class="flex flex-col gap-1">
                                    <span class="text-sm font-bold text-slate-800"><%# Eval("HoTenKH") %></span>
                                    <div class="text-[10px] text-slate-400 flex items-center gap-1 font-medium">
                                        <span class="material-symbols-outlined text-[14px]">calendar_today</span>
                                        <%# Eval("NgayDH", "{0:dd/MM/yyyy HH:mm}") %>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Tổng giá trị">
                            <HeaderStyle CssClass="px-6 py-4" />
                            <ItemStyle CssClass="px-6 py-5" />
                            <ItemTemplate>
                                <span class="font-black text-[#2d3436] text-sm tracking-tight">
                                    <%# Eval("TriGia", "{0:N0}") %><span class="text-[10px] ml-0.5">đ</span>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Trạng thái">
                            <HeaderStyle CssClass="px-6 py-4 text-center" />
                            <ItemStyle CssClass="px-6 py-5 text-center" />
                            <ItemTemplate>
                                <%# (Eval("DaGiao") != DBNull.Value && (bool)Eval("DaGiao")) ? 
                                    "<span class='inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-emerald-50 text-emerald-600 text-[10px] font-bold uppercase border border-emerald-100'><span class='size-1.5 bg-emerald-500 rounded-full'></span>Hoàn thành</span>" : 
                                    "<span class='inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-amber-50 text-amber-600 text-[10px] font-bold uppercase border border-amber-100'><span class='size-1.5 bg-amber-500 rounded-full animate-pulse'></span>Đang xử lý</span>" %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Thao tác">
                            <HeaderStyle CssClass="px-6 py-4 text-right" />
                            <ItemStyle CssClass="px-6 py-5 text-right" />
                            <ItemTemplate>
                                <div class="flex items-center justify-end gap-1">
                                    <a href='<%# "ChiTietDonHang.aspx?id=" + Eval("SoDH") %>' class="p-2.5 text-slate-400 hover:text-[#0984e3] hover:bg-blue-50 rounded-xl transition-all" title="Xem chi tiết">
                                        <span class="material-symbols-outlined text-[20px]">visibility</span>
                                    </a>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteDH" CommandArgument='<%# Eval("SoDH") %>' CssClass="p-2.5 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-xl transition-all" OnClientClick="return confirm('Xác nhận hủy và xóa vĩnh viễn đơn hàng này?')">
                                        <span class="material-symbols-outlined text-[20px]">delete_sweep</span>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <EmptyDataTemplate>
                        <div class="py-24 text-center">
                            <div class="inline-flex items-center justify-center size-20 bg-slate-50 rounded-full mb-4">
                                <span class="material-symbols-outlined text-4xl text-slate-200">receipt_long</span>
                            </div>
                            <h3 class="text-slate-800 font-bold">Không có đơn hàng nào</h3>
                            <p class="text-slate-400 text-sm mt-1">Hệ thống chưa ghi nhận giao dịch nào phù hợp</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

