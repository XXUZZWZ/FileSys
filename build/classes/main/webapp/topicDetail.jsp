<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.filesys.servlet.Topic" %>
<%@ page import="com.filesys.servlet.Reply" %>
<%@ page import="com.filesys.servlet.ForumDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>主题详情</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h1 class="mb-4">轻量级文档管理系统 - 主题详情</h1>
        
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
                                <a class="nav-link" href="forum.jsp">返回论坛</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="index.jsp">返回首页</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            
            <% if(request.getParameter("success") != null) { %>
                <div class="alert alert-success">回复发布成功！</div>
            <% } %>
            <% if(request.getParameter("error") != null) { %>
                <div class="alert alert-danger">操作失败，请重试！</div>
            <% } %>
            
            <% 
            try {
                int topicId = Integer.parseInt(request.getParameter("id"));
                // 增加浏览次数
                ForumDAO.incrementViewCount(topicId);
                
                // 获取主题内容
                Topic topic = ForumDAO.getTopicById(topicId);
                if(topic != null) { 
            %>
            <!-- 主题内容 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h2><%=topic.getTitle()%></h2>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-3">
                        <span>作者：<%=topic.getUsername()%></span>
                        <span>发布时间：<%=topic.getCreateTime()%></span>
                        <span>浏览次数：<%=topic.getViewCount()%></span>
                    </div>
                    <div class="p-3 bg-light rounded">
                        <%=topic.getContent().replace("\n", "<br>")%>
                    </div>
                </div>
            </div>
            
            <!-- 回复列表 -->
            <div class="card mb-4">
                <div class="card-header">
                    <h3>回复列表</h3>
                </div>
                <div class="card-body">
                    <% 
                        List<Reply> replies = ForumDAO.getRepliesByTopicId(topicId);
                        if(replies.isEmpty()) {
                    %>
                        <p class="text-muted">暂无回复。</p>
                    <% } else { 
                        for(Reply reply : replies) { 
                    %>
                    <div class="card mb-2">
                        <div class="card-header d-flex justify-content-between">
                            <span><strong><%=reply.getUsername()%></strong></span>
                            <span><%=reply.getCreateTime()%></span>
                        </div>
                        <div class="card-body">
                            <%=reply.getContent().replace("\n", "<br>")%>
                        </div>
                    </div>
                    <% 
                        }
                      } 
                    %>
                </div>
            </div>
            
            <!-- 发表回复表单 -->
            <div class="card">
                <div class="card-header">
                    <h3>发表回复</h3>
                </div>
                <div class="card-body">
                    <form action="AddReplyServlet" method="post">
                        <input type="hidden" name="topicId" value="<%=topic.getId()%>">
                        <div class="mb-3">
                            <textarea class="form-control" name="content" rows="3" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">发表回复</button>
                    </form>
                </div>
            </div>
            
            <% 
                } else {
            %>
                <div class="alert alert-danger">找不到指定主题！</div>
            <%
                }
            } catch(Exception e) {
                e.printStackTrace();
            %>
                <div class="alert alert-danger">查看主题时出错：<%=e.getMessage()%></div>
            <%
            }
            %>
        <% } %>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>