<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.filesys.servlet.Topic" %>
<%@ page import="com.filesys.servlet.ForumDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>论坛</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h1 class="mb-4">轻量级文档管理系统 - 论坛</h1>
        
        <% if(session.getAttribute("user") == null) { %>
            <div class="alert alert-warning">请先<a href="index.jsp" class="alert-link">登录</a>后使用论坛功能。</div>
        <% } else { %>
            <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
                <div class="container-fluid">
                    <span class="navbar-brand">欢迎，<%= session.getAttribute("user") %>！</span>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="index.jsp">返回首页</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            
            <% if(request.getParameter("success") != null) { %>
                <div class="alert alert-success">主题发布成功！</div>
            <% } %>
            <% if(request.getParameter("error") != null) { %>
                <div class="alert alert-danger">操作失败，请重试！</div>
            <% } %>
            
            <!-- 发表新主题表单 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h2>发表新主题</h2>
                </div>
                <div class="card-body">
                    <form action="CreateTopicServlet" method="post">
                        <div class="mb-3">
                            <label for="title" class="form-label">标题：</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="content" class="form-label">内容：</label>
                            <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">发表主题</button>
                    </form>
                </div>
            </div>
            
            <!-- 主题列表 -->
            <div class="card">
                <div class="card-header">
                    <h2>主题列表</h2>
                </div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>标题</th>
                                <th>作者</th>
                                <th>发布时间</th>
                                <th>浏览次数</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            try {
                                List<Topic> topics = ForumDAO.getAllTopics();
                                for(Topic topic : topics) { 
                            %>
                            <tr>
                                <td><a href="topicDetail.jsp?id=<%=topic.getId()%>"><%=topic.getTitle()%></a></td>
                                <td><%=topic.getUsername()%></td>
                                <td><%=topic.getCreateTime()%></td>
                                <td><%=topic.getViewCount()%></td>
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
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>