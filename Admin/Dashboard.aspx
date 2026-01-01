<%@ Page Title="Dashboard - LaptopZone Admin" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LaptopZone_project.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .page-fade-in {
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(12px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .stat-card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

            .stat-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 12px 24px -8px rgba(0,0,0,0.05);
            }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 6px;
        }

        ::-webkit-scrollbar-track {
            background: transparent;
        }

        ::-webkit-scrollbar-thumb {
            background: #e2e8f0;
            border-radius: 10px;
        }

            ::-webkit-scrollbar-thumb:hover {
                background: #cbd5e1;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="flex flex-col gap-8 p-2 md:p-4 page-fade-in">

        <%-- Header & Date Filter --%>
        <div class="flex flex-col lg:flex-row justify-between items-start lg:items-center gap-6">
            <div>
                <h2 class="text-3xl font-black text-[#2d3436] tracking-tight">Trung tâm điều hành</h2>
                <p class="text-slate-500 font-medium mt-1">Phân tích số liệu kinh doanh thời gian thực</p>
            </div>

            <div class="flex flex-wrap items-center gap-3 bg-white p-2 rounded-2xl shadow-sm border border-slate-100 w-full lg:w-auto">
                <div class="flex items-center px-4 py-1 border-r border-slate-100 group">
                    <span class="material-symbols-outlined text-slate-400 text-[20px] mr-3 group-focus-within:text-[#0984e3]">calendar_month</span>
                    <asp:TextBox ID="txtTuNgay" runat="server" TextMode="Date" CssClass="text-sm border-none focus:ring-0 text-slate-600 font-bold outline-none"></asp:TextBox>
                </div>
                <div class="flex items-center px-4 py-1">
                    <asp:TextBox ID="txtDenNgay" runat="server" TextMode="Date" CssClass="text-sm border-none focus:ring-0 text-slate-600 font-bold outline-none"></asp:TextBox>
                </div>
                <asp:LinkButton ID="btnLoc" runat="server" OnClick="btnLoc_Click"
                    CssClass="bg-[#0984e3] hover:bg-[#0873c4] text-white px-6 py-2.5 rounded-xl font-bold text-xs uppercase tracking-wider transition-all shadow-md shadow-blue-100 flex items-center gap-2">
                    <span class="material-symbols-outlined text-[18px]">sync_alt</span> Cập nhật
                </asp:LinkButton>
            </div>
        </div>

        <%-- Stat Cards --%>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <div class="bg-white p-6 rounded-[2rem] border border-slate-100 stat-card group">
                <div class="flex justify-between items-start mb-4">
                    <div class="size-14 bg-blue-50 text-[#0984e3] rounded-2xl flex items-center justify-center transition-colors group-hover:bg-[#0984e3] group-hover:text-white">
                        <span class="material-symbols-outlined text-[28px]">account_balance_wallet</span>
                    </div>
                    <span class="text-emerald-500 text-[11px] font-black bg-emerald-50 px-2.5 py-1 rounded-lg border border-emerald-100">+12.5%</span>
                </div>
                <p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">Tổng doanh thu</p>
                <h3 class="text-2xl font-black text-[#2d3436] mt-1 tracking-tight">
                    <asp:Literal ID="ltrDoanhThu" runat="server" />
                    <span class="text-sm font-bold">đ</span>
                </h3>
            </div>

            <div class="bg-white p-6 rounded-[2rem] border border-slate-100 stat-card group">
                <div class="flex justify-between items-start mb-4">
                    <div class="size-14 bg-amber-50 text-amber-600 rounded-2xl flex items-center justify-center transition-colors group-hover:bg-amber-600 group-hover:text-white">
                        <span class="material-symbols-outlined text-[28px]">shopping_basket</span>
                    </div>
                    <span class="text-slate-400 text-[10px] font-bold bg-slate-50 px-2 py-1 rounded-lg">Tháng này</span>
                </div>
                <p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">Đơn hàng mới</p>
                <h3 class="text-2xl font-black text-[#2d3436] mt-1 tracking-tight">
                    <asp:Literal ID="ltrDonHang" runat="server" />
                    <span class="text-sm font-bold uppercase">đơn</span>
                </h3>
            </div>

            <div class="bg-white p-6 rounded-[2rem] border border-slate-100 stat-card group">
                <div class="flex justify-between items-start mb-4">
                    <div class="size-14 bg-purple-50 text-purple-600 rounded-2xl flex items-center justify-center transition-colors group-hover:bg-purple-600 group-hover:text-white">
                        <span class="material-symbols-outlined text-[28px]">devices</span>
                    </div>
                </div>
                <p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">Thiết bị trong kho</p>
                <h3 class="text-2xl font-black text-[#2d3436] mt-1 tracking-tight">
                    <asp:Literal ID="ltrLaptop" runat="server" />
                    <span class="text-sm font-bold uppercase">máy</span>
                </h3>
            </div>

            <div class="bg-white p-6 rounded-[2rem] border border-slate-100 stat-card group">
                <div class="flex justify-between items-start mb-4">
                    <div class="size-14 bg-rose-50 text-rose-600 rounded-2xl flex items-center justify-center transition-colors group-hover:bg-rose-600 group-hover:text-white">
                        <span class="material-symbols-outlined text-[28px]">person_celebrate</span>
                    </div>
                </div>
                <p class="text-[11px] font-black text-slate-400 uppercase tracking-widest">Thành viên mới</p>
                <h3 class="text-2xl font-black text-[#2d3436] mt-1 tracking-tight">
                    <asp:Literal ID="ltrKhachHang" runat="server" />
                    <span class="text-sm font-bold uppercase">User</span>
                </h3>
            </div>
        </div>

        <%-- Charts Section --%>
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <div class="lg:col-span-2 bg-white p-8 rounded-[2.5rem] shadow-sm border border-slate-100">
                <div class="flex justify-between items-center mb-8">
                    <h3 class="font-black text-[#2d3436] flex items-center gap-2">
                        <span class="size-2 bg-[#0984e3] rounded-full"></span>
                        Hiệu suất doanh thu (7 ngày gần nhất)
                    </h3>
                </div>
                <div class="h-[360px] w-full">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>

            <div class="bg-white p-8 rounded-[2.5rem] shadow-sm border border-slate-100">
                <h3 class="font-black text-[#2d3436] mb-8 text-center">Tỷ trọng dòng máy</h3>
                <div class="h-[300px] flex items-center justify-center relative">
                    <canvas id="categoryChart"></canvas>
                </div>
                <div class="mt-6 space-y-2" id="chartLegend"></div>
            </div>
        </div>

        <%-- Table & List Section --%>
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-8">
            <div class="lg:col-span-2 bg-white rounded-[2.5rem] shadow-sm border border-slate-100 overflow-hidden">
                <div class="px-8 py-6 border-b border-slate-50 flex justify-between items-center">
                    <h3 class="font-black text-[#2d3436]">Giao dịch vừa thực hiện</h3>
                    <a href="QuanLyDonHang.aspx" class="text-[#0984e3] text-xs font-black uppercase tracking-wider hover:underline">Tất cả</a>
                </div>
                <div class="overflow-x-auto p-4">
                    <asp:GridView ID="gvMoiNhat" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="w-full text-left">
                        <Columns>
                            <asp:TemplateField HeaderText="Khách hàng" HeaderStyle-CssClass="px-4 py-3 text-[10px] font-black text-slate-400 uppercase tracking-widest">
                                <ItemTemplate>
                                    <div class="flex items-center gap-3 py-2">
                                        <div class="size-9 rounded-xl bg-slate-100 text-slate-600 flex items-center justify-center font-black text-xs border border-slate-200 uppercase">
                                            <%# Eval("HoTenKH").ToString().Substring(0,1) %>
                                        </div>
                                        <span class="text-sm font-bold text-slate-700"><%# Eval("HoTenKH") %></span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Giá trị" HeaderStyle-CssClass="px-4 py-3 text-[10px] font-black text-slate-400 uppercase tracking-widest text-right">
                                <ItemStyle CssClass="text-right" />
                                <ItemTemplate>
                                    <span class="text-sm font-black text-[#2d3436]"><%# Eval("TriGia", "{0:N0}") %>đ</span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Trạng thái" HeaderStyle-CssClass="px-4 py-3 text-[10px] font-black text-slate-400 uppercase tracking-widest text-center">
                                <ItemStyle CssClass="text-center" />
                                <ItemTemplate>
                                    <span class='<%# Convert.ToBoolean(Eval("DaGiao")) ? "bg-emerald-50 text-emerald-600 border-emerald-100" : "bg-amber-50 text-amber-600 border-amber-100" %> px-3 py-1 rounded-lg text-[10px] font-black uppercase border'>
                                        <%# Convert.ToBoolean(Eval("DaGiao")) ? "Đã giao" : "Chờ" %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <div class="bg-white p-8 rounded-[2.5rem] shadow-sm border border-slate-100">
                <h3 class="font-black text-[#2d3436] mb-6">Xếp hạng thương hiệu</h3>
                <div class="flex flex-col gap-4">
                    <asp:Repeater ID="rptTopBrands" runat="server">
                        <ItemTemplate>
                            <div class="flex items-center justify-between p-4 bg-slate-50 rounded-2xl border border-slate-100 hover:border-blue-200 transition-colors">
                                <div class="flex items-center gap-3">
                                    <span class="size-2 bg-blue-400 rounded-full"></span>
                                    <span class="font-bold text-slate-700 text-sm"><%# Eval("TenHang") %></span>
                                </div>
                                <span class="text-[#0984e3] font-black bg-white px-3 py-1 rounded-xl shadow-sm text-xs border border-slate-100"><%# Eval("SL") %> <span class="text-[9px] text-slate-400 font-bold uppercase ml-1">máy</span></span>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Biểu đồ Line Doanh Thu (Customized)
            const revenueData = <%= GetChartData() %>;
            const ctxRev = document.getElementById('revenueChart').getContext('2d');

            const revGradient = ctxRev.createLinearGradient(0, 0, 0, 400);
            revGradient.addColorStop(0, 'rgba(9, 132, 227, 0.15)');
            revGradient.addColorStop(1, 'rgba(9, 132, 227, 0)');

            new Chart(ctxRev, {
                type: 'line',
                data: {
                    labels: revenueData.labels,
                    datasets: [{
                        data: revenueData.values,
                        borderColor: '#0984e3',
                        borderWidth: 4,
                        backgroundColor: revGradient,
                        fill: true,
                        tension: 0.45,
                        pointBackgroundColor: '#fff',
                        pointBorderColor: '#0984e3',
                        pointBorderWidth: 3,
                        pointRadius: 5,
                        pointHoverRadius: 8
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false } },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: { color: '#f1f5f9', drawBorder: false },
                            ticks: { color: '#94a3b8', font: { size: 11, weight: 'bold' } }
                        },
                        x: {
                            grid: { display: false },
                            ticks: { color: '#94a3b8', font: { size: 11, weight: 'bold' } }
                        }
                    }
                }
            });

            // Biểu đồ Doughnut (Customized)
            const categoryData = <%= GetCategoryChartData() %>;
            new Chart(document.getElementById('categoryChart'), {
                type: 'doughnut',
                data: {
                    labels: categoryData.labels,
                    datasets: [{
                        data: categoryData.values,
                        backgroundColor: ['#0984e3', '#6c5ce7', '#00cec9', '#fab1a0', '#ffeaa7'],
                        borderWidth: 0,
                        hoverOffset: 15
                    }]
                },
                options: {
                    cutout: '75%',
                    responsive: true,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: '#2d3436',
                            padding: 12,
                            titleFont: { size: 14, weight: '900' },
                            usePointStyle: true
                        }
                    }
                }
            });
        });
    </script>
</asp:Content>

