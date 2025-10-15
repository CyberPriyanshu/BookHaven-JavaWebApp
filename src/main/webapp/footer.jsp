    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-book-open"></i> BookHaven</h5>
                    <p>Your digital library companion for discovering and exploring books.</p>
                </div>
                <div class="col-md-3">
                    <h6>Quick Links</h6>
                    <ul class="list-unstyled">
                        <li><a href="<%= request.getContextPath() %>/index.jsp" class="text-white-50">Home</a></li>
                        <li><a href="<%= request.getContextPath() %>/contact" class="text-white-50">Contact</a></li>
                        <li><a href="<%= request.getContextPath() %>/admin/login" class="text-white-50">Admin</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h6>Contact Info</h6>
                    <p class="text-white-50 mb-1"><i class="fas fa-envelope"></i> info@bookhaven.com</p>
                    <p class="text-white-50"><i class="fas fa-phone"></i> +1 234 567 890</p>
                </div>
            </div>
            <hr class="bg-white">
            <div class="text-center">
                <p class="mb-0">&copy; 2025 BookHaven. All rights reserved. | Advanced Java Project</p>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
