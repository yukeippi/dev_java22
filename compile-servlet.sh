#!/bin/bash

# Java Servlet コンパイルスクリプト

echo "Compiling Java servlets..."

# Tomcatのライブラリパスを設定
TOMCAT_LIB="/opt/tomcat/lib"
SERVLET_API="$TOMCAT_LIB/servlet-api.jar"

# ソースディレクトリと出力ディレクトリを設定
SRC_DIR="web/WEB-INF/src"
OUTPUT_DIR="web/WEB-INF/classes"
TOMCAT_CLASSES="/opt/tomcat/webapps/HelloWorld/WEB-INF/classes"

# 出力ディレクトリが存在しない場合は作成
mkdir -p "$OUTPUT_DIR"
mkdir -p "$TOMCAT_CLASSES"

# srcディレクトリ内のすべての.javaファイルを検索してコンパイル
if [ -d "$SRC_DIR" ]; then
    # .javaファイルを検索
    JAVA_FILES=$(find "$SRC_DIR" -name "*.java")
    
    if [ -n "$JAVA_FILES" ]; then
        echo "Found Java files:"
        echo "$JAVA_FILES"
        echo ""
        
        # すべての.javaファイルをまとめてコンパイル
        javac -cp "$SERVLET_API" -d "$OUTPUT_DIR" $JAVA_FILES
        
        if [ $? -eq 0 ]; then
            echo "✓ Compilation successful!"
            
            # 生成されたクラスファイルをTomcatにコピー
            cp -r "$OUTPUT_DIR"/* "$TOMCAT_CLASSES/"
            echo "✓ Class files copied to Tomcat: $TOMCAT_CLASSES/"
        else
            echo "✗ Compilation failed!"
            exit 1
        fi
    else
        echo "✗ No Java files found in: $SRC_DIR"
        exit 1
    fi
else
    echo "✗ Source directory not found: $SRC_DIR"
    exit 1
fi