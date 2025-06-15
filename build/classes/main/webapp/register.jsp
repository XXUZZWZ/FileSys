<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户注册</title>
</head>
<body>
    <h1>用户注册</h1>
    
    <% if(request.getParameter("error") != null) { %>
        <p style="color: red;">注册失败，用户名可能已存在！</p>
    <% } %>
    
    <form action="RegisterServlet" method="post">
        用户名：<input type="text" name="username" required><br>
        密码：<input type="password" name="password" required><br>
        <input type="submit" value="注册">
    </form>
    
    <p>已有账号？<a href="index.jsp">返回登录</a></p>
</body>
</html> 