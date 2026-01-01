<%@ Page Title="Quản lý Hãng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyHang.aspx.cs" Inherits="LaptopZone_project.Admin.QuanLyHang" %>

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
                <h2 class="text-2xl font-extrabold text-[#2d3436] tracking-tight">Đối Tác & Hãng Sản Xuất</h2>
                <p class="text-[13px] text-slate-500 font-medium">Quản lý thông tin các nhà cung cấp laptop</p>
            </div>
            <asp:LinkButton ID="btnOpenAdd" runat="server" OnClick="btnOpenAdd_Click"
                CssClass="bg-[#0984e3] text-white px-5 py-2.5 rounded-xl font-bold text-sm hover:bg-[#0873c4] transition-all flex items-center gap-2 shadow-md shadow-blue-100">
                <span class="material-symbols-outlined text-[20px]">factory</span> Thêm Hãng Mới
            </asp:LinkButton>
        </div>

        <%-- GridView Table --%>
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="overflow-x-auto">
                <asp:GridView ID="gvHang" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="MaHang" GridLines="None"
                    CssClass="w-full text-left"
                    OnRowCommand="gvHang_RowCommand"
                    AllowPaging="True" PageSize="5" OnPageIndexChanging="gvHang_PageIndexChanging">

                    <HeaderStyle CssClass="bg-slate-50 border-b border-slate-100 text-[11px] font-bold text-slate-400 uppercase tracking-widest" />
                    <RowStyle CssClass="border-b border-slate-50 last:border-none hover:bg-slate-50/50 transition-all" />

                    <PagerStyle CssClass="pager-style" />
                    <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last" />

                    <Columns>
                        <asp:TemplateField HeaderText="Thương hiệu">
                            <HeaderStyle CssClass="px-6 py-4" />
                            <ItemStyle CssClass="px-6 py-5" />
                            <ItemTemplate>
                                <div class="flex flex-col">
                                    <span class="text-sm font-black text-slate-800"><%# Eval("TenHang") %></span>
                                    <span class="text-[10px] text-slate-400 font-bold uppercase tracking-tighter">Mã đối tác: #<%# Eval("MaHang") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Thông tin liên hệ">
                            <HeaderStyle CssClass="px-6 py-4" />
                            <ItemStyle CssClass="px-6 py-5" />
                            <ItemTemplate>
                                <div class="flex flex-col gap-1">
                                    <div class="flex items-center gap-1.5 text-slate-600 text-xs font-medium">
                                        <span class="material-symbols-outlined text-sm text-slate-400">location_on</span>
                                        <%# Eval("DiaChi") %>
                                    </div>
                                    <div class="flex items-center gap-1.5 text-[#0984e3] text-xs font-bold">
                                        <span class="material-symbols-outlined text-sm">call</span>
                                        <%# Eval("DienThoai") %>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Thao tác">
                            <HeaderStyle CssClass="px-6 py-4 text-right" />
                            <ItemStyle CssClass="px-6 py-5 text-right" />
                            <ItemTemplate>
                                <div class="flex items-center justify-end gap-1">
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditHang" CommandArgument='<%# Eval("MaHang") %>'
                                        CssClass="p-2.5 text-slate-400 hover:text-[#0984e3] hover:bg-blue-50 rounded-xl transition-all">
                                        <span class="material-symbols-outlined text-[20px]">edit_note</span>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteHang" CommandArgument='<%# Eval("MaHang") %>'
                                        CssClass="p-2.5 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-xl transition-all"
                                        OnClientClick="return confirm('Xác nhận xóa hãng này khỏi hệ thống?')">
                                        <span class="material-symbols-outlined text-[20px]">delete_forever</span>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="py-20 text-center text-slate-400">Chưa có dữ liệu hãng sản xuất.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>

    <%-- Form Modal --%>
    <asp:Panel ID="pnlForm" runat="server" Visible="false" CssClass="fixed inset-0 bg-slate-900/60 backdrop-blur-sm flex items-center justify-center z-50 p-4">
        <div class="bg-white rounded-[2.5rem] shadow-2xl w-full max-w-lg overflow-hidden animate-in zoom-in-95 duration-200">
            <div class="p-8">
                <div class="flex justify-between items-center mb-8">
                    <div class="flex items-center gap-3">
                        <div class="size-10 rounded-2xl bg-blue-50 text-[#0984e3] flex items-center justify-center">
                            <span class="material-symbols-outlined">apartment</span>
                        </div>
                        <h3 class="text-xl font-black text-slate-800 tracking-tight">
                            <asp:Literal ID="litFormTitle" runat="server" /></h3>
                    </div>
                    <asp:LinkButton ID="btnClose" runat="server" OnClick="btnClose_Click" CssClass="size-10 flex items-center justify-center rounded-xl hover:bg-slate-100 text-slate-400 transition-all">
                        <span class="material-symbols-outlined">close</span>
                    </asp:LinkButton>
                </div>

                <div class="space-y-5">
                    <asp:HiddenField ID="hdMaHang" runat="server" />

                    <div>
                        <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Tên hãng sản xuất</label>
                        <asp:TextBox ID="txtTenHang" runat="server" placeholder="VD: Apple, Dell, Asus..." CssClass="w-full px-5 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl focus:ring-4 focus:ring-blue-50 outline-none font-bold text-slate-700 transition-all"></asp:TextBox>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Số điện thoại</label>
                            <asp:TextBox ID="txtDienThoai" runat="server" CssClass="w-full px-5 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl focus:ring-4 focus:ring-blue-50 outline-none font-bold text-slate-700 transition-all"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Địa chỉ trụ sở</label>
                            <asp:TextBox ID="txtDiaChi" runat="server" CssClass="w-full px-5 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl focus:ring-4 focus:ring-blue-50 outline-none font-bold text-slate-700 transition-all"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="mt-10 flex gap-3">
                    <asp:Button ID="btnLuu" runat="server" Text="LƯU THÔNG TIN HÃNG" OnClick="btnLuu_Click"
                        CssClass="flex-1 bg-[#0984e3] text-white font-black py-4 rounded-2xl shadow-xl shadow-blue-100 hover:bg-[#0873c4] transition-all cursor-pointer text-[11px] tracking-widest uppercase" />
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>

