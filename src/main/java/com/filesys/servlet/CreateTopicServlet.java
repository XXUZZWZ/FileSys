package com.filesys.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CreateTopicServlet")
public class CreateTopicServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 检查用户是否登录
    	  
        HttpSession session = request.getSession();
        if(session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String username = (String) session.getAttribute("user");
        
        try {
            ForumDAO.createTopic(title, content, username);
            response.sendRedirect("forum.jsp?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("forum.jsp?error=1");
        }
    }
}