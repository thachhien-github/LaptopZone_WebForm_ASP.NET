<%@ Page Title="Quản lý Khách Hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyKhachHang.aspx.cs" Inherits="LaptopZone_project.Admin.QuanLyKhachHang" %>

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

        .custom-grid {
            min-width: 900px;
            border-collapse: separate;
            border-spacing: 0;
        }

            .custom-grid tr {
                transition: all 0.2s;
            }

                .custom-grid tr:hover {
                    background-color: #f8fafc;
                }

        /* Style phân trang hiện đại */
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
                <h2 class="text-2xl font-extrabold text-[#2d3436] tracking-tight">Cộng Đồng Khách Hàng</h2>
                <p class="text-[13px] text-slate-500 font-medium">Quản lý tài khoản, thông tin liên lạc và hỗ trợ kỹ thuật</p>
            </div>
            <a href="DoiMatKhauAdmin.aspx" class="bg-[#2d3436] hover:bg-black text-white px-6 py-2.5 rounded-xl font-bold text-sm shadow-md transition-all flex items-center gap-2 group">
                <span class="material-symbols-outlined text-[20px] group-hover:rotate-12 transition-transform">admin_panel_settings</span>
                Đổi Pass Admin
            </a>
        </div>

        <%-- Filter & Search Bar --%>
        <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-100 flex flex-wrap gap-4 items-center">
            <div class="relative flex-1 min-w-[300px] group">
                <span class="material-symbols-outlined absolute left-3 top-2.5 text-slate-400 group-focus-within:text-[#0984e3]">search</span>
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Tìm tên khách hàng, SĐT, Email..."
                    CssClass="w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-100 rounded-xl text-sm focus:bg-white focus:ring-4 focus:ring-blue-50 focus:border-[#0984e3] outline-none transition-all"></asp:TextBox>
            </div>

            <div class="flex flex-wrap gap-3">
                <asp:DropDownList ID="ddlFilter" runat="server"
                    CssClass="bg-slate-50 border border-slate-100 rounded-xl text-sm px-4 py-2.5 focus:ring-4 focus:ring-blue-50 outline-none font-medium text-slate-600 cursor-pointer">
                    <asp:ListItem Text="Tất cả khách hàng" Value="all" />
                    <asp:ListItem Text="Đã có đơn hàng" Value="hasOrder" />
                    <asp:ListItem Text="Chưa có đơn hàng" Value="noOrder" />
                </asp:DropDownList>

                <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click"
                    CssClass="bg-[#0984e3] text-white px-5 py-2.5 rounded-xl hover:bg-[#0873c4] transition-all flex items-center gap-2 shadow-sm shadow-blue-100">
                    <span class="material-symbols-outlined text-[18px]">filter_list</span>
                    <span class="text-xs font-bold uppercase tracking-wider">Lọc</span>
                </asp:LinkButton>
            </div>
        </div>

        <%-- GridView Section --%>
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="overflow-x-auto">
                <asp:GridView ID="gvKhachHang" runat="server" AutoGenerateColumns="False" DataKeyNames="MaKH"
                    GridLines="None" CssClass="w-full text-left custom-grid"
                    AllowPaging="True" PageSize="4" OnPageIndexChanging="gvKhachHang_PageIndexChanging"
                    OnRowDeleting="gvKhachHang_RowDeleting">

                    <PagerStyle CssClass="pager-style" />
                    <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last" />

                    <Columns>
                        <%-- Cột Khách hàng --%>
                        <asp:TemplateField HeaderText="Danh tính khách hàng" HeaderStyle-CssClass="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100">
                            <ItemTemplate>
                                <div class="flex items-center gap-4 py-3 px-2">
                                    <div class="size-12 rounded-2xl bg-gradient-to-br from-[#0984e3] to-blue-600 flex items-center justify-center text-white font-black text-sm shadow-sm ring-4 ring-blue-50">
                                        <%# GetInitials(Eval("HoTenKH").ToString()) %>
                                    </div>
                                    <div>
                                        <p class="font-bold text-slate-800 text-sm"><%# Eval("HoTenKH") %></p>
                                        <div class="flex items-center gap-2 mt-1">
                                            <span class="text-[9px] text-slate-400 font-bold bg-slate-50 px-2 py-0.5 rounded border border-slate-100 uppercase">ID: <%# Eval("MaKH") %></span>
                                            <span class="text-[10px] text-[#0984e3] font-extrabold italic">@<%# Eval("TenDN") %></span>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <%-- Cột Thông tin liên hệ --%>
                        <asp:TemplateField HeaderText="Thông tin liên hệ" HeaderStyle-CssClass="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100">
                            <ItemTemplate>
                                <div class="text-[11px] py-3 space-y-1.5">
                                    <div class="flex items-center gap-2">
                                        <span class="material-symbols-outlined text-[15px] text-emerald-500">call</span>
                                        <span class="font-bold text-slate-700 tracking-wide"><%# Eval("DienThoai") %></span>
                                    </div>
                                    <div class="flex items-center gap-2">
                                        <span class="material-symbols-outlined text-[15px] text-slate-300">mail</span>
                                        <span class="text-slate-500 font-medium"><%# Eval("Email") %></span>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <%-- Cột Địa chỉ --%>
                        <asp:TemplateField HeaderText="Địa chỉ & Cá nhân" HeaderStyle-CssClass="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100">
                            <ItemTemplate>
                                <div class="py-3">
                                    <div class="flex items-start gap-1 max-w-[220px]">
                                        <span class="material-symbols-outlined text-[14px] text-slate-300 mt-0.5">location_on</span>
                                        <p class="text-[11px] text-slate-600 line-clamp-2 leading-relaxed font-medium"><%# Eval("DiaChi") %></p>
                                    </div>
                                    <p class="text-[10px] text-slate-400 mt-2 flex items-center gap-1 font-medium">
                                        <span class="material-symbols-outlined text-[13px]">cake</span>
                                        Sinh ngày: <%# Eval("NgaySinh", "{0:dd/MM/yyyy}") %>
                                    </p>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <%-- Cột Thao tác --%>
                        <asp:TemplateField HeaderText="Quản lý" HeaderStyle-CssClass="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100 text-center">
                            <ItemTemplate>
                                <div class="flex items-center justify-center gap-1 py-3">
                                    <button type="button" onclick='openPassModal("<%# Eval("MaKH") %>", "<%# Eval("HoTenKH") %>")'
                                        class="p-2.5 text-slate-400 hover:text-[#0984e3] hover:bg-blue-50 rounded-xl transition-all" title="Cấp lại mật khẩu">
                                        <span class="material-symbols-outlined text-[20px]">lock_reset</span>
                                    </button>
                                    <asp:LinkButton ID="lbtnDelete" runat="server" CommandName="Delete"
                                        OnClientClick="return confirm('Xác nhận xóa khách hàng? Hành động này không thể hoàn tác!');"
                                        CssClass="p-2.5 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-xl transition-all" title="Xóa tài khoản">
                                        <span class="material-symbols-outlined text-[20px]">person_remove</span>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <EmptyDataTemplate>
                        <div class="py-24 text-center">
                            <div class="inline-flex items-center justify-center size-20 bg-slate-50 rounded-full mb-4">
                                <span class="material-symbols-outlined text-4xl text-slate-200">person_search</span>
                            </div>
                            <h3 class="text-slate-800 font-bold">Không tìm thấy khách hàng</h3>
                            <p class="text-slate-400 text-sm mt-1">Vui lòng kiểm tra lại từ khóa tìm kiếm</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>

    <%-- Modal Đổi Mật Khẩu --%>
    <div id="passModal" class="hidden fixed inset-0 bg-[#2d3436]/60 backdrop-blur-sm z-50 flex items-center justify-center p-4 overflow-hidden">
        <div class="bg-white rounded-[2.5rem] p-8 w-full max-w-[360px] shadow-2xl scale-100 transition-transform">
            <div class="text-center mb-8">
                <div class="size-16 bg-blue-50 text-[#0984e3] rounded-3xl flex items-center justify-center mx-auto mb-4 ring-8 ring-blue-50/50">
                    <span class="material-symbols-outlined text-3xl">key_visualizer</span>
                </div>
                <h3 class="text-xl font-extrabold text-[#2d3436] tracking-tight">Cấp mật khẩu mới</h3>
                <p id="modalCustomerName" class="text-[13px] text-blue-600 mt-1 font-bold"></p>
            </div>

            <asp:HiddenField ID="hdnMaKH" runat="server" />
            <div class="space-y-5">
                <div class="bg-slate-50 p-4 rounded-2xl border border-slate-100 focus-within:border-[#0984e3] transition-colors">
                    <label class="text-[10px] font-black text-slate-400 uppercase tracking-widest block mb-2">Mật khẩu mới</label>
                    <div class="flex items-center gap-2">
                        <span class="material-symbols-outlined text-slate-300 text-[18px]">lock_open</span>
                        <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" placeholder="Tối thiểu 6 ký tự..."
                            CssClass="w-full bg-transparent border-none p-0 focus:ring-0 text-sm outline-none font-bold text-slate-700" />
                    </div>
                </div>

                <div class="flex gap-3 pt-2">
                    <button type="button" onclick="closePassModal()" class="flex-1 py-3.5 rounded-2xl font-bold text-slate-500 bg-slate-100 hover:bg-slate-200 transition-all text-[13px]">Đóng</button>
                    <asp:Button ID="btnConfirmUpdate" runat="server" Text="Cập Nhật" OnClick="btnConfirmUpdate_Click"
                        CssClass="flex-1 py-3.5 rounded-2xl font-bold text-white bg-[#0984e3] hover:bg-[#0873c4] shadow-lg shadow-blue-100 transition-all text-[13px] cursor-pointer" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function openPassModal(id, name) {
            const modal = document.getElementById('passModal');
            modal.classList.remove('hidden');
            document.getElementById('<%= hdnMaKH.ClientID %>').value = id;
            document.getElementById('modalCustomerName').innerText = name;
        }
        function closePassModal() {
            document.getElementById('passModal').classList.add('hidden');
        }
    </script>
</asp:Content>

