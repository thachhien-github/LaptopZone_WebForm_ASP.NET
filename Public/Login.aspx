<%@ Page Title="Đăng nhập - LaptopZone" Language="C#" MasterPageFile="~/Public/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LaptopZone_project.Public.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="login-wrapper position-relative overflow-hidden py-5 d-flex align-items-center">
        <div class="blob-1"></div>
        <div class="blob-2"></div>

        <div class="container position-relative z-2">
            <div class="row g-0 justify-content-center">
                <div class="col-lg-11 col-xl-10 shadow-2xl rounded-4 overflow-hidden d-flex flex-column flex-lg-row bg-white border-0">

                    <div class="d-none d-lg-flex flex-column justify-content-between p-5 text-white position-relative overflow-hidden side-panel" style="width: 45%;">
                        <img src="https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?q=80&w=1000"
                            alt="Technology Workspace" class="position-absolute top-0 start-0 w-100 h-100 object-fit-cover transition-transform duration-1000" id="heroImage" />
                        <div class="overlay position-absolute top-0 start-0 w-100 h-100"></div>

                        <div class="position-relative z-2">
                            <div class="brand-wrapper text-white mb-5 d-inline-flex flex-column align-items-start">
                                <h1 class="brand-name-login">LAPTOP<span class="flex items-baseline"><span class="highlight-z">Z</span><span class="one-text">ONE</span></span></h1>
                                <span class="brand-slogan-login">HIGH-END COMPUTING SOLUTIONS</span>
                            </div>
                        </div>

                        <div class="position-relative z-2 mt-auto">
                            <div class="badge rounded-pill bg-white bg-opacity-10 backdrop-blur border border-white border-opacity-20 mb-3 px-3 py-2 extra-small fw-semibold d-inline-flex align-items-center">
                                <span class="d-inline-block rounded-circle bg-info me-2 pulse-animation" style="width: 8px; height: 8px;"></span>
                                KHÁM PHÁ CÔNG NGHỆ MỚI
                            </div>
                            <h3 class="fw-bold mb-3 lh-sm display-6">Hiệu năng tối đỉnh.<br />
                                Trải nghiệm mượt mà.</h3>
                            <p class="opacity-75 extra-small mb-0 max-w-sm fw-light">Trở thành thành viên của LaptopZone để nhận những ưu đãi đặc quyền và trải nghiệm dịch vụ hỗ trợ cao cấp nhất.</p>
                        </div>
                    </div>

                    <div class="p-4 p-md-5 bg-white d-flex flex-column justify-content-center align-items-center" style="flex: 1;">
                        <div class="w-100" style="max-width: 380px;">

                            <div class="d-lg-none text-center mb-5">
                                <h1 class="brand-name-login" style="color: #0f172a;">LAPTOP<span class="flex items-baseline"><span class="highlight-z">Z</span><span class="one-text">ONE</span></span></h1>
                            </div>

                            <div class="mb-4 text-center text-lg-start">
                                <h3 class="fw-bold text-dark mb-1">Chào mừng trở lại!</h3>
                                <p class="text-muted small">Vui lòng đăng nhập để tiếp tục mua sắm.</p>
                            </div>

                            <div class="login-form-fields">
                                <div class="mb-3">
                                    <label class="form-label extra-small fw-bold text-dark mb-2 text-uppercase opacity-75">Tên đăng nhập</label>
                                    <div class="input-group-modern">
                                        <span class="material-symbols-outlined icon-field">account_circle</span>
                                        <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control-modern" placeholder="Username của bạn"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <label class="form-label extra-small fw-bold text-dark mb-0 text-uppercase opacity-75">Mật khẩu</label>
                                        <a href="#" class="text-primary extra-small text-decoration-none fw-semibold">Quên mật khẩu?</a>
                                    </div>
                                    <div class="input-group-modern">
                                        <span class="material-symbols-outlined icon-field">lock</span>
                                        <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control-modern" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                                    </div>
                                </div>

                                <asp:Button ID="btnDangNhap" runat="server" Text="ĐĂNG NHẬP NGAY" OnClick="btnDangNhap_Click"
                                    CssClass="btn-login-gradient w-100 py-3 fw-bold rounded-3 mb-4" />

                                <div class="d-flex align-items-center gap-3 mb-4">
                                    <hr class="flex-grow-1 opacity-10" />
                                    <span class="extra-small fw-bold text-muted text-uppercase" style="letter-spacing: 1px;">Hoặc</span>
                                    <hr class="flex-grow-1 opacity-10" />
                                </div>

                                <div class="row g-2 mb-4">
                                    <div class="col-6">
                                        <button type="button" class="btn btn-social-auth">
                                            <img src="https://www.svgrepo.com/show/475656/google-color.svg" width="18" />
                                            <span>Google</span>
                                        </button>
                                    </div>
                                    <div class="col-6">
                                        <button type="button" class="btn btn-social-auth">
                                            <img src="https://www.svgrepo.com/show/475647/facebook-color.svg" width="18" />
                                            <span>Facebook</span>
                                        </button>
                                    </div>
                                </div>

                                <div class="text-center p-3 rounded-4 bg-light border border-dashed border-2">
                                    <p class="text-muted extra-small mb-0 fw-medium">
                                        Bạn chưa có tài khoản? 
                                        <a href="Register.aspx" class="text-primary fw-bold text-decoration-none ms-1">Đăng ký ngay</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <style>
        .login-wrapper { background-color: #f8fafc; min-height: 85vh; }
        .extra-small { font-size: 11px; letter-spacing: 0.5px; }

        /* --- High-Tech Typography --- */
        .brand-name-login {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            font-size: 28px;
            margin: 0;
            line-height: 1;
            letter-spacing: -1.5px;
            display: flex;
            align-items: baseline;
        }

        .highlight-z {
            font-size: 42px;
            font-weight: 900;
            background: linear-gradient(135deg, #00d2ff 0%, #3b82f6 50%, #6c5ce7 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-left: 2px;
            filter: drop-shadow(0 2px 10px rgba(59, 130, 246, 0.3));
        }

        .one-text {
            background: linear-gradient(to bottom, #3b82f6, #1d4ed8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 26px;
        }

        .brand-slogan-login {
            font-size: 9px;
            font-weight: 700;
            letter-spacing: 2.5px;
            opacity: 0.8;
            margin-top: 5px;
        }

        /* Modern Input Group */
        .input-group-modern { position: relative; }
        .icon-field {
            position: absolute; left: 16px; top: 50%;
            transform: translateY(-50%); color: #94a3b8;
            font-size: 20px; transition: 0.3s; z-index: 5;
        }

        .form-control-modern {
            width: 100%; padding: 14px 14px 14px 48px;
            background: #f1f5f9; border: 2px solid transparent;
            border-radius: 12px; font-size: 14px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .form-control-modern:focus {
            background: white; border-color: #3b82f6;
            box-shadow: 0 8px 20px rgba(59, 130, 246, 0.1); outline: none;
        }

        .form-control-modern:focus + .icon-field { color: #3b82f6; }

        /* Button Gradient */
        .btn-login-gradient {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            border: none; color: white; transition: all 0.3s;
            box-shadow: 0 10px 20px -5px rgba(37, 99, 235, 0.4);
        }

        .btn-login-gradient:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px -5px rgba(37, 99, 235, 0.5);
            filter: brightness(1.1);
        }

        /* Social Auth */
        .btn-social-auth {
            display: flex; align-items: center; justify-content: center;
            gap: 10px; width: 100%; padding: 12px;
            background: white; border: 1.5px solid #e2e8f0;
            border-radius: 12px; font-size: 13px;
            font-weight: 600; color: #475569; transition: 0.2s;
        }

        /* Decorations */
        .blob-1, .blob-2 {
            position: absolute; width: 600px; height: 600px;
            border-radius: 50%; filter: blur(100px); z-index: 0; opacity: 0.4;
        }
        .blob-1 { top: -200px; left: -200px; background: #dbeafe; }
        .blob-2 { bottom: -200px; right: -200px; background: #e0f2fe; }

        .side-panel .overlay {
            background: linear-gradient(180deg, rgba(15,23,42,0.2) 0%, rgba(15,23,42,0.9) 100%);
        }

        .pulse-animation { animation: pulse-blue 2s infinite; }
        @keyframes pulse-blue {
            0%, 100% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(6, 182, 212, 0.7); }
            70% { transform: scale(1); box-shadow: 0 0 0 8px rgba(6, 182, 212, 0); }
        }
    </style>

    <script>
        const panel = document.querySelector('.side-panel');
        const img = document.getElementById('heroImage');
        if (panel && img) {
            panel.addEventListener('mouseenter', () => img.style.transform = 'scale(1.1)');
            panel.addEventListener('mouseleave', () => img.style.transform = 'scale(1)');
        }
    </script>
</asp:Content>
