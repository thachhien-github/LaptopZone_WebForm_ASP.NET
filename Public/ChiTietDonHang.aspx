<%@ Page Title="Chi tiết Đơn Hàng" Language="C#" MasterPageFile="~/Public/Site.Master" AutoEventWireup="true" CodeBehind="ChiTietDonHang.aspx.cs" Inherits="LaptopZone_project.Public.ChiTietDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold">Chi tiết đơn hàng #<asp:Literal ID="ltrSoDH" runat="server"></asp:Literal></h2>
            <a href="Profile.aspx" class="btn btn-outline-secondary rounded-pill">
                <i class="bi bi-arrow-left"></i> Quay lại lịch sử
            </a>
        </div>

        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="card-body p-0">
                <asp:GridView ID="gvChiTiet" runat="server" AutoGenerateColumns="False" 
                    CssClass="table table-hover mb-0" GridLines="None">
                    <HeaderStyle CssClass="bg-light py-3" />
                    <Columns>
                        <asp:TemplateField HeaderText="Sản phẩm">
                            <ItemTemplate>
                                <div class="d-flex align-items-center py-2 px-3">
                                    <img src='<%# "../Images/" + Eval("AnhBia") %>' alt="" style="width: 60px; height: 60px; object-fit: cover;" class="rounded me-3" />
                                    <span class="fw-bold"><%# Eval("TenLaptop") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="DonGia" HeaderText="Đơn giá" DataFormatString="{0:N0} đ" ItemStyle-CssClass="align-middle" />
                        <asp:BoundField DataField="SoLuong" HeaderText="Số lượng" ItemStyle-CssClass="align-middle text-center" HeaderStyle-CssClass="text-center" />
                        <asp:BoundField DataField="ThanhTien" HeaderText="Thành tiền" DataFormatString="{0:N0} đ" ItemStyle-CssClass="align-middle text-end fw-bold text-primary" HeaderStyle-CssClass="text-end px-3" />
                    </Columns>
                </asp:GridView>
            </div>
            <div class="card-footer bg-white p-4 text-end">
                <h4 class="mb-0">Tổng giá trị đơn hàng: <span class="text-danger fw-bold"><asp:Literal ID="ltrTongTien" runat="server"></asp:Literal> đ</span></h4>
            </div>
        </div>
    </div>
</asp:Content>

