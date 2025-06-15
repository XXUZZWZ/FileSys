package com.filesys.servlet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DocumentDAO {
    //private static final String JDBC_URL = "jdbc:mysql://localhost:3306/filesys?serverTimezone=UTC";
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/filesys?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "12341234q";

    public static List<Document> getAllDocuments() throws Exception {
        List<Document> documents = new ArrayList<>();

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            String sql = "SELECT * FROM documents ORDER BY upload_time DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Document doc = new Document(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("filename"),
                    rs.getTimestamp("upload_time")
                );
                documents.add(doc);
            }
        } finally {
            if (rs != null) {
				rs.close();
			}
            if (pstmt != null) {
				pstmt.close();
			}
            if (conn != null) {
				conn.close();
			}
        }

        return documents;
    }

    public static Document getById(String id) throws SQLException, ClassNotFoundException {
        Document doc = null;

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            String sql = "SELECT * FROM documents WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                doc = new Document(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("filename"),
                    rs.getTimestamp("upload_time")
                );
            }
        } finally {
            if (rs != null) {
				rs.close();
			}
            if (pstmt != null) {
				pstmt.close();
			}
            if (conn != null) {
				conn.close();
			}
        }

        return doc;
    }
}