/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAL.DAO;
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
public class LoadDB_jsp extends HttpServlet {

//    DAO dao;
//
//    public void init() {
//        dao = new DAO();
//    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Object o1 = request.getParameter("type");
        Object o2 = request.getParameter("id");
//        dao.LoadStd();
//        dao.LoadDept();

        if (o1 != null) {
            if ((o1 + "").equals("0")) {
                if (o2 != null) {
                    request.setAttribute("update", o2 + "");
                }
            } else if ((o1 + "").equals("1")) {
                if (o2 != null) {
                    try {
                        int id = Integer.parseInt(o2 + "");
                        DAO.INSTANCE.Delete(id);
                    } catch (Exception e) {
                    }
                }
            }

        }
        DAO.INSTANCE.LoadStd();
        DAO.INSTANCE.LoadDept();
        request.setAttribute("dao", DAO.INSTANCE);
        request.getRequestDispatcher("Views/LoadDB_jsp.jsp").forward(request, response);
    }

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
        for (Student st : DAO.INSTANCE.getStd()) {
            if (st.getId() == id) {
                checkId = true;
                break;
            }
        }
        if (isUpdate && checkId) {
            DAO.INSTANCE.Update(id, name, gender, deptId, dob, gpa);
        }
        if (!isUpdate && !checkId) {
            DAO.INSTANCE.Insert(id, name, gender, deptId, dob, gpa);

        }
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}