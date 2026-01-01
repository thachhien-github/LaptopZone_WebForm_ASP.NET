<%@ Page Title="Chi tiết Sản Phẩm" Language="C#" MasterPageFile="~/Public/Site.Master" AutoEventWireup="true" CodeBehind="ChiTietLaptop.aspx.cs" Inherits="LaptopZone_project.Public.ChiTietLaptop" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="bg-[#f3f4f6] min-vh-100 pb-5">
        <div class="bg-white border-b border-slate-200 shadow-sm mb-4">
            <div class="container py-2 text-xs text-slate-500 d-flex align-items-center gap-2">
                <a href="Default.aspx" class="text-decoration-none text-slate-500">Trang chủ</a>
                <span class="material-symbols-outlined fs-6">chevron_right</span>
                <span class="text-slate-900 fw-medium">Chi tiết sản phẩm</span>
            </div>
        </div>

        <div class="container">
            <asp:Repeater ID="rptChiTiet" runat="server">
                <ItemTemplate>
                    <div class="row g-4">
                        <div class="col-lg-6">
                            <div class="bg-white rounded-4 p-5 shadow-sm border border-slate-200 text-center position-sticky <%# Convert.ToInt32(Eval("SoLuong")) <= 0 ? "out-of-stock-filter" : "" %>" style="top: 100px;">
                                <img src='<%# "../Images/" + Eval("AnhBia") %>'
                                    class="img-fluid object-fit-contain" style="max-height: 450px;"
                                    alt='<%# Eval("TenLaptop") %>'>

                                <%# Convert.ToInt32(Eval("SoLuong")) <= 0 ? "<div class='badge-sold-out-large'>TẠM HẾT HÀNG</div>" : "" %>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="bg-white rounded-4 p-4 p-md-5 shadow-sm border border-slate-200">
                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="bg-blue-100 text-primary px-3 py-1 rounded-pill fw-bold" style="font-size: 12px;">
                                            <%# Eval("TenHang") %>
                                        </span>
                                        <span class="text-slate-400" style="font-size: 12px;">Mã SP: #<%# Eval("MaLaptop") %></span>
                                    </div>
                                    <span class='<%# Convert.ToInt32(Eval("SoLuong")) > 0 ? "text-success" : "text-danger" %> fw-bold small'>
                                        <%# Convert.ToInt32(Eval("SoLuong")) > 0 ? "● Còn hàng" : "● Hết hàng" %>
                                    </span>
                                </div>

                                <h1 class="fw-bold text-slate-900 mb-3 fs-2"><%# Eval("TenLaptop") %></h1>

                                <div class="d-flex align-items-baseline gap-2 mb-4">
                                    <h2 class="text-primary fw-extrabold fs-1 mb-0" style="color: #2563eb;">
                                        <%# Eval("Gia", "{0:N0}") %> <span class="fs-4">₫</span>
                                    </h2>
                                    <span class="text-slate-400 text-decoration-line-through small">
                                        <%# string.Format("{0:N0}", Convert.ToDouble(Eval("Gia")) * 1.1) %> ₫
                                    </span>
                                    <span class="badge bg-danger">-10%
                                    </span>
                                </div>

                                <div class="bg-slate-50 rounded-4 p-4 mb-4 border border-slate-100">
                                    <h5 class="fw-bold text-slate-800 mb-3 d-flex align-items-center gap-2">
                                        <span class="material-symbols-outlined text-primary">settings_input_component</span>
                                        Cấu hình chi tiết
                                    </h5>
                                    <div class="row g-3">
                                        <div class="col-sm-6">
                                            <div class="d-flex align-items-center gap-2">
                                                <span class="material-symbols-outlined text-slate-400">memory</span>
                                                <div>
                                                    <div class="text-xs text-slate-500">Vi xử lý</div>
                                                    <div class="fw-bold text-slate-700"><%# Eval("CPU") %></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="d-flex align-items-center gap-2">
                                                <span class="material-symbols-outlined text-slate-400">memory_alt</span>
                                                <div>
                                                    <div class="text-xs text-slate-500">Bộ nhớ RAM</div>
                                                    <div class="fw-bold text-slate-700"><%# Eval("RAM") %></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-5">
                                    <h5 class="fw-bold text-slate-800 mb-2">Đặc điểm nổi bật</h5>
                                    <p class="text-slate-600 lh-lg"><%# Eval("MoTa") %></p>
                                </div>

                                <div class="d-flex gap-3">
                                    <asp:LinkButton runat="server" ID="btnAddToCart"
                                        CommandArgument='<%# Eval("MaLaptop") %>'
                                        OnClick="btnAddToCart_Click"
                                        Enabled='<%# Convert.ToInt32(Eval("SoLuong")) > 0 %>'
                                        CssClass='<%# Convert.ToInt32(Eval("SoLuong")) > 0 ? "btn btn-primary flex-grow-1 d-flex align-items-center justify-content-center gap-2 fw-bold rounded-3 py-3 shadow-sm border-0" : "btn btn-secondary flex-grow-1 d-flex align-items-center justify-content-center gap-2 fw-bold rounded-3 py-3 shadow-sm border-0 disabled" %>'
                                        Style='<%# Convert.ToInt32(Eval("SoLuong")) > 0 ? "background: #2563eb;": "background: #94a3b8;" %>'>
                                        <span class="material-symbols-outlined">
                                            <%# Convert.ToInt32(Eval("SoLuong")) > 0 ? "shopping_cart" : "production_quantity_limits" %>
                                        </span>
                                        <%# Convert.ToInt32(Eval("SoLuong")) > 0 ? "THÊM VÀO GIỎ HÀNG" : "TẠM HẾT HÀNG" %>
                                    </asp:LinkButton>

                                    <button type="button" class="btn btn-outline-slate border-slate-200 px-3 rounded-3 hover:bg-slate-50">
                                        <span class="material-symbols-outlined text-slate-500">favorite</span>
                                    </button>
                                </div>

                                <div class="mt-4 p-3 bg-emerald-50 rounded-3 border border-emerald-100 text-emerald-700 d-flex align-items-center gap-2 small">
                                    <span class="material-symbols-outlined fs-5">verified_user</span>
                                    Bảo hành chính hãng 12 tháng - Lỗi 1 đổi 1 trong 30 ngày
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <style>
        /* Các class cũ */
        .text-emerald-700 {
            color: #047857;
        }

        .bg-emerald-50 {
            background-color: #ecfdf5;
        }

        .border-emerald-100 {
            border-color: #d1fae5;
        }

        .bg-slate-50 {
            background-color: #f8fafc;
        }

        .text-slate-400 {
            color: #94a3b8;
        }

        .text-slate-600 {
            color: #475569;
        }

        .border-slate-200 {
            border-color: #e2e8f0;
        }

        .btn-outline-slate {
            border: 1px solid #e2e8f0;
            background: white;
        }

            .btn-outline-slate:hover {
                background: #f8fafc;
            }

        /* Style mới cho trường hợp hết hàng */
        .out-of-stock-filter {
            filter: grayscale(0.6);
            opacity: 0.8;
        }

        .badge-sold-out-large {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-10deg);
            background: rgba(30, 41, 59, 0.9);
            color: white;
            padding: 10px 30px;
            font-weight: 800;
            border-radius: 8px;
            border: 3px solid white;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            z-index: 10;
            pointer-events: none;
        }

        .btn.disabled {
            cursor: not-allowed;
            pointer-events: none;
        }
    </style>
</asp:Content>

