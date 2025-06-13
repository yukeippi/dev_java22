#!/bin/bash

# Start Tomcat server
echo "Starting Tomcat server..."

# Check if Tomcat is already running
if pgrep -f "catalina" > /dev/null; then
    echo "Tomcat is already running!"
    exit 1
fi

# Set environment variables
export CATALINA_HOME=/opt/tomcat
# export JAVA_HOME=/usr/lib/jvm/temurin-22-jdk-amd64
export JAVA_HOME=/usr/lib/jvm/temurin-22-jdk-arm64

# Start Tomcat
$CATALINA_HOME/bin/startup.sh

echo "Tomcat started successfully!"
echo "Access your application at: http://localhost:8080"
echo "Tomcat Manager at: http://localhost:8080/manager/html (admin/admin)"

# Show logs
echo "Showing Tomcat logs (Ctrl+C to stop):"
tail -f $CATALINA_HOME/logs/catalina.out
