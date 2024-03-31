/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.donate.revivinglife.servlets;

import com.donate.revivinglife.helper.ConnectionProvider;
import com.donate.revivinglife.dao.UserDao;
import com.donate.revivinglife.entities.Message;
import com.donate.revivinglife.entities.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


/**
 *
 * @author sa451
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            
            //login_page.jsp ke form se sara data yaha is LoginServlet pr aayega
//            fetch username and password from request
                
            String userEmail=request.getParameter("email");
            String userPassword=request.getParameter("password");
            
            
            UserDao dao= new UserDao(ConnectionProvider.getConnection());
            User u=dao.getUserByEmailAndPassword(userEmail, userPassword);
            
            if(u==null)
            {
                //login error message will be shown
                
                //out.println("Invalid details...try again");
                
                Message msg= new Message("Invalid Login Credentials! try again","error","alert-danger");
                HttpSession s= request.getSession();
                s.setAttribute("msg", msg);
                
                response.sendRedirect("login_page.jsp");
                
            }
            else
            {
                //login success
                //session ka object ek hota hain,jab tak browser band nhi hoga tab tak wo
                // session ka object manage hoga
                //ham kya karenge ki poora ka poora user session me store kardenege
                //wo session tabtak ragega jab tak user login hain
                //ya to user log out karde ya browser band karde jisse wo sign out hojayega.
                
                HttpSession s= request.getSession();
                //setAttribute() takes two parameters, key and value
                s.setAttribute("currentUser", u);
                if(u.getUserType().equals("admin"))
                {
                    response.sendRedirect("admin_page.jsp");
                }
                else if(u.getUserType().equals("user"))
                {
                     response.sendRedirect("profile.jsp");
                }
                else
                {
                    System.out.println("WE HAVE NOT IDENTIIED YOU");
                }
               
            }

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
        processRequest(request, response);
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
