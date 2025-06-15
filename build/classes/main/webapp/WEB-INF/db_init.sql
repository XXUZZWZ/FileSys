-- 创建数据库
CREATE DATABASE IF NOT EXISTS filesys;
USE filesys;

-- 创建用户表
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(20) UNIQUE,
  password VARCHAR(20)
);

-- 创建文档表
CREATE TABLE IF NOT EXISTS documents (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  filename VARCHAR(255),
  upload_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 初始化管理员账号
INSERT INTO users (username, password) VALUES ('admin', '123456'); 