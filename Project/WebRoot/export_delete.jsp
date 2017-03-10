<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");

String str1 = request.getParameter("exportid");
int exportid = 0;
if (str1 != null && !str1.isEmpty()){
	exportid = Integer.parseInt(request.getParameter("exportid"));
}

%> 

		<center>
			<div class="custom-popup delete-widget-popup delete-confirmation-popup" id="deleteWidgetConfirm">
				<div class="popup-header text-center">
					<span class="fa-stack fa-4x">
					  <i class="fa fa-circle fa-stack-2x"></i>
					  <i class="fa fa-lock fa-stack-1x fa-inverse"></i>
					</span>
				</div>
				<div class="popup-body text-center">
					<h5>你确认要删除这条出库记录吗？</h5>
					<strong class="block m-top-xs"><i class="fa fa-exclamation-circle m-right-xs text-danger"></i>此操作无法撤回！</strong>
				
					<div class="text-center m-top-lg">
					<form action="export.do?method=delete" method="post">
						<button name="exportid" value="<%=exportid %>"class="btn btn-success">确认删除</button>
					</form>
					<div class="seperator"></div>
						<button class="btn btn-default" onclick="cancel()">取消</button>
					</div>
				</div>
			</div>
		</center>

<script type="text/javascript">
function cancel(){
	history.back(-1);
	/* window.location.href="product.jsp"; */
}
</script>

<% dbconntest.close(); %>
<%@include file="foot.jsp"%>
