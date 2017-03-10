<%@ page language="java" import="java.util.*, bjy.gp.entity.*" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="test" class="bjy.gp.entity.Product" />
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

<%
Product pdt = new Product();
String pdtname="pdtnametest";
pdt.setPdtname(pdtname);
%>

  <body>
  	<a>pdtname:<%=pdt.getPdtname()%></a>
  </body>
</html>


