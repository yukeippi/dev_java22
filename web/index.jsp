<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>HelloWorld Web Application</title>
</head>
<body>
    <h1>Hello, World from JSP!</h1>
    <p>Current time: <%= new java.util.Date() %></p>
    <p>Java version: <%= System.getProperty("java.version") %></p>
    <p>Tomcat is running successfully!</p>
</body>
</html>
