<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
request.setCharacterEncoding("utf8");
/* String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; */
String username = (String)session.getAttribute("username");
/* String username = request.getParameter("username"); */
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%-- <base href="<%=basePath%>"> --%>
    <title>BJY - GraduationProject</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="Bjy,GraduationProject,ManagementSystem">
	<meta http-equiv="description" content="HELLO WORLD.">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
  	<p>success!</p>
  	<a>username:<%=username %></a>
  </body>
</html>
