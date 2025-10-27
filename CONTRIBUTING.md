# Contributing to BookHaven

First off, thank you for considering contributing to BookHaven! It's people like you that make BookHaven such a great learning project.

## Code of Conduct

This project and everyone participating in it is governed by a code of respect and professionalism. By participating, you are expected to uphold this standard.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include as many details as possible:

**Bug Report Template:**
```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**
- OS: [e.g., Windows 10, Ubuntu 20.04]
- Java Version: [e.g., JDK 11]
- Tomcat Version: [e.g., 9.0.65]
- PostgreSQL Version: [e.g., 13.8]
- Browser: [e.g., Chrome 108]

**Additional context**
Any other relevant information.
```

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- **Clear title** - Descriptive and specific
- **Detailed description** - What enhancement you'd like to see
- **Use cases** - Why this would be useful
- **Alternative solutions** - Other ways to achieve the same goal

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Make your changes** with clear, focused commits
3. **Test your changes** thoroughly
4. **Update documentation** if needed
5. **Submit a pull request** with a clear description

## Development Setup

### Prerequisites
- Java JDK 8+
- Apache Tomcat 9.x
- PostgreSQL 12+
- IDE (Eclipse, IntelliJ IDEA, or NetBeans)

### Setup Steps
```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/BookHaven-JavaWebApp.git
cd BookHaven-JavaWebApp

# Setup database
createdb bookhaven
psql -U postgres -d bookhaven -f database/schema.sql

# Configure database connection
# Edit src/main/resources/db.properties

# Add PostgreSQL JDBC driver
cp /path/to/postgresql-42.x.x.jar src/main/webapp/WEB-INF/lib/

# Import into your IDE and run
```

## Coding Standards

### Java Code Style

```java
// Class naming: PascalCase
public class BookService {
    
    // Constants: UPPER_SNAKE_CASE
    private static final int MAX_BOOKS = 100;
    
    // Variables: camelCase
    private String bookTitle;
    
    // Methods: camelCase
    public Book getBookById(int id) {
        // Implementation
    }
    
    // Always use braces for control structures
    if (condition) {
        doSomething();
    }
    
    // Add JavaDoc for public methods
    /**
     * Retrieves a book by its ID
     * @param id The book ID
     * @return Book object or null
     */
    public Book findBook(int id) {
        // Implementation
    }
}
```

### JSP Best Practices

```jsp
<%-- Always include page directives --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- Import required classes --%>
<%@ page import="com.bookhaven.model.Book"%>

<%-- Use JSTL when possible --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- Keep Java code minimal in JSP --%>
<%-- Business logic should be in Servlets/Controllers --%>
```

### SQL Best Practices

```sql
-- Always use PreparedStatements
String query = "SELECT * FROM books WHERE id = ?";
pstmt.setInt(1, bookId);

-- Table names: lowercase with underscores
CREATE TABLE book_categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- Use meaningful column names
-- Good: created_at, updated_at
-- Bad: dt, ts
```

### File Organization

```
src/main/java/com/bookhaven/
├── controller/    (Future: separate controllers)
├── dao/          (Data Access Objects)
├── model/        (Entity classes)
├── service/      (Future: business logic)
├── servlet/      (HTTP handlers)
└── util/         (Helper classes)
```

## Git Workflow

### Branch Naming
- Feature: `feature/description` (e.g., `feature/book-search`)
- Bug fix: `bugfix/description` (e.g., `bugfix/login-validation`)
- Enhancement: `enhancement/description`
- Documentation: `docs/description`

### Commit Messages

Follow the conventional commits specification:

```
type(scope): subject

body (optional)

footer (optional)
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

**Examples:**
```
feat(books): add book search functionality

Implemented search by title, author, and category.
Added search form to home page.

Closes #123

---

fix(login): validate empty credentials

Added null check before authentication.
Display error message for empty fields.

---

docs(readme): update setup instructions

