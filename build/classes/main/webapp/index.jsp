<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.filesys.servlet.Document" %>
<%@ page import="com.filesys.servlet.DocumentDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>文档管理系统</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h1 class="mb-4">轻量级文档管理系统</h1>
        
        <% if(session.getAttribute("user") == null) { %>
        <!-- 登录表单 -->
        <div class="card mb-4">
            <div class="card-header">
                <h2>用户登录</h2>
            </div>
            <div class="card-body">
                <% if(request.getParameter("error") != null) { %>
                    <div class="alert alert-danger">用户名或密码错误！</div>
                <% } %>
                <% if(request.getParameter("registered") != null) { %>
                    <div class="alert alert-success">注册成功，请登录！</div>
                <% } %>
                <form action="LoginServlet" method="post">
                    <div class="mb-3">
                        <label for="username" class="form-label">用户名：</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">密码：</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary">登录</button>
                </form>
                <p class="mt-3">没有账号？<a href="register.jsp">注册</a></p>
            </div>
        </div>
        <% } else { %>
        <!-- 已登录状态 -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
            <div class="container-fluid">
                <span class="navbar-brand">欢迎，<%= session.getAttribute("user") %>！</span>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="forum.jsp">论坛</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp?logout=1">退出</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        
        <% if("admin".equals(session.getAttribute("user"))) { %>
        <!-- 管理员上传表单 -->
        <div class="card mb-4">
            <div class="card-header">
                <h2>上传文档</h2>
            </div>
            <div class="card-body">
                <% if(request.getParameter("success") != null) { %>
                    <div class="alert alert-success">文件上传成功！</div>
                <% } %>
                <% if(request.getParameter("error") != null && request.getParameter("error").equals("4")) { %>
                    <div class="alert alert-danger">文件上传失败！</div>
                <% } %>
                <form action="UploadServlet" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="title" class="form-label">标题：</label>
                        <input type="text" class="form-control" id="title" name="title" required>
                    </div>
                    <div class="mb-3">
                        <label for="file" class="form-label">文件：</label>
                        <input type="file" class="form-control" id="file" name="file" required>
                    </div>
                    <button type="submit" class="btn btn-primary">上传</button>
                </form>
            </div>
        </div>
        <% } %>
        
        <!-- 文档列表 -->
        <div class="card">
            <div class="card-header">
                <h2>文档列表</h2>
            </div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>标题</th>
                            <th>上传时间</th>
                        </tr>
                    </thead>
                    <tbody>
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
                    </tbody>
                </table>
            </div>
        </div>
        <% } %>
    </div>
    
    <% 
    // 处理退出登录
    if(request.getParameter("logout") != null) {
        session.invalidate();
        response.sendRedirect("index.jsp");
    }
    %>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>