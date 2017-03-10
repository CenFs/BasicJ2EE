<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");

String wrname = null;
int wr_capacity = 0, wr_margin = 0;
int wrpdt = 0;

String str1 = request.getParameter("wrid");
int wrid = 0;
if (str1 != null && !str1.isEmpty()){
	wrid = Integer.parseInt(request.getParameter("wrid"));
}

String sql = "SELECT * FROM bjy2016gp.wareroom where wrid=" + wrid;
ResultSet rs = dbconntest.executeQuery(sql);
while(rs.next()) {
	wrname = rs.getString("wrname");
	wr_capacity = rs.getInt("wr_capacity");
	wr_margin = rs.getInt("wr_margin");
	wrpdt = wr_capacity - wr_margin;
}

if(wrpdt == 0) {
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
					<h5>你确认要删除这个产品吗？</h5>
					<strong class="block m-top-xs"><i class="fa fa-exclamation-circle m-right-xs text-danger"></i>此操作无法撤回！</strong>
				
					<div class="text-center m-top-lg">
					<form action="wareroom.do?method=delete" method="post">
						<button name="wrid" value="<%=wrid %>"class="btn btn-success">确认删除</button>
					</form>
					<div class="seperator"></div>
						<button class="btn btn-default" onclick="cancel()">取消</button>
					</div>
				</div>
			</div>
		</center>
		
		
<%} else {%>


		<center>
			<div class="custom-popup delete-widget-popup delete-confirmation-popup" id="deleteWidgetConfirm">
				<div class="popup-header text-center">
					<span class="fa-stack fa-4x">
					  <i class="fa fa-circle fa-stack-2x"></i>
					  <i class="fa fa-lock fa-stack-1x fa-inverse"></i>
					</span>
				</div>
				<div class="popup-body text-center">
					<h5>仓库中还有<%=wrpdt %>件剩余产品！无法删除！</h5>
					<strong class="block m-top-xs"><i class="fa fa-exclamation-circle m-right-xs text-danger"></i>请将仓库中剩余产品清空，再进行此操作！</strong>
				
					<div class="text-center m-top-lg">
					<div class="seperator"></div>
						<button class="btn btn-default" onclick="cancel()">返回</button>
					</div>
				</div>
			</div>
		</center>


<%};%>

<script type="text/javascript">
function cancel(){
	history.back(-1);
	/* window.location.href="product.jsp"; */
}
</script>

<% dbconntest.close(); %>
<%@include file="foot.jsp"%>
