<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.filesys.servlet.Document" %>
<%@ page import="com.filesys.servlet.DocumentDAO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %>

<%
// 检查用户是否登录
if(session.getAttribute("user") == null) {
    response.sendRedirect("index.jsp");
    return;
}

String id = request.getParameter("id");
if(id == null || id.isEmpty()) {
    response.sendRedirect("index.jsp");
    return;
}

try {
    // 获取文档信息
    Document doc = DocumentDAO.getById(id);
    if(doc == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    // 设置文件路径
    String uploadPath = application.getRealPath("/uploads");
    File file = new File(uploadPath + File.separator + doc.getFilename());
    
    if(!file.exists()) {
        out.println("文件不存在！");
        return;
    }
    
    // 设置响应头
    String mimeType = getServletContext().getMimeType(file.getAbsolutePath());
    if(mimeType == null) {
        mimeType = "application/octet-stream";
    }
    
    response.setContentType(mimeType);
    response.setContentLength((int)file.length());
    
    // 设置下载文件名
    String fileName = doc.getFilename();
    if(fileName.length() > 36) { // 去掉UUID前缀
        fileName = fileName.substring(36);
    }
    
    String headerKey = "Content-Disposition";
    String headerValue = String.format("attachment; filename=\"%s\"", fileName);
    response.setHeader(headerKey, headerValue);
    
    // 输出文件内容
    FileInputStream fileInputStream = new FileInputStream(file);
    OutputStream outputStream = response.getOutputStream();
    
    byte[] buffer = new byte[4096];
    int bytesRead;
    
    while((bytesRead = fileInputStream.read(buffer)) != -1) {
        outputStream.write(buffer, 0, bytesRead);
    }
    
    fileInputStream.close();
    outputStream.close();
} catch(Exception e) {
    e.printStackTrace();
    response.sendRedirect("index.jsp");
}
%> 