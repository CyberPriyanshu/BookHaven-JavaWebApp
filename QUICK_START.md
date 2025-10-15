# BookHaven - Quick Start Guide

Get BookHaven up and running in 5 minutes!

## Prerequisites Checklist

- [ ] Java JDK 8+ installed (`java -version`)
- [ ] Apache Tomcat 9.x downloaded and extracted
- [ ] PostgreSQL installed and running
- [ ] PostgreSQL JDBC driver downloaded (postgresql-42.x.x.jar)

## 5-Minute Setup

### Step 1: Database (2 minutes)

```bash
# Create database
createdb bookhaven

# Or using psql
psql -U postgres -c "CREATE DATABASE bookhaven;"

# Initialize schema
cd BookHaven-JavaWebApp
psql -U postgres -d bookhaven -f database/schema.sql
```

### Step 2: Configure (1 minute)

Edit `src/main/resources/db.properties`:
```properties
db.url=jdbc:postgresql://localhost:5432/bookhaven
db.username=postgres
db.password=YOUR_PASSWORD_HERE
db.driver=org.postgresql.Driver
```

### Step 3: Add JDBC Driver (30 seconds)

```bash
# Copy PostgreSQL JDBC driver to WEB-INF/lib
cp /path/to/postgresql-42.x.x.jar src/main/webapp/WEB-INF/lib/
```

### Step 4: Deploy (1 minute)

**Option A: Using IDE (Recommended for Development)**
1. Import project into Eclipse/IntelliJ/NetBeans
2. Add to Tomcat server
3. Run

**Option B: Manual Deployment**
```bash
# Build (if you have servlet-api.jar)
export SERVLET_JAR=/path/to/tomcat/lib/servlet-api.jar
export POSTGRES_JAR=/path/to/postgresql-42.x.x.jar
./build.sh

# Or create WAR manually and deploy
cp BookHaven.war $CATALINA_HOME/webapps/
cd $CATALINA_HOME/bin
./catalina.sh run
```

### Step 5: Access (30 seconds)

Open browser: `http://localhost:8080/BookHaven/`

## Default Credentials

**Admin Login:**
- Username: `admin`
- Password: `admin123`

## Quick Links

- **Home**: http://localhost:8080/BookHaven/
- **Contact**: http://localhost:8080/BookHaven/contact
- **Admin**: http://localhost:8080/BookHaven/admin/login
- **Dashboard**: http://localhost:8080/BookHaven/admin/dashboard (after login)

## Verify Installation

Run these checks:

```sql
-- Check database tables
psql -U postgres -d bookhaven -c "\dt"

-- Check sample data
psql -U postgres -d bookhaven -c "SELECT COUNT(*) FROM books;"
psql -U postgres -d bookhaven -c "SELECT COUNT(*) FROM admins;"
```

Expected output:
- 10 books
- 1 admin

## Common Issues & Fixes

### Issue: Database connection failed

**Solution:**
```bash
# Check PostgreSQL is running
sudo systemctl status postgresql  # Linux
# or check Services on Windows

# Verify credentials in db.properties
psql -U postgres -d bookhaven -c "SELECT 1;"
```

### Issue: ClassNotFoundException: org.postgresql.Driver

**Solution:**
```bash
# Ensure JDBC driver is in correct location
ls src/main/webapp/WEB-INF/lib/postgresql*.jar

# If missing, download and copy:
wget https://jdbc.postgresql.org/download/postgresql-42.6.0.jar
mv postgresql-42.6.0.jar src/main/webapp/WEB-INF/lib/
```

### Issue: 404 Not Found

**Solution:**
- Check context path: Use `/BookHaven/` not `/`
- Verify deployment in Tomcat webapps directory
- Check Tomcat logs: `tail -f $CATALINA_HOME/logs/catalina.out`

### Issue: Admin login fails

**Solution:**
```sql
-- Verify admin user exists
psql -U postgres -d bookhaven -c "SELECT * FROM admins;"

-- If no admin, create one:
psql -U postgres -d bookhaven -c "INSERT INTO admins (username, password, email) VALUES ('admin', 'admin123', 'admin@bookhaven.com');"
```

### Issue: No books showing

**Solution:**
```sql
-- Check for featured books
psql -U postgres -d bookhaven -c "SELECT * FROM books WHERE featured=true;"

-- If none, update some books:
psql -U postgres -d bookhaven -c "UPDATE books SET featured=true WHERE id <= 6;"
```

