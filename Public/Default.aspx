<%@ Page Title="LaptopZone - trang chủ" Language="C#" MasterPageFile="~/Public/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LaptopZone_project.Public.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4 mb-2">
        <div id="heroCarousel" class="carousel slide shadow-sm rounded-4 overflow-hidden" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active" style="height: 400px;">
                    <img src="https://images.unsplash.com/photo-1603302576837-37561b2e2302?q=80&w=2068&auto=format&fit=crop" class="d-block w-100 h-100 object-fit-cover" alt="Gaming Laptop">
                    <div class="carousel-caption d-none d-md-block text-start" style="bottom: 20%; left: 8%;">
                        <span class="badge bg-danger mb-2 px-3 py-2 rounded-pill">GAMING REVOLUTION</span>
                        <h2 class="display-5 fw-bold text-white shadow-sm" style="font-family: 'Montserrat', sans-serif;">ĐẲNG CẤP GAMING</h2>
                        <p class="fs-5">Chiến game cực đỉnh với RTX 40-Series mới nhất.</p>
                        <a href="LaptopTheoLoai.aspx?MaLoai=1" class="btn btn-primary btn-lg rounded-3 fw-bold px-4 mt-2 border-0" style="background: #2563eb;">Sắm Ngay</a>
                    </div>
                </div>
                <div class="carousel-item" style="height: 400px;">
                    <img src="https://images.unsplash.com/photo-1517336714731-489689fd1ca8?q=80&w=1926&auto=format&fit=crop" class="d-block w-100 h-100 object-fit-cover" alt="Macbook">
                    <div class="carousel-caption d-none d-md-block text-end" style="bottom: 20%; right: 8%;">
                        <h2 class="display-5 fw-bold text-dark">MACBOOK M3 PRO</h2>
                        <asp:CheckBoxList ID="CheckBoxList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"
                            CssClass="custom-checkbox-list" RepeatLayout="UnorderedList">
                        </asp:CheckBoxList>
                        <p class="fs-5 text-secondary">Thiết kế mỏng nhẹ, hiệu năng không giới hạn.</p>
                        <button class="btn btn-dark btn-lg rounded-3 px-5">Tìm hiểu thêm</button>
                    </div>
                </div>
                <div class="carousel-item" style="height: 400px;">
                    <img src="https://images.unsplash.com/photo-1496181133206-80ce9b88a853?q=80&w=2071&auto=format&fit=crop" class="d-block w-100 h-100 object-fit-cover" alt="Workstation">
                    <div class="carousel-caption d-none d-md-block" style="bottom: 25%;">
                        <h2 class="display-4 fw-bold">GIẢM ĐẾN 30%</h2>
                        <p class="fs-5">Duy nhất tuần lễ vàng - Miễn phí vận chuyển toàn quốc.</p>
                        <button class="btn btn-warning btn-lg rounded-3 px-5 fw-bold">Săn Sale Ngay</button>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
            </button>
        </div>
    </div>
    <div class="bg-[#f3f4f6] min-h-screen pb-12">
        <div class="bg-white border-b border-slate-200 shadow-sm">
            <div class="container py-2 text-xs text-slate-500 d-flex align-items-center gap-2">
                <span>Trang chủ</span>
                <span class="material-symbols-outlined fs-6">chevron_right</span>
                <span class="text-slate-900 fw-medium">Laptop chính hãng</span>
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
                            <asp:LinkButton runat="server" ID="btnClearFilter" OnClick="btnClearFilter_Click" CssClass="text-decoration-none text-xs text-slate-500 hover:text-primary">Xóa tất cả</asp:LinkButton>
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

                            <asp:Button ID="btnApply" runat="server" Text="Áp dụng bộ lọc" OnClick="Filter_Changed"
                                CssClass="w-100 py-2 bg-primary border-0 text-white fw-bold rounded-3 shadow-sm mt-3" />
                        </div>
                    </div>
                </aside>

                <div class="col-lg-9 col-md-8">
                    <div class="bg-white rounded-4 p-4 shadow-sm border border-slate-200 mb-4 d-flex justify-content-between align-items-center">
                        <div>
                            <h1 class="fs-4 fw-bold text-slate-900 mb-0">
                                <asp:Literal ID="ltrTitle" runat="server" Text="Laptop Mới Nhất"></asp:Literal>
                            </h1>
                            <p class="text-slate-500 mb-0 mt-1" style="font-size: 13px;">
                                Tìm thấy <span class="fw-bold text-slate-900">
                                    <asp:Literal ID="ltrTotalCount" runat="server" Text="0"></asp:Literal></span> sản phẩm
                            </p>
                        </div>
                        <div class="d-flex align-items-center gap-2 flex-nowrap">
                            <span class="text-muted text-xs text-nowrap">Sắp xếp theo:</span>
                            <asp:DropDownList ID="ddlSort" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed"
                                CssClass="form-select form-select-sm border-slate-200 rounded-3 w-auto py-1">
                                <asp:ListItem Value="new">Mới nhất</asp:ListItem>
                                <asp:ListItem Value="price-asc">Giá thấp đến cao</asp:ListItem>
                                <asp:ListItem Value="price-desc">Giá cao đến thấp</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="row g-3">
                        <asp:Repeater ID="rptLaptops" runat="server">
                            <ItemTemplate>
                                <div class="col-xl-4 col-md-6 mb-4">
                                    <div class="product-card group h-100 position-relative d-flex flex-column bg-white rounded-4 overflow-hidden shadow-sm <%# Convert.ToInt32(Eval("SoLuong")) <= 0 ? "product-sold-out" : "" %>">

                                        <%# Convert.ToInt32(Eval("SoLuong")) <= 0 ? "<div class='sold-out-overlay'><span>HẾT HÀNG</span></div>" : "" %>

                                        <div class="position-absolute top-3 start-3 z-1 d-flex flex-column gap-2" style="top: 15px; left: 15px; pointer-events: none;">
                                            <span class="bg-blue-600 text-white px-2 py-1 rounded-2 fw-bold shadow-sm" style="font-size: 10px; background-color: #2563eb;">MỚI</span>
                                        </div>

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
                                                        <span class="material-symbols-outlined" style="font-size: 16px">memory</span>
                                                        <%# Eval("CPU") %>
                                                    </div>
                                                    <div class="d-flex align-items-center gap-1 bg-slate-50 border border-slate-100 px-2 py-1 rounded-2 text-slate-500" style="font-size: 12px;">
                                                        <span class="material-symbols-outlined" style="font-size: 16px">memory_alt</span>
                                                        <%# Eval("RAM") %>
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
                                <asp:LinkButton runat="server" CssClass='<%# (bool)Eval("Active") ? "btn btn-primary mx-1 rounded-3 fw-bold shadow-sm" : "btn btn-white border mx-1 rounded-3" %>'
                                    Text='<%# Eval("Text") %>' CommandArgument='<%# Eval("Value") %>' OnClick="Page_Changed"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        /* CSS Giữ nguyên như cũ */
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

        .product-image-container img {
            transition: transform 0.6s ease;
        }

        .product-card:hover img {
            transform: scale(1.08);
        }

        /* Lớp phủ khi hết hàng */
        .product-sold-out {
            opacity: 0.7; /* Làm mờ card */
            filter: grayscale(0.4); /* Giảm độ tươi của màu sắc */
            pointer-events: none; /* Ngăn tương tác vào các link bên trong nếu cần */
        }

            /* Kích hoạt lại tương tác cho nút xem chi tiết dù card bị mờ */
            .product-sold-out a, .product-sold-out .p-4 {
                pointer-events: auto;
            }

        .sold-out-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.2);
            z-index: 10;
            display: flex;
            align-items: center;
            justify-content: center;
            pointer-events: none;
        }

            .sold-out-overlay span {
                background: rgba(30, 41, 59, 0.9); /* Màu Slate-800 */
                color: white;
                padding: 8px 20px;
                border-radius: 99px;
                font-weight: 800;
                font-size: 14px;
                letter-spacing: 1px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.2);
                transform: rotate(-5deg);
                border: 2px solid #fff;
            }

        /* Khi hết hàng thì không cho card bay lên khi hover */
        .product-sold-out:hover {
            transform: none !important;
            box-shadow: none !important;
        }

        /* Custom Carousel */
        #heroCarousel .carousel-item {
            transition: transform 0.8s cubic-bezier(0.19, 1, 0.22, 1); /* Chuyển slide mượt hơn */
        }

        #heroCarousel .carousel-caption {
            z-index: 2;
            text-shadow: 0 2px 10px rgba(0,0,0,0.3); /* Giúp chữ nổi bật trên ảnh */
        }

        /* Hiệu ứng zoom nhẹ cho ảnh trong slide */
        #heroCarousel .carousel-item img {
            transition: transform 10s linear;
        }

        #heroCarousel .carousel-item.active img {
            transform: scale(1.1);
        }

        /* Bo góc cho Carousel khớp với bộ lọc và card sản phẩm */
        .rounded-4 {
            border-radius: 1rem !important;
        }
    </style>
</asp:Content>

