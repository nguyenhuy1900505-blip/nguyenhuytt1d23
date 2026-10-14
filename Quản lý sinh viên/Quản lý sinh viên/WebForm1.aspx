<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Quản_lý_sinh_viên.WebForm1" %>



<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        * { box-sizing: border-box; }
        
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

        .toolbar {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
            flex-wrap: wrap;
            align-items: center;
            background: #f8fafc;
            padding: 16px;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
        }

        .toolbar input[type="text"],
        .toolbar select {
            padding: 10px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: 0.2s;
            background: white;
        }
        .toolbar input[type="text"]:focus,
        .toolbar select:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
        }

        .btn {
            padding: 10px 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            color: white;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn:hover { transform: translateY(-1px); box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        .btn:active { transform: translateY(0); }

        .btn-primary { background: linear-gradient(135deg, #3b82f6, #2563eb); }
        .btn-success { background: linear-gradient(135deg, #22c55e, #16a34a); }
        .btn-warning { background: linear-gradient(135deg, #f59e0b, #d97706); }
        .btn-danger  { background: linear-gradient(135deg, #ef4444, #dc2626); }

        .grid {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.07), 0 2px 4px -1px rgba(0,0,0,0.04);
        }

        .grid th {
            background: linear-gradient(135deg, #1e293b, #334155);
            color: white;
            padding: 14px 12px;
            text-align: center;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .grid td {
            padding: 14px 12px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
            color: #334155;
            vertical-align: middle;
            text-align: center;
        }

        .grid tr:last-child td { border-bottom: none; }
        .grid tr:hover td { background: #f8fafc; }

        .avatar {
            width: 70px;
            height: 70px;
            border-radius: 8px;
            object-fit: cover;
            border: 3px solid #e2e8f0;
            background: #f1f5f9;
            box-shadow: 0 3px 8px rgba(0,0,0,0.12);
        }

        .action-btn {
            padding: 6px 12px;
            margin-right: 6px;
            border: none;
            border-radius: 6px;
            color: white;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            transition: 0.2s;
        }
        .action-btn:last-child { margin-right: 0; }
        .action-btn:hover { opacity: 0.9; transform: scale(1.05); }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0; top: 0;
            width: 100%; height: 100%;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            animation: fadeIn 0.2s;
        }

        .modal-content {
            background: white;
            margin: 4% auto;
            padding: 32px;
            width: 480px;
            max-width: 95%;
            border-radius: 16px;
            box-shadow: 0 25px 50px -12px rgba(0,0,0,0.25);
            animation: slideUp 0.3s;
        }

        .modal-content h3 {
            margin: 0 0 24px 0;
            font-size: 20px;
            color: #1e293b;
            font-weight: 700;
        }

        .form-group {
            margin-bottom: 18px;
        }
        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            font-size: 13px;
            color: #475569;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 11px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            transition: 0.2s;
            outline: none;
        }
        .form-group input:focus,
        .form-group select:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 28px;
            padding-top: 20px;
            border-top: 1px solid #f1f5f9;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        @keyframes slideUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .grid .pager {
            background: #f8fafc;
            padding: 12px;
        }
        .grid .pager table { margin: 0 auto; }
        .grid .pager td {
            padding: 4px 8px !important;
            border: none !important;
        }
        .grid .pager a, .grid .pager span {
            padding: 6px 12px;
            border-radius: 6px;
            margin: 0 2px;
            text-decoration: none;
            color: #3b82f6;
            font-weight: 600;
        }
        .grid .pager span {
            background: #3b82f6;
            color: white;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-title">
        <span>🎓</span> QUẢN LÝ SINH VIÊN
    </div>

    <div class="toolbar">
        <asp:TextBox ID="txtSearch" runat="server" placeholder="🔍 Tìm theo mã SV hoặc họ tên..." Width="280px" />
        <asp:DropDownList ID="ddlLop" runat="server" Width="200px" />
        <asp:Button ID="btnLoc" runat="server" Text="Lọc dữ liệu" CssClass="btn btn-primary" OnClick="btnLoc_Click" />
        <asp:Button ID="btnThem" runat="server" Text="+ Thêm sinh viên" CssClass="btn btn-success" OnClick="btnThem_Click" />
    </div>

    <asp:GridView ID="gvSinhVien" runat="server" AutoGenerateColumns="False" CssClass="grid"
        DataKeyNames="MaSV" AllowPaging="True" PageSize="6"
        OnRowCommand="gvSinhVien_RowCommand" OnPageIndexChanging="gvSinhVien_PageIndexChanging"
        PagerStyle-CssClass="pager">
        <Columns>
            <asp:BoundField DataField="MaSV" HeaderText="Mã SV" />
            
            <asp:TemplateField HeaderText="Ảnh">
                <ItemTemplate>
                    <asp:Image ID="img" runat="server" CssClass="avatar"
                        ImageUrl='<%# string.IsNullOrEmpty(Eval("Anh")?.ToString()) 
                                    ? "~/images/default.png" 
                                    : "~/images/" + Eval("Anh") %>' />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="HotenSV" HeaderText="Họ và tên" />
            <asp:BoundField DataField="ngaysinh" HeaderText="Ngày sinh" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="SDT" HeaderText="Số điện thoại" />
            <asp:BoundField DataField="TenLop" HeaderText="Lớp" />

            <asp:TemplateField HeaderText="Thao tác">
                <ItemTemplate>
                    <asp:LinkButton ID="btnSua" runat="server" CommandName="Sua" 
                        CommandArgument='<%# Eval("MaSV") %>'
                        CssClass="action-btn btn-warning" Text="Sửa" />
                    <asp:LinkButton ID="btnXoa" runat="server" CommandName="Xoa" 
                        CommandArgument='<%# Eval("MaSV") %>'
                        CssClass="action-btn btn-danger" Text="Xóa"
                        OnClientClick="return confirm('Bạn chắc chắn muốn xóa sinh viên này?');" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <div id="modalForm" class="modal">
        <div class="modal-content">
            <h3 id="modalTitle">Thêm sinh viên mới</h3>
            
            <asp:HiddenField ID="hfMaSV" runat="server" />
            <asp:HiddenField ID="hfAnhCu" runat="server" />

            <div class="form-group">
                <label>Mã sinh viên</label>
                <asp:TextBox ID="txtMaSV" runat="server" placeholder="Ví dụ: SV007" />
            </div>
            <div class="form-group">
                <label>Họ và tên</label>
                <asp:TextBox ID="txtHoten" runat="server" placeholder="Nhập họ tên đầy đủ" />
            </div>
            <div class="form-group">
                <label>Ngày sinh</label>
                <asp:TextBox ID="txtNgaySinh" runat="server" TextMode="Date" />
            </div>
            <div class="form-group">
                <label>Số điện thoại</label>
                <asp:TextBox ID="txtSDT" runat="server" placeholder="0xxxxxxxxx" />
            </div>
            <div class="form-group">
                <label>Lớp học</label>
                <asp:DropDownList ID="ddlLopForm" runat="server" />
            </div>
            <div class="form-group">
                <label>Ảnh đại diện</label>
                <asp:FileUpload ID="fuAnh" runat="server" />
                <asp:Label ID="lblAnhCu" runat="server" ForeColor="#64748b" Font-Size="13px" style="display:block;margin-top:6px;"></asp:Label>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-danger" onclick="closeModal()">Hủy bỏ</button>
                <asp:Button ID="btnLuu" runat="server" Text="Lưu lại" CssClass="btn btn-success" OnClick="btnLuu_Click" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
function openModal(isEdit) {
    document.getElementById('modalForm').style.display = 'block';
    document.getElementById('modalTitle').innerText = isEdit ? 'Cập nhật thông tin sinh viên' : 'Thêm sinh viên mới';
}
function closeModal() {
    document.getElementById('modalForm').style.display = 'none';
}

window.onclick = function (event) {
    var modal = document.getElementById('modalForm');
    if (event.target == modal) {
        closeModal();
    }
}
</script>
</asp:Content>