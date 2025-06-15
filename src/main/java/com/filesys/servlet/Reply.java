package com.filesys.servlet;

import java.sql.Timestamp;

public class Reply {
    private int id;
    private int topicId;
    private String content;
    private String username;
    private Timestamp createTime;
    
    // 构造函数
    public Reply() {}
    
    public Reply(int id, int topicId, String content, String username, Timestamp createTime) {
        this.id = id;
        this.topicId = topicId;
        this.content = content;
        this.username = username;
        this.createTime = createTime;
    }
    
    // Getter和Setter方法
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getTopicId() { return topicId; }
    public void setTopicId(int topicId) { this.topicId = topicId; }
    
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    
    public Timestamp getCreateTime() { return createTime; }
    public void setCreateTime(Timestamp createTime) { this.createTime = createTime; }
}