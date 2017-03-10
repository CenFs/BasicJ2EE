<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");

String str1 = request.getParameter("reasonid");
int reasonid = 0;
if (str1 != null && !str1.isEmpty()){
	reasonid = Integer.parseInt(request.getParameter("reasonid"));
}

int ifexistim = 0, ifexistex = 0;

String sqlim = "select count(import_reasonid) from bjy2016gp.import where import_reasonid=" + reasonid;
ResultSet rsim = dbconntest.executeQuery(sqlim);
while (rsim.next()) {
	ifexistim = rsim.getInt("count(import_reasonid)");
}

String sqlex = "select count(export_reasonid) from bjy2016gp.export where export_reasonid=" + reasonid;
ResultSet rsex = dbconntest.executeQuery(sqlex);
while (rsex.next()) {
	ifexistex = rsex.getInt("count(export_reasonid)");
}

int ifexist = ifexistim + ifexistex;

if (ifexist == 0) { // 没有出入库数据单用到此原因
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
					<h5>你确认要删除这条理由吗？</h5>
					<strong class="block m-top-xs"><i class="fa fa-exclamation-circle m-right-xs text-danger"></i>此操作无法撤回！</strong>
				
					<div class="text-center m-top-lg">
					<form action="reason.do?method=delete" method="post">
						<button type="submit" name="reasonid" value="<%=reasonid %>"class="btn btn-success">确认删除</button>
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
					<h5>无法删除！</h5>
					<strong class="block m-top-xs"><i class="fa fa-exclamation-circle m-right-xs text-danger"></i>有出入库记录在用此原因！</strong>
				
					<div class="text-center m-top-lg">
					<div class="seperator"></div>
						<button class="btn btn-default" onclick="cancel()">取消</button>
					</div>
				</div>
			</div>
		</center>


<%};%> 
<script type="text/javascript">
function cancel(){
	history.back(-1);
}
</script>

<% dbconntest.close(); %>
<%@include file="foot.jsp"%>
