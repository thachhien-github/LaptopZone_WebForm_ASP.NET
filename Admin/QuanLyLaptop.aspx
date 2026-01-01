<%@ Page Title="Quản lý Sản Phẩm" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyLaptop.aspx.cs" Inherits="LaptopZone_project.Admin.QuanLyLaptop" %>

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

        /* Phân trang căn giữa hiện đại */
        .pager-style table {
            margin: 24px auto;
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

        .no-scrollbar::-webkit-scrollbar {
            display: none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="flex flex-col gap-6 page-fade-in">
        <%-- Header --%>
        <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
            <div>
                <h2 class="text-2xl font-extrabold text-[#2d3436] tracking-tight">Kho Sản Phẩm</h2>
                <p class="text-[13px] text-slate-500 font-medium">Quản lý cấu hình, giá bán và tồn kho laptop</p>
            </div>
            <a href="ThemLaptop.aspx" class="bg-[#0984e3] hover:bg-[#0873c4] text-white px-6 py-2.5 rounded-xl font-bold text-sm shadow-md transition-all flex items-center gap-2 group">
                <span class="material-symbols-outlined text-[20px] group-hover:rotate-90 transition-transform">add</span>
                Thêm Laptop Mới
            </a>
        </div>

        <%-- Filter --%>
        <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-100 flex flex-wrap gap-4 items-center">
            <div class="relative flex-1 min-w-[300px]">
                <span class="material-symbols-outlined absolute left-3 top-2.5 text-slate-400">search</span>
                <asp:TextBox ID="txtTimKiem" runat="server" placeholder="Tìm tên máy, CPU..."
                    CssClass="w-full pl-10 pr-4 py-2.5 bg-slate-50 border border-slate-100 rounded-xl text-sm focus:ring-4 focus:ring-blue-50 outline-none transition-all"></asp:TextBox>
            </div>
            <asp:DropDownList ID="ddlLoai" runat="server" CssClass="bg-slate-50 border border-slate-100 rounded-xl text-sm px-4 py-2.5 outline-none font-medium text-slate-600"></asp:DropDownList>
            <asp:DropDownList ID="ddlHang" runat="server" CssClass="bg-slate-50 border border-slate-100 rounded-xl text-sm px-4 py-2.5 outline-none font-medium text-slate-600"></asp:DropDownList>
            <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" CssClass="bg-[#2d3436] text-white px-5 py-2.5 rounded-xl hover:bg-black transition-all flex items-center gap-2">
                <span class="material-symbols-outlined text-[18px]">filter_list</span>
                <span class="text-xs font-bold uppercase">Lọc</span>
            </asp:LinkButton>
        </div>

        <%-- GridView --%>
        <div class="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="overflow-x-auto no-scrollbar">
                <asp:GridView ID="gvLaptop" runat="server" AutoGenerateColumns="False" DataKeyNames="MaLaptop"
                    OnRowDeleting="gvLaptop_RowDeleting" AllowPaging="True" PageSize="4"
                    OnPageIndexChanging="gvLaptop_PageIndexChanging" GridLines="None" CssClass="w-full text-left custom-grid">

                    <PagerStyle CssClass="pager-style" />
                    <Columns>
                        <asp:TemplateField HeaderText="Sản phẩm">
                            <ItemTemplate>
                                <div class="flex items-center gap-4 py-3 px-6">
                                    <img src='<%# Eval("AnhBia") != DBNull.Value ? "../Images/" + Eval("AnhBia") : "../Images/no-image.png" %>' class="size-14 rounded-lg object-cover border border-slate-100" />
                                    <div>
                                        <p class="font-bold text-slate-800 text-sm"><%# Eval("TenLaptop") %></p>
                                        <div class="flex gap-2 mt-1">
                                            <span class="text-[9px] text-[#0984e3] font-bold bg-blue-50 px-1.5 py-0.5 rounded uppercase"><%# Eval("TenLoai") %></span>
                                            <span class="text-[10px] text-slate-400 font-medium"><%# Eval("TenHang") %></span>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Cấu hình">
                            <ItemTemplate>
                                <div class="text-[11px] text-slate-600 px-6">
                                    <div><strong>CPU:</strong> <%# Eval("CPU") %></div>
                                    <div><strong>RAM:</strong> <%# Eval("RAM") %></div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Giá & Kho">
                            <ItemTemplate>
                                <div class="px-6">
                                    <p class="font-black text-slate-800 text-sm"><%# String.Format("{0:N0}", Eval("Gia")) %>đ</p>
                                    <span class='<%# Convert.ToInt32(Eval("SoLuong")) <= 5 ? "text-red-500" : "text-emerald-600" %> text-[10px] font-bold'>Kho: <%# Eval("SoLuong") %>
                                    </span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Thao tác" ItemStyle-CssClass="text-center px-6">
                            <ItemTemplate>
                                <div class="flex justify-center gap-2">
                                    <a href='<%# "SuaLaptop.aspx?id=" + Eval("MaLaptop") %>' class="text-slate-400 hover:text-blue-500"><span class="material-symbols-outlined">edit_note</span></a>
                                    <asp:LinkButton ID="lbtnDelete" runat="server" CommandName="Delete" OnClientClick="return confirm('Xác nhận xóa laptop này?');" CssClass="text-slate-400 hover:text-red-500">
                                        <span class="material-symbols-outlined">delete_sweep</span>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

