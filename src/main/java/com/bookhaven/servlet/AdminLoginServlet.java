package com.bookhaven.servlet;

import com.bookhaven.dao.AdminDAO;
import com.bookhaven.model.Admin;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet for handling admin login
 */
public class AdminLoginServlet extends HttpServlet {
    
    private AdminDAO adminDAO = new AdminDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to login page
        request.getRequestDispatcher("/admin-login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate credentials
        Admin admin = adminDAO.validateAdmin(username, password);
        
        if (admin != null) {
            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            session.setAttribute("adminUsername", admin.getUsername());
            
            // Redirect to admin dashboard
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            // Login failed
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/admin-login.jsp").forward(request, response);
        }
    }
}
