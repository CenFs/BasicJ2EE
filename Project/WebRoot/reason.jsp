<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");
dbconntest.create();
/* reason (reasonid, reasonname, reason_remark) */
String reasonname = null, reason_remark = null;
int reasonid = 0, count = 0;

String sqlcount = "SELECT count(*) FROM bjy2016gp.reason";
ResultSet rscount = dbconntest.executeQuery(sqlcount);
while (rscount.next()) {
	count = rscount.getInt("count(*)");
}

System.out.println("---------reason_count:" + count);


String sql = "SELECT * FROM bjy2016gp.reason";
ResultSet rs = dbconntest.executeQuery(sql);
%> 
			
			<div class="main-container">
				<div class="padding-md">

					<table class="table table-striped" id="dataTable">
						<thead>
										<tr>
											<th>出入库理由名称</th>
											<td>备注</td>
											<th>编号</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
									<%for (int i = 0; i < count; i++) {
										if (rs.next()) {
											reasonid = rs.getInt("reasonid");
											reasonname = rs.getString("reasonname");
											reason_remark = rs.getString("reason_remark");
										}
										%>
									
										<tr>
											<td><%=reasonname %></td>
											<td><%=reason_remark %></td>
											<td><%=reasonid %></td>
											<td>
												<button id="reasondelete+<%=reasonid %>" class="label label-danger" onclick="reasondelete()">删除</button>
											</td>
										</tr>
									<%}; %>
						</tbody>
					</table>
				</div><!-- ./padding-md -->
			</div><!-- /main-container -->
			
			
<script type="text/javascript">
function reasondelete(){
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="reason_delete.jsp?reasonid=" + id;
}
</script>

<% dbconntest.close(); %>
<%@include file="foot.jsp"%>
