# BookHaven Project Structure

This document explains the organization and structure of the BookHaven web application.

## Directory Structure

```
BookHaven/
├── database/                          # Database scripts
│   └── schema.sql                     # PostgreSQL schema with sample data
│
├── src/
│   └── main/
│       ├── java/com/bookhaven/        # Java source code
│       │   ├── dao/                   # Data Access Object layer
│       │   │   ├── AdminDAO.java      # Admin database operations
│       │   │   ├── BookDAO.java       # Book database operations
│       │   │   └── ContactDAO.java    # Contact database operations
│       │   │
│       │   ├── model/                 # Domain model classes
│       │   │   ├── Admin.java         # Admin entity
│       │   │   ├── Book.java          # Book entity
│       │   │   └── Contact.java       # Contact entity
│       │   │
│       │   ├── servlet/               # Servlet controllers
│       │   │   ├── AdminDashboardServlet.java  # Admin dashboard
│       │   │   ├── AdminLoginServlet.java      # Admin login handler
│       │   │   ├── AdminLogoutServlet.java     # Admin logout handler
│       │   │   └── ContactServlet.java         # Contact form handler
│       │   │
│       │   └── util/                  # Utility classes
│       │       └── DBUtil.java        # Database connection utility
│       │
│       ├── resources/                 # Configuration resources
│       │   └── db.properties          # Database configuration
│       │
│       └── webapp/                    # Web application resources
│           ├── WEB-INF/
│           │   ├── lib/               # External libraries (JAR files)
│           │   └── web.xml            # Deployment descriptor
│           │
│           ├── css/                   # Custom CSS files (optional)
│           ├── js/                    # Custom JavaScript files (optional)
│           ├── images/                # Images and static assets
│           │
│           ├── admin-dashboard.jsp    # Admin dashboard page
│           ├── admin-login.jsp        # Admin login page
│           ├── contact.jsp            # Contact form page
│           ├── footer.jsp             # Common footer include
│           ├── header.jsp             # Common header include
│           └── index.jsp              # Home page
│
├── .gitignore                         # Git ignore rules
├── LICENSE                            # MIT License
├── README.md                          # Project documentation
├── SETUP.md                           # Detailed setup guide
├── PROJECT_STRUCTURE.md               # This file
└── build.sh                           # Build script

```

## Architecture Overview

### MVC Pattern

The application follows the Model-View-Controller (MVC) architectural pattern:

**Model (`com.bookhaven.model`):**
- `Admin.java` - Admin user entity
- `Book.java` - Book entity with properties (title, author, isbn, price, etc.)
- `Contact.java` - Contact form submission entity

**View (JSP Pages):**
- `index.jsp` - Home page displaying featured books
- `contact.jsp` - Contact form for user inquiries
- `admin-login.jsp` - Admin authentication page
- `admin-dashboard.jsp` - Admin control panel
- `header.jsp` - Common header with navigation
- `footer.jsp` - Common footer

**Controller (`com.bookhaven.servlet`):**
- `AdminLoginServlet` - Handles admin authentication
- `AdminLogoutServlet` - Handles admin logout
- `ContactServlet` - Processes contact form submissions
- `AdminDashboardServlet` - Manages admin dashboard data

### DAO Pattern

The Data Access Object (DAO) pattern separates database operations from business logic:

**DAO Layer (`com.bookhaven.dao`):**
- `AdminDAO.java` - Admin CRUD operations
- `BookDAO.java` - Book CRUD operations (getAllBooks, getFeaturedBooks, etc.)
- `ContactDAO.java` - Contact CRUD operations

Each DAO class:
- Uses `DBUtil` for database connections
- Implements CRUD operations (Create, Read, Update, Delete)
- Uses PreparedStatements to prevent SQL injection
- Handles SQLExceptions appropriately

### Database Layer

**Utility (`com.bookhaven.util`):**
- `DBUtil.java` - Manages PostgreSQL database connections
  - Loads configuration from `db.properties`
  - Provides connection pooling capabilities
  - Handles JDBC driver loading

## File Descriptions

### Java Source Files

#### Model Classes
| File | Description |
|------|-------------|
| `Admin.java` | Represents admin users with id, username, password, email |
| `Book.java` | Represents books with id, title, author, isbn, category, price, description, featured |
| `Contact.java` | Represents contact submissions with id, name, email, phone, message, timestamp |

#### DAO Classes
| File | Description |
|------|-------------|
| `AdminDAO.java` | Database operations for admins (validate credentials, add admin) |
| `BookDAO.java` | Database operations for books (get all, get featured, add, update, delete) |
| `ContactDAO.java` | Database operations for contacts (save, get all, get by ID, delete) |

#### Servlet Classes
| File | Description |
|------|-------------|
| `AdminLoginServlet.java` | Handles GET (show login form) and POST (process login) |
| `AdminLogoutServlet.java` | Invalidates session and redirects to home |
| `ContactServlet.java` | Handles GET (show form) and POST (save submission) |
| `AdminDashboardServlet.java` | Loads and displays books and contacts for admin |

#### Utility Classes
| File | Description |
|------|-------------|
| `DBUtil.java` | Singleton pattern for database connection management |

### JSP Pages

| File | Purpose |
|------|---------|
| `header.jsp` | Common header with Bootstrap CSS, navigation menu, styling |
| `footer.jsp` | Common footer with links and Bootstrap JS |
| `index.jsp` | Home page with hero section, featured books, feature cards |
| `contact.jsp` | Contact form with validation and feedback messages |
| `admin-login.jsp` | Admin login form with username/password fields |
| `admin-dashboard.jsp` | Admin panel showing statistics, books table, contacts table |

