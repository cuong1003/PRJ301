/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers;

import DAL.DAO;
import Models.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author c9
 */
public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("Views/Login.jsp").forward(request, response);
    } 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        processRequest(request, response);
          DAO dao = new DAO();
          String u = request.getParameter("username").trim();
          String p = request.getParameter("password").trim();
          //debug xem co u p ko
          request.setAttribute("uu", u);
          
          Users loginUser = dao.checkLogin(u, p);
          if (loginUser != null) {
              HttpSession ses = request.getSession();
              ses.setAttribute("us",loginUser);
              response.sendRedirect(request.getContextPath() + "/Admin/Admin01");
          } else {
              request.setAttribute("fail", "User or Password wrong!");
              request.getRequestDispatcher("Views/Login.jsp").forward(request, response);
          }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
