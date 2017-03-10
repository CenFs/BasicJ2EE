<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");
dbconntest.create();
/* import (importid, importname, import_person, import_time, import_remark, import_pdtid, import_wrid, import_reasonid, import_quantity) */
int importid = 0;
int import_pdtid = 0;
int import_wrid = 0;
int import_reasonid = 0;
int import_quantity = 0;
String importname = null, import_person = null, import_time = null, import_remark = null;
int count = 0;

ResultSet rscount = dbconntest.executeQuery("SELECT count(*) FROM bjy2016gp.import");
while (rscount.next()) {
	count = rscount.getInt("count(*)");
}

System.out.println("---------import_count:" + count);

ResultSet rs = dbconntest.executeQuery("SELECT * FROM bjy2016gp.import");
%> 

			<div class="main-container">
				<div class="padding-md">

					<table class="table table-striped" id="dataTable">
						<thead>
							<tr>
								<th>入库单编号</th>
								<th>入库单名称</th>
								<th>入库负责人</th>
								<th>入库时间</th>
								<th>入库产品</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<%for (int i = 0; i < count; i++) {
							if (rs.next()) {
								importid = rs.getInt("importid");
								importname = rs.getString("importname");
								import_person = rs.getString("import_person");
								import_time = rs.getString("import_time");
								import_pdtid = rs.getInt("import_pdtid");					
							}
							String pdtname = null;
							String sqlpdt = "SELECT pdtname FROM bjy2016gp.product where pdtid=" + import_pdtid;
							ResultSet rspdt = dbconntest.executeQuery(sqlpdt);
							while (rspdt.next()) {
								pdtname = rspdt.getString("pdtname");
							}
							%>
							<tr>
								<td><%=importid %></td>
								<td><%=importname %></td>
								<td><%=import_person %></td>
								<td><%=import_time %></td>
								<td><%=pdtname %></td>
								<td>
									<button id="importquery+<%=importid %>" class="label label-warning" onclick="importquery()">查看</button>
									<button id="importedit+<%=importid %>" class="label label-info" onclick="importedit()">修改</button>
									<button id="importdelete+<%=importid %>" class="label label-danger" onclick="importdelete()">删除</button>
								</td>
							</tr>
							<%}; %>
						</tbody>
					</table>
				</div><!-- ./padding-md -->
			</div><!-- /main-container -->
	
<script type="text/javascript">
function importedit(){ 
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="import_edit.jsp?importid=" + id;
}

function importdelete(){
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="import_delete.jsp?importid=" + id;
}

function importquery(){
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="import_query.jsp?importid=" + id;
}



</script>

<% dbconntest.close(); %>
<%@include file="foot.jsp"%>
