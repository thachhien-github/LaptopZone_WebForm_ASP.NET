<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintDonHang.aspx.cs"
    Inherits="LaptopZone_project.Admin.PrintDonHang"
    EnableViewState="false" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>In hóa đơn - LaptopZone</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;800;900&family=Roboto+Mono&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            -webkit-print-color-adjust: exact;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background: #f4f7f6;
            color: #2d3436;
            margin: 0;
            padding: 0;
        }

        .invoice-wrapper {
            width: 210mm;
            min-height: 297mm;
            margin: 20px auto;
            background: white;
            padding: 40px 60px;
            position: relative;
            border: 1px solid #eee;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
        }

        /* --- High-Tech Logo Style --- */
        .brand-name-print {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            font-size: 32px;
            margin: 0;
            line-height: 1;
            letter-spacing: -1.5px;
            display: flex;
            align-items: baseline;
            color: #2d3436;
        }

        .highlight-z {
            font-size: 46px;
            font-weight: 900;
            background: linear-gradient(135deg, #00d2ff 0%, #3b82f6 50%, #6c5ce7 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-left: 2px;
        }

        /* Các chữ ONE còn lại trong ZONE */
.one-text {
    background: linear-gradient(to bottom, #0984e3, #0773c5);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    font-size: 30px;
}

        .top-accent {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 10px;
            background: linear-gradient(90deg, #3b82f6 0%, #6c5ce7 100%);
        }

        /* Header Section */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 50px;
            border-bottom: 2px solid #f1f2f6;
            padding-bottom: 25px;
        }

        .order-info {
            text-align: right;
        }

        .order-info h2 {
            margin: 0;
            font-size: 24px;
            background: linear-gradient(90deg, #3b82f6, #1d4ed8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-weight: 900;
            letter-spacing: 1px;
        }

        /* Grid Information */
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            margin-bottom: 40px;
        }

        .info-box h3 {
            font-size: 11px;
            text-transform: uppercase;
            color: #3b82f6;
            letter-spacing: 2px;
            margin-bottom: 12px;
            border-bottom: 1px solid #f1f2f6;
            padding-bottom: 5px;
            font-weight: 900;
        }

        .info-content {
            font-size: 13px;
            line-height: 1.8;
        }

        .info-content strong {
            color: #0f172a;
            font-size: 15px;
            display: block;
            margin-bottom: 4px;
            font-weight: 700;
        }

        /* Table Section */
        .product-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        .product-table th {
            background: #f8fafc;
            padding: 15px;
            font-size: 11px;
            text-transform: uppercase;
            border-bottom: 3px solid #3b82f6;
            text-align: left;
            color: #475569;
            letter-spacing: 1px;
        }

        .product-table td {
            padding: 18px 15px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 13px;
        }

        /* Summary Section */
        .summary-wrapper {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
        }

        .summary-container {
            width: 320px;
            padding: 10px 0;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            font-size: 14px;
            color: #64748b;
        }

        .total-row {
            margin-top: 10px;
            padding-top: 15px;
            border-top: 2px solid #0f172a;
            font-weight: 800;
            font-size: 22px;
            color: #0f172a;
        }

        .total-price {
            color: #2563eb;
        }

        /* Signatures */
        .signature-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            text-align: center;
            margin-top: 60px;
        }

        .signature-box p {
            font-weight: 800;
            font-size: 14px;
            margin-bottom: 80px;
            text-transform: uppercase;
        }

        .stamp {
            display: inline-block;
            border: 3px solid #10b981;
            color: #10b981;
            padding: 5px 20px;
            font-weight: 900;
            transform: rotate(-12deg);
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 15px;
        }

        .footer-note {
            margin-top: 80px;
            text-align: center;
            border-top: 1px dashed #e2e8f0;
            padding-top: 30px;
        }

        @media print {
            body { background: white; }
            .invoice-wrapper {
                margin: 0; border: none; width: 100%; box-shadow: none; padding: 20px;
            }
            .no-print { display: none; }
        }
    </style>
</head>
<body onload="window.print()">
    <form id="form1" runat="server">
        <div class="invoice-wrapper">
            <div class="top-accent"></div>

            <div class="header">
                <div class="brand">
                    <div class="brand-name-print">LAPTOP<span class="highlight-z">Z</span><span class="one-text">ONE</span></div>
                    <p style="font-size: 9px; letter-spacing: 3px; color: #94a3b8; margin-top: 8px; font-weight: 700;">HIGH-END COMPUTING SOLUTIONS</p>
                </div>
                <div class="order-info">
                    <h2>HÓA ĐƠN</h2>
                    <div style="font-family: 'Roboto Mono'; font-size: 14px; color: #475569; margin-top: 5px; font-weight: 600;">#<asp:Literal ID="ltrSoDH" runat="server" /></div>
                    <div style="font-family: 'Roboto Mono'; font-size: 12px; color: #64748b;">NGÀY: <asp:Literal ID="ltrNgayDH" runat="server" /></div>
                </div>
            </div>

            <div class="info-grid">
                <div class="info-box">
                    <h3>ĐƠN VỊ CUNG CẤP</h3>
                    <div class="info-content">
                        <strong>LAPTOPZONE TECHNOLOGY STORE</strong>
                        Địa chỉ: 52/18 Nguyễn Sỹ Sách, P. Tân Sơn, TP. HCM<br />
                        Hotline: 0906.891.704<br />
                        Website: www.laptopzone.vn
                    </div>
                </div>
                <div class="info-box">
                    <h3>THÔNG TIN KHÁCH HÀNG</h3>
                    <div class="info-content">
                        <strong><asp:Literal ID="ltrTenKH" runat="server" /></strong>
                        SĐT: <asp:Literal ID="ltrSDT" runat="server" /><br />
                        Địa chỉ: <asp:Literal ID="ltrDiaChi" runat="server" />
                    </div>
                </div>
            </div>

            <asp:GridView ID="gvCTDH" runat="server" AutoGenerateColumns="False" CssClass="product-table" GridLines="None">
                <Columns>
                    <asp:TemplateField HeaderText="Sản phẩm / Mô tả">
                        <ItemTemplate>
                            <div style="font-weight: 700; color: #0f172a; font-size: 14px;"><%# Eval("TenLaptop") %></div>
                            <div style="font-size: 11px; color: #64748b; margin-top: 2px;">MODEL ID: LPZ-<%# Eval("MaLaptop") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SoLuong" HeaderText="SL" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="DonGia" HeaderText="Đơn giá" DataFormatString="{0:N0} đ" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                    <asp:BoundField DataField="ThanhTien" HeaderText="Thành tiền" DataFormatString="{0:N0} đ" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true" />
                </Columns>
            </asp:GridView>

            <div class="summary-wrapper">
                <div class="summary-container">
                    <div class="summary-row">
                        <span>Giá trị đơn hàng:</span>
                        <span style="font-weight: 600; color: #0f172a;"><asp:Literal ID="ltrTongTienHang" runat="server" /></span>
                    </div>
                    <div class="summary-row">
                        <span>Vận chuyển (Express):</span>
                        <span style="color: #10b981; font-weight: 700;">MIỄN PHÍ</span>
                    </div>
                    <div class="summary-row total-row">
                        <span>TỔNG CỘNG:</span>
                        <span class="total-price"><asp:Literal ID="ltrTongTien" runat="server" /></span>
                    </div>
                </div>
            </div>

            <div class="signature-section">
                <div class="signature-box">
                    <p>Khách hàng</p>
                    <span style="font-size: 11px; color: #94a3b8; font-style: italic;">(Ký và ghi rõ họ tên)</span>
                </div>
                <div class="signature-box">
                    <p>Đại diện LaptopZone</p>
                    <div>
                        <div class="stamp">PAID / ĐÃ THANH TOÁN</div>
                    </div>
                    <span style="font-size: 11px; color: #94a3b8; font-style: italic;">(Xác nhận hệ thống)</span>
                </div>
            </div>

            <div class="footer-note">
                <p style="font-size: 13px; color: #475569; font-weight: 600; margin: 0;">Trân trọng cảm ơn quý khách!</p>
                <p style="font-size: 11px; color: #94a3b8; margin-top: 8px;">Mọi vấn đề về bảo hành vui lòng mang theo hóa đơn này hoặc cung cấp mã đơn hàng.</p>
            </div>
        </div>
    </form>
</body>
</html>