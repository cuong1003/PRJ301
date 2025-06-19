function confirmDelete(id, name, servletName) {
    if(confirm(`Bạn có chắc chắn muốn xóa sinh viên sau \nStudenID: ${id}  \nStudentName: ${name}`)) {
        window.location.href= servletName + '?type=1&id=' + id;
    }
}
function thongbaotrunglap() {
    alert('ID đã tồn tại! Vui lòng chọn ID khác.\nHoặc chọn Update nếu muốn cập nhật thông tin.');
} 