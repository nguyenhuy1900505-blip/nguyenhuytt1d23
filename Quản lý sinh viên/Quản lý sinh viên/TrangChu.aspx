<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="Quản_lý_sinh_viên.TrangChu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .page-title {
            font-size: 24px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 24px;
            padding-bottom: 12px;
            border-bottom: 3px solid #3b82f6;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .welcome {
            background: linear-gradient(135deg, #3b82f6, #1e293b);
            color: white;
            padding: 32px;
            border-radius: 16px;
            margin-bottom: 24px;
            box-shadow: 0 10px 25px -5px rgba(59, 130, 246, 0.35);
        }
        .welcome h2 { font-size: 26px; margin-bottom: 8px; }
        .welcome p { font-size: 15px; opacity: 0.9; }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 24px;
        }
        .stat-card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 24px;
            text-align: center;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.07);
            transition: 0.2s;
        }
        .stat-card:hover { transform: translateY(-3px); box-shadow: 0 10px 20px -5px rgba(0,0,0,0.12); }
        .stat-icon { font-size: 36px; margin-bottom: 8px; }
        .stat-number { font-size: 36px; font-weight: 700; color: #1e293b; }
        .stat-label { font-size: 14px; color: #64748b; margin-top: 4px; }

        .quick-title {
            font-size: 18px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 14px;
        }
        .quick-links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
        }
        .quick-link {
            display: block;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            text-decoration: none;
            color: #334155;
            font-weight: 600;
            transition: 0.2s;
        }
        .quick-link:hover {
            background: #3b82f6;
            color: white;
            border-color: #3b82f6;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-title">
        <span>🏠</span> TRANG CHỦ
    </div>

    <div class="welcome">
        <h2>Chào mừng đến với hệ thống Quản lý Sinh viên</h2>
        <p>Hôm nay là <asp:Label ID="lblNgay" runat="server" /></p>
    </div>

    <div class="stats">
        <div class="stat-card">
            <div class="stat-icon">🎓</div>
            <div class="stat-number"><asp:Label ID="lblTongSV" runat="server" Text="0" /></div>
            <div class="stat-label">Tổng số sinh viên</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">🏫</div>
            <div class="stat-number"><asp:Label ID="lblTongLop" runat="server" Text="0" /></div>
            <div class="stat-label">Tổng số lớp học</div>
        </div>
    </div>

    <div class="quick-title">Truy cập nhanh</div>
    <div class="quick-links">
        <a class="quick-link" href="WebForm1.aspx">🎓 Quản lý sinh viên</a>
        <a class="quick-link" href="#">🏫 Quản lý lớp học</a>
        <a class="quick-link" href="#">📋 Tra cứu &amp; Điểm danh</a>
    </div>

</asp:Content>