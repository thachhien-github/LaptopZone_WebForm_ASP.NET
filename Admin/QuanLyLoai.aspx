<%@ Page Title="Quản lý Loại" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyLoai.aspx.cs" Inherits="LaptopZone_project.Admin.QuanLyLoai" %>

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

        /* Tùy chỉnh phân trang GridView */
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
                <h2 class="text-2xl font-extrabold text-[#2d3436] tracking-tight">Danh Mục Loại Máy</h2>
                <p class="text-[13px] text-slate-500 font-medium">Quản lý phân loại sản phẩm (Gaming, Văn phòng, Đồ họa...)</p>
            </div>
            <div class="flex gap-2">
                <asp:LinkButton ID="lbtnAdd" runat="server" OnClick="btnShowAdd_Click" CssClass="bg-[#0984e3] text-white px-5 py-2.5 rounded-xl font-bold text-sm hover:bg-[#0873c4] transition-all flex items-center gap-2 shadow-md">
                    <span class="material-symbols-outlined text-[20px]">add_circle</span> Thêm Loại Mới
                </asp:LinkButton>
            </div>
        </div>

        <%-- GridView Table --%>
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="overflow-x-auto">
                <asp:GridView ID="gvLoai" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="MaLoai" GridLines="None" CssClass="w-full text-left"
                    OnRowCommand="gvLoai_RowCommand" AllowPaging="True" PageSize="5"
                    OnPageIndexChanging="gvLoai_PageIndexChanging">

                    <HeaderStyle CssClass="bg-slate-50 border-b border-slate-100 text-[11px] font-bold text-slate-400 uppercase tracking-widest" />
                    <RowStyle CssClass="border-b border-slate-50 last:border-none hover:bg-slate-50/50 transition-all" />
                    <PagerStyle CssClass="pager-style" />

                    <Columns>
                        <asp:TemplateField HeaderText="Mã số">
                            <HeaderStyle CssClass="px-6 py-4" />
                            <ItemStyle CssClass="px-6 py-5" />
                            <ItemTemplate>
                                <span class="font-bold text-slate-400 text-[12px]">#<%# Eval("MaLoai") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Tên danh mục loại">
                            <HeaderStyle CssClass="px-6 py-4" />
                            <ItemStyle CssClass="px-6 py-5" />
                            <ItemTemplate>
                                <div class="flex items-center gap-3">
                                    <div class="size-8 rounded-lg bg-blue-50 text-[#0984e3] flex items-center justify-center">
                                        <span class="material-symbols-outlined text-sm">category</span>
                                    </div>
                                    <span class="text-sm font-bold text-slate-700"><%# Eval("TenLoai") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Thao tác">
                            <HeaderStyle CssClass="px-6 py-4 text-right" />
                            <ItemStyle CssClass="px-6 py-5 text-right" />
                            <ItemTemplate>
                                <div class="flex items-center justify-end gap-1">
                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditLoai" CommandArgument='<%# Eval("MaLoai") %>'
                                        CssClass="p-2.5 text-slate-400 hover:text-[#0984e3] hover:bg-blue-50 rounded-xl transition-all">
                                        <span class="material-symbols-outlined text-[20px]">edit_square</span>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteLoai" CommandArgument='<%# Eval("MaLoai") %>'
                                        CssClass="p-2.5 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-xl transition-all"
                                        OnClientClick="return confirm('Xóa loại này sẽ ảnh hưởng đến các sản phẩm liên quan. Bạn chắc chắn chứ?')">
                                        <span class="material-symbols-outlined text-[20px]">delete</span>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="py-20 text-center text-slate-400 font-medium">Chưa có danh mục nào.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>

    <%-- Form Modal --%>
    <asp:Panel ID="pnlForm" runat="server" Visible="false" CssClass="fixed inset-0 bg-slate-900/50 backdrop-blur-sm flex items-center justify-center z-50 p-4">
        <div class="bg-white rounded-[2rem] shadow-2xl w-full max-w-md overflow-hidden animate-in zoom-in-95 duration-200">
            <div class="p-8">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="text-xl font-black text-slate-800">
                        <asp:Literal ID="litFormTitle" runat="server" /></h3>
                    <asp:LinkButton ID="btnClose" runat="server" OnClick="btnClose_Click" CssClass="text-slate-400 hover:text-slate-600"><span class="material-symbols-outlined">close</span></asp:LinkButton>
                </div>
                <div class="space-y-4">
                    <div>
                        <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Tên loại Laptop</label>
                        <asp:TextBox ID="txtTenLoai" runat="server" CssClass="w-full px-5 py-3.5 bg-slate-50 border border-slate-100 rounded-2xl focus:ring-4 focus:ring-blue-50 outline-none font-bold text-slate-700 transition-all"></asp:TextBox>
                        <asp:HiddenField ID="hdMaLoai" runat="server" />
                    </div>
                </div>
                <div class="mt-8">
                    <asp:Button ID="btnLuu" runat="server" Text="XÁC NHẬN LƯU" OnClick="btnLuu_Click"
                        CssClass="w-full bg-[#0984e3] text-white font-black py-4 rounded-2xl shadow-lg hover:bg-[#0873c4] transition-all cursor-pointer text-[11px] tracking-widest" />
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>