Added troubleshooting section for common issues.
```

### Pull Request Process

1. **Update your fork**
   ```bash
   git remote add upstream https://github.com/CyberPriyanshu/BookHaven-JavaWebApp.git
   git fetch upstream
   git merge upstream/main
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature
   ```

3. **Make changes and commit**
   ```bash
   git add .
   git commit -m "feat(scope): your message"
   ```

4. **Push to your fork**
   ```bash
   git push origin feature/your-feature
   ```

5. **Open Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Select your branch
   - Fill out the PR template

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Enhancement
- [ ] Documentation update

## Testing
- [ ] Local testing completed
- [ ] All existing tests pass
- [ ] New tests added (if applicable)

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings generated
- [ ] Database changes documented (if applicable)

## Screenshots (if applicable)
Add screenshots for UI changes

## Related Issues
Closes #(issue number)
```

## Testing Guidelines

### Manual Testing Checklist

Before submitting a PR, test:

- [ ] Home page loads and displays books
- [ ] Contact form submits successfully
- [ ] Admin login works with correct credentials
- [ ] Admin login rejects incorrect credentials
- [ ] Admin dashboard displays data
- [ ] Admin logout works
- [ ] Navigation links work
- [ ] Responsive design on mobile
- [ ] No console errors in browser
- [ ] No exceptions in Tomcat logs

### Database Testing

```sql
-- Verify data integrity
SELECT COUNT(*) FROM books;
SELECT COUNT(*) FROM admins;
SELECT COUNT(*) FROM contacts;

-- Test foreign key constraints (if added)
-- Test data validation (if added)
```

## Documentation

### When to Update Documentation

Update documentation when you:
- Add a new feature
- Change existing functionality
- Fix a bug that affects usage
- Add new configuration options
- Change database schema

### Documentation Files

- **README.md** - Overview and main documentation
- **SETUP.md** - Detailed setup instructions
- **FEATURES.md** - Feature descriptions
- **PROJECT_STRUCTURE.md** - Architecture details
- **QUICK_START.md** - Quick reference guide
- **Code comments** - Inline documentation

## Project Areas for Contribution

### High Priority

1. **Security Enhancements**
   - Implement password hashing (BCrypt)
   - Add CSRF protection
   - Implement servlet filters for authentication
   - Add input sanitization

2. **Admin Features**
   - CRUD operations for books
   - CRUD operations for contacts
   - Book cover image upload
   - Bulk operations

3. **User Features**
   - Book search and filtering
   - Category browsing
   - Book details page
   - User reviews system

### Medium Priority

4. **UI Improvements**
   - Better mobile navigation
   - Loading indicators
   - Toast notifications
   - Dark mode

5. **Backend Enhancements**
   - Connection pooling
   - Logging framework (Log4j)
   - Exception handling
   - Validation framework

6. **Database**
   - More sample data
   - Database migration scripts
   - Backup scripts
   - Performance indexes

### Nice to Have

7. **Advanced Features**
   - REST API
   - Email integration
   - Report generation
   - Export to PDF/Excel

8. **DevOps**
   - Docker support
   - CI/CD pipeline
   - Automated testing
   - Deployment scripts

## Code Review Process

All submissions require review. Reviewers will check:

- **Functionality** - Does it work as intended?
- **Code Quality** - Is it clean and maintainable?
- **Security** - Are there any vulnerabilities?
- **Performance** - Is it efficient?
- **Documentation** - Is it well documented?
- **Testing** - Is it adequately tested?

## Getting Help

- **Questions?** Open an issue with the "question" label
- **Stuck?** Check existing issues and documentation
- **Need clarification?** Comment on the relevant issue
- **Want to discuss?** Use GitHub Discussions (if enabled)

## Recognition

Contributors will be:
- Listed in a CONTRIBUTORS.md file
- Mentioned in release notes
- Credited in relevant documentation

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Additional Resources

- [Java Servlet Tutorial](https://docs.oracle.com/javaee/7/tutorial/servlets.htm)
- [JSP Tutorial](https://docs.oracle.com/javaee/7/tutorial/jsps.htm)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Bootstrap 5 Documentation](https://getbootstrap.com/docs/5.3/)
- [Git Best Practices](https://git-scm.com/book/en/v2)

## Thank You!

Your contributions make BookHaven better for everyone. We appreciate your time and effort in helping improve this project! 🎉

---

**Questions?** Feel free to reach out or open an issue for clarification.

Happy Coding! 🚀
