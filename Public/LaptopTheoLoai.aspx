<%@ Page Title="LaptopZone - trang chủ" Language="C#" MasterPageFile="~/Public/Site.Master" AutoEventWireup="true" CodeBehind="LaptopTheoLoai.aspx.cs" Inherits="LaptopZone_project.Public.LaptopTheoLoai" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="bg-[#f3f4f6] min-h-screen pb-12">
        <div class="bg-white border-b border-slate-200 shadow-sm">
            <div class="container py-2 text-xs text-slate-500 d-flex align-items-center gap-2">
                <a href="Default.aspx" class="text-decoration-none text-slate-500">Trang chủ</a>
                <span class="material-symbols-outlined fs-6">chevron_right</span>
                <span class="text-slate-900 fw-medium">
                    <asp:Literal ID="ltrBreadcrumb" runat="server"></asp:Literal></span>
            </div>
        </div>

        <div class="container py-4">
            <div class="row g-4">
                <aside class="col-lg-3 col-md-4">
                    <div class="bg-white rounded-4 p-4 shadow-sm border border-slate-200 sticky-top" style="top: 100px; z-index: 10;">
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <h3 class="d-flex align-items-center gap-2 fw-bold text-slate-800 fs-5 mb-0">
                                <span class="material-symbols-outlined text-primary">filter_list</span> Bộ lọc
                            </h3>
                            <asp:LinkButton runat="server" ID="btnClearFilter" OnClick="btnClearFilter_Click" CssClass="text-decoration-none text-xs text-slate-500 hover:text-primary">Xóa lọc</asp:LinkButton>
                        </div>

                        <div class="space-y-4">
                            <div class="mb-4">
                                <h4 class="fw-bold text-sm text-slate-800 mb-3" style="font-size: 14px;">Thương hiệu</h4>
                                <asp:CheckBoxList ID="cblHang" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"
                                    CssClass="custom-checkbox-list" RepeatLayout="UnorderedList">
                                </asp:CheckBoxList>
                            </div>
                            <hr class="border-slate-100" />
                            <div class="mb-4">
                                <h4 class="fw-bold text-sm text-slate-800 mb-3" style="font-size: 14px;">Dung lượng RAM</h4>
                                <asp:RadioButtonList ID="rblRam" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"
                                    RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="ram-selector">
                                    <asp:ListItem Value="8GB">8GB</asp:ListItem>
                                    <asp:ListItem Value="16GB">16GB</asp:ListItem>
                                    <asp:ListItem Value="32GB">32GB</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <asp:Button ID="btnApply" runat="server" Text="Áp dụng" OnClick="Filter_Changed"
                                CssClass="w-100 py-2 bg-primary border-0 text-white fw-bold rounded-3 shadow-sm mt-3" />
                        </div>
                    </div>
                </aside>

                <div class="col-lg-9 col-md-8">
                    <div class="bg-white rounded-4 p-4 shadow-sm border border-slate-200 mb-4 d-flex justify-content-between align-items-center">
                        <div>
                            <h1 class="fs-4 fw-bold text-slate-900 mb-0">
                                <asp:Literal ID="ltrTenLoai" runat="server"></asp:Literal>
                            </h1>
                            <p class="text-slate-500 mb-0 mt-1" style="font-size: 13px;">
                                Tìm thấy <span class="fw-bold text-slate-900">
                                    <asp:Literal ID="ltrTotalCount" runat="server" Text="0"></asp:Literal></span> sản phẩm
                            </p>
                        </div>
                        <div class="d-flex align-items-center gap-2 flex-nowrap">
                            <span class="text-muted text-xs text-nowrap">Sắp xếp:</span>
                            <asp:DropDownList ID="ddlSort" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"
                                CssClass="form-select form-select-sm border-slate-200 rounded-3 w-auto py-1">
                                <asp:ListItem Value="new">Mới nhất</asp:ListItem>
                                <asp:ListItem Value="price-asc">Giá thấp → cao</asp:ListItem>
                                <asp:ListItem Value="price-desc">Giá cao → thấp</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="row g-3">
                        <asp:Repeater ID="rptLaptops" runat="server">
                            <ItemTemplate>
                                <div class="col-xl-4 col-md-6 mb-1">
                                    <div class="product-card group h-100 position-relative d-flex flex-column bg-white rounded-4 overflow-hidden shadow-sm <%# Convert.ToInt32(Eval("SoLuong")) <= 0 ? "product-sold-out" : "" %>">

                                        <%# Convert.ToInt32(Eval("SoLuong")) <= 0 ? "<div class='sold-out-overlay'><span>HẾT HÀNG</span></div>" : "" %>

                                        <a href='ChiTietLaptop.aspx?MaLaptop=<%# Eval("MaLaptop") %>' class="text-decoration-none d-flex flex-column h-100">
                                            <div class="product-image-container p-4 d-block text-center border-bottom border-light">
                                                <img src='<%# "../Images/" + Eval("AnhBia") %>' alt='<%# Eval("TenLaptop") %>'
                                                    class="img-fluid object-fit-contain" style="height: 180px; width: 100%;">
                                            </div>
                                            <div class="p-4 pt-3 d-flex flex-column flex-grow-1">
                                                <h3 class="fw-bold text-slate-900 fs-6 line-clamp-2 mb-2" style="min-height: 44px; color: #1e293b;">
                                                    <%# Eval("TenLaptop") %>
                                                </h3>
                                                <div class="d-flex flex-wrap gap-2 mb-3">
                                                    <div class="d-flex align-items-center gap-1 bg-slate-50 border border-slate-100 px-2 py-1 rounded-2 text-slate-500" style="font-size: 12px;">
                                                        <span class="material-symbols-outlined" style="font-size: 16px">memory</span> <%# Eval("CPU") %>
                                                    </div>
                                                    <div class="d-flex align-items-center gap-1 bg-slate-50 border border-slate-100 px-2 py-1 rounded-2 text-slate-500" style="font-size: 12px;">
                                                        <span class="material-symbols-outlined" style="font-size: 16px">memory_alt</span> <%# Eval("RAM") %>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-column mb-3">
                                                    <!-- Hàng giá mới -->
                                                    <div class="d-flex align-items-baseline gap-1">
                                                        <span class="fw-bold text-primary fs-4" style="color: #2563eb !important;">
                                                            <%# Eval("Gia", "{0:N0}") %>
                                                        </span>
                                                        <span class="text-primary fw-bold" style="font-size: 14px;">₫</span>
                                                    </div>

                                                    <!-- Hàng giá cũ và phần trăm giảm giá -->
                                                    <div class="d-flex align-items-center gap-2">
                                                        <span class="text-muted text-decoration-line-through small">
                                                            <%# string.Format("{0:N0}", Convert.ToDouble(Eval("Gia")) * 1.1) %> ₫
                                                        </span>
                                                        <span class="badge bg-danger">-10%
                                                        </span>
                                                    </div>
                                                </div>

                                            </div>
                                        </a>

                                        <div class="p-4 pt-0 mt-auto">
                                            <div class="d-flex gap-2">
                                                <asp:LinkButton runat="server" ID="btnAddToCart"
                                                    Visible='<%# Convert.ToInt32(Eval("SoLuong")) > 0 %>'
                                                    CommandArgument='<%# Eval("MaLaptop") %>' OnClick="btnAddToCart_Click"
                                                    CssClass="btn btn-primary flex-grow-1 d-flex align-items-center justify-content-center gap-2 fw-bold rounded-3 py-2 shadow-sm border-0" Style="background: #2563eb;">
                            <span class="material-symbols-outlined fs-5">shopping_cart</span> Thêm vào giỏ
                                                </asp:LinkButton>

                                                <a href='ChiTietLaptop.aspx?MaLaptop=<%# Eval("MaLaptop") %>'
                                                    class='<%# Convert.ToInt32(Eval("SoLuong")) <= 0 ? "btn btn-outline-secondary w-100" : "btn btn-outline-slate border-slate-200" %> px-3 py-2 rounded-3 hover:bg-slate-50 transition-colors d-flex align-items-center justify-content-center gap-2'>
                                                    <span class="material-symbols-outlined fs-5">visibility</span>
                                                    <%# Convert.ToInt32(Eval("SoLuong")) <= 0 ? "Xem chi tiết" : "" %>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="d-flex justify-content-center mt-5">
                        <asp:Repeater ID="rptPager" runat="server">
                            <ItemTemplate>
                                <asp:LinkButton runat="server"
                                    CssClass='<%# (bool)Eval("Active") ? "btn btn-primary mx-1 rounded-3 fw-bold shadow-sm" : "btn btn-white border mx-1 rounded-3 text-slate-600" %>'
                                    Text='<%# Eval("Text") %>'
                                    CommandArgument='<%# Eval("Value") %>'
                                    OnClick="Page_Changed">
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .custom-checkbox-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

            .custom-checkbox-list li {
                display: flex;
                align-items: center;
                margin-bottom: 8px;
            }

            .custom-checkbox-list input[type="checkbox"] {
                width: 18px;
                height: 18px;
                cursor: pointer;
            }

            .custom-checkbox-list label {
                font-size: 14px;
                color: #475569;
                cursor: pointer;
                margin-left: 10px;
                font-weight: 500;
            }

        .ram-selector label {
            border: 1px solid #e2e8f0;
            padding: 6px 16px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            background: #f8fafc;
            color: #64748b;
            margin-right: 5px;
        }

        .ram-selector input:checked + label {
            background: #2563eb;
            color: white;
            border-color: #2563eb;
        }

        .ram-selector input {
            display: none;
        }

        .product-card {
            transition: all 0.4s ease;
            border: 1px solid #f1f5f9 !important;
        }

            .product-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05) !important;
            }

                .product-card:hover img {
                    transform: scale(1.08);
                    transition: transform 0.6s ease;
                }
        /* Trạng thái hết hàng */
        .product-sold-out {
            opacity: 0.7;
            filter: grayscale(0.5);
        }

        .sold-out-overlay {
            position: absolute;
            inset: 0;
            background: rgba(255, 255, 255, 0.1);
            z-index: 10;
            display: flex;
            align-items: center;
            justify-content: center;
            pointer-events: none;
        }

            .sold-out-overlay span {
                background: #1e293b;
                color: white;
                padding: 6px 16px;
                border-radius: 50px;
                font-weight: 800;
                font-size: 12px;
                transform: rotate(-5deg);
                border: 2px solid white;
                box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            }

        /* Vô hiệu hóa hover khi hết hàng */
        .product-sold-out:hover {
            transform: none !important;
        }
    </style>
</asp:Content>

