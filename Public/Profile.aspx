<%@ Page Title="Hồ sơ cá nhân" Language="C#" MasterPageFile="~/Public/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="LaptopZone_project.Public.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row">
            <div class="col-lg-4 mb-4">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-4">
                        <h4 class="fw-bold mb-4">Hồ sơ của tôi</h4>
                        <div class="mb-3">
                            <label class="form-label text-muted small fw-bold">HỌ TÊN</label>
                            <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted small fw-bold">EMAIL</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted small fw-bold">SỐ ĐIỆN THOẠI</label>
                            <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted small fw-bold">ĐỊA CHỈ GIAO HÀNG</label>
                            <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnUpdate" runat="server" Text="Cập nhật thông tin" OnClick="btnUpdate_Click" CssClass="btn btn-primary w-100 fw-bold rounded-pill" />
                        <hr class="my-4 text-muted opacity-25">

                        <h5 class="fw-bold mb-3">Đổi mật khẩu</h5>
                        <div class="mb-3">
                            <label class="form-label text-muted small fw-bold">MẬT KHẨU CŨ</label>
                            <asp:TextBox ID="txtOldPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted small fw-bold">MẬT KHẨU MỚI</label>
                            <asp:TextBox ID="txtNewPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>
                        <div class="mb-4">
                            <label class="form-label text-muted small fw-bold">NHẬP LẠI MẬT KHẨU MỚI</label>
                            <asp:TextBox ID="txtConfirmPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnChangePass" runat="server" Text="Đổi mật khẩu" OnClick="btnChangePass_Click" CssClass="btn btn-outline-danger w-100 fw-bold rounded-pill" />
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-4">
                        <h4 class="fw-bold mb-4">Lịch sử đặt hàng</h4>
                        <div class="table-responsive">
                            <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="table table-hover" GridLines="None">
                                <Columns>
                                    <asp:BoundField DataField="SoDH" HeaderText="Mã ĐH" />
                                    <asp:BoundField DataField="NgayDH" HeaderText="Ngày đặt" DataFormatString="{0:dd/MM/yyyy}" />
                                    <asp:BoundField DataField="TriGia" HeaderText="Tổng tiền" DataFormatString="{0:N0} đ" />
                                    <asp:TemplateField HeaderText="Trạng thái">
                                        <ItemTemplate>
                                            <span class='<%# Convert.ToBoolean(Eval("DaGiao")) ? "badge bg-success" : "badge bg-warning" %>'>
                                                <%# Convert.ToBoolean(Eval("DaGiao")) ? "Đã giao" : "Đang xử lý" %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <%-- Cột mới thêm để xem chi tiết --%>
                                    <asp:HyperLinkField
                                        DataNavigateUrlFields="SoDH"
                                        DataNavigateUrlFormatString="ChiTietDonHang.aspx?id={0}"
                                        Text="Chi tiết"
                                        ControlStyle-CssClass="btn btn-sm btn-outline-primary rounded-pill px-3" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

