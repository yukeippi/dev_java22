# Java 22 Development Environment

このプロジェクトはJava 22の開発環境をVS Code Dev Containerで提供します。

## 環境構成

- **Java**: OpenJDK 22 (Adoptium Temurin)
- **ビルドツール**: Maven, Gradle 8.5
- **ベースイメージ**: Ubuntu (Microsoft Dev Containers)

## 使い方

### Dev Containerの起動

1. VS Codeでこのフォルダを開く
2. 「Dev Container で再度開く」を選択
3. コンテナのビルドと起動を待つ

### HelloWorldプログラムの実行

```bash
# コンパイル
javac HelloWorld.java

# 実行
java HelloWorld
```

期待される出力:
```
Hello, World!
```

## 含まれるツール

- Java 22 (Temurin JDK)
- Maven
- Gradle 8.5
- Git
- Vim