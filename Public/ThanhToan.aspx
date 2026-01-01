<%@ Page Title="Thanh Toán" Language="C#" MasterPageFile="~/Public/Site.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="LaptopZone_project.Public.ThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <main class="bg-light min-vh-100 py-5">
        <div class="container max-w-7xl">
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="d-flex gap-2 mb-4 text-sm px-1">
                        <a href="GioHang.aspx" class="text-secondary text-decoration-none fw-medium">Giỏ hàng</a>
                        <span class="text-muted">/</span>
                        <span class="text-primary fw-bold">Thanh toán</span>
                        <span class="text-muted">/</span>
                        <span class="text-muted">Hoàn tất</span>
                    </div>

                    <section class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
                        <div class="card-header bg-white border-bottom py-3 px-4">
                            <h2 class="h5 fw-bold mb-0 d-flex align-items-center gap-2">
                                <span class="material-symbols-outlined text-primary">local_shipping</span>
                                Thông tin giao hàng
                            </h2>
                        </div>
                        <div class="card-body p-4">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary fs-sm">Họ và tên <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control py-2 px-3" placeholder="Nguyễn Văn A"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvHoTen" runat="server" ControlToValidate="txtHoTen" Display="Dynamic" ErrorMessage="Vui lòng nhập họ tên" CssClass="text-danger fs-xs"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary fs-sm">Số điện thoại <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control py-2 px-3" placeholder="09xx xxx xxx"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvSDT" runat="server" ControlToValidate="txtSDT" Display="Dynamic" ErrorMessage="Nhập số điện thoại" CssClass="text-danger fs-xs"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-12">
                                    <label class="form-label fw-bold text-secondary fs-sm">Địa chỉ cụ thể <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control py-2 px-3" placeholder="Số nhà, tên đường, phường/xã..."></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDiaChi" runat="server" ControlToValidate="txtDiaChi" Display="Dynamic" ErrorMessage="Nhập địa chỉ giao hàng" CssClass="text-danger fs-xs"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary fs-sm">Ngày giao dự kiến <span class="text-danger">*</span></label>
                                    <asp:TextBox ID="txtNgayGiao" runat="server" CssClass="form-control py-2 px-3" TextMode="Date"></asp:TextBox>
                                </div>
                                <div class="col-12">
                                    <label class="form-label fw-bold text-secondary fs-sm">Ghi chú giao hàng</label>
                                    <asp:TextBox ID="txtGhiChu" runat="server" CssClass="form-control py-2 px-3" TextMode="MultiLine" Rows="3" placeholder="Ví dụ: Gọi trước khi giao..."></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </section>

                    <section class="card border-0 shadow-sm rounded-4 overflow-hidden">
                        <div class="card-header bg-white border-bottom py-3 px-4">
                            <h2 class="h5 fw-bold mb-0 d-flex align-items-center gap-2">
                                <span class="material-symbols-outlined text-primary">payments</span>
                                Phương thức thanh toán
                            </h2>
                        </div>
                        <div class="card-body p-4">
                            <div class="d-flex flex-column gap-3">
                                <label class="payment-option border rounded-4 p-3 d-flex gap-3 cursor-pointer">
                                    <input type="radio" name="pay" checked="checked" class="mt-1" />
                                    <div>
                                        <div class="fw-bold text-dark">Thanh toán khi nhận hàng (COD)</div>
                                        <div class="fs-sm text-muted">Bạn chỉ phải thanh toán khi đã nhận được hàng.</div>
                                    </div>
                                </label>
                                <label class="payment-option border rounded-4 p-3 d-flex gap-3 cursor-pointer border-primary bg-primary-subtle bg-opacity-10">
                                    <input type="radio" name="pay" class="mt-1" />
                                    <div>
                                        <div class="fw-bold text-dark d-flex align-items-center gap-2">
                                            Chuyển khoản ngân hàng <span class="badge bg-success">Giảm 1%</span>
                                        </div>
                                        <div class="fs-sm text-muted">Hỗ trợ QR Code qua ứng dụng ngân hàng.</div>
                                    </div>
                                </label>
                            </div>
                        </div>
                    </section>
                </div>

                <div class="col-lg-4">
                    <div class="sticky-top" style="top: 100px;">
                        <div class="card border-0 shadow rounded-4 overflow-hidden mb-4">
                            <div class="card-header bg-light bg-opacity-50 border-bottom py-3 px-4 d-flex justify-content-between align-items-center">
                                <h2 class="h6 fw-bold mb-0">Đơn hàng (<asp:Literal ID="ltrCount" runat="server"></asp:Literal>)</h2>
                                <a href="GioHang.aspx" class="fs-xs fw-bold text-primary text-decoration-none">Sửa</a>
                            </div>
                            <div class="card-body p-4">
                                <div class="cart-items max-vh-40 overflow-auto mb-4 pe-2">
                                    <asp:Repeater ID="rptTomTat" runat="server">
                                        <ItemTemplate>
                                            <div class="d-flex gap-3 mb-3">
                                                <div class="border rounded-3 p-1 shrink-0" style="width: 60px; height: 60px;">
                                                    <img src='<%# "../Images/" + Eval("AnhBia") %>' class="w-100 h-100 object-fit-contain" />
                                                </div>
                                                <div class="flex-grow-1">
                                                    <h4 class="fs-xs fw-bold text-dark mb-0 text-truncate" style="max-width: 180px;"><%# Eval("TenLaptop") %></h4>
                                                    <div class="text-muted fs-xs">x<%# Eval("SoLuong") %></div>
                                                    <div class="fw-bold text-primary fs-sm"><%# Eval("ThanhTien", "{0:N0}") %>₫</div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                                <hr class="my-4 text-muted opacity-25" />
                                <div class="d-flex flex-column gap-2 mb-4">
                                    <div class="d-flex justify-content-between fs-sm">
                                        <span class="text-muted">Tạm tính</span>
                                        <span class="fw-medium"><asp:Literal ID="ltrTamTinh" runat="server"></asp:Literal>₫</span>
                                    </div>
                                    <div class="d-flex justify-content-between fs-sm">
                                        <span class="text-muted">VAT (10%)</span>
                                        <span class="fw-medium"><asp:Literal ID="ltrVAT" runat="server"></asp:Literal>₫</span>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <span class="text-dark fw-bold">Tổng cộng</span>
                                        <div class="text-end">
                                            <div class="h4 fw-black text-primary mb-0"><asp:Literal ID="ltrTongCong" runat="server"></asp:Literal>₫</div>
                                            <span class="fs-xs text-muted">(Đã gồm VAT)</span>
                                        </div>
                                    </div>
                                </div>
                                <asp:LinkButton ID="btnXacNhan" runat="server" OnClick="btnXacNhan_Click" CssClass="btn btn-primary w-100 py-3 rounded-3 fw-bold shadow-lg d-flex align-items-center justify-content-center gap-2">
                                    ĐẶT HÀNG NGAY <span class="material-symbols-outlined">arrow_forward</span>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <style>
        .fs-xs { font-size: 0.75rem; }
        .fs-sm { font-size: 0.875rem; }
        .fw-black { font-weight: 900; }
        .payment-option { transition: all 0.2s; cursor: pointer; }
        .payment-option:hover { border-color: var(--bs-primary) !important; }
        .max-vh-40 { max-height: 40vh; }
    </style>
</asp:Content>

