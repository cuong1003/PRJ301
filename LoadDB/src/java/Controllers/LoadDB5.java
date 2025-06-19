/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAL.DAO;
import Models.Department;
import Models.Student;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
public class LoadDB5 extends HttpServlet {

    DAO dao;

    public void init() {
        dao = new DAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>5.Combo-box x Combo-box</title>");
            out.println("<script src='js/myjs.js'></script>");
            if (request.getAttribute("duplicateId") != null) {
                out.println("<script>");
                out.println("window.onload = function() { thongbaotrunglap(); };");
                out.println("</script>");
            }
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoadDB at " + request.getContextPath() + "</h1>");
            dao.LoadStd();
            dao.LoadDept();
            Student stUpdate = null;
            int stId = -1;
            if (request.getAttribute("update") != null) {
                try {
                    stId = Integer.parseInt(request.getAttribute("update") + "");
                } catch (Exception e) {
                }
            }
            for (Student st : dao.getStd()) {
                if (st.getId() == stId) {
                    stUpdate = st;
                }
            }
            String tbl = "<table>";
            out.println("<h1>Servlet LoadDB at " + dao.getStatus() + "</h1>");

            for (Student st : dao.getStd()) {
                tbl += "<tr>";
                tbl += "<td>" + st.getId() + "</td>";
                tbl += "<td>" + st.getName() + "</td>";
                tbl += "<td>" + (st.isGender() ? "Male" : "Female") + "</td>";
                tbl += "<td>" + "<input type='checkbox'" + (st.isGender() ? "checked" : "") + " >" + (st.isGender() ? "Male" : "Female") + "</td>";
                tbl += "<td>" + "<input type='radio' name='rdb" + (st.getId()) + "'" + (st.isGender() ? "checked" : "") + " >" + "Male" + "</td>";
                tbl += "<td>" + "<input type='radio' name='rdb" + (st.getId()) + "'" + (st.isGender() ? "" : "checked") + " >" + "Female" + "</td>";
                tbl += "<td>" + dao.GetDeptName(st.getDepartId()) + "</td>";
                tbl += "<td>" + st.getDob() + "</td>";
                tbl += "<td>" + st.getGpa() + "</td>";
                tbl += "<td><a href='LoadDB5?type=0&id=" + st.getId() + "'>Update</a></td>";
                tbl += "<td><a href='javascript:void(0)' onclick='confirmDelete(" + st.getId() + ", \"" + st.getName() + "\", \"LoadDB5\")'>Delete</a></td>";
                tbl += "</tr>";
            }
            tbl += "</table>";
            //Gender: checkbox  ;  Department: select
            String form = "<form action='LoadDB5' method='post'>\n"
                    + "            Id: <input type='text' name='txtId' value='"
                    + (stUpdate != null?stUpdate.getId():"")
                    + "'/><br/>\n"
                    + "            Name: <input type='text' name='txtName' value='"
                    + (stUpdate != null?stUpdate.getName():"")
                    + "'><br/>\n"
                    + "            Gender: <select name='chkGender'>\n"
                    + "                <option value='true' " + (stUpdate != null?(stUpdate.isGender() ? "selected" : ""):"") + ">Male</option>\n"
                    + "                <option value='false' " + (stUpdate != null?(stUpdate.isGender() ? "" : "selected"):"") + ">Female</option>\n"
                    + "            </select><br/>\n"
                    + "            Department: <select name='sltDept'>";
            for (Department de : dao.getDept()) {
                form += "<option value = '" + de.getId() + "' "
                        + (stUpdate != null && de.getId().equals(stUpdate.getDepartId()) ? "selected" : "")
                        + ">" + de.getName() + "</option>";
            }
            form += "</select> <br/> \n"
                    + "            Dob: <input type='date' name='datDob' value='"
                    + (stUpdate != null?stUpdate.getDob():"")
                    + "'><br/> \n"
                    + "            Gpa: <input type='text' name='txtGpa' value='"
                    + (stUpdate != null?stUpdate.getGpa():"")
                    + "'><br/>\n"
                    + "            <input type='submit' name='btnInsert' value='Insert'/>\n"
                    + "            <input type='submit' name='btnUpdate' value='Update'/>\n"
                    + "        </form>";
            out.println(form);
            out.println(tbl);
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Object o1 = request.getParameter("type");
        Object o2 = request.getParameter("id");
        if (o1 != null) {
            if ((o1 + "").equals("0")) {
                if (o2 != null) {
                    request.setAttribute("update", o2 + "");
                }
                //update
            } else if ((o1 + "").equals("1")) {
                if (o2 != null) {
                    try {
                        int id = Integer.parseInt(o2+"");
                        dao.Delete(id);
                    } catch (Exception e) {
                    }
                }
                //delete
            }
        }
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("txtId"));
        String name = request.getParameter("txtName");
        boolean gender = request.getParameter("chkGender") != null;
        String deptId = request.getParameter("sltDept");
        String dob = request.getParameter("datDob");
        float gpa = Float.parseFloat(request.getParameter("txtGpa"));
        boolean isUpdate = false;
        Object o1 = request.getParameter("btnInsert");
        Object o2 = request.getParameter("btnUpdate");
        isUpdate = o2 != null;
        boolean checkId = false;
        for (Student st : dao.getStd()) {
            if (st.getId() == id) {
                checkId = true;
                break;
            }
        }
        if (isUpdate && checkId) {
            dao.Update(id, name, gender, deptId, dob, gpa);
        }
        if (!isUpdate && !checkId) {
            dao.Insert(id, name, gender, deptId, dob, gpa);

        }else if (!isUpdate && checkId) {
            request.setAttribute("duplicateId", "true");
        }

        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
