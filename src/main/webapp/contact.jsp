<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setAttribute("pageTitle", "BookHaven - Contact Us");
%>
<jsp:include page="header.jsp" />

<!-- Page Header -->
<div class="hero-section">
    <div class="container text-center">
        <h1 class="display-4"><i class="fas fa-envelope"></i> Contact Us</h1>
        <p class="lead">We'd love to hear from you!</p>
    </div>
</div>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            
            <!-- Success Message -->
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle"></i> <%= request.getAttribute("successMessage") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            
            <!-- Error Message -->
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("errorMessage") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            
            <!-- Contact Form -->
            <div class="card shadow-lg">
                <div class="card-body p-5">
                    <h3 class="card-title mb-4">Get in Touch</h3>
                    <form method="post" action="<%= request.getContextPath() %>/contact">
                        <div class="mb-3">
                            <label for="name" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required>
                        </div>
                        <div class="mb-3">
                            <label for="message" class="form-label">Message</label>
                            <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary btn-lg w-100">
                            <i class="fas fa-paper-plane"></i> Submit Message
                        </button>
                    </form>
                </div>
            </div>
            
            <!-- Contact Info -->
            <div class="row mt-5 g-4">
                <div class="col-md-4 text-center">
                    <div class="card h-100">
                        <div class="card-body">
                            <i class="fas fa-map-marker-alt fa-2x text-primary mb-3"></i>
                            <h5>Location</h5>
                            <p class="text-muted">123 Library Street<br>BookCity, BC 12345</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 text-center">
                    <div class="card h-100">
                        <div class="card-body">
                            <i class="fas fa-phone fa-2x text-success mb-3"></i>
                            <h5>Phone</h5>
                            <p class="text-muted">+1 234 567 890<br>Mon-Fri: 9AM-6PM</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 text-center">
                    <div class="card h-100">
                        <div class="card-body">
                            <i class="fas fa-envelope fa-2x text-danger mb-3"></i>
                            <h5>Email</h5>
                            <p class="text-muted">info@bookhaven.com<br>support@bookhaven.com</p>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
