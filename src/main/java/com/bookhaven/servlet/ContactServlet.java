package com.bookhaven.servlet;

import com.bookhaven.dao.ContactDAO;
import com.bookhaven.model.Contact;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet for handling contact form submissions
 */
public class ContactServlet extends HttpServlet {
    
    private ContactDAO contactDAO = new ContactDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forward to contact page
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");
        
        // Create contact object
        Contact contact = new Contact(name, email, phone, message);
        
        // Save to database
        boolean saved = contactDAO.saveContact(contact);
        
        if (saved) {
            request.setAttribute("successMessage", "Thank you for contacting us! We will get back to you soon.");
        } else {
            request.setAttribute("errorMessage", "Failed to submit your message. Please try again.");
        }
        
        // Forward back to contact page
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }
}
