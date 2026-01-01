<%@ Page Title="Đổi Mật Khẩu Admin" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="DoiMatKhauAdmin.aspx.cs" Inherits="LaptopZone_project.Admin.DoiMatKhauAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%-- Container chính với tỉ lệ thu nhỏ --%>
    <div class="max-w-[420px] mx-auto mt-10 p-8 bg-white rounded-[2.2rem] shadow-2xl shadow-slate-200/60 border border-slate-50 transition-all hover:shadow-blue-50/50">
        
        <%-- Header Section (Thu nhỏ icon và text) --%>
        <div class="text-center mb-8">
            <div class="size-16 bg-blue-50 text-[#0984e3] rounded-[1.8rem] flex items-center justify-center mx-auto mb-4 shadow-sm">
                <span class="material-symbols-outlined text-3xl">lock_reset</span>
            </div>
            <h2 class="text-2xl font-black text-slate-800 tracking-tight">Cài đặt mật khẩu</h2>
            <p class="text-slate-400 font-bold text-[10px] uppercase tracking-widest mt-1.5">LAPTOP<span class="text-[#0984e3]">ZONE</span> SECURITY</p>
        </div>

        <%-- Form Section (Khoảng cách space-y giảm từ 6 xuống 4) --%>
        <div class="space-y-4">
            <%-- Mật khẩu cũ --%>
            <div class="group bg-slate-50/80 p-3.5 rounded-xl border border-transparent focus-within:border-blue-200 focus-within:bg-white transition-all">
                <label class="text-[9px] font-black text-slate-400 uppercase tracking-widest block mb-1 px-1">Mật khẩu cũ</label>
                <div class="flex items-center gap-2.5">
                    <span class="material-symbols-outlined text-slate-300 text-lg group-focus-within:text-[#0984e3]">password</span>
                    <asp:TextBox ID="txtOldPass" runat="server" TextMode="Password" placeholder="••••••••"
                        CssClass="w-full bg-transparent border-none p-0 focus:ring-0 text-sm font-bold text-slate-700 outline-none" />
                </div>
            </div>
            
            <%-- Mật khẩu mới --%>
            <div class="group bg-slate-50/80 p-3.5 rounded-xl border border-transparent focus-within:border-blue-200 focus-within:bg-white transition-all">
                <label class="text-[9px] font-black text-slate-400 uppercase tracking-widest block mb-1 px-1">Mật khẩu mới</label>
                <div class="flex items-center gap-2.5">
                    <span class="material-symbols-outlined text-slate-300 text-lg group-focus-within:text-[#0984e3]">lock_open</span>
                    <asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" placeholder="Mật khẩu mới"
                        CssClass="w-full bg-transparent border-none p-0 focus:ring-0 text-sm font-bold text-slate-700 outline-none" />
                </div>
            </div>

            <%-- Xác nhận --%>
            <div class="group bg-slate-50/80 p-3.5 rounded-xl border border-transparent focus-within:border-blue-200 focus-within:bg-white transition-all">
                <label class="text-[9px] font-black text-slate-400 uppercase tracking-widest block mb-1 px-1">Xác nhận lại</label>
                <div class="flex items-center gap-2.5">
                    <span class="material-symbols-outlined text-slate-300 text-lg group-focus-within:text-[#0984e3]">verified_user</span>
                    <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" placeholder="Nhập lại mật khẩu"
                        CssClass="w-full bg-transparent border-none p-0 focus:ring-0 text-sm font-bold text-slate-700 outline-none" />
                </div>
            </div>

            <%-- Nút bấm (Thu nhỏ padding) --%>
            <div class="pt-3">
                <asp:Button ID="btnChangePass" runat="server" Text="CẬP NHẬT MẬT KHẨU" OnClick="btnChangePass_Click"
                    CssClass="w-full bg-[#0984e3] hover:bg-[#0873c4] text-white font-black py-3.5 rounded-xl transition-all shadow-md shadow-blue-100 cursor-pointer active:scale-95 text-xs tracking-wider" />
            </div>

            <div class="text-center mt-2">
                <a href="DashboardAdmin.aspx" class="text-[10px] font-bold text-slate-300 hover:text-slate-500 transition-colors uppercase tracking-tighter">
                    Huỷ bỏ và quay lại
                </a>
            </div>
        </div>
    </div>
</asp:Content>
