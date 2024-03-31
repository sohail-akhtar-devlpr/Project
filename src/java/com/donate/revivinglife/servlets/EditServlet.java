package com.donate.revivinglife.servlets;

import com.donate.revivinglife.dao.UserDao;
import com.donate.revivinglife.entities.Message;
import com.donate.revivinglife.entities.User;
import com.donate.revivinglife.helper.ConnectionProvider;
import com.donate.revivinglife.helper.Helper;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;

/**
 *
 * @author sa451
 */
@MultipartConfig
public class EditServlet extends HttpServlet {

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
            out.println("<title>Servlet EditServlet</title>");
            out.println("</head>");
            out.println("<body>");

            //fetch forms data comming from edit profile form
            //save those data in the USERS table of the database 
            //FETCH ALL DATA
            String userEmail = request.getParameter("user_email");
            String userName = request.getParameter("user_name");
            String userPassword = request.getParameter("user_password");
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();

            //get the user from the session
            HttpSession s = request.getSession();
            //Here the user variable has old details
            User user = (User) s.getAttribute("currentUser");

            //to set for the new details mean edit details 
            user.setEmail(userEmail);
            user.setName(userName);
            user.setPassword(userPassword);
            String oldFile=user.getProfile();
            user.setProfile(imageName);

            //Now UPDATE THE DATABASE
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());

            boolean ans = userDao.updateUser(user);

            if (ans) {

                // Get the ServletContext
                ServletContext servletContext = getServletContext();

                // Construct the path to the directory where you want to save the file
                String uploadDirectory = servletContext.getRealPath("/pics");

                // Use File.separator for platform-independent file path
                String path = uploadDirectory + File.separator + user.getProfile();
                
                String pathOldFile = uploadDirectory + File.separator + oldFile;
                if(!oldFile.equals("default.png"))
                {
                    Helper.deleteFile(pathOldFile);
                }
                
                if (Helper.saveFile(part.getInputStream(), path)) {
                    //out.println("Profile Updated");
                    Message msg = new Message("Profile details Updated", "success", "alert-success");
                    s.setAttribute("msg", msg);
                } else {
                    Message msg = new Message("Something went wrong", "error", "alert-danger");
                    s.setAttribute("msg", msg);
                }
            } else {
                //out.println("Not Updated");
//                Message msg = new Message("Something went wrong", "error", "alert-danger");
//                s.setAttribute("msg", msg);
            }
            
            response.sendRedirect("profile.jsp");

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
