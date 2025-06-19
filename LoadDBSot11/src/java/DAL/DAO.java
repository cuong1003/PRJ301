package DAL;

import Models.*;
import java.sql.*;
import java.util.Vector;

public class DAO {

    private String status = "ok";
    private Connection con;
    private Vector<Student> std;
    private Vector<Department> dept; //dung Vector thay vi ArrayList vi co co che dong bo

    public static DAO INSTANCE = new DAO();

    public DAO() {
        if (INSTANCE == null) {
            INSTANCE = this;
            try {
                con = new DBContext().getConnection();
            } catch (Exception e) {
                status = "Error at connection " + e.getMessage();
            }
        }
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Vector<Student> getStd() {
        return std;
    }

    public void setStd(Vector<Student> std) {
        this.std = std;
    }

    public Vector<Department> getDept() {
        return dept;
    }

    public void setDept(Vector<Department> dept) {
        this.dept = dept;
    }

    public void LoadStd() {
        String sql = "select * from Student";
        std = new Vector<>();
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Student st = new Student();
                st.setId(rs.getInt(1));
                st.setName(rs.getString(2));
                st.setGender(rs.getBoolean(3));
                st.setDepartId(rs.getString(4));
                st.setDob(rs.getDate(5));
                st.setGpa(rs.getFloat(6));
                std.add(st);
            }

        } catch (Exception e) {
            status = "Error at read Student " + e.getMessage();
        }

    }

    public void LoadDept() {
        String sql = "select * from Department";
        dept = new Vector<>();
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                dept.add(new Department(rs.getString(1), rs.getString(2)));
            }
        } catch (Exception e) {
            status = "Error at read Department " + e.getMessage();
        }
    }

//    public static void main(String[] args) {
//        DAO dao = new DAO();
//
//        System.out.println("Connection status: " + dao.getStatus());
//
//        if (dao.getStatus().equals("ok")) {
//            dao.LoadStd(); // Load danh sách sinh viên
//
//            Vector<Student> students = dao.getStd();
//            System.out.println("Danh sách sinh viên:");
//
//            for (Student st : students) {
//                System.out.println(st); // Gọi toString()
//            }
//        } else {
//            System.out.println("Không thể kết nối CSDL. Kiểm tra lại DBContext.");
//        }
//    }
    public String GetDeptName(String id) {
        for (Department de : dept) {
            if (de.getId().equals(id)) {
                return de.getName();
            }
        }
        return null;
    }

    public void Insert(int id, String name, boolean gender, String deptId, String dob, float gpa) {
        String sql = "Insert into Student values(?,?,?,?,?,?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setString(2, name);
            ps.setString(4, deptId);
            ps.setString(5, dob);
            ps.setBoolean(3, gender);
            ps.setFloat(6, gpa);
            ps.execute();
        } catch (Exception e) {
            status = "Error at Insert Student " + e.getMessage();
        }
    }

    public void Update(int id, String name, boolean gender, String deptId, String dob, float gpa) {
        String sql = "Update Student set gpa=?,name=?,gender=?,departId=?,dob=? where id = ?"; //loi 1=1 -> dung prepare
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(6, id);
            ps.setString(2, name);
            ps.setString(4, deptId);
            ps.setString(5, dob);
            ps.setBoolean(3, gender);
            ps.setFloat(1, gpa);
            ps.execute();
        } catch (Exception e) {
            status = "Error at Update Student " + e.getMessage();
        }
    }

    public void Delete(int id) {
        String sql = "delete from Student where id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.execute();
        } catch (Exception e) {
            status = "Error at Delete Student " + e.getMessage();
        }
    }

    public void Filter(String id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void LoadStd(Vector<String> deptSelect) {
        if (deptSelect.contains("All")) {
            LoadStd();
        } else {
            String sql = "select * from Student s where 1=0 ";
            String str = "";
            for (String s : deptSelect) {
                str += "or s.departId = '" + s + "' ";
            }
            sql = sql + str;

            std = new Vector<>();
            try {
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Student st = new Student();
                    st.setId(rs.getInt(1));
                    st.setName(rs.getString(2));
                    st.setGender(rs.getBoolean(3));
                    st.setDepartId(rs.getString(4));
                    st.setDob(rs.getDate(5));
                    st.setGpa(rs.getFloat(6));
                    std.add(st);
                }

            } catch (Exception e) {
                status = "Error at read Student " + e.getMessage();
            }
        }
    }

}
