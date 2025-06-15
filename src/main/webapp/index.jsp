<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.filesys.servlet.Document" %>
<%@ page import="com.filesys.servlet.DocumentDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>文档管理系统</title>
</head>
<body>
    <h1>轻量级文档管理系统</h1>
    
    <% if(session.getAttribute("user") == null) { %>
    <!-- 登录表单 -->
    <h2>用户登录</h2>
    <% if(request.getParameter("error") != null) { %>
        <p style="color: red;">用户名或密码错误！</p>
    <% } %>
    <% if(request.getParameter("registered") != null) { %>
        <p style="color: green;">注册成功，请登录！</p>
    <% } %>
    <form action="LoginServlet" method="post">
        用户名：<input type="text" name="username" required><br>
        密码：<input type="password" name="password" required><br>
        <input type="submit" value="登录">
    </form>
    <p>没有账号？<a href="register.jsp">注册</a></p>
    <% } else { %>
    <!-- 已登录状态 -->
    <p>欢迎，<%= session.getAttribute("user") %>！ <a href="index.jsp?logout=1">退出</a></p>
    <!-- 在已登录状态下的导航部分添加 -->
	<p>欢迎，<%= session.getAttribute("user") %>！ <a href="index.jsp?logout=1">退出</a> | <a href="forum.jsp">论坛</a></p>
    <% if("admin".equals(session.getAttribute("user"))) { %>
    <!-- 管理员上传表单 -->
    <h2>上传文档</h2>
    <% if(request.getParameter("success") != null) { %>
        <p style="color: green;">文件上传成功！</p>
    <% } %>
    <% if(request.getParameter("error") != null && request.getParameter("error").equals("4")) { %>
        <p style="color: red;">文件上传失败！</p>
    <% } %>
    <form action="UploadServlet" method="post" enctype="multipart/form-data">
        标题：<input type="text" name="title" required><br>
        文件：<input type="file" name="file" required><br>
        <input type="submit" value="上传">
    </form>
    <% } %>
    
    <!-- 文档列表 -->
    <h2>文档列表</h2>
    <table border="1" style="width: 80%;">
        <tr>
            <th>标题</th>
            <th>上传时间</th>
        </tr>
        <% 
        try {
            List<Document> documentList = DocumentDAO.getAllDocuments();
            for(Document doc : documentList) { 
        %>
        <tr>
            <td><a href="download.jsp?id=<%=doc.getId()%>"><%=doc.getTitle()%></a></td>
            <td><%=doc.getUploadTime()%></td>
        </tr>
        <% 
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        %>
    </table>
    <% } %>
    
    <% 
    // 处理退出登录
    if(request.getParameter("logout") != null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }
    %>
</body>
</html> 