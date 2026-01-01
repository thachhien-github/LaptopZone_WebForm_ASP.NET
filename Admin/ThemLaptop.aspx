<%@ Page Title="Thêm Laptop Mới" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ThemLaptop.aspx.cs" Inherits="LaptopZone_project.Admin.ThemLaptop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-fade-in {
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(15px);
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

        .input-focus-ring:focus {
            background-color: white;
            border-color: #0984e3;
            box-shadow: 0 0 0 4px rgba(9, 132, 227, 0.08);
            outline: none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="max-w-6xl mx-auto p-4 md:p-6 space-y-8 page-fade-in">

        <%-- Header Action Bar --%>
        <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-6">
            <div>
                <h2 class="text-3xl font-black text-[#2d3436] tracking-tight">Thêm sản phẩm mới</h2>
                <p class="text-slate-400 font-bold text-[13px] uppercase tracking-wider mt-1">Khởi tạo thiết bị vào hệ thống kho</p>
            </div>
            <div class="flex gap-3">
                <a href="QuanLyLaptop.aspx" class="inline-flex items-center justify-center px-6 py-2.5 rounded-xl text-sm font-bold text-slate-500 hover:bg-slate-100 transition-all">Hủy bỏ
                </a>
                <asp:LinkButton ID="btnSave" runat="server" OnClick="btnAdd_Click"
                    CssClass="inline-flex items-center justify-center gap-2 bg-[#0984e3] hover:bg-[#0873c4] text-white px-8 py-2.5 rounded-xl text-sm font-black shadow-lg shadow-blue-100 transition-all">
                    <span class="material-symbols-outlined text-[20px]">add_circle</span>
                    Đăng sản phẩm
                </asp:LinkButton>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <div class="lg:col-span-2 space-y-8">

                <%-- Section 1: Thông tin cơ bản --%>
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
                            <asp:TextBox ID="txtTenLaptop" runat="server" placeholder="VD: ASUS ROG Zephyrus G14 (2024)..."
                                CssClass="block w-full rounded-2xl border-none py-4 px-5 bg-slate-50 text-slate-700 font-bold input-focus-ring transition-all"></asp:TextBox>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <div class="p-4 bg-emerald-50 rounded-2xl border border-emerald-100/50">
                                <label class="block text-[10px] font-black text-emerald-500 uppercase tracking-widest mb-1.5">Giá bán niêm yết (VNĐ)</label>
                                <asp:TextBox ID="txtGia" runat="server" TextMode="Number" placeholder="0"
                                    CssClass="block w-full bg-transparent border-none p-0 text-xl font-black text-emerald-600 focus:ring-0"></asp:TextBox>
                            </div>
                            <div class="p-4 bg-slate-50 rounded-2xl border border-slate-100">
                                <label class="block text-[10px] font-black text-slate-400 uppercase tracking-widest mb-1.5">Số lượng nhập kho ban đầu</label>
                                <asp:TextBox ID="txtSoLuong" runat="server" TextMode="Number" placeholder="10"
                                    CssClass="block w-full bg-transparent border-none p-0 text-xl font-black text-slate-700 focus:ring-0"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Section 2: Thông số kỹ thuật --%>
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
                            <asp:TextBox ID="txtCPU" runat="server" placeholder="VD: Apple M3 Chip" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-600 font-medium input-focus-ring transition-all"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Dung lượng RAM</label>
                            <asp:TextBox ID="txtRAM" runat="server" placeholder="VD: 16GB LPDDR5X" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-600 font-medium input-focus-ring transition-all"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Lưu trữ (SSD/HDD)</label>
                            <asp:TextBox ID="txtOCung" runat="server" placeholder="VD: 1TB NVMe Gen4" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-600 font-medium input-focus-ring transition-all"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Công nghệ màn hình</label>
                            <asp:TextBox ID="txtManHinh" runat="server" placeholder="VD: 14.2 inch Liquid Retina" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-600 font-medium input-focus-ring transition-all"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Xử lý đồ họa (VGA)</label>
                            <asp:TextBox ID="txtVGA" runat="server" placeholder="VD: 10-core GPU" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-600 font-medium input-focus-ring transition-all"></asp:TextBox>
                        </div>
                        <div>
                            <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Hệ điều hành đi kèm</label>
                            <asp:TextBox ID="txtHDH" runat="server" placeholder="VD: macOS / Windows 11" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-600 font-medium input-focus-ring transition-all"></asp:TextBox>
                        </div>
                    </div>

                    <div class="mt-8">
                        <label class="block text-[11px] font-black text-slate-400 uppercase tracking-widest mb-2 ml-1">Mô tả sản phẩm (Marketing)</label>
                        <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" Rows="5"
                            placeholder="Nhập những điểm nổi bật nhất để thu hút khách hàng..."
                            CssClass="block w-full rounded-2xl border-none py-4 px-5 bg-slate-50 text-slate-600 font-medium input-focus-ring transition-all leading-relaxed"></asp:TextBox>
                    </div>
                </div>
            </div>

            <%-- Right Column: Side Controls --%>
            <div class="space-y-8">
                <%-- Phân loại --%>
                <div class="bg-white rounded-[2rem] shadow-sm border border-slate-100 p-8">
                    <h3 class="text-[11px] font-black text-slate-400 uppercase tracking-[0.2em] mb-6">Phân loại hàng hóa</h3>
                    <div class="space-y-6">
                        <div>
                            <label class="block text-[10px] font-black text-slate-400 uppercase mb-2 ml-1">Thương hiệu</label>
                            <asp:DropDownList ID="ddlHang" runat="server" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-700 font-bold custom-select input-focus-ring cursor-pointer"></asp:DropDownList>
                        </div>
                        <div>
                            <label class="block text-[10px] font-black text-slate-400 uppercase mb-2 ml-1">Danh mục sản phẩm</label>
                            <asp:DropDownList ID="ddlLoai" runat="server" CssClass="block w-full rounded-2xl border-none py-3.5 px-5 bg-slate-50 text-slate-700 font-bold custom-select input-focus-ring cursor-pointer"></asp:DropDownList>
                        </div>
                    </div>
                </div>

                <%-- Upload Ảnh --%>
                <div class="bg-white rounded-[2rem] shadow-sm border border-slate-100 p-8">
                    <h3 class="text-[11px] font-black text-slate-400 uppercase tracking-[0.2em] mb-6">Hình ảnh đại diện</h3>

                    <div class="group relative aspect-[4/3] rounded-[1.5rem] bg-slate-50 border-2 border-dashed border-slate-200 flex items-center justify-center overflow-hidden mb-6 transition-all hover:border-[#0984e3]/30">
                        <img id="imgPreview" src="../Images/no-image.png" class="max-h-full max-w-full object-contain p-4 transition-transform duration-500 group-hover:scale-105" />

                        <div class="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                            <span class="text-white text-[10px] font-black uppercase tracking-widest px-4 py-2 bg-white/20 backdrop-blur-md rounded-full border border-white/30">Chọn tệp tin</span>
                        </div>
                        <asp:FileUpload ID="fuAnhBia" runat="server" onchange="previewImage(this);" CssClass="absolute inset-0 opacity-0 cursor-pointer z-10" />
                    </div>

                    <div class="space-y-3">
                        <div class="flex items-start gap-2 text-slate-400">
                            <span class="material-symbols-outlined text-[16px] mt-0.5">check_circle</span>
                            <p class="text-[10px] font-bold leading-tight uppercase">Định dạng hỗ trợ: JPG, PNG, WEBP</p>
                        </div>
                        <div class="flex items-start gap-2 text-slate-400">
                            <span class="material-symbols-outlined text-[16px] mt-0.5">check_circle</span>
                            <p class="text-[10px] font-bold leading-tight uppercase">Dung lượng tối đa: 5MB</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('imgPreview').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>