## IDE-Specific Quick Setup

### Eclipse

1. File → New → Dynamic Web Project → Name: `BookHaven`
2. Copy all files from repository
3. Right-click project → Build Path → Add External JARs → Add servlet-api.jar and postgresql.jar
4. Right-click project → Run As → Run on Server
5. Access: http://localhost:8080/BookHaven/

### IntelliJ IDEA

1. File → New → Project from Existing Sources → Select directory
2. File → Project Structure → Libraries → Add servlet-api.jar and postgresql.jar
3. Run → Edit Configurations → Add Tomcat Server
4. Click Run
5. Access: http://localhost:8080/BookHaven/

### NetBeans

1. File → New Project → Java Web → Web Application
2. Copy all files
3. Right-click project → Properties → Libraries → Add JARs
4. Right-click project → Run
5. Access: http://localhost:8080/BookHaven/

## Project Structure (Simplified)

```
BookHaven/
├── database/schema.sql              # Run this first!
├── src/main/
│   ├── java/com/bookhaven/          # Java source files
│   ├── resources/db.properties      # Configure database here
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── web.xml              # Servlet configuration
│       │   └── lib/                 # Add postgresql.jar here
│       └── *.jsp                    # Web pages
└── README.md                        # Full documentation
```

## Testing Your Setup

### Test 1: Home Page
```bash
curl http://localhost:8080/BookHaven/
# Should return HTML with "BookHaven" title
```

### Test 2: Database Connection
```bash
# Check Tomcat logs for errors
tail -f $CATALINA_HOME/logs/catalina.out
# Should NOT see "SQLException" or "Connection refused"
```

### Test 3: Admin Login
1. Go to: http://localhost:8080/BookHaven/admin/login
2. Enter: admin / admin123
3. Should redirect to dashboard

### Test 4: Contact Form
1. Go to: http://localhost:8080/BookHaven/contact
2. Fill and submit form
3. Should see success message
4. Verify in database:
   ```sql
   psql -U postgres -d bookhaven -c "SELECT * FROM contacts ORDER BY id DESC LIMIT 1;"
   ```

## Next Steps

1. **Customize Data**: 
   - Add your own books in database
   - Update contact information in JSP files

2. **Modify UI**:
   - Edit colors in `header.jsp` (CSS variables)
   - Update footer information in `footer.jsp`

3. **Enhance Features**:
   - Add book search functionality
   - Implement CRUD operations in admin dashboard
   - Add image upload for books

4. **Production Deployment**:
   - Change admin password
   - Enable HTTPS
   - Implement password hashing
   - See SETUP.md for production checklist

## Getting Help

- **Documentation**: See README.md for detailed info
- **Setup Issues**: Check SETUP.md troubleshooting section
- **Architecture**: Read PROJECT_STRUCTURE.md
- **Logs**: Always check Tomcat logs first!

## Useful Commands

```bash
# Check Tomcat status
ps aux | grep tomcat

# View logs in real-time
tail -f $CATALINA_HOME/logs/catalina.out

# Check PostgreSQL connections
psql -U postgres -c "SELECT * FROM pg_stat_activity WHERE datname='bookhaven';"

# Restart Tomcat
$CATALINA_HOME/bin/shutdown.sh
$CATALINA_HOME/bin/startup.sh

# Check if port 8080 is in use
lsof -i :8080  # Mac/Linux
netstat -ano | findstr :8080  # Windows
```

## Development Tips

1. **Hot Reload**: Use IDE's hot swap feature for quick development
2. **Debug Mode**: Start Tomcat with `catalina.sh jpda run` for debugging
3. **Logs**: Always check logs when something doesn't work
4. **Database**: Use pgAdmin for easier database management
5. **Version Control**: Commit changes frequently

---

## Quick Reference Card

| Task | Command/URL |
|------|-------------|
| Access app | http://localhost:8080/BookHaven/ |
| Admin login | http://localhost:8080/BookHaven/admin/login |
| View logs | `tail -f $CATALINA_HOME/logs/catalina.out` |
| Restart Tomcat | `$CATALINA_HOME/bin/shutdown.sh && $CATALINA_HOME/bin/startup.sh` |
| Check DB | `psql -U postgres -d bookhaven` |
| Re-deploy | `cp BookHaven.war $CATALINA_HOME/webapps/` |

---

**Ready to code!** 🚀

For complete documentation, see [README.md](README.md) and [SETUP.md](SETUP.md).
