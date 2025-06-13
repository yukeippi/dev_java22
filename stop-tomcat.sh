#!/bin/bash

# Stop Tomcat server
echo "Stopping Tomcat server..."

# Set environment variables
export CATALINA_HOME=/opt/tomcat
# export JAVA_HOME=/usr/lib/jvm/temurin-22-jdk-amd64
export JAVA_HOME=/usr/lib/jvm/temurin-22-jdk-arm64

# Stop Tomcat
$CATALINA_HOME/bin/shutdown.sh

echo "Tomcat stopped successfully!"
