### 简化版在线文档管理系统Prompt

**项目名称**：轻量级JSP文档管理系统  
**核心需求**：  
```markdown
1. 用户管理（基础版）
   - 注册：仅需用户名+密码
   - 登录：Session简单验证
   - 权限：区分普通用户和管理员（固定admin账号）

2. 文档管理（核心功能）
   - 管理员可上传.txt/.pdf文档（限制2MB）
   - 显示文档列表（标题+上传时间）
   - 支持文档下载

3. 界面要求
   - 单页面设计（index.jsp）
   - 基础HTML表单（无CSS框架）
```

### 极简数据库设计
```sql
/* 用户表 */
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(20) UNIQUE,
  password VARCHAR(20) /* 明文存储简化 */
);

/* 文档表 */
CREATE TABLE documents (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(100),
  filename VARCHAR(50), /* 存储文件名 */
  upload_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 技术栈精简
```markdown
- 前端：纯HTML表单
- 后端：JSP + Servlet
- 存储：服务器文件系统
- 安全：基础Session验证
```

### 核心代码文件（共5个）
```
1. index.jsp          # 主界面（登录/文档列表）
2. register.jsp       # 注册页面
3. UploadServlet.java # 文件上传处理
4. LoginServlet.java  # 登录验证
5. download.jsp       # 文档下载
```

### 生成要求
```markdown
1. 用户系统：
   - 注册：直接INSERT用户数据
   - 登录：固定admin账号(admin/123456)
   
2. 文档功能：
   - 上传：<input type="file">表单
   - 存储：文件保存到/webapp/uploads/
   - 列表：SELECT * FROM documents

3. 权限控制：
   - 上传按钮仅admin可见
   - 普通用户只能查看/下载

4. 代码限制：
   - 每个JSP文件≤50行
   - 每个Servlet≤30行
   - 无JavaScript/CSS框架
```

### 示例代码片段
**文件上传表单(index.jsp)**
```jsp
<% if(session.getAttribute("user").equals("admin")) { %>
  <form action="UploadServlet" method="post" enctype="multipart/form-data">
    标题：<input type="text" name="title"><br>
    文件：<input type="file" name="file"><br>
    <input type="submit" value="上传">
  </form>
<% } %>
```

**文档列表(index.jsp)**
```jsp
<table border="1">
  <tr><th>标题</th><th>上传时间</th></tr>
  <% for(Document doc : documentList) { %>
    <tr>
      <td><a href="download.jsp?id=<%=doc.getId()%>"><%=doc.getTitle()%></a></td>
      <td><%=doc.getUploadTime()%></td>
    </tr>
  <% } %>
</table>
```

**文件下载(download.jsp)**
```jsp
<%
String id = request.getParameter("id");
Document doc = DocumentDAO.getById(id);
response.setHeader("Content-Disposition", "attachment; filename="+doc.getFilename());
Files.copy(Paths.get(uploadPath + doc.getFilename()), response.getOutputStream());
%>
```

### 特别说明
```markdown
1. 放弃的功能：
   - 用户信息修改
   - 文档编辑/删除
   - 分页/搜索
   - 论坛模块
   
2. 安全简化：
   - 密码明文存储
   - 无文件类型检查
   - 无XSS防护

3. 部署要求：
   - 创建/webapp/uploads/目录
   - 初始化数据库：
     INSERT INTO users VALUES(1,'admin','123456');
```

"# FileSys" 
