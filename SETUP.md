# BookHaven Setup Guide

This document provides detailed step-by-step instructions for setting up the BookHaven web application.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Database Setup](#database-setup)
3. [Project Configuration](#project-configuration)
4. [IDE Setup](#ide-setup)
5. [Manual Build and Deploy](#manual-build-and-deploy)
6. [Troubleshooting](#troubleshooting)

## Prerequisites

### Required Software

1. **Java Development Kit (JDK) 8 or higher**
   - Download from: https://www.oracle.com/java/technologies/downloads/
   - Verify installation: `java -version` and `javac -version`

2. **Apache Tomcat 9.x or 10.x**
   - Download from: https://tomcat.apache.org/download-90.cgi
   - Extract to a suitable location

3. **PostgreSQL 12 or higher**
   - Download from: https://www.postgresql.org/download/
   - Remember the password you set during installation

4. **PostgreSQL JDBC Driver**
   - Download from: https://jdbc.postgresql.org/download.html
   - Get the latest version (e.g., postgresql-42.x.x.jar)

## Database Setup

### Step 1: Create Database

Open PostgreSQL command line (psql) or pgAdmin and run:

```sql
CREATE DATABASE bookhaven;
```

### Step 2: Create User (Optional)

```sql
CREATE USER bookhaven_user WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE bookhaven TO bookhaven_user;
```

### Step 3: Initialize Schema

Navigate to the project directory and run:

```bash
# Using psql command line
psql -U postgres -d bookhaven -f database/schema.sql

# Or if you created a custom user
psql -U bookhaven_user -d bookhaven -f database/schema.sql
```

### Step 4: Verify Database

Connect to the database and verify tables:

```sql
\c bookhaven
\dt
SELECT * FROM admins;
SELECT * FROM books;
```

You should see the sample data created by the schema.

## Project Configuration

### Configure Database Connection

Edit `src/main/resources/db.properties`:

```properties
db.url=jdbc:postgresql://localhost:5432/bookhaven
db.username=postgres
db.password=your_actual_password
db.driver=org.postgresql.Driver
```

**Important**: Replace `your_actual_password` with your PostgreSQL password.

### Add JDBC Driver

Copy the PostgreSQL JDBC driver JAR file to:
```
src/main/webapp/WEB-INF/lib/postgresql-42.x.x.jar
```

## IDE Setup

### Eclipse Setup

1. **Create Dynamic Web Project**
   - File → New → Dynamic Web Project
   - Project name: `BookHaven`
   - Target runtime: Apache Tomcat 9.x
   - Click Finish

2. **Import Source Files**
   - Copy all files from the repository to the project directory
   - Refresh the project in Eclipse

3. **Configure Build Path**
   - Right-click project → Build Path → Configure Build Path
   - Add External JARs:
     - servlet-api.jar (from Tomcat lib directory)
     - postgresql-42.x.x.jar

4. **Configure Server**
   - Window → Show View → Servers
   - New → Server → Apache Tomcat 9.x
   - Add BookHaven project to server

5. **Run Application**
   - Right-click project → Run As → Run on Server
   - Access: http://localhost:8080/BookHaven/

### IntelliJ IDEA Setup

1. **Create New Project**
   - File → New → Project from Existing Sources
   - Select the BookHaven directory
   - Choose "Java Enterprise" and select Web Application

2. **Configure Application Server**
   - Run → Edit Configurations
   - Add New Configuration → Tomcat Server → Local
   - Configure Tomcat installation directory

3. **Add Libraries**
   - File → Project Structure → Libraries
   - Add servlet-api.jar and postgresql-42.x.x.jar

4. **Deploy and Run**
   - Click Run button
   - Access: http://localhost:8080/BookHaven/

### NetBeans Setup

1. **Create Web Application**
   - File → New Project → Java Web → Web Application
   - Project name: BookHaven
   - Server: Apache Tomcat

2. **Import Sources**
   - Copy all source files to the project

3. **Add Libraries**
   - Right-click project → Properties → Libraries
   - Add JAR/Folder → Add servlet-api.jar and postgresql JAR

4. **Run**
   - Right-click project → Run
   - Access: http://localhost:8080/BookHaven/

## Manual Build and Deploy

### Using Build Script (Linux/Mac)

```bash
# Set environment variables
export SERVLET_JAR=/path/to/tomcat/lib/servlet-api.jar
export POSTGRES_JAR=/path/to/postgresql-42.x.x.jar

# Run build script
./build.sh

# Deploy
cp BookHaven.war $CATALINA_HOME/webapps/

# Start Tomcat
cd $CATALINA_HOME/bin
./catalina.sh run
```

### Manual Compilation (Windows)

```batch
REM Create build directories
mkdir build\WEB-INF\classes

REM Compile Java files
javac -d build\WEB-INF\classes -cp "C:\path\to\servlet-api.jar;C:\path\to\postgresql.jar" src\main\java\com\bookhaven\**\*.java

REM Copy web resources
xcopy src\main\webapp\* build\ /E /I

REM Copy resources
xcopy src\main\resources\* build\WEB-INF\classes\ /E /I

REM Create WAR file
cd build
jar -cvf ..\BookHaven.war *
cd ..

REM Deploy to Tomcat
copy BookHaven.war C:\path\to\tomcat\webapps\
```

## Troubleshooting

### Database Connection Issues

**Problem**: Cannot connect to database

**Solutions**:
1. Verify PostgreSQL is running: `systemctl status postgresql` (Linux) or check Services (Windows)
2. Check db.properties credentials
3. Verify PostgreSQL accepts connections from localhost
4. Check pg_hba.conf for connection permissions

### ClassNotFoundException: org.postgresql.Driver

**Problem**: JDBC driver not found

**Solutions**:
1. Ensure postgresql-xx.jar is in `WEB-INF/lib/`
2. Verify JAR is added to build path in IDE
3. Restart Tomcat after adding JAR

### 404 Error on Servlets

**Problem**: Servlet URLs return 404

**Solutions**:
1. Check web.xml servlet mappings
2. Verify servlet classes are compiled
3. Check Tomcat logs for deployment errors
4. Ensure context path is correct: `/BookHaven/admin/login`

### Admin Login Not Working

**Problem**: Admin credentials not accepted

**Solutions**:
1. Verify database schema was created: `SELECT * FROM admins;`
2. Check credentials: username=`admin`, password=`admin123`
3. Verify AdminLoginServlet is properly deployed
4. Check Tomcat logs for exceptions

### Books Not Displaying

**Problem**: Home page shows no books

**Solutions**:
1. Check database: `SELECT * FROM books WHERE featured=true;`
2. Verify database connection in logs
3. Check BookDAO.getFeaturedBooks() method
4. Look for exceptions in Tomcat logs

### Port Already in Use

**Problem**: Tomcat fails to start - port 8080 in use

**Solutions**:
1. Change Tomcat port in `server.xml`
2. Stop conflicting application: `lsof -i :8080` (Linux/Mac)
3. Kill process using port: `kill -9 <PID>`

## Testing the Application

### Test Home Page
```
http://localhost:8080/BookHaven/
```
Should display featured books

### Test Contact Form
```
http://localhost:8080/BookHaven/contact
```
Submit a message and verify it's saved

### Test Admin Login
```
http://localhost:8080/BookHaven/admin/login
```
Login with: admin / admin123

### Test Admin Dashboard
```
http://localhost:8080/BookHaven/admin/dashboard
```
Should show books and contact submissions

## Production Deployment Checklist

Before deploying to production:

- [ ] Change default admin password
- [ ] Implement password hashing
- [ ] Enable HTTPS/SSL
- [ ] Configure production database
- [ ] Remove sample data
- [ ] Set secure session cookies
- [ ] Implement input validation
- [ ] Add error handling
- [ ] Configure backup strategy
- [ ] Set up monitoring
- [ ] Review security settings
- [ ] Test all functionality

## Additional Resources

- [Apache Tomcat Documentation](https://tomcat.apache.org/tomcat-9.0-doc/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Java Servlet Tutorial](https://docs.oracle.com/javaee/7/tutorial/servlets.htm)
- [JSP Tutorial](https://docs.oracle.com/javaee/7/tutorial/jsps.htm)

## Support

If you encounter issues not covered here:
1. Check Tomcat logs: `$CATALINA_HOME/logs/catalina.out`
2. Check PostgreSQL logs
3. Open an issue on GitHub
4. Contact the development team

---

**Good luck with your setup!** 🚀
