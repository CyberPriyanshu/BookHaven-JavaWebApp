<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "BookHaven" %></title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .navbar {
            background-color: var(--primary-color) !important;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .navbar-brand {
            font-weight: bold;
            font-size: 1.5rem;
            color: #fff !important;
        }
        
        .navbar-brand i {
            color: var(--secondary-color);
        }
        
        .nav-link {
            color: rgba(255,255,255,0.8) !important;
            transition: color 0.3s;
        }
        
        .nav-link:hover {
            color: var(--secondary-color) !important;
        }
        
        .hero-section {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 60px 0;
            margin-bottom: 40px;
        }
        
        .card {
            border: none;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.2);
        }
        
        .btn-primary {
            background-color: var(--secondary-color);
            border: none;
        }
        
        .btn-primary:hover {
            background-color: #2980b9;
        }
        
        .book-card {
            height: 100%;
        }
        
        .book-card .card-body {
            display: flex;
            flex-direction: column;
        }
        
        .book-card .card-title {
            color: var(--primary-color);
            font-weight: bold;
        }
        
        .book-card .price {
            font-size: 1.25rem;
            color: var(--accent-color);
            font-weight: bold;
            margin-top: auto;
        }
        
        footer {
            background-color: var(--primary-color);
            color: white;
            padding: 30px 0;
            margin-top: 60px;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/index.jsp">
                <i class="fas fa-book-open"></i> BookHaven
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/contact">Contact</a>
                    </li>
                    <% if (session.getAttribute("admin") != null) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/admin/dashboard">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/admin/logout">Logout</a>
                        </li>
                    <% } else { %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/admin/login">Admin Login</a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>
