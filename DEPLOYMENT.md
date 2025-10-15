# BookHaven Deployment Guide

This guide covers deploying BookHaven to various environments.

## Table of Contents
1. [Local Development Deployment](#local-development-deployment)
2. [Production Deployment](#production-deployment)
3. [Cloud Deployment Options](#cloud-deployment-options)
4. [Docker Deployment](#docker-deployment)
5. [Deployment Checklist](#deployment-checklist)

---

## Local Development Deployment

### Quick Deploy to Tomcat

**Method 1: IDE Deployment (Recommended)**
```
1. Import project into Eclipse/IntelliJ/NetBeans
2. Configure Tomcat server in IDE
3. Right-click project → Run on Server
4. Access: http://localhost:8080/BookHaven/
```

**Method 2: Manual WAR Deployment**
```bash
# Build WAR file (requires servlet-api.jar and postgresql.jar)
export SERVLET_JAR=/path/to/servlet-api.jar
export POSTGRES_JAR=/path/to/postgresql-42.x.x.jar
./build.sh

# Deploy to Tomcat
cp BookHaven.war $CATALINA_HOME/webapps/

# Start Tomcat
cd $CATALINA_HOME/bin
./catalina.sh run
```

**Method 3: Direct Directory Copy**
```bash
# Copy application to webapps
cp -r src/main/webapp $CATALINA_HOME/webapps/BookHaven

# Copy compiled classes
mkdir -p $CATALINA_HOME/webapps/BookHaven/WEB-INF/classes
cp -r [compiled-classes]/* $CATALINA_HOME/webapps/BookHaven/WEB-INF/classes/

# Start Tomcat
cd $CATALINA_HOME/bin
./catalina.sh run
```

---

## Production Deployment

### Pre-Deployment Checklist

- [ ] **Security Updates**
  - [ ] Change default admin password
  - [ ] Implement password hashing (BCrypt)
  - [ ] Enable HTTPS/SSL
  - [ ] Configure secure session cookies
  - [ ] Add CSRF protection
  - [ ] Implement input validation and sanitization
  - [ ] Review and update security headers

- [ ] **Configuration**
  - [ ] Update database credentials in db.properties
  - [ ] Configure production database connection
  - [ ] Set appropriate session timeout
  - [ ] Configure error pages (web.xml)
  - [ ] Remove development/debug code
  - [ ] Update contact information in JSP files

- [ ] **Database**
  - [ ] Create production database
  - [ ] Run schema.sql
  - [ ] Remove sample/test data
  - [ ] Set up database backups
  - [ ] Configure connection pooling
  - [ ] Apply proper database permissions

- [ ] **Performance**
  - [ ] Enable Tomcat compression
  - [ ] Configure JVM memory settings
  - [ ] Set up connection pooling
  - [ ] Optimize database queries
  - [ ] Add caching if needed

- [ ] **Monitoring**
  - [ ] Set up application logging
  - [ ] Configure Tomcat access logs
  - [ ] Set up error monitoring
  - [ ] Configure database monitoring
  - [ ] Set up uptime monitoring

### Step-by-Step Production Deployment

#### 1. Prepare Production Server

```bash
# Install Java
sudo apt update
sudo apt install openjdk-11-jdk

# Install Tomcat
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz
tar -xzf apache-tomcat-9.0.65.tar.gz
sudo mv apache-tomcat-9.0.65 /opt/tomcat

# Install PostgreSQL
sudo apt install postgresql postgresql-contrib
```

#### 2. Configure PostgreSQL

```bash
# Switch to postgres user
sudo -i -u postgres

# Create database and user
psql
CREATE DATABASE bookhaven_prod;
CREATE USER bookhaven_user WITH PASSWORD 'secure_password_here';
GRANT ALL PRIVILEGES ON DATABASE bookhaven_prod TO bookhaven_user;
\q

# Exit postgres user
exit
```

#### 3. Initialize Database

```bash
# Upload schema.sql to server
scp database/schema.sql user@server:/tmp/

# Run schema on production database
psql -U bookhaven_user -d bookhaven_prod -f /tmp/schema.sql
```

#### 4. Configure Application

Edit production `db.properties`:
```properties
db.url=jdbc:postgresql://localhost:5432/bookhaven_prod
db.username=bookhaven_user
db.password=secure_password_here
db.driver=org.postgresql.Driver
```

#### 5. Build and Deploy

```bash
# Build WAR file locally
./build.sh

# Upload WAR to server
scp BookHaven.war user@server:/tmp/

# Deploy to Tomcat
sudo cp /tmp/BookHaven.war /opt/tomcat/webapps/

# Add PostgreSQL JDBC driver
sudo cp postgresql-42.x.x.jar /opt/tomcat/lib/
```

#### 6. Configure Tomcat

Edit `/opt/tomcat/conf/server.xml`:

```xml
<!-- Add Connector with compression -->
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443"
           compression="on"
           compressionMinSize="2048"
           compressibleMimeType="text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json" />

<!-- For HTTPS (if configured) -->
<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
           maxThreads="150" SSLEnabled="true">
    <SSLHostConfig>
        <Certificate certificateKeystoreFile="conf/keystore.jks"
                     type="RSA" />
    </SSLHostConfig>
</Connector>
```

#### 7. Configure Systemd Service

Create `/etc/systemd/system/tomcat.service`:

```ini
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
```

Enable and start service:
```bash
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat
sudo systemctl status tomcat
```

#### 8. Configure Firewall

```bash
# Allow HTTP and HTTPS
sudo ufw allow 8080/tcp
sudo ufw allow 8443/tcp
sudo ufw enable
```

#### 9. Set Up Reverse Proxy (Optional)

**Nginx Configuration** (`/etc/nginx/sites-available/bookhaven`):

```nginx
server {
    listen 80;
    server_name your-domain.com;

    # Redirect to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name your-domain.com;

    ssl_certificate /path/to/certificate.crt;
    ssl_certificate_key /path/to/private.key;

    location / {
        proxy_pass http://localhost:8080/BookHaven/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Enable site:
```bash
sudo ln -s /etc/nginx/sites-available/bookhaven /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

---

## Cloud Deployment Options

### AWS Deployment

**Option 1: AWS Elastic Beanstalk**
```bash
# Install EB CLI
pip install awsebcli

# Initialize
eb init -p tomcat-8.5-java-8 bookhaven

# Deploy
eb create bookhaven-prod
eb deploy

# Configure RDS for PostgreSQL
# Update db.properties with RDS endpoint
```

**Option 2: AWS EC2**
```bash
# Launch EC2 instance (Ubuntu)
# Follow production deployment steps above
# Configure Security Groups for ports 8080, 80, 443
# Use RDS for PostgreSQL database
```

### Heroku Deployment

Create `Procfile`:
```
web: java $JAVA_OPTS -jar target/BookHaven.war --port=$PORT
```

Deploy:
```bash
heroku create bookhaven-app
heroku addons:create heroku-postgresql:hobby-dev
git push heroku main
```

### Google Cloud Platform

**App Engine Deployment**

Create `app.yaml`:
```yaml
runtime: java11
instance_class: F2

handlers:
- url: /.*
  script: auto
  secure: always
```

Deploy:
```bash
gcloud app deploy
```

### Azure Deployment

```bash
# Create App Service
az webapp create --name bookhaven --resource-group myResourceGroup --plan myAppServicePlan

# Deploy WAR file
az webapp deploy --name bookhaven --resource-group myResourceGroup --src-path BookHaven.war --type war
```

---

## Docker Deployment

### Dockerfile

Create `Dockerfile`:

```dockerfile
FROM tomcat:9-jdk11

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY BookHaven.war /usr/local/tomcat/webapps/ROOT.war

# Copy PostgreSQL JDBC driver
COPY postgresql-42.6.0.jar /usr/local/tomcat/lib/

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
```

### docker-compose.yml

```yaml
version: '3.8'

services:
  db:
    image: postgres:13
    environment:
      POSTGRES_DB: bookhaven
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./database/schema.sql:/docker-entrypoint-initdb.d/schema.sql

  web:
    build: .
    ports:
      - "8080:8080"
    depends_on:
      - db
    environment:
      DB_URL: jdbc:postgresql://db:5432/bookhaven
      DB_USER: postgres
      DB_PASSWORD: postgres

volumes:
  postgres_data:
```

### Deploy with Docker

```bash
# Build and run
docker-compose up -d

# View logs
docker-compose logs -f

# Stop
docker-compose down
```

---

## Deployment Checklist

### Pre-Deployment
- [ ] All tests pass locally
- [ ] Code reviewed and approved
- [ ] Database schema finalized
- [ ] Configuration files updated
- [ ] Security measures implemented
- [ ] Documentation updated
- [ ] Backup plan in place

### During Deployment
- [ ] Database backup created
- [ ] Application deployed
- [ ] Database migrations run
- [ ] Configuration verified
- [ ] Services restarted
- [ ] Smoke tests passed

### Post-Deployment
- [ ] Application accessible
- [ ] All pages loading correctly
- [ ] Database connectivity verified
- [ ] Admin login working
- [ ] Contact form functional
- [ ] Logs checked for errors
- [ ] Performance metrics acceptable
- [ ] Monitoring enabled
- [ ] Team notified

### Rollback Plan
- [ ] Previous version WAR backed up
- [ ] Database backup available
- [ ] Rollback procedure documented
- [ ] Emergency contacts identified

---

## Monitoring and Maintenance

### Log Locations

```bash
# Tomcat logs
tail -f /opt/tomcat/logs/catalina.out

# PostgreSQL logs
sudo tail -f /var/log/postgresql/postgresql-13-main.log

# Nginx logs (if used)
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

### Performance Monitoring

```bash
# Check Tomcat process
ps aux | grep tomcat

# Check memory usage
free -h

# Check disk space
df -h

# Check database connections
psql -U postgres -d bookhaven_prod -c "SELECT count(*) FROM pg_stat_activity;"
```

### Backup Strategy

```bash
# Database backup (daily)
pg_dump -U bookhaven_user bookhaven_prod > backup_$(date +%Y%m%d).sql

# Automated backup script
0 2 * * * /usr/bin/pg_dump -U bookhaven_user bookhaven_prod > /backups/bookhaven_$(date +\%Y\%m\%d).sql
```

---

## Troubleshooting

### Application Not Starting
```bash
# Check Tomcat logs
tail -100 /opt/tomcat/logs/catalina.out

# Check for port conflicts
netstat -tuln | grep 8080

# Verify JAVA_HOME
echo $JAVA_HOME
```

### Database Connection Issues
```bash
# Test database connection
psql -U bookhaven_user -h localhost -d bookhaven_prod

# Check PostgreSQL status
sudo systemctl status postgresql

# Check database logs
sudo tail -50 /var/log/postgresql/postgresql-13-main.log
```

### Performance Issues
```bash
# Check JVM memory
jstat -gc <tomcat_pid>

# Monitor database
psql -U postgres -d bookhaven_prod -c "SELECT * FROM pg_stat_activity;"

# Check slow queries
psql -U postgres -d bookhaven_prod -c "SELECT * FROM pg_stat_statements ORDER BY total_time DESC LIMIT 10;"
```

---

## Support

For deployment issues:
- Check logs first
- Review documentation
- Open GitHub issue
- Contact support team

---

**Successful Deployment!** 🚀

Your BookHaven application should now be live and accessible to users.
