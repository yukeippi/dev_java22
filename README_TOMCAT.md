# Apache Tomcat 10 環境設定ガイド

このガイドでは、Java 22 + Apache Tomcat 10を使用したWeb開発環境の設定と使用方法について説明します。

## 環境構成

- **Java**: OpenJDK 22 (Temurin)
- **Tomcat**: Apache Tomcat 10.1.28
- **ビルドツール**: Apache Ant, Maven, Gradle
- **開発環境**: VS Code Dev Container

## セットアップ手順

### 1. Dev Containerの再構築

VS Codeで以下の手順を実行：

1. Command Palette (`Ctrl+Shift+P`) を開く
2. "Dev Containers: Rebuild Container" を実行
3. コンテナのビルドが完了するまで待機（Tomcatのダウンロードとインストールが実行されます）

### 2. Tomcatの起動

```bash
# 便利な起動スクリプトを使用
./start-tomcat.sh

# または手動で起動
export CATALINA_HOME=/opt/tomcat
$CATALINA_HOME/bin/startup.sh
```

### 3. 動作確認

以下のURLにアクセスして動作確認：

- **Tomcatデフォルトページ**: http://localhost:8080
- **サンプルJSPアプリ**: http://localhost:8080/HelloWorld
- **Tomcat管理コンソール**: http://localhost:8080/manager/html
  - ユーザー名: `admin`
  - パスワード: `admin`

## プロジェクト構造

```
├── .devcontainer/
│   └── Dockerfile              # 開発環境設定（Tomcatインストール含む）
├── web/
│   ├── WEB-INF/
│   │   ├── src/
│   │   │   └── HelloServlet.java    # Servletソースコード
│   │   ├── classes/
│   │   │   └── HelloServlet.class   # コンパイル済みクラスファイル
│   │   └── web.xml             # Webアプリケーション設定
│   └── index.jsp               # サンプルJSPページ
├── HelloWorld.java             # 単体実行用Javaファイル
├── HelloWorld.class            # コンパイル済みクラスファイル
├── build.xml                   # Antビルドスクリプト
├── compile-servlet.sh          # Servlet専用コンパイルスクリプト
├── deploy-web.sh               # Webアプリケーション手動デプロイスクリプト
├── setup-dev-mode.sh           # 開発モード設定スクリプト（推奨）
├── restart-tomcat.sh           # Tomcat再起動スクリプト
├── start-tomcat.sh             # Tomcat起動スクリプト
└── stop-tomcat.sh              # Tomcat停止スクリプト
```

## 開発環境のセットアップ

### 開発モードの設定（推奨）

```bash
# 一度だけ実行：開発モードを有効化
./setup-dev-mode.sh

# これにより以下が設定されます：
# - プロジェクトファイルとTomcatをシンボリックリンクで接続
# - JSPファイルの変更が即座に反映される
# - /opt/tomcat/webapps/HelloWorld -> /workspaces/dev_java22/web
```

### 開発モード後の作業手順

```bash
# JSPファイル編集の場合：
# 1. web/index.jsp を編集・保存
# 2. ブラウザでリフレッシュ → 即座に反映

# Servletファイル編集の場合：
# 1. web/WEB-INF/src/HelloServlet.java を編集・保存
# 2. ./compile-servlet.sh を実行
# 3. ブラウザでリフレッシュ → 変更が反映
```

## ビルドとデプロイ

### Servlet専用コンパイルスクリプト

```bash
# web/WEB-INF/src内のすべてのJavaファイルをコンパイル
./compile-servlet.sh

# このスクリプトは以下を実行します：
# 1. src内のすべての.javaファイルを検索
# 2. Servlet API付きでコンパイル
# 3. classesディレクトリに出力
# 4. Tomcatのwebappsディレクトリにコピー
```

### Antを使用したビルド（利用可能）

```bash
# プロジェクトのビルド
ant compile

# WARファイルの作成
ant war

# Tomcatへのデプロイ
ant deploy

# 一括実行（コンパイル→WAR作成→デプロイ）
ant deploy
```

### 手動デプロイ

```bash
# WARファイルを直接Tomcatのwebappsディレクトリにコピー
cp dist/HelloWorld.war $CATALINA_HOME/webapps/

# または、開発モードを使わない場合の手動デプロイ
./deploy-web.sh
```

## Tomcatの管理

### 起動・停止

```bash
# 起動（ログ表示付き）
./start-tomcat.sh

# 停止
./stop-tomcat.sh

# 再起動
./restart-tomcat.sh

# または手動で操作
$CATALINA_HOME/bin/startup.sh   # 起動
$CATALINA_HOME/bin/shutdown.sh  # 停止
```

### ログの確認

```bash
# リアルタイムログ表示
tail -f $CATALINA_HOME/logs/catalina.out

# アクセスログ
tail -f $CATALINA_HOME/logs/localhost_access_log.*.txt

# エラーログのみ表示
grep ERROR $CATALINA_HOME/logs/catalina.out
```

### Tomcatプロセスの確認

