<%@ Page Title="Liên Hệ - LaptopZone" Language="C#" MasterPageFile="~/Public/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="LaptopZone_project.Public.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="bg-white border-bottom border-slate-200 shadow-sm">
        <div class="container py-2 text-xs text-slate-500 d-flex align-items-center gap-2">
            <a href="Default.aspx" class="text-decoration-none text-slate-500">Trang chủ</a>
            <span class="material-symbols-outlined fs-6">chevron_right</span>
            <span class="text-slate-900 fw-medium">Liên hệ</span>
        </div>
    </div>

    <div class="container py-5">
        <div class="text-center mb-5">
            <h1 class="fw-bold text-slate-900">Liên hệ với chúng tôi</h1>
            <p class="text-muted">Chúng tôi luôn sẵn sàng hỗ trợ bạn 24/7</p>
        </div>

        <div class="row g-5">
            <div class="col-lg-6">
                <div class="mb-4 d-flex align-items-start gap-3">
                    <div class="bg-primary bg-opacity-10 p-3 rounded-4 text-primary">
                        <span class="material-symbols-outlined">location_on</span>
                    </div>
                    <div>
                        <h5 class="fw-bold mb-1">Địa chỉ showroom</h5>
                        <p class="text-muted mb-0">52/18, Nguyễn Sỹ Sách, P. Tân Sơn, Q. Tân Bình, TP. HCM</p>
                    </div>
                </div>

                <div class="mb-4 d-flex align-items-start gap-3">
                    <div class="bg-primary bg-opacity-10 p-3 rounded-4 text-primary">
                        <span class="material-symbols-outlined">call</span>
                    </div>
                    <div>
                        <h5 class="fw-bold mb-1">Điện thoại hỗ trợ</h5>
                        <p class="text-muted mb-0">0906.891.704 (Zalo/Hotline)</p>
                    </div>
                </div>

                <div class="rounded-4 overflow-hidden shadow-sm border" style="height: 350px;">
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.1234567890!2d106.637!3d10.806!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zNTIsIDE4IE5ndXnhu4VuIFPhu7kgU8OhY2gsIFTDom4gU8ahbiwgVMOibiBCw6xuaCwgVGjDoG5oIHBo4buRIEjhu5MgQ2jDrSBNaW5oLCBWaeG7h3QgTmFt!5e0!3m2!1svi!2s!4v1700000000000" 
                        width="100%" height="100%" style="border: 0;" allowfullscreen="" loading="lazy"></iframe>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="card border-0 shadow-sm rounded-4 p-4">
                    <h4 class="fw-bold mb-4">Gửi tin nhắn cho chúng tôi</h4>

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted text-uppercase">Họ và tên</label>
                        <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control py-2" placeholder="Nguyễn Văn A"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted text-uppercase">Email liên hệ</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control py-2" placeholder="email@example.com"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label small fw-bold text-muted text-uppercase">Chủ đề</label>
                        <asp:DropDownList ID="ddlChuDe" runat="server" CssClass="form-select py-2">
                            <asp:ListItem>Tư vấn mua máy</asp:ListItem>
                            <asp:ListItem>Hỗ trợ kỹ thuật</asp:ListItem>
                            <asp:ListItem>Khiếu nại dịch vụ</asp:ListItem>
                            <asp:ListItem>Hợp tác kinh doanh</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="mb-4">
                        <label class="form-label small fw-bold text-muted text-uppercase">Nội dung tin nhắn</label>
                        <asp:TextBox ID="txtNoiDung" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Nhập tin nhắn của bạn..."></asp:TextBox>
                    </div>

                    <asp:Button ID="btnGui" runat="server" Text="GỬI TIN NHẮN" OnClick="btnGui_Click" CssClass="btn btn-primary w-100 py-3 fw-bold rounded-pill shadow-lg" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
