<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>


<%
request.setCharacterEncoding("utf8");
dbconntest.create();

/* String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; */

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
					<div class="row">
						<div class="col-sm-6">
							<div class="page-title">
								你好，<%=username %>！
							</div>
							
						</div>
					</div>


							<div class="smart-widget">
								<div class="smart-widget-header">
									仓库信息
								</div>
								
									<table class="table table-striped no-margin">
										<thead>
											<tr>
												<th class="text-right">仓库编号</th>
												<th class="text-right">仓库名称</th>
												<th class="text-right">负责人姓名</th>
												<th class="text-right">仓库容量</th>
												<th class="text-right">仓库剩余量</th>
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
												/* System.out.println("wr_margin_percent:" + wr_margin_percent); */
											}%>
											
										
											<tr>
												<td class="text-right"><%=wrid %></td>
												<td class="text-right"><%=wrname %></td>
												<td class="text-right"><%=wr_person_in_charge %></td>
												<td class="text-right"><%=wr_capacity %></td>
												<td class="text-right">
													<div class="progress progress-sm inline-block m-bottom-none" style="width:100px; margin-top:6px">
													  <div class="progress-bar progress-bar-success" style="width: <%=wr_margin_percent %>%;">
													    <span class="sr-only"><%=wr_margin_percent %>%</span>
													  </div>
													</div>

													<span class="m-left-sm vertical-top"><%=wr_margin_percent %>%</span>
												</td>
											</tr>
										<%}; %>
										</tbody>
									</table>
								</div><!-- ./smart-widget-inner -->
							</div><!-- ./smart-widget -->
			  </div><!-- ./col -->
						
				</div><!-- ./padding-md -->
			</div><!-- /main-container -->
		</div><!-- /wrapper -->
<% dbconntest.close(); %>
<%@include file="foot.jsp"%>