```bash
# Tomcatプロセスが動作しているか確認
ps aux | grep tomcat

# ポート8080が使用されているか確認
netstat -tlnp | grep :8080
```

## 環境変数

設定済みの環境変数：

- `JAVA_HOME`: `/usr/lib/jvm/temurin-22-jdk-amd64`
- `CATALINA_HOME`: `/opt/tomcat`
- `PATH`: Tomcatのbinディレクトリが追加済み

## サンプルアプリケーションの作成

### 1. 基本的なServlet

```java
// web/WEB-INF/src/HelloServlet.java
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class HelloServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head><title>Hello Servlet</title></head>");
        out.println("<body>");
        out.println("<h1>Hello from Servlet!</h1>");
        out.println("<p>Current time: " + new java.util.Date() + "</p>");
        out.println("</body>");
        out.println("</html>");
    }
}
```

### 2. web.xmlにServletを登録

web/WEB-INF/web.xmlに以下を追加：

```xml
<servlet>
    <servlet-name>HelloServlet</servlet-name>
    <servlet-class>HelloServlet</servlet-class>
</servlet>
<servlet-mapping>
    <servlet-name>HelloServlet</servlet-name>
    <url-pattern>/hello</url-pattern>
</servlet-mapping>
```

### 3. ビルドとデプロイ

```bash
# 開発モードが設定済みの場合（推奨）：
# Servletの場合のみコンパイルが必要
./compile-servlet.sh

# 開発モードを使わない場合：
# Servlet専用コンパイルスクリプトを使用
./compile-servlet.sh

# またはAntを使用
ant deploy

# Tomcatを再起動（必要に応じて）
./restart-tomcat.sh
```

アクセスURL: http://localhost:8080/HelloWorld/hello

## よくある質問と問題解決

### JSPファイルの変更が反映されない場合

**開発モードが設定されていない場合：**
```bash
# 開発モードを設定（一度だけ実行）
./setup-dev-mode.sh

# その後はJSPファイル編集→保存→ブラウザリフレッシュで即反映
```

**シンボリックリンクの確認：**
```bash
# HelloWorldがシンボリックリンクになっているか確認
ls -la /opt/tomcat/webapps/ | grep HelloWorld
# 結果: HelloWorld -> /workspaces/dev_java22/web
```

### Servletファイルの変更が反映されない場合

```bash
# 1. Servletファイルを編集後、必ずコンパイルを実行
./compile-servlet.sh

# 2. ブラウザでリフレッシュ
# 3. それでも反映されない場合はTomcat再起動
./restart-tomcat.sh
```

## トラブルシューティング

### Tomcatが起動しない場合

1. **ポート衝突の確認**
   ```bash
   netstat -tlnp | grep :8080
   # ポートが使用されている場合は、そのプロセスを終了
   ```

2. **Java環境の確認**
   ```bash
   java -version
   echo $JAVA_HOME
   ```

3. **Tomcatファイルの確認**
   ```bash
   ls -la $CATALINA_HOME/bin/
   # startup.shが実行可能か確認
   ```

### アプリケーションがデプロイされない場合

1. **WARファイルの確認**
   ```bash
   ls -la dist/
   ls -la $CATALINA_HOME/webapps/
   ```

2. **Tomcatログでエラーを確認**
   ```bash
   tail -n 50 $CATALINA_HOME/logs/catalina.out
   ```

3. **権限の確認**
   ```bash
   # webappsディレクトリの権限確認
   ls -la $CATALINA_HOME/webapps/
   ```

### よくあるエラーと解決方法

- **ClassNotFoundException**: クラスパスの設定を確認
- **Port already in use**: 他のプロセスがポート8080を使用している
- **Permission denied**: ファイル権限を確認（chmod +x）

## 設定ファイルの詳細

### tomcat-users.xml

管理ユーザーの設定：

```xml
<user username="admin" password="admin" roles="manager-gui,manager-script,admin-gui"/>
```

### server.xml

サーバーの基本設定（ポート、コネクタなど）が定義されています。

### web.xml

Jakarta EE 6.0仕様に基づくWebアプリケーション設定ファイルです。現在HelloServletが登録済みです。

## パフォーマンス最適化

### JVMオプションの設定

start-tomcat.shを編集してJVMオプションを追加：

```bash
export JAVA_OPTS="-Xmx512m -Xms256m -XX:+UseG1GC"
```

### Tomcat設定の最適化

server.xmlでコネクタのスレッド数を調整：

```xml
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443"
           maxThreads="200"
           minSpareThreads="10" />
```

## 参考リンク

- [Apache Tomcat 10 Documentation](https://tomcat.apache.org/tomcat-10.1-doc/)
- [Jakarta EE Specifications](https://jakarta.ee/specifications/)
- [Jakarta Servlet API](https://jakarta.ee/specifications/servlet/)
- [Java 22 Documentation](https://docs.oracle.com/en/java/javase/22/)

## 追加の開発ツール

- **Eclipse**: Tomcat統合プラグインあり
- **IntelliJ IDEA**: Tomcat実行設定をサポート
- **VS Code**: Extension Pack for Java + Tomcat for Java