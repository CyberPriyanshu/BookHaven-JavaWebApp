<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setAttribute("pageTitle", "BookHaven - Admin Login");
    
    // Redirect if already logged in
    if (session.getAttribute("admin") != null) {
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        return;
    }
%>
<jsp:include page="header.jsp" />

<!-- Page Header -->
<div class="hero-section">
    <div class="container text-center">
        <h1 class="display-4"><i class="fas fa-user-shield"></i> Admin Login</h1>
        <p class="lead">Secure access for administrators</p>
    </div>
</div>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            
            <!-- Error Message -->
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-triangle"></i> <%= request.getAttribute("errorMessage") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            
            <!-- Login Form -->
            <div class="card shadow-lg">
                <div class="card-body p-5">
                    <div class="text-center mb-4">
                        <i class="fas fa-lock fa-3x text-primary mb-3"></i>
                        <h3 class="card-title">Admin Portal</h3>
                    </div>
                    <form method="post" action="<%= request.getContextPath() %>/admin/login">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control" id="username" name="username" required autofocus>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label for="password" class="form-label">Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary btn-lg w-100">
                            <i class="fas fa-sign-in-alt"></i> Login
                        </button>
                    </form>
                </div>
            </div>
            
            <div class="text-center mt-4">
                <p class="text-muted">
                    <i class="fas fa-info-circle"></i> 
                    Default credentials: <strong>admin</strong> / <strong>admin123</strong>
                </p>
            </div>
            
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
