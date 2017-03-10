<%@ page language="java" pageEncoding="ISO-8859-1"%>

<jsp:useBean id="userinfo" class="bjy.gp.entity.User"></jsp:useBean> 
<jsp:setProperty property="*" name="userinfo"/> 
You have enterted below details:<br> 
<jsp:getProperty property="username" name="userinfo"/><br> 
<jsp:getProperty property="userpwd" name="userinfo"/><br> 
<jsp:getProperty property="userid" name="userinfo" /><br>



<!-- property一定要跟getXXX和setXXX里面的那些XXX一样啊！！ --> 