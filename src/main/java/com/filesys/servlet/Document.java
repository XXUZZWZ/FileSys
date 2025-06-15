package com.filesys.servlet;

import java.sql.Timestamp;

public class Document {
    private int id;
    private String title;
    private String filename;
    private Timestamp uploadTime;

    public Document() {
    }

    public Document(int id, String title, String filename, Timestamp uploadTime) {
        this.id = id;
        this.title = title;
        this.filename = filename;
        this.uploadTime = uploadTime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public Timestamp getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(Timestamp uploadTime) {
        this.uploadTime = uploadTime;
    }
}