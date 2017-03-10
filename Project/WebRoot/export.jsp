<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");
dbconntest.create();
/* export (exportid, exportname, export_person, export_time, export_remark, export_pdtid, export_wrid, export_reasonid, export_quantity) */
int exportid = 0;
int export_pdtid = 0;
int export_wrid = 0;
int export_reasonid = 0;
int export_quantity = 0;
String exportname = null, export_person = null, export_time = null, export_remark = null;
int count = 0;

ResultSet rscount = dbconntest.executeQuery("SELECT count(*) FROM bjy2016gp.export");
while (rscount.next()) {
	count = rscount.getInt("count(*)");
}

System.out.println("---------export_count:" + count);

ResultSet rs = dbconntest.executeQuery("SELECT * FROM bjy2016gp.export");
%> 

			<div class="main-container">
				<div class="padding-md">

					<table class="table table-striped" id="dataTable">
						<thead>
							<tr>
								<th>出库单编号</th>
								<th>出库单名称</th>
								<th>出库负责人</th>
								<th>出库时间</th>
								<th>出库产品</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<%for (int i = 0; i < count; i++) {
							if (rs.next()) {
								exportid = rs.getInt("exportid");
								exportname = rs.getString("exportname");
								export_person = rs.getString("export_person");
								export_time = rs.getString("export_time");
								export_pdtid = rs.getInt("export_pdtid");					
							}
							String pdtname = null;
							String sqlpdt = "SELECT pdtname FROM bjy2016gp.product where pdtid=" + export_pdtid;
							ResultSet rspdt = dbconntest.executeQuery(sqlpdt);
							while (rspdt.next()) {
								pdtname = rspdt.getString("pdtname");
							}
							%>
							<tr>
								<td><%=exportid %></td>
								<td><%=exportname %></td>
								<td><%=export_person %></td>
								<td><%=export_time %></td>
								<td><%=pdtname %></td>
								<td>
									<button id="exportquery+<%=exportid %>" class="label label-warning" onclick="exportquery()">查看</button>
									<button id="exportedit+<%=exportid %>" class="label label-info" onclick="exportedit()">修改</button>
									<button id="exportdelete+<%=exportid %>" class="label label-danger" onclick="exportdelete()">删除</button>
								</td>
							</tr>
							<%}; %>
						</tbody>
					</table>
				</div><!-- ./padding-md -->
			</div><!-- /main-container -->
	
<script type="text/javascript">
function exportedit(){ 
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="export_edit.jsp?exportid=" + id;
}

function exportdelete(){
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="export_delete.jsp?exportid=" + id;
}

function exportquery(){
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="export_query.jsp?exportid=" + id;
}



</script>

<% dbconntest.close(); %>
<%@include file="foot.jsp"%>
