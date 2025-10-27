<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bookhaven.model.Book"%>
<%@ page import="com.bookhaven.model.Contact"%>
<%@ page import="java.util.List"%>
<%
    request.setAttribute("pageTitle", "BookHaven - Admin Dashboard");
    
    // Check if admin is logged in
    if (session.getAttribute("admin") == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
    
    String adminUsername = (String) session.getAttribute("adminUsername");
    List<Book> books = (List<Book>) request.getAttribute("books");
    List<Contact> contacts = (List<Contact>) request.getAttribute("contacts");
%>
<jsp:include page="header.jsp" />

<!-- Page Header -->
<div class="hero-section">
    <div class="container">
        <h1 class="display-5">
            <i class="fas fa-tachometer-alt"></i> Admin Dashboard
        </h1>
        <p class="lead">Welcome back, <%= adminUsername %>!</p>
    </div>
</div>

<div class="container">
    
    <!-- Statistics Cards -->
    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="card-title">Total Books</h6>
                            <h2 class="mb-0"><%= books != null ? books.size() : 0 %></h2>
                        </div>
                        <i class="fas fa-book fa-3x opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="card-title">Contact Leads</h6>
                            <h2 class="mb-0"><%= contacts != null ? contacts.size() : 0 %></h2>
                        </div>
                        <i class="fas fa-envelope fa-3x opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-white bg-info">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="card-title">Featured Books</h6>
                            <h2 class="mb-0">
                                <% 
                                    int featuredCount = 0;
                                    if (books != null) {
                                        for (Book book : books) {
                                            if (book.isFeatured()) featuredCount++;
                                        }
                                    }
                                %>
                                <%= featuredCount %>
                            </h2>
                        </div>
                        <i class="fas fa-star fa-3x opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Books Section -->
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="fas fa-book"></i> Book Management</h5>
        </div>
        <div class="card-body">
            <% if (books != null && !books.isEmpty()) { %>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Author</th>
                                <th>ISBN</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Featured</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Book book : books) { %>
                                <tr>
                                    <td><%= book.getId() %></td>
                                    <td><strong><%= book.getTitle() %></strong></td>
                                    <td><%= book.getAuthor() %></td>
                                    <td><%= book.getIsbn() %></td>
                                    <td><span class="badge bg-secondary"><%= book.getCategory() %></span></td>
                                    <td>$<%= String.format("%.2f", book.getPrice()) %></td>
                                    <td>
                                        <% if (book.isFeatured()) { %>
                                            <span class="badge bg-success"><i class="fas fa-check"></i> Yes</span>
                                        <% } else { %>
                                            <span class="badge bg-secondary">No</span>
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> No books available in the database.
                </div>
            <% } %>
        </div>
    </div>
    
    <!-- Contacts Section -->
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0"><i class="fas fa-envelope"></i> Contact Leads</h5>
        </div>
        <div class="card-body">
            <% if (contacts != null && !contacts.isEmpty()) { %>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Message</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Contact contact : contacts) { %>
                                <tr>
                                    <td><%= contact.getId() %></td>
                                    <td><strong><%= contact.getName() %></strong></td>
                                    <td><%= contact.getEmail() %></td>
                                    <td><%= contact.getPhone() %></td>
                                    <td><%= contact.getMessage().length() > 50 ? contact.getMessage().substring(0, 50) + "..." : contact.getMessage() %></td>
                                    <td><%= contact.getCreatedAt() != null ? contact.getCreatedAt().toString() : "N/A" %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } else { %>
                <div class="alert alert-info">
                    <i class="fas fa-info-circle"></i> No contact submissions yet.
                </div>
            <% } %>
        </div>
    </div>
    
</div>

<jsp:include page="footer.jsp" />
