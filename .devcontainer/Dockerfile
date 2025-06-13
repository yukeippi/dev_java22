FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install Java 22
RUN apt-get update && \
    apt-get install -y wget curl git vim && \
    wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | apt-key add - && \
    echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list && \
    apt-get update && \
    apt-get install -y temurin-22-jdk

# Set JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/temurin-22-jdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Install Maven
RUN apt-get install -y maven

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-8.5-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-*.zip && \
    ln -s /opt/gradle/gradle-8.5/bin/gradle /usr/bin/gradle

# Install Tomcat 10
RUN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.28/bin/apache-tomcat-10.1.28.tar.gz -P /tmp && \
    tar -xzf /tmp/apache-tomcat-10.1.28.tar.gz -C /opt && \
    mv /opt/apache-tomcat-10.1.28 /opt/tomcat && \
    chown -R vscode:vscode /opt/tomcat && \
    chmod +x /opt/tomcat/bin/*.sh

# Set Tomcat environment variables
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

# Install Node.js 22
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

# Configure npm for user-local installation (avoid permission issues)
RUN mkdir -p /home/vscode/.npm-global && \
    chown -R vscode:vscode /home/vscode/.npm-global

# Copy Tomcat configuration files
COPY tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml
COPY server.xml /opt/tomcat/conf/server.xml

# Expose Tomcat port
EXPOSE 8080

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Switch to vscode user and set npm configuration
USER vscode

# Set npm prefix for user-local installation
RUN npm config set prefix '/home/vscode/.npm-global' && \
    echo 'export PATH=/home/vscode/.npm-global/bin:$PATH' >> /home/vscode/.bashrc