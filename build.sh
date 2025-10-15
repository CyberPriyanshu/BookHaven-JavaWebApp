#!/bin/bash
# Build script for BookHaven Web Application

echo "========================================="
echo "   BookHaven - Build Script"
echo "========================================="

# Variables
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$PROJECT_ROOT/src/main/java"
WEB_DIR="$PROJECT_ROOT/src/main/webapp"
BUILD_DIR="$PROJECT_ROOT/build"
CLASSES_DIR="$BUILD_DIR/WEB-INF/classes"
LIB_DIR="$WEB_DIR/WEB-INF/lib"
WAR_FILE="$PROJECT_ROOT/BookHaven.war"

# Check for required tools
if ! command -v javac &> /dev/null; then
    echo "Error: javac not found. Please install JDK."
    exit 1
fi

if ! command -v jar &> /dev/null; then
    echo "Error: jar not found. Please install JDK."
    exit 1
fi

echo "Step 1: Cleaning previous build..."
rm -rf "$BUILD_DIR"
rm -f "$WAR_FILE"

echo "Step 2: Creating build directories..."
mkdir -p "$CLASSES_DIR"
mkdir -p "$BUILD_DIR/WEB-INF/lib"

echo "Step 3: Compiling Java sources..."
# Note: You need to add servlet-api.jar and postgresql.jar to the classpath
# Example: export CLASSPATH="/path/to/servlet-api.jar:/path/to/postgresql.jar"

if [ -z "$SERVLET_JAR" ]; then
    echo "Warning: SERVLET_JAR environment variable not set."
    echo "Please set it to the path of servlet-api.jar"
    echo "Example: export SERVLET_JAR=/path/to/servlet-api.jar"
fi

if [ -z "$POSTGRES_JAR" ]; then
    echo "Warning: POSTGRES_JAR environment variable not set."
    echo "Please set it to the path of postgresql-xx.jar"
    echo "Example: export POSTGRES_JAR=/path/to/postgresql.jar"
fi

# Compile with servlet and postgresql jars if available
COMPILE_CP="$SERVLET_JAR:$POSTGRES_JAR"
if [ -n "$SERVLET_JAR" ] && [ -n "$POSTGRES_JAR" ]; then
    find "$SRC_DIR" -name "*.java" -print | xargs javac -d "$CLASSES_DIR" -cp "$COMPILE_CP"
    if [ $? -ne 0 ]; then
        echo "Error: Compilation failed!"
        exit 1
    fi
    echo "Compilation successful!"
else
    echo "Skipping compilation - classpath not configured"
    echo "Please set SERVLET_JAR and POSTGRES_JAR environment variables"
fi

echo "Step 4: Copying web resources..."
cp -r "$WEB_DIR"/* "$BUILD_DIR/"

echo "Step 5: Copying resources..."
if [ -d "$PROJECT_ROOT/src/main/resources" ]; then
    cp -r "$PROJECT_ROOT/src/main/resources"/* "$CLASSES_DIR/"
fi

echo "Step 6: Creating WAR file..."
cd "$BUILD_DIR"
jar -cvf "$WAR_FILE" *
cd "$PROJECT_ROOT"

if [ -f "$WAR_FILE" ]; then
    echo "========================================="
    echo "   Build Successful!"
    echo "   WAR file: $WAR_FILE"
    echo "========================================="
    echo ""
    echo "Deploy Instructions:"
    echo "1. Copy $WAR_FILE to Tomcat's webapps directory"
    echo "2. Start/Restart Tomcat"
    echo "3. Access at http://localhost:8080/BookHaven/"
else
    echo "Error: WAR file creation failed!"
    exit 1
fi
