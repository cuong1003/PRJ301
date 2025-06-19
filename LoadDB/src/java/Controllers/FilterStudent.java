/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import DAL.DAO;
import Models.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author c9
 */
public class FilterStudent extends  HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        Object o1 = request.getParameter("type");
        Object o2 = request.getParameter("id");
        DAO.INSTANCE.LoadStd();
        DAO.INSTANCE.LoadDept();
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
                        //dao.Delete(id);
                        DAO.INSTANCE.Delete(id);
                    } catch (Exception e) {
                    }
                }
                //delete
            }
        }
        if (request.getAttribute("FDeptId") == null) {
            request.setAttribute("FDeptId", "ALL");
        }
        request.setAttribute("dao", DAO.INSTANCE);
        request.getRequestDispatcher("Views/FilterStudent.jsp").forward(request, resp);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        String id = request.getParameter("sltDept");
        String ids = request.getParameter("radioDept");
        String filterValue = "ALL";
        if (id != null) {
            filterValue = id;
        } else if (ids != null) {
            filterValue = ids;
        }
        
        String gender = request.getParameter("genderFilter");
        String genderValue = "All";
        if (gender != null) {
            if ("M".equals(gender)) {
                genderValue = "M";
            } else if ("F".equals(gender)) {
                genderValue = "F";
            }
        }
        
        // nếu người dùng chọn cả 2 Filter cho Depart và Gender thì mặc định Logic ban đầu là AND
        String logic = request.getParameter("logicFilter");
        if (logic == null && !filterValue.equals("ALL") && !genderValue.equals("All")) {
            logic = "AND";
        }
        
        request.setAttribute("FGender", genderValue);
        request.setAttribute("FLogic", logic);
        request.setAttribute("FDeptId", filterValue);
        doGet(request, resp);
    }
    
    
}
