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

# Install Node.js 22
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Switch to vscode user (already exists in base image)
USER vscode