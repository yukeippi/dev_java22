#!/bin/bash

# Web アプリケーション デプロイスクリプト

echo "Deploying web application..."

# プロジェクトディレクトリとTomcatパスを設定
PROJECT_WEB_DIR="web"
TOMCAT_APP_DIR="/opt/tomcat/webapps/HelloWorld"

# Tomcatアプリディレクトリをクリーンアップ
echo "Cleaning up existing deployment..."
if [ -d "$TOMCAT_APP_DIR" ]; then
    rm -rf "$TOMCAT_APP_DIR"
fi

# WARファイルも削除（自動展開されるのを防ぐため）
if [ -f "/opt/tomcat/webapps/HelloWorld.war" ]; then
    rm -f "/opt/tomcat/webapps/HelloWorld.war"
fi

# プロジェクトのwebディレクトリをTomcatにコピー
echo "Copying web files to Tomcat..."
cp -r "$PROJECT_WEB_DIR" "$TOMCAT_APP_DIR"

if [ $? -eq 0 ]; then
    echo "✓ Files copied successfully!"
    echo "✓ JSP files can now be edited directly in the project"
    echo "✓ Changes will be reflected immediately after browser refresh"
    
    # 権限設定
    chmod -R 755 "$TOMCAT_APP_DIR"
    
    echo ""
    echo "Web application deployed to: $TOMCAT_APP_DIR"
    echo "Access URL: http://localhost:8080/HelloWorld/"
else
    echo "✗ Failed to copy files!"
    exit 1
fi