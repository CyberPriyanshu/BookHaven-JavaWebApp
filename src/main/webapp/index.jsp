<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bookhaven.dao.BookDAO"%>
<%@ page import="com.bookhaven.model.Book"%>
<%@ page import="java.util.List"%>
<%
    request.setAttribute("pageTitle", "BookHaven - Home");
    BookDAO bookDAO = new BookDAO();
    List<Book> featuredBooks = bookDAO.getFeaturedBooks();
%>
<jsp:include page="header.jsp" />

<!-- Hero Section -->
<div class="hero-section">
    <div class="container text-center">
        <h1 class="display-3 mb-4"><i class="fas fa-book-reader"></i> Welcome to BookHaven</h1>
        <p class="lead mb-4">Discover your next favorite book from our curated collection</p>
        <a href="#featured" class="btn btn-light btn-lg">Explore Books</a>
    </div>
</div>

<!-- Featured Books Section -->
<div class="container" id="featured">
    <div class="text-center mb-5">
        <h2 class="display-5">Featured Books</h2>
        <p class="text-muted">Handpicked selections just for you</p>
    </div>
    
    <% if (featuredBooks != null && !featuredBooks.isEmpty()) { %>
        <div class="row g-4">
            <% for (Book book : featuredBooks) { %>
                <div class="col-md-4">
                    <div class="card book-card">
                        <div class="card-body">
                            <h5 class="card-title"><%= book.getTitle() %></h5>
                            <h6 class="card-subtitle mb-2 text-muted">
                                <i class="fas fa-user"></i> <%= book.getAuthor() %>
                            </h6>
                            <p class="card-text">
                                <span class="badge bg-secondary"><%= book.getCategory() %></span>
                            </p>
                            <p class="card-text"><%= book.getDescription() %></p>
                            <p class="price">$<%= String.format("%.2f", book.getPrice()) %></p>
                            <div class="d-flex justify-content-between align-items-center">
                                <small class="text-muted">ISBN: <%= book.getIsbn() %></small>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    <% } else { %>
        <div class="alert alert-info text-center" role="alert">
            <i class="fas fa-info-circle"></i> No featured books available at the moment. Please check back later!
        </div>
    <% } %>
</div>

<!-- Features Section -->
<div class="container mt-5">
    <div class="row g-4 text-center">
        <div class="col-md-4">
            <div class="card p-4">
                <div class="card-body">
                    <i class="fas fa-book fa-3x text-primary mb-3"></i>
                    <h5>Wide Selection</h5>
                    <p class="text-muted">Browse through our extensive collection of books across various genres</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card p-4">
                <div class="card-body">
                    <i class="fas fa-star fa-3x text-warning mb-3"></i>
                    <h5>Quality Content</h5>
                    <p class="text-muted">Curated selection of highly-rated books from renowned authors</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card p-4">
                <div class="card-body">
                    <i class="fas fa-headset fa-3x text-success mb-3"></i>
                    <h5>24/7 Support</h5>
                    <p class="text-muted">Our team is always here to help you find your perfect read</p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
