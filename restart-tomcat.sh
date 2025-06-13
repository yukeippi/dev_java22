#!/bin/bash

# Tomcat 再起動スクリプト

echo "Restarting Tomcat server..."

# Tomcatを停止
./stop-tomcat.sh

# 少し待機（プロセス終了を確実にする）
sleep 2

# Tomcatを起動
./start-tomcat.sh

echo "Tomcat restart completed!"