package com.bookhaven.servlet;

import com.bookhaven.dao.BookDAO;
import com.bookhaven.dao.ContactDAO;
import com.bookhaven.model.Book;
import com.bookhaven.model.Contact;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for admin dashboard
 */
public class AdminDashboardServlet extends HttpServlet {
    
    private BookDAO bookDAO = new BookDAO();
    private ContactDAO contactDAO = new ContactDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        // Get all books and contacts
        List<Book> books = bookDAO.getAllBooks();
        List<Contact> contacts = contactDAO.getAllContacts();
        
        request.setAttribute("books", books);
        request.setAttribute("contacts", contacts);
        
        // Forward to dashboard page
        request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
    }
}
