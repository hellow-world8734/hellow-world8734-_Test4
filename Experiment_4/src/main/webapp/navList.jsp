<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nav</title>
</head>
<style>
	.nav-a{
		display: inline-block;
		text-decoration: none;
		color: black;
		transition: all .5s;
		padding: 10px 20px;
		position: relative;
		top: 0px;
		margin-top: 20px;
		margin-bottom: 40px;
	}
	.nav-a:hover{
		color: #0094FF;
		animation: pass .3s ease-in-out;
	}
	@keyframes pass{
		0%{
			top: 0px;
		}50%{
			top: -5px;
		}100%{
			top:  0px;
		}
	}
</style>
<body>
	<% 
		Map<String, String> navMap = new HashMap();
		navMap.put("删除", "dele.jsp");
		navMap.put("修改", "update.jsp");
		navMap.put("搜索", "search.jsp");
		navMap.put("添加", "insert.jsp");
		navMap.put("显示所有", "allShow.jsp");
		navMap.put("首页", "index.jsp");
	%>
	<%
	for (String key : navMap.keySet()) {
	%>
		<a class="nav-a" href="<%=navMap.get(key) %>"><%=key %></a>
	<%
	}
	%>

</body>
</html>