### Configuration Files

| File | Purpose |
|------|---------|
| `web.xml` | Servlet mappings, welcome files, session configuration |
| `db.properties` | Database connection parameters (URL, username, password, driver) |

### Database Files

| File | Purpose |
|------|---------|
| `schema.sql` | PostgreSQL DDL for tables (admins, books, contacts) and sample data |

### Build & Documentation

| File | Purpose |
|------|---------|
| `build.sh` | Shell script to compile Java files and create WAR file |
| `README.md` | Main project documentation with features and setup overview |
| `SETUP.md` | Detailed step-by-step setup instructions |
| `PROJECT_STRUCTURE.md` | This file - explains project organization |

## Request Flow

### User Flow (Home Page)

1. User navigates to `http://localhost:8080/BookHaven/`
2. Tomcat serves `index.jsp` (welcome file)
3. JSP includes `header.jsp` for navigation and styling
4. JSP creates `BookDAO` instance and calls `getFeaturedBooks()`
5. DAO uses `DBUtil` to get database connection
6. DAO executes query: `SELECT * FROM books WHERE featured = true`
7. Books are displayed in Bootstrap card layout
8. JSP includes `footer.jsp`

### Contact Form Flow

1. User clicks "Contact" in navigation
2. GET request to `/contact` → `ContactServlet.doGet()`
3. Servlet forwards to `contact.jsp`
4. User fills form and clicks submit
5. POST request to `/contact` → `ContactServlet.doPost()`
6. Servlet creates `Contact` object from form parameters
7. Servlet calls `ContactDAO.saveContact(contact)`
8. DAO inserts record into `contacts` table
9. Success/error message displayed on `contact.jsp`

### Admin Login Flow

1. User navigates to `/admin/login`
2. GET request → `AdminLoginServlet.doGet()`
3. Servlet forwards to `admin-login.jsp`
4. User enters credentials and submits
5. POST request → `AdminLoginServlet.doPost()`
6. Servlet calls `AdminDAO.validateAdmin(username, password)`
7. If valid: create session, redirect to `/admin/dashboard`
8. If invalid: show error message on login page

### Admin Dashboard Flow

1. Admin logged in, navigates to `/admin/dashboard`
2. GET request → `AdminDashboardServlet.doGet()`
3. Servlet checks session for admin object
4. If not logged in: redirect to login page
5. If logged in: 
   - Call `BookDAO.getAllBooks()`
   - Call `ContactDAO.getAllContacts()`
   - Set attributes and forward to `admin-dashboard.jsp`
6. JSP displays statistics and data tables

## Database Schema

### Tables

**admins**
```sql
CREATE TABLE admins (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**books**
```sql
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    featured BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**contacts**
```sql
CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Key Design Patterns

1. **MVC (Model-View-Controller)**
   - Separates data (Model), presentation (View), and logic (Controller)

2. **DAO (Data Access Object)**
   - Abstracts database access logic
   - Provides clean API for data operations

3. **Singleton (in DBUtil)**
   - Single instance of database configuration
   - Static initialization block for setup

4. **Front Controller**
   - Servlets act as entry points for requests
   - Handle routing and delegation

5. **Include Pattern (JSP)**
   - `header.jsp` and `footer.jsp` reused across pages
   - DRY (Don't Repeat Yourself) principle

## Technology Stack

- **Backend**: Java, JSP, Servlets
- **Frontend**: HTML5, CSS3, Bootstrap 5, Font Awesome
- **Database**: PostgreSQL 12+
- **Server**: Apache Tomcat 9.x/10.x
- **Build**: Shell script (build.sh)

## Dependencies

- **servlet-api.jar** - Java Servlet API
- **postgresql-xx.jar** - PostgreSQL JDBC Driver
- **Bootstrap 5.3** - CSS framework (CDN)
- **Font Awesome 6.4** - Icons (CDN)

## Security Considerations

⚠️ **Note**: This is an educational project. For production use:

1. **Password Security**: Implement bcrypt or PBKDF2 hashing
2. **SQL Injection**: Already using PreparedStatements ✓
3. **XSS Protection**: Add input sanitization
4. **Session Security**: Configure secure cookies, HTTPS
5. **CSRF Protection**: Add CSRF tokens to forms
6. **Authentication Filter**: Implement servlet filters for protected pages
7. **Error Handling**: Don't expose stack traces to users

## Future Enhancements

Potential improvements:
- Book search functionality
- User registration and reviews
- Shopping cart for book orders
- Payment integration
- Email notifications
- File upload for book covers
- REST API endpoints
- Pagination for large datasets
- Advanced admin features (book management UI)
- Report generation

## Maintenance

### Adding a New Page

1. Create JSP file in `webapp/`
2. Include `header.jsp` and `footer.jsp`
3. If dynamic, create corresponding Servlet
4. Map servlet in `web.xml`
5. Update navigation in `header.jsp`

### Adding a New Entity

1. Create Model class in `com.bookhaven.model`
2. Create DAO class in `com.bookhaven.dao`
3. Create table in `schema.sql`
4. Create servlet if needed
5. Create JSP view

### Modifying Database

1. Update `schema.sql`
2. Update Model class
3. Update DAO methods
4. Update JSP views if needed
5. Test thoroughly

---

**Version**: 1.0  
**Last Updated**: 2025  
**Maintained By**: Priyanshu Kanaujiya
