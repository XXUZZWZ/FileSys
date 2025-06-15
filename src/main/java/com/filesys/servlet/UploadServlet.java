package com.filesys.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/UploadServlet")
@MultipartConfig(maxFileSize = 2097152) // 2MB
public class UploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

  //  private static final String JDBC_URL = "jdbc:mysql://localhost:3306/filesys?serverTimezone=UTC";
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/filesys?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "12341234q";

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        Part filePart = request.getPart("file");

        // 检查用户权限
        if (!"admin".equals(request.getSession().getAttribute("user"))) {
            response.sendRedirect("index.jsp?error=3");
            return;
        }

        // 生成唯一文件名
        String fileName = UUID.randomUUID().toString() + getFileName(filePart);

        // 保存文件到服务器
        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        filePart.write(uploadPath + File.separator + fileName);

        // 保存文件信息到数据库
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            String sql = "INSERT INTO documents (title, filename) VALUES (?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, fileName);

            pstmt.executeUpdate();
            pstmt.close();
            conn.close();

            response.sendRedirect("index.jsp?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=4");
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");

        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
    }
}