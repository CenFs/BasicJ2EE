<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");
dbconntest.create();
/* 
String str1 = request.getParameter("pdtid");
String str2 = request.getParameter("method");
if (str1 != null && !str1.isEmpty() && str2 != null && str2.equals("delete")){
	int pdtid = Integer.parseInt(request.getParameter("pdtid"));
	String sql = "delete from bjy2016gp.product where pdtid=" + pdtid;
	ResultSet rscount = dbconntest.executeQuery(sql);
	response.setHeader("Refresh","1;URL=product_query.jsp");
} */
/* product (pdtid, pdtname, pdt_wareroom, pdt_register_time, pdt_register_person, pdt_remark, pdt_price, pdt_quantity) */
String pdtname = null, pdt_register_time = null, pdt_register_person = null, pdt_remark = null;
int pdtid = 0, pdt_wareroom = 0, pdt_quantity = 0, count = 0;
double pdt_price = 0.00;
String wrname = null;


String sqlcount = "SELECT count(*) FROM bjy2016gp.product";
ResultSet rscount = dbconntest.executeQuery(sqlcount);
while (rscount.next()) {
	count = rscount.getInt("count(*)");
}

System.out.println("---------product_count:" + count);


String sql = "SELECT * FROM bjy2016gp.product";
ResultSet rs = dbconntest.executeQuery(sql);
%> 

			<div class="main-container">
				<div class="padding-md">
				
					<table class="table table-striped" id="dataTable">
						<thead>
							<tr>
								<th>产品编号</th>
								<th>产品名称</th>
								<th>所属库房</th>
								<th>录入时间</th>
								<th>价格</th>
								<th>数量</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
						<%for (int i = 0; i < count; i++) {
							if (rs.next()) {
								pdtid = rs.getInt("pdtid");
								pdtname = rs.getString("pdtname");
								pdt_wareroom = rs.getInt("pdt_wareroom");
								pdt_register_time = rs.getString("pdt_register_time");
								pdt_price = rs.getDouble("pdt_price");
								pdt_quantity = rs.getInt("pdt_quantity");
							}
							String sqlwr = "SELECT wrname FROM bjy2016gp.wareroom WHERE wrid=" + pdt_wareroom;
							ResultSet rswr = dbconntest.executeQuery(sqlwr);
							while (rswr.next()) {
								wrname = rswr.getString("wrname");
							}
							%>
							<tr>
								<td><%=pdtid %></td>
								<td><%=pdtname %> <!-- <span class="label label-success m-left-xs">Best Seller</span> --> </td>
								<td><%=wrname %></td>
								<td><%=pdt_register_time %></td>
								<td><%=pdt_price %></td>
								<td><%=pdt_quantity %></td>
								<td>
									<!-- <span class="label label-success">修改</span>
									<span class="label label-danger">删除</span> -->
									<button id="pdtquery+<%=pdtid %>" class="label label-warning" onclick="pdtquery()">查看</button>
									<button id="pdtedit+<%=pdtid %>" class="label label-info" onclick="pdtedit()">修改</button>
									<button id="pdtdelete+<%=pdtid %>" class="label label-danger" onclick="pdtdelete()">删除</button>
								</td>
							</tr>
							<%}; %>
						</tbody>
					</table>
				</div><!-- ./padding-md -->
			</div><!-- /main-container -->
	
<script type="text/javascript">
function pdtedit(){ 
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="product_edit.jsp?pdtid=" + id;
}

function pdtdelete(){
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="product_delete.jsp?pdtid=" + id;
}

function pdtquery(){
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="product_query.jsp?pdtid=" + id;
}



</script>

<% dbconntest.close(); %>
<%@include file="foot.jsp"%>
