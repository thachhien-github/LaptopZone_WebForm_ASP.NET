<%@ Page Title="Đăng nhập Admin" Language="C#" AutoEventWireup="true" CodeBehind="LoginAdmin.aspx.cs" Inherits="LaptopZone_project.Admin.LoginAdmin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Quản trị hệ thống - LaptopZone</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;600;800&family=Montserrat:wght@800;900&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,400,0,0" />
    <style>
        body { font-family: 'Manrope', sans-serif; background-color: #f1f5f9; color: #1e293b; }
        
        /* --- High-Tech Branding Sync --- */
        .brand-name-admin {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            font-size: 32px;
            margin: 0;
            line-height: 1;
            letter-spacing: -1.5px;
            display: flex;
            align-items: baseline;
            color: #ffffff;
        }

        .highlight-z {
            font-size: 48px;
            font-weight: 900;
            background: linear-gradient(135deg, #00d2ff 0%, #3b82f6 50%, #6c5ce7 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-left: 2px;
            filter: drop-shadow(0 4px 12px rgba(59, 130, 246, 0.4));
        }

        /* Đã cập nhật theo yêu cầu: ONE màu Gradient Blue */
        .one-text {
            background: linear-gradient(to bottom, #0984e3, #0773c5);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-size: 30px;
        }

        /* --- Layout Styles --- */
        .main-card { 
            border-radius: 2.5rem !important;
            overflow: hidden; 
            border: none;
            background: #ffffff;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
        }

        .image-section {
            border-radius: 2.5rem 0 0 2.5rem;
            overflow: hidden;
            position: relative;
            background: #0f172a; /* Nền tối để nổi bật ảnh và logo */
        }

        .overlay { 
            background: linear-gradient(to top, rgba(15, 23, 42, 0.9), rgba(15, 23, 42, 0.2)); 
            z-index: 1; 
        }
        
        .extra-small { font-size: 11px; letter-spacing: 1.5px; }

        .form-control { 
            border: 1px solid #e2e8f0; 
            font-size: 14px; 
            transition: all 0.3s; 
            border-radius: 14px; 
            background-color: #f8fafc;
        }
        .form-control:focus { 
            background-color: #ffffff;
            border-color: #3b82f6; 
            box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1) !important; 
        }

        .btn-admin { 
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            border: none; 
            color: white; 
            padding: 16px;
            font-weight: 800;
            border-radius: 14px;
            transition: all 0.4s;
        }
        .btn-admin:hover { 
            transform: translateY(-3px); 
            box-shadow: 0 12px 24px -6px rgba(37, 99, 235, 0.4);
            filter: brightness(1.1);
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="min-vh-100 d-flex align-items-center py-5">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-10 col-xl-9 d-flex main-card" style="min-height: 600px;">
                        
                        <%-- Cột Trái: Ảnh và Logo --%>
                        <div class="d-none d-lg-flex flex-column justify-content-end p-5 text-white image-section" style="width: 45%;">
                            <%-- Ảnh nền Laptop High-tech --%>
                            <img src="https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?q=80&w=1000" 
                                 class="position-absolute top-0 start-0 w-100 h-100 object-fit-cover" alt="Laptop Admin" />
                            <div class="overlay position-absolute top-0 start-0 w-100 h-100"></div>
                            
                            <div class="position-relative z-2">
                                <div class="mb-2">
                                    <div class="brand-name-admin">LAPTOP<span class="highlight-z">Z</span><span class="one-text">ONE</span></div>
                                </div>
                                <p class="opacity-75 extra-small fw-bold text-uppercase">High-End Computing Solutions</p>
                            </div>
                        </div>

                        <%-- Cột Phải: Form --%>
                        <div class="p-5 flex-grow-1 d-flex flex-column justify-content-center bg-white">
                            <div class="w-100 mx-auto" style="max-width: 350px;">
                                <div class="mb-5 text-center">
                                    <span class="material-symbols-outlined fs-1 text-primary mb-3">admin_panel_settings</span>
                                    <h3 class="fw-bold text-dark">Hệ Thống Quản Trị</h3>
                                    <p class="text-muted small">Nhập thông tin xác thực để truy cập</p>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label extra-small fw-800 text-secondary text-uppercase">Tài khoản</label>
                                    <asp:TextBox ID="txtTenDN" runat="server" CssClass="form-control px-4 py-3" placeholder="Username"></asp:TextBox>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label extra-small fw-800 text-secondary text-uppercase">Mật khẩu</label>
                                    <asp:TextBox ID="txtMatKhau" runat="server" CssClass="form-control px-4 py-3" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                                </div>

                                <asp:Button ID="btnDangNhap" runat="server" Text="ĐĂNG NHẬP NGAY" OnClick="btnDangNhap_Click"
                                    CssClass="btn btn-admin w-100" />
                                
                                <div class="text-center mt-5">
                                    <a href="../Public/Default.aspx" class="text-decoration-none extra-small text-muted fw-bold d-inline-flex align-items-center gap-2">
                                        <span class="material-symbols-outlined fs-6">west</span> VỀ TRANG CHỦ
                                    </a>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>