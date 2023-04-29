<%@page import="com.alibaba.fastjson.JSONArray"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.mysql.cj.xdevapi.JsonArray"%>
<%@page import="org.apache.tomcat.util.json.JSONParser"%>
<%@ page language="java" import="java.util.*,dbutil.*,entity.*,model.*"
	pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>显示数据页面</title>
</head>
<body>
<%@include file="navList.jsp" %>
	<%
	request.setCharacterEncoding("gbk");
	String idString = request.getParameter("id");
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String usersString = request.getParameter("users");
	
	JSONArray jsonArray = null;
	
	PrintWriter printWriter = response.getWriter();
	printWriter.println("插入结果（0为失败，1为成功）：<br/>");
	Model model = new Model();
	
	if(!"".equals(idString) && !"".equals(name) && !"".equals(password)){
		// 输入添加
		printWriter.println("用户输入添加：<br/>");
		int i = model.insert(Integer.valueOf(idString), name, password);
		if(i == 0){
			printWriter.println("ID为"+idString+"的用户插入的结果："+ i + "，失败原因：用户已经存在" +"<br/>");
		}else {
			printWriter.println("ID为"+idString+"的用户插入的结果："+ i + "，插入成功" +"<br/>");
		}
	}else if(!"".equals(usersString)) {
		// xlsx添加
		printWriter.println("使用Excel添加：<br/>");
		jsonArray = JSON.parseArray(usersString);
		
		for(Object o : jsonArray){
			User user = JSON.toJavaObject(JSON.parseObject(o.toString()), User.class);
			int i = model.insert(user.getId(), user.getName(), user.getPassword());
			if(i == 0){
				printWriter.println("ID为"+user.getId()+"的用户插入的结果："+ i + "，失败原因：用户已经存在" +"<br/>");
			}else {
				printWriter.println("ID为"+user.getId()+"的用户插入的结果："+ i +", 插入成功<br/>");
			}
		}
	}else {
		request.setAttribute("error", "数据不能为空");
		request.setAttribute("color", "red");
		request.getRequestDispatcher("insert.jsp").forward(request, response);
	}
	
	%>
	<form action="allShow.jsp">
		<input type="submit" value="显示所有用户">
	</form>
</body>
</html>
