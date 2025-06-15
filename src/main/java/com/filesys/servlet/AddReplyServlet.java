package com.filesys.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AddReplyServlet")
public class AddReplyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 检查用户是否登录
//   	   request.setCharacterEncoding("UTF-8");
//       response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        if(session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        
        int topicId = Integer.parseInt(request.getParameter("topicId"));
        String content = request.getParameter("content");
        String username = (String) session.getAttribute("user");
        
        try {
            ForumDAO.addReply(topicId, content, username);
            response.sendRedirect("topicDetail.jsp?id=" + topicId + "&success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("topicDetail.jsp?id=" + topicId + "&error=1");
        }
    }
}