<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");
dbconntest.create();

/* wareroom (wrid, wrname, wr_person_in_charge, wr_capacity, wr_margin, wr_remark) */
String wrname = null, wr_person_in_charge = null, wr_remark = null;
int wrid = 0, wr_capacity = 0, wr_margin = 0, count = 0;
double wr_margin_percent = 0.00;

String sqlcount = "SELECT count(*) FROM bjy2016gp.wareroom";
ResultSet rscount = dbconntest.executeQuery(sqlcount);
while (rscount.next()) {
	count = rscount.getInt("count(*)");
}

System.out.println("---------wareroom_count:" + count);


String sql = "SELECT * FROM bjy2016gp.wareroom";
ResultSet rs = dbconntest.executeQuery(sql);
%> 

			<div class="main-container">
				<div class="padding-md">
					<div class="smart-widget">
							
							<div class="smart-widget-body">
								<table class="table">
									<thead>
										<tr>
											<th>仓库编号</th>
											<th>仓库名称</th>
											<th>负责人</th>
											<th>剩余容量</th>
											<th></th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
									<%for (int i = 0; i < count; i++) {
										if (rs.next()) {
											wrid = rs.getInt("wrid");
											wrname = rs.getString("wrname");
											wr_person_in_charge = rs.getString("wr_person_in_charge");
											wr_capacity = rs.getInt("wr_capacity");
											wr_margin = rs.getInt("wr_margin");
											wr_remark = rs.getString("wr_remark");
											wr_margin_percent = (double)wr_margin / (double)wr_capacity;
											wr_margin_percent *= 100;
										}%>
										<tr>
											<td><%=wrid %></td>
											<td><%=wrname %></td>
											<td><%=wr_person_in_charge %></td>
											<td>
												<div class="progress progress-striped active" style="height:8px; margin:5px 0 0 0;">
													<div class="progress-bar progress-bar-success" style="width: <%=wr_margin_percent %>%">
														<span class="sr-only"><%=wr_margin_percent %>% </span>
													</div>
												</div>
											</td>
											<td><%=wr_margin_percent %>%</td>
											<td>
												<button id="wrquery+<%=wrid %>" class="badge badge-warning" onclick="wrquery()">查询</button>
												<button id="wredit+<%=wrid %>" class="badge badge-info" onclick="wredit()">修改</button>
												<button id="wrdelete+<%=wrid %>" class="badge badge-danger" onclick="wrdelete()">删除</button>
											</td>
										</tr>
										<%}; %>
									</tbody>
								</table>
							</div>
							
					</div><!-- ./smart-widget -->
				</div><!-- ./padding-md -->
			</div><!-- /main-container -->
			
<script type="text/javascript">
function wredit(){ 
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="wareroom_edit.jsp?wrid=" + id;
}

function wrdelete(){
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="wareroom_delete.jsp?wrid=" + id;
}

function wrquery(){
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="wareroom_query.jsp?wrid=" + id;
}
</script>

<% dbconntest.close(); %>
<%@include file="foot.jsp"%>
