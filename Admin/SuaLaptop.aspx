<%@ Page Title="Chỉnh sửa Laptop" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="SuaLaptop.aspx.cs" Inherits="LaptopZone_project.Admin.SuaLaptop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-fade-in {
            animation: fadeIn 0.4s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .custom-select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%2394a3b8' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            background-size: 1.2em 1.2em;
        }

        .input-focus-effect:focus {
            background-color: white;
            border-color: #0984e3;
            box-shadow: 0 0 0 4px rgba(9, 132, 227, 0.1);
            outline: none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="max-w-6xl mx-auto p-4 md:p-6 space-y-8 page-fade-in">

        <%-- Header Section --%>
        <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-6">
            <div>
                <h2 class="text-3xl font-black text-[#2d3436] tracking-tight">Cấu hình sản phẩm</h2>
                <div class="flex items-center gap-2 text-[13px] text-slate-400 font-bold uppercase tracking-wider mt-1">
                    <span>Kho hàng</span>
                    <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                    <span class="text-[#0984e3]">Chỉnh sửa Laptop</span>
                </div>
            </div>
            <div class="flex gap-3">
                <a href="QuanLyLaptop.aspx" class="inline-flex items-center justify-center px-6 py-2.5 rounded-xl text-sm font-bold text-slate-500 hover:bg-slate-100 transition-all">Hủy bỏ
                </a>
                <asp:LinkButton ID="btnSave" runat="server" OnClick="btnSave_Click"
                    CssClass="inline-flex items-center justify-center gap-2 bg-[#0984e3] hover:bg-[#0873c4] text-white px-8 py-2.5 rounded-xl text-sm font-black shadow-lg shadow-blue-100 transition-all">
                    <span class="material-symbols-outlined text-[20px]">check_circle</span>
                    Cập Nhật Ngay
                </asp:LinkButton>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <%-- Left Column: Main Info --%>
            <div class="lg:col-span-2 space-y-8">

                <%-- Thông tin cơ bản --%>
                <div class="bg-white rounded-[2rem] shadow-sm border border-slate-100 p-8">
                    <div class="flex items-center gap-3 mb-8">
                        <div class="size-10 bg-blue-50 text-[#0984e3] rounded-xl flex items-center justify-center">
                            <span class="material-symbols-outlined">edit_note</span>
                        </div>
                        <h3 class="text-lg font-black text-[#2d3436]">Thông tin định danh</h3>
                    </div>

                    <div class="space-y-6">
                        <div>
                            <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Tên Laptop Thương Mại</label>
                            <asp:TextBox ID="txtTenLaptop" runat="server" placeholder="Ví dụ: MacBook Pro M2 2023..."
                                CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-700 font-bold input-focus-effect transition-all"></asp:TextBox>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div>
                                <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Hãng sản xuất</label>
                                <asp:DropDownList ID="ddlHang" runat="server" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-700 font-bold custom-select input-focus-effect cursor-pointer"></asp:DropDownList>
                            </div>
                            <div>
                                <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Phân khúc / Loại</label>
                                <asp:DropDownList ID="ddlLoai" runat="server" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-700 font-bold custom-select input-focus-effect cursor-pointer"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Thông số kỹ thuật --%>
                <div class="bg-white rounded-[2rem] shadow-sm border border-slate-100 p-8">
                    <div class="flex items-center gap-3 mb-8">
                        <div class="size-10 bg-purple-50 text-purple-600 rounded-xl flex items-center justify-center">
                            <span class="material-symbols-outlined">settings_input_component</span>
                        </div>
                        <h3 class="text-lg font-black text-[#2d3436]">Thông số kỹ thuật</h3>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-x-8 gap-y-6">
                        <div>
                            <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Bộ vi xử lý (CPU)</label>
                            <asp:TextBox ID="txtCPU" runat="server" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-600 font-medium input-focus-effect transition-all"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Bộ nhớ (RAM)</label>
                            <asp:TextBox ID="txtRAM" runat="server" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-600 font-medium input-focus-effect transition-all"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Lưu trữ (SSD/HDD)</label>
                            <asp:TextBox ID="txtOCung" runat="server" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-600 font-medium input-focus-effect transition-all"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Kích thước màn hình</label>
                            <asp:TextBox ID="txtManHinh" runat="server" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-600 font-medium input-focus-effect transition-all"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Đồ họa (VGA)</label>
                            <asp:TextBox ID="txtVGA" runat="server" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-600 font-medium input-focus-effect transition-all"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Hệ điều hành</label>
                            <asp:TextBox ID="txtHDH" runat="server" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-600 font-medium input-focus-effect transition-all"></asp:TextBox>
                        </div>
                    </div>

                    <div class="mt-8">
                        <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Mô tả đặc điểm nổi bật</label>
                        <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" Rows="5"
                            CssClass="block w-full rounded-2xl border-none py-4 px-5 bg-slate-50 text-slate-600 font-medium input-focus-effect transition-all leading-relaxed"></asp:TextBox>
                    </div>
                </div>
            </div>

            <%-- Right Column: Side Info --%>
            <div class="space-y-8">
                <%-- Giá và Kho --%>
                <div class="bg-white rounded-[2rem] shadow-sm border border-slate-100 p-8">
                    <h3 class="text-[11px] font-black text-slate-400 uppercase tracking-[0.2em] mb-6">Thương mại & Tồn kho</h3>
                    <div class="space-y-6">
                        <div class="p-4 bg-rose-50 rounded-2xl border border-rose-100/50">
                            <label class="block text-[10px] font-black text-rose-400 uppercase tracking-widest mb-1.5">Giá niêm yết (VNĐ)</label>
                            <asp:TextBox ID="txtGia" runat="server" TextMode="Number"
                                CssClass="block w-full bg-transparent border-none p-0 text-2xl font-black text-rose-600 focus:ring-0"></asp:TextBox>
                        </div>
                        <div class="p-4 bg-slate-50 rounded-2xl border border-slate-100">
                            <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1.5">Số lượng tồn kho</label>
                            <asp:TextBox ID="txtSoLuong" runat="server" TextMode="Number"
                                CssClass="block w-full bg-transparent border-none p-0 text-xl font-black text-slate-700 focus:ring-0"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <%-- Hình ảnh --%>
                <div class="bg-white rounded-[2rem] shadow-sm border border-slate-100 p-8">
                    <h3 class="text-[11px] font-black text-slate-400 uppercase tracking-[0.2em] mb-6">Hình ảnh đại diện</h3>

                    <div class="group relative aspect-square rounded-[1.5rem] bg-slate-50 border-2 border-dashed border-slate-200 flex items-center justify-center overflow-hidden mb-6 transition-all hover:border-[#0984e3]/30">
                        <asp:Image ID="imgHienTai" runat="server" CssClass="max-h-full max-w-full object-contain p-4 transition-transform duration-500 group-hover:scale-105" />

                        <div class="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                            <span class="text-white text-xs font-bold px-4 py-2 bg-white/20 backdrop-blur-md rounded-full border border-white/30">Thay đổi ảnh</span>
                        </div>
                    </div>

                    <asp:HiddenField ID="hfAnhCu" runat="server" />

                    <div class="relative">
                        <asp:FileUpload ID="fuAnhBia" runat="server" onchange="previewImage(this);"
                            CssClass="block w-full text-[11px] text-slate-500 
                            file:mr-4 file:py-2.5 file:px-6 file:rounded-xl file:border-0 
                            file:text-xs file:font-black file:uppercase file:tracking-widest
                            file:bg-[#0984e3] file:text-white hover:file:bg-[#0873c4] cursor-pointer" />
                    </div>

                    <p class="text-[10px] text-slate-400 font-bold mt-4 flex items-center gap-1">
                        <span class="material-symbols-outlined text-[14px]">info</span>
                        Hỗ trợ định dạng: JPG, PNG, WEBP (Tối đa 2MB)
                    </p>
                </div>
            </div>
        </div>
    </div>

    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('<%= imgHienTai.ClientID %>').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>

