<%@ Page Title="Đăng ký tài khoản - LaptopZone" Language="C#" MasterPageFile="~/Public/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="LaptopZone_project.Public.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="register-wrapper min-vh-100 position-relative overflow-hidden py-5 d-flex align-items-center">
        <div class="blob-1"></div>
        <div class="blob-2"></div>

        <div class="container position-relative z-2">
            <div class="row g-4 align-items-center justify-content-center">

                <div class="col-lg-5 d-none d-lg-flex flex-column gap-4 pe-lg-5">
                    <div class="brand-badge-wrapper">
                        <span class="badge rounded-pill bg-primary bg-opacity-10 text-primary px-3 py-2 extra-small fw-bold mb-3">
                            <i class="bi bi-stars me-1"></i>THÀNH VIÊN MỚI
                        </span>
                        <h1 class="display-5 fw-black text-dark lh-1 mb-3">Khởi đầu
                            <br />
                            <span class="text-primary-gradient">Kỷ nguyên số</span>
                        </h1>
                        <p class="text-muted small leading-relaxed max-w-sm">
                            Gia nhập cộng đồng LaptopZone ngay hôm nay để nhận voucher giảm giá 10% và đặc quyền bảo hành ưu tiên.
                        </p>
                    </div>

                    <div class="row g-3">
                        <div class="col-6">
                            <div class="benefit-card">
                                <span class="material-symbols-outlined icon">local_shipping</span>
                                <span class="fw-bold extra-small">Miễn phí giao hàng</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="benefit-card">
                                <span class="material-symbols-outlined icon">verified_user</span>
                                <span class="fw-bold extra-small">Chính hãng 100%</span>
                            </div>
                        </div>
                    </div>

                    <div class="mt-2">
                        <img src="https://img.freepik.com/free-vector/sign-up-concept-illustration_114360-7885.jpg" alt="Register illustration" class="img-fluid opacity-75" style="max-width: 300px;" />
                    </div>
                </div>

                <div class="col-lg-7 col-xl-6">
                    <div class="card border-0 shadow-2xl rounded-4 overflow-hidden bg-white">
                        <div class="card-header bg-white border-0 px-4 pt-4 pb-0">
                            <h3 class="fw-bold text-dark mb-1">Tạo tài khoản</h3>
                            <p class="text-muted extra-small">Bắt đầu hành trình mua sắm tuyệt vời của bạn.</p>
                        </div>

                        <div class="card-body p-4">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label extra-small fw-bold mb-2 text-uppercase opacity-75">Họ và tên <span class="text-danger">*</span></label>
                                    <div class="input-group-modern">
                                        <span class="material-symbols-outlined icon-field">person</span>
                                        <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control-modern" placeholder="Nguyễn Văn A"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvHoTen" runat="server" ControlToValidate="txtHoTen" ForeColor="#dc3545" Display="Dynamic" ErrorMessage="Vui lòng nhập họ tên" CssClass="error-msg" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label extra-small fw-bold mb-2 text-uppercase opacity-75">Email <span class="text-danger">*</span></label>
                                    <div class="input-group-modern">
                                        <span class="material-symbols-outlined icon-field">mail</span>
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control-modern" TextMode="Email" placeholder="name@example.com"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ForeColor="#dc3545" Display="Dynamic" ErrorMessage="Vui lòng nhập email" CssClass="error-msg" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label extra-small fw-bold mb-2 text-uppercase opacity-75">Số điện thoại</label>
                                    <div class="input-group-modern">
                                        <span class="material-symbols-outlined icon-field">call</span>
                                        <asp:TextBox ID="txtSDT" runat="server" CssClass="form-control-modern" placeholder="09xxxxxxxx"></asp:TextBox>
                                    </div>
                                    <asp:RegularExpressionValidator ID="revSDT" runat="server" ControlToValidate="txtSDT" ValidationExpression="^\d{10,11}$" ForeColor="#dc3545" Display="Dynamic" ErrorMessage="SĐT không hợp lệ" CssClass="error-msg" />
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label extra-small fw-bold mb-2 text-uppercase text-primary">Tên đăng nhập *</label>
                                    <div class="input-group-modern">
                                        <span class="material-symbols-outlined icon-field text-primary">account_circle</span>
                                        <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control-modern border-primary-subtle" placeholder="username"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvTenDN" runat="server" ControlToValidate="txtTenDN" ForeColor="#dc3545" Display="Dynamic" ErrorMessage="Vui lòng nhập tên đăng nhập" CssClass="error-msg" />
                                </div>

                                <div class="col-12">
                                    <label class="form-label extra-small fw-bold mb-2 text-uppercase text-primary">Mật khẩu * (Ít nhất 6 ký tự)</label>
                                    <div class="input-group-modern">
                                        <span class="material-symbols-outlined icon-field text-primary">lock</span>
                                        <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control-modern border-primary-subtle pe-5" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                                        <button type="button" id="btnTogglePass" class="btn-toggle-eye">
                                            <span class="material-symbols-outlined fs-5" id="eyeIcon">visibility</span>
                                        </button>
                                    </div>
                                    <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtMatKhau" ValidationExpression="^.{6,}$" ForeColor="#dc3545" Display="Dynamic" ErrorMessage="Mật khẩu quá ngắn" CssClass="error-msg" />
                                </div>

                                <div class="col-12 mt-4">
                                    <asp:Button ID="btnDangKy" runat="server" Text="TẠO TÀI KHOẢN NGAY" OnClick="btnDangKy_Click"
                                        OnClientClick="if(Page_ClientValidate()) { this.value='Đang xử lý...'; this.disabled=true; }" UseSubmitBehavior="false"
                                        CssClass="btn-register-gradient w-100 py-3 fw-bold rounded-3 shadow-blue" />
                                </div>
                            </div>

                            <div class="text-center mt-4">
                                <p class="text-muted small">
                                    Đã có tài khoản? <a href="Login.aspx" class="text-primary fw-bold text-decoration-none ms-1 hover-underline">Đăng nhập tại đây</a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .register-wrapper {
            background-color: #f8fafc;
            font-family: 'Inter', sans-serif;
        }

        .extra-small {
            font-size: 11px;
            letter-spacing: 0.5px;
        }

        .error-msg {
            font-size: 11px;
            margin-top: 4px;
            display: block;
            font-weight: 500;
        }

        .fw-black {
            font-weight: 900;
        }

        .text-primary-gradient {
            background: linear-gradient(90deg, #2563eb, #60a5fa);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Benefit Cards */
        .benefit-card {
            padding: 1.25rem;
            background: white;
            border-radius: 12px;
            border: 1px solid rgba(255,255,255,1);
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            display: flex;
            flex-direction: column;
            gap: 8px;
            transition: 0.3s;
        }

            .benefit-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1);
            }

            .benefit-card .icon {
                color: #2563eb;
                font-size: 28px;
            }

        /* Modern Input Group */
        .input-group-modern {
            position: relative;
        }

        .icon-field {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 20px;
            z-index: 5;
            transition: 0.3s;
        }

        .form-control-modern {
            width: 100%;
            padding: 12px 12px 12px 48px;
            background: #f8fafc;
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            font-size: 14px;
            transition: 0.3s;
        }

            .form-control-modern:focus {
                background: white;
                border-color: #2563eb;
                outline: none;
                box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
            }

                .form-control-modern:focus + .icon-field {
                    color: #2563eb;
                }

        /* Toggle Eye Button */
        .btn-toggle-eye {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #94a3b8;
            padding: 4px;
            z-index: 10;
        }

            .btn-toggle-eye:hover {
                color: #2563eb;
            }

        /* Button Style */
        .btn-register-gradient {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            border: none;
            color: white;
            transition: 0.3s;
            box-shadow: 0 10px 20px -5px rgba(37, 99, 235, 0.3);
        }

            .btn-register-gradient:hover:not(:disabled) {
                transform: translateY(-2px);
                box-shadow: 0 15px 25px -5px rgba(37, 99, 235, 0.4);
                filter: brightness(1.1);
            }

            .btn-register-gradient:disabled {
                opacity: 0.7;
                cursor: not-allowed;
            }

        /* Decoration Blobs */
        .blob-1, .blob-2 {
            position: absolute;
            width: 500px;
            height: 500px;
            border-radius: 50%;
            filter: blur(100px);
            z-index: 0;
            opacity: 0.4;
        }

        .blob-1 {
            top: -150px;
            right: -150px;
            background: #dbeafe;
        }

        .blob-2 {
            bottom: -150px;
            left: -150px;
            background: #e0f2fe;
        }

        .shadow-2xl {
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.08);
        }

        .hover-underline:hover {
            text-decoration: underline !important;
        }
    </style>

    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            const btnToggle = document.getElementById('btnTogglePass');
            const passInput = document.getElementById('<%= txtMatKhau.ClientID %>');
            const eyeIcon = document.getElementById('eyeIcon');

            if (btnToggle && passInput) {
                btnToggle.addEventListener('click', function (e) {
                    e.preventDefault();
                    const isPassword = passInput.type === 'password';
                    passInput.type = isPassword ? 'text' : 'password';
                    eyeIcon.textContent = isPassword ? 'visibility_off' : 'visibility';
                });
            }
        });
    </script>
</asp:Content>

