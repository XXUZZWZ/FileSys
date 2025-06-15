package com.filesys.servlet;

import java.sql.Timestamp;

public class Topic {
    private int id;
    private String title;
    private String content;
    private String username;
    private Timestamp createTime;
    private int viewCount;
    
    // 构造函数
    public Topic() {}
    
    public Topic(int id, String title, String content, String username, Timestamp createTime, int viewCount) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.username = username;
        this.createTime = createTime;
        this.viewCount = viewCount;
    }
    
    // Getter和Setter方法
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public Timestamp getCreateTime() { return createTime; }
    public void setCreateTime(Timestamp createTime) { this.createTime = createTime; }
    
    public int getViewCount() { return viewCount; }
    public void setViewCount(int viewCount) { this.viewCount = viewCount; }
}