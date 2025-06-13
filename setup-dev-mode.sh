#!/bin/bash

# 開発モード設定スクリプト（ファイル変更の自動反映）

echo "Setting up development mode..."

# プロジェクトディレクトリとTomcatパスを設定
PROJECT_WEB_DIR="/workspaces/dev_java22/web"
TOMCAT_APP_DIR="/opt/tomcat/webapps/HelloWorld"

# 既存のデプロイメントを削除
echo "Cleaning up existing deployment..."
if [ -d "$TOMCAT_APP_DIR" ]; then
    rm -rf "$TOMCAT_APP_DIR"
fi

if [ -f "/opt/tomcat/webapps/HelloWorld.war" ]; then
    rm -f "/opt/tomcat/webapps/HelloWorld.war"
fi

# シンボリックリンクを作成（ファイル変更の自動反映）
echo "Creating symbolic link for auto-reload..."
ln -sf "$PROJECT_WEB_DIR" "$TOMCAT_APP_DIR"

if [ $? -eq 0 ]; then
    echo "✓ Development mode enabled!"
    echo "✓ JSP files will be automatically reloaded on change"
    echo "✓ Edit files in: $PROJECT_WEB_DIR"
    echo "✓ Changes reflect immediately at: http://localhost:8080/HelloWorld/"
    echo ""
    echo "Note: For Servlet changes, still run ./compile-servlet.sh"
else
    echo "✗ Failed to create symbolic link!"
    exit 1
fi