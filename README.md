# BookHaven-JavaWebApp

📚 A Java-based web application built using JSP, Servlets, and PostgreSQL on Apache Tomcat. BookHaven is a mini library portal that allows users to explore books, manage records, and store contact leads. Developed as part of the Advanced Java course project.

## 🌟 Features

- **Home Page**: Displays featured books with a clean Bootstrap-based UI
- **Book Management**: View and manage book collection through admin dashboard
- **Admin Authentication**: Secure login system using JSP and Servlets
- **Contact Form**: Users can submit inquiries which are stored in PostgreSQL database
- **MVC Architecture**: Clean separation of concerns with Model-View-Controller pattern
- **DAO Pattern**: Data Access Objects for database operations
- **Responsive Design**: Bootstrap 5 for modern, mobile-friendly interface

## 🏗️ Architecture

The application follows the MVC (Model-View-Controller) architectural pattern:

```
BookHaven/
├── src/main/java/com/bookhaven/
│   ├── model/           # Model classes (Book, Contact, Admin)
│   ├── dao/             # Data Access Objects (BookDAO, ContactDAO, AdminDAO)
│   ├── servlet/         # Servlet controllers (Admin, Contact handling)
│   └── util/            # Utility classes (Database connection)
├── src/main/webapp/
│   ├── WEB-INF/         # Configuration files (web.xml)
│   ├── *.jsp            # JSP view pages
│   └── css/js/images/   # Static resources
├── src/main/resources/
│   └── db.properties    # Database configuration
└── database/
    └── schema.sql       # PostgreSQL database schema
```

## 🛠️ Technologies Used

- **Backend**: Java (JSP, Servlets)
- **Frontend**: HTML5, CSS3, Bootstrap 5, Font Awesome
- **Database**: PostgreSQL
- **Server**: Apache Tomcat 9.x or 10.x
- **Architecture**: MVC Pattern with DAO Layer

## 📋 Prerequisites

Before running this application, ensure you have:

- Java Development Kit (JDK) 8 or higher
- Apache Tomcat 9.x or 10.x
- PostgreSQL 12 or higher
- PostgreSQL JDBC Driver (download from [PostgreSQL JDBC](https://jdbc.postgresql.org/download.html))

## 🚀 Setup Instructions

### 1. Database Setup

1. Install PostgreSQL if not already installed
2. Create a new database:
   ```sql
   CREATE DATABASE bookhaven;
   ```
3. Run the schema file to create tables and insert sample data:
   ```bash
   psql -U postgres -d bookhaven -f database/schema.sql
   ```
   Or connect to PostgreSQL and run the SQL commands manually.

### 2. Configure Database Connection

Edit `src/main/resources/db.properties` with your PostgreSQL credentials:

```properties
db.url=jdbc:postgresql://localhost:5432/bookhaven
db.username=postgres
db.password=your_password
db.driver=org.postgresql.Driver
```

### 3. Add PostgreSQL JDBC Driver

Download the PostgreSQL JDBC driver (.jar file) and place it in:
- `src/main/webapp/WEB-INF/lib/` directory, OR
- Your Tomcat's `lib` directory

### 4. Compile the Application

If using command line:
```bash
# Navigate to src directory
cd src/main/java

# Compile all Java files
javac -cp "path/to/servlet-api.jar:path/to/postgresql.jar" com/bookhaven/**/*.java
```

If using an IDE (Eclipse, IntelliJ IDEA, NetBeans):
- Import the project as a Dynamic Web Project
- Configure the build path to include servlet-api.jar and postgresql.jar
- Build the project

### 5. Deploy to Tomcat

**Option A: Using IDE**
1. Add the project to your Tomcat server in the IDE
2. Right-click the project and select "Run on Server"

**Option B: Manual Deployment**
1. Export the project as a WAR file named `BookHaven.war`
2. Copy the WAR file to Tomcat's `webapps` directory
3. Start Tomcat server:
   ```bash
   # Linux/Mac
   ./catalina.sh run
   
   # Windows
   catalina.bat run
   ```

### 6. Access the Application

Open your web browser and navigate to:
```
http://localhost:8080/BookHaven/
```

## 🔐 Default Admin Credentials

- **Username**: `admin`
- **Password**: `admin123`

⚠️ **Important**: Change these credentials in production!

## 📱 Application Pages

1. **Home Page** (`/index.jsp`)
   - Displays featured books
   - Hero section with welcome message
   - Feature highlights

2. **Contact Page** (`/contact`)
   - Contact form for user inquiries
   - Stores submissions in database
   - Success/error message feedback

3. **Admin Login** (`/admin/login`)
   - Secure authentication for administrators
   - Session management

4. **Admin Dashboard** (`/admin/dashboard`)
   - View all books in the database
   - View all contact submissions
   - Statistics overview

## 📊 Database Schema

### Tables

**admins**
- id (SERIAL PRIMARY KEY)
- username (VARCHAR)
- password (VARCHAR)
- email (VARCHAR)
- created_at (TIMESTAMP)

**books**
- id (SERIAL PRIMARY KEY)
- title (VARCHAR)
- author (VARCHAR)
- isbn (VARCHAR)
- category (VARCHAR)
- price (DECIMAL)
- description (TEXT)
- featured (BOOLEAN)
- created_at (TIMESTAMP)

**contacts**
- id (SERIAL PRIMARY KEY)
- name (VARCHAR)
- email (VARCHAR)
- phone (VARCHAR)
- message (TEXT)
- created_at (TIMESTAMP)

## 🎨 UI Features

- Clean and modern Bootstrap 5 design
- Responsive layout for all screen sizes
- Font Awesome icons
- Card-based layout for books
- Color-coded admin dashboard
- Alert messages for user feedback
- Hover effects and smooth transitions

## 🔧 Configuration Files

### web.xml
Deployment descriptor configuring:
- Servlet mappings
- Welcome files
- Session timeout

### db.properties
Database connection properties:
- JDBC URL
- Username and password
- Driver class name

## 📝 Sample Data

The application comes with:
- 10 sample books (6 featured)
- 1 admin user
- 2 sample contact submissions

## 🛡️ Security Notes

For production deployment:
1. **Hash Passwords**: Implement password hashing (BCrypt, PBKDF2)
2. **SQL Injection**: Use PreparedStatements (already implemented)
3. **Session Security**: Configure secure session cookies
4. **HTTPS**: Enable SSL/TLS encryption
5. **Input Validation**: Add comprehensive input validation
6. **Authentication**: Implement proper authentication filters

## 🤝 Contributing

This is an educational project for learning Java web development. Feel free to:
- Fork the repository
- Create feature branches
- Submit pull requests
- Report issues

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Priyanshu Kanaujiya**

- GitHub: [@CyberPriyanshu](https://github.com/CyberPriyanshu)

## 🎓 Course Information

Developed as part of the **Advanced Java** course project, demonstrating:
- Java EE web development
- MVC architecture
- Database integration
- Session management
- CRUD operations
- UI/UX design with Bootstrap

⭐ If you find this project helpful, please give it a star!

**Happy Coding! 🚀**
