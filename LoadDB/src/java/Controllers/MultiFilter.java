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
import java.util.Collections;
import java.util.Comparator;
import java.util.Vector;

/**
 *
 * @author admin
 */
public class MultiFilter extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object o1 = request.getParameter("type");
        Object o2 = request.getParameter("id");
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
        request.setAttribute("deptSlt", deptSelect);

//        request.getRequestDispatcher("Views/FilterStudent.jsp").forward(request, response);
        request.getRequestDispatcher("Views/MultiFilter.jsp").forward(request, response);
    }
    Vector<String> deptSelect = new Vector<String>();

    {
        deptSelect = new Vector<>();
        deptSelect.add("All");
    }
    int k = 1;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        if(request.getParameter("btnFilter")!=null) {
//            String id = request.getParameter("sltDept");
//            request.setAttribute("FDeptId", id);
//            doGet(request,response);
//        } else {
//            
//        }
        if (request.getParameter("btnSort") == null) {
            // Filter logic
            deptSelect.clear();
            if (request.getParameter("All") != null) {
                deptSelect.add("All");
            } else {
                for (Department d : DAO.INSTANCE.getDept()) {
                    if (request.getParameter("chk" + d.getId()) != null) {
                        deptSelect.add(d.getId());
                    }
                }
            }
            request.setAttribute("deptSlt", deptSelect);
            DAO.INSTANCE.LoadStd(deptSelect);
        } else { //btnSort!=null
            // Sort logic
            k = k * -1;
            Collections.sort(DAO.INSTANCE.getStd(), new Comparator<Student>() {
                public int compare(Student o1, Student o2) {
                    return k * Float.compare(o1.getGpa(), o2.getGpa());
                }
            });
        }

// Chung cho cả Filter và Sort
        request.setAttribute("dao", DAO.INSTANCE);
        request.setAttribute("deptSlt", deptSelect);
        request.getRequestDispatcher("Views/MultiFilter.jsp").forward(request, response);
    }
}
