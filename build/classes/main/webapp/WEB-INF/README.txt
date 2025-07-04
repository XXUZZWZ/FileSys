轻量级JSP文档管理系统使用说明
=======================

系统简介
-------
这是一个基于JSP和Servlet技术的轻量级文档管理系统，支持用户注册、登录、文档上传和下载功能。
系统区分普通用户和管理员权限，只有管理员可以上传文档，所有登录用户可以查看和下载文档。

部署说明
-------
1. 确保已安装Tomcat 9.0及以上版本
2. 确保已安装MySQL 5.7及以上版本
3. 执行db_init.sql脚本初始化数据库
4. 修改context.xml中的数据库连接信息（用户名、密码等）
5. 确保uploads目录有写入权限

账号信息
-------
管理员账号: admin
管理员密码: 123456

功能说明
-------
1. 用户注册：普通用户可以通过注册页面创建新账号
2. 用户登录：使用用户名和密码登录系统
3. 文档上传：管理员可以上传.txt/.pdf文档（大小限制2MB）
4. 文档下载：所有登录用户可以查看和下载文档

技术栈
-------
- 前端：HTML
- 后端：JSP + Servlet
- 数据库：MySQL
- 服务器：Tomcat 