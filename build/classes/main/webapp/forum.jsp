<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.filesys.servlet.Topic" %>
<%@ page import="com.filesys.servlet.ForumDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>论坛</title>
</head>
<body>
    <h1>轻量级文档管理系统 - 论坛</h1>
    
    <% if(session.getAttribute("user") == null) { %>
        <p>请先<a href="index.jsp">登录</a>后使用论坛功能。</p>
    <% } else { %>
        <p>欢迎，<%= session.getAttribute("user") %>！ <a href="index.jsp">返回首页</a></p>
        
        <% if(request.getParameter("success") != null) { %>
            <p style="color: green;">主题发布成功！</p>
        <% } %>
        <% if(request.getParameter("error") != null) { %>
            <p style="color: red;">操作失败，请重试！</p>
        <% } %>
        
        <!-- 发表新主题表单 -->
        <h2>发表新主题</h2>
        <form action="CreateTopicServlet" method="post">
            标题：<input type="text" name="title" required style="width: 300px;"><br>
            内容：<br>
            <textarea name="content" rows="5" cols="50" required></textarea><br>
            <input type="submit" value="发表主题">
        </form>
        
        <!-- 主题列表 -->
        <h2>主题列表</h2>
        <table border="1" style="width: 90%;">
            <tr>
                <th>标题</th>
                <th>作者</th>
                <th>发布时间</th>
                <th>浏览次数</th>
            </tr>
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
        </table>
    <% } %>
</body>
</html>