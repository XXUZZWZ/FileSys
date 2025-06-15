<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.filesys.servlet.Topic" %>
<%@ page import="com.filesys.servlet.Reply" %>
<%@ page import="com.filesys.servlet.ForumDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>主题详情</title>
</head>
<body>
    <h1>轻量级文档管理系统 - 主题详情</h1>
    
    <% if(session.getAttribute("user") == null) { %>
        <p>请先<a href="index.jsp">登录</a>后使用论坛功能。</p>
    <% } else { %>
        <p>欢迎，<%= session.getAttribute("user") %>！ <a href="forum.jsp">返回论坛</a> | <a href="index.jsp">返回首页</a></p>
        
        <% if(request.getParameter("success") != null) { %>
            <p style="color: green;">回复发布成功！</p>
        <% } %>
        <% if(request.getParameter("error") != null) { %>
            <p style="color: red;">操作失败，请重试！</p>
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
        <h2><%=topic.getTitle()%></h2>
        <p>作者：<%=topic.getUsername()%> | 发布时间：<%=topic.getCreateTime()%> | 浏览次数：<%=topic.getViewCount()%></p>
        <div style="border: 1px solid #ccc; padding: 10px; margin: 10px 0; background-color: #f9f9f9;">
            <%=topic.getContent().replace("\n", "<br>")%>
        </div>
        
        <!-- 回复列表 -->
        <h3>回复列表</h3>
        <% 
            List<Reply> replies = ForumDAO.getRepliesByTopicId(topicId);
            if(replies.isEmpty()) {
        %>
            <p>暂无回复。</p>
        <% } else { 
            for(Reply reply : replies) { 
        %>
        <div style="border: 1px solid #ddd; padding: 5px; margin: 5px 0;">
            <p><strong><%=reply.getUsername()%></strong> 回复于 <%=reply.getCreateTime()%></p>
            <p><%=reply.getContent().replace("\n", "<br>")%></p>
        </div>
        <% 
            }
          } 
        %>
        
        <!-- 发表回复表单 -->
        <h3>发表回复</h3>
        <form action="AddReplyServlet" method="post">
            <input type="hidden" name="topicId" value="<%=topic.getId()%>">
            <textarea name="content" rows="3" cols="50" required></textarea><br>
            <input type="submit" value="发表回复">
        </form>
        
        <% 
            } else {
                out.println("<p>找不到指定主题！</p>");
            }
        } catch(Exception e) {
            e.printStackTrace();
            out.println("<p>查看主题时出错：" + e.getMessage() + "</p>");
        }
        %>
    <% } %>
</body>
</html>