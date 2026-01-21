<%@ Page Title="Giỏ Hàng" Language="C#" MasterPageFile="~/Public/Site.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="LaptopZone_project.Public.GioHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="bg-[#f3f4f6] min-h-screen pb-12">
        <div class="bg-white border-b border-slate-200 shadow-sm">
            <div class="container py-2 text-xs text-slate-500 d-flex align-items-center gap-2">
                <a href="Default.aspx" class="text-decoration-none text-slate-500">Trang chủ</a>
                <span class="material-symbols-outlined fs-6">chevron_right</span>
                <span class="text-slate-900 fw-medium">Giỏ hàng</span>
            </div>
        </div>

        <div class="container py-8">
            <asp:UpdatePanel ID="upCart" runat="server">
                <ContentTemplate>
                    <h1 class="fs-2 fw-extrabold text-slate-900 mb-4 d-flex align-items-baseline gap-2">Giỏ hàng <span class="fs-6 fw-normal text-slate-500">(<asp:Literal ID="ltrCount" runat="server">0</asp:Literal>
                        sản phẩm)</span>
                    </h1>

                    <asp:PlaceHolder ID="phEmptyCart" runat="server" Visible="false">
                        <div class="flex flex-col items-center justify-center py-20 text-center">
                            <span class="material-symbols-outlined text-slate-300 mb-4" style="font-size: 120px;">shopping_cart_off</span>
                            <h2 class="fs-3 fw-bold text-slate-900 mb-2">Giỏ hàng trống</h2>
                            <p class="text-slate-500 mb-4">Bạn chưa thêm sản phẩm nào vào giỏ hàng.</p>
                            <a href="Default.aspx" class="btn btn-primary px-4 py-2 rounded-3 fw-bold">Tiếp tục mua sắm</a>
                        </div>
                    </asp:PlaceHolder>

                    <asp:PlaceHolder ID="phCartContent" runat="server">
                        <div class="row g-4">
                            <div class="col-lg-8">
                                <div class="bg-white rounded-4 shadow-sm border border-slate-200 overflow-hidden">
                                    <div class="table-responsive">
                                        <table class="table mb-0 align-middle">
                                            <thead class="bg-light border-bottom">
                                                <tr>
                                                    <th class="px-4 py-3 text-uppercase text-secondary fs-xs fw-bold">Sản phẩm</th>
                                                    <th class="px-4 py-3 text-uppercase text-secondary fs-xs fw-bold">Đơn giá</th>
                                                    <th class="px-4 py-3 text-uppercase text-secondary fs-xs fw-bold">Số lượng</th>
                                                    <th class="px-4 py-3 text-uppercase text-secondary fs-xs fw-bold">Thành tiền</th>
                                                    <th class="px-4 py-3 text-center text-uppercase text-secondary fs-xs fw-bold">Xóa</th>
                                                </tr>
                                            </thead>
                                            <tbody class="divide-y">
                                                <asp:Repeater ID="rptGioHang" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td class="px-4 py-4">
                                                                <div class="d-flex align-items-center gap-3">
                                                                    <div class="border rounded-3 p-1 bg-white shadow-sm" style="width: 64px; height: 64px;">
                                                                        <img src='<%# "../Images/" + Eval("AnhBia") %>' class="img-fluid h-100 w-100 object-fit-contain" />
                                                                    </div>
                                                                    <div>
                                                                        <a href='ChiTietLaptop.aspx?MaLaptop=<%# Eval("MaLaptop") %>' class="text-decoration-none text-slate-900 fw-bold d-block line-clamp-1"><%# Eval("TenLaptop") %></a>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="px-4 py-4 fw-medium"><%# Eval("Gia", "{0:N0}") %>₫</td>
                                                            <td class="px-4 py-4">
                                                                <div class="input-group input-group-sm" style="width: 110px;">
                                                                    <asp:LinkButton runat="server" CommandArgument='<%# Eval("MaLaptop") %>' OnClick="btnGiam_Click" CssClass="btn btn-outline-secondary border-slate-200">
                                                                        <span class="material-symbols-outlined fs-6">remove</span>
                                                                    </asp:LinkButton>
                                                                    <asp:TextBox ID="txtSoLuong" runat="server" Text='<%# Eval("SoLuong") %>' AutoPostBack="true" OnTextChanged="txtSoLuong_TextChanged"
                                                                        CssClass="form-control text-center fw-bold border-slate-200" Style="width: 40px;"></asp:TextBox>
                                                                    <asp:LinkButton runat="server" CommandArgument='<%# Eval("MaLaptop") %>' OnClick="btnTang_Click" CssClass="btn btn-outline-secondary border-slate-200">
                                                                        <span class="material-symbols-outlined fs-6">add</span>
                                                                    </asp:LinkButton>
                                                                </div>
                                                            </td>
                                                            <td class="px-4 py-4 fw-bold text-primary"><%# Eval("ThanhTien", "{0:N0}") %>₫</td>
                                                            <td class="px-4 py-4 text-center">
                                                                <asp:LinkButton runat="server" CommandArgument='<%# Eval("MaLaptop") %>' OnClick="btnXoa_Click"
                                                                    CssClass="text-slate-400 hover-text-danger p-2 rounded-circle" OnClientClick="return confirm('Bạn muốn xóa sản phẩm này?');">
                                                                    <span class="material-symbols-outlined">delete</span>
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="bg-light p-3">
                                        <a href="Default.aspx" class="text-decoration-none text-primary fw-bold d-flex align-items-center gap-1 fs-sm">
                                            <span class="material-symbols-outlined fs-6">arrow_back</span> Tiếp tục mua sắm
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-4">
                                <div class="bg-white rounded-4 shadow-lg border border-slate-200 p-4 sticky-top" style="top: 100px;">
                                    <h2 class="fs-5 fw-bold text-slate-900 mb-4">Tổng quan đơn hàng</h2>
                                    <div class="d-flex flex-column gap-3 pb-4 border-bottom">
                                        <div class="d-flex justify-content-between text-slate-500 fs-sm">
                                            <span>Tạm tính</span>
                                            <span class="text-slate-900 fw-medium">
                                                <asp:Literal ID="ltrTamTinh" runat="server"></asp:Literal>₫</span>
                                        </div>
                                        <div class="d-flex justify-content-between text-slate-500 fs-sm">
                                            <span>VAT (10%)</span>
                                            <span class="text-slate-900 fw-medium">
                                                <asp:Literal ID="ltrVAT" runat="server"></asp:Literal>₫</span>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <span class="text-slate-500 fs-sm">Vận chuyển</span>
                                            <span class="text-success fw-bold fs-sm">Miễn phí</span>
                                        </div>
                                    </div>
                                    <div class="py-4 d-flex justify-content-between align-items-end">
                                        <span class="fw-bold text-slate-900">Tổng cộng</span>
                                        <div class="text-end">
                                            <div class="fs-3 fw-black text-primary tracking-tight">
                                                <asp:Literal ID="ltrTongCong" runat="server"></asp:Literal>₫
                                            </div>
                                            <div class="text-slate-400" style="font-size: 10px;">Đã bao gồm VAT</div>
                                        </div>
                                    </div>

                                    <div class="input-group mb-4">
                                        <input type="text" class="form-control border-slate-200 fs-sm" placeholder="Mã giảm giá">
                                        <button class="btn btn-outline-primary fw-bold text-uppercase fs-xs" type="button">Áp dụng</button>
                                    </div>

                                    <asp:LinkButton ID="btnThanhToan" runat="server" OnClick="btnThanhToan_Click"
                                        CssClass="btn btn-primary w-100 py-3 rounded-3 fw-bold shadow-lg d-flex align-items-center justify-content-center gap-2 group mb-3">
                                        Thanh toán ngay <span class="material-symbols-outlined fs-5 group-hover-translate-x">arrow_forward</span>
                                    </asp:LinkButton>

                                    <div class="text-center">
                                        <div class="d-flex align-items-center justify-content-center gap-1 text-slate-400 fs-xs mb-2">
                                            <span class="material-symbols-outlined fs-6">lock</span> Bảo mật thanh toán SSL
                                        </div>
                                        <div class="d-flex justify-content-center gap-2 opacity-50">
                                            <img src="https://img.icons8.com/color/48/visa.png" width="30" />
                                            <img src="https://img.icons8.com/color/48/mastercard.png" width="30" />
                                            <img src="https://img.icons8.com/color/48/momo.png" width="30" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:PlaceHolder>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upCart">
                <ProgressTemplate>
                    <div style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(255,255,255,0.5); z-index: 9999; display: flex; align-items: center; justify-content: center;">
                        <div class="spinner-border text-primary" role="status"></div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </div>
    </div>

    <style>
        /* Các style giữ nguyên như cũ */
        .fs-xs {
            font-size: 0.75rem;
        }

        .fs-sm {
            font-size: 0.875rem;
        }

        .fw-extrabold {
            font-weight: 800;
        }

        .fw-black {
            font-weight: 900;
        }

        .hover-text-danger:hover {
            color: #ef4444 !important;
            background-color: #fef2f2;
        }

        .line-clamp-1 {
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .group:hover .group-hover-translate-x {
            transform: translateX(4px);
            transition: transform 0.2s;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        function updateMasterCartCount(newCount) {
            // Tìm thẻ span có id là 'cart-count' ở trang Master
            var cartBadge = document.getElementById('cart-count');
            if (cartBadge) {
                cartBadge.innerText = newCount;
            }
        }
    </script>
</asp:Content>
