<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");

String str = request.getParameter("wrid");
int wrid = 0;
if (str != null && !str.isEmpty()){
	wrid = Integer.parseInt(request.getParameter("wrid"));
} else {
	response.setHeader("Refresh","1;URL=wareroom.jsp"); 
}
/* wareroom (wrid, wrname, wr_person_in_charge, wr_capacity, wr_margin, wr_remark) */
String wrname = null, wr_person_in_charge = null, wr_remark = null;
int wr_capacity = 0, wr_margin = 0, count = 0;
double wr_margin_percent = 0.00;


String sql = "SELECT * FROM bjy2016gp.wareroom where wrid=" + wrid;
ResultSet rs = dbconntest.executeQuery(sql);
while(rs.next()) {
	wrname = rs.getString("wrname");
	wr_person_in_charge = rs.getString("wr_person_in_charge");
	wr_capacity = rs.getInt("wr_capacity");
	wr_margin = rs.getInt("wr_margin");
	wr_remark = rs.getString("wr_remark");
	wr_margin_percent = (double)wr_margin / (double)wr_capacity;
	wr_margin_percent *= 100;
}

int nowpdtcount = wr_capacity - wr_margin;

%>


			<div class="main-container">
				<div class="padding-md">
					<h2 class="header-text">
						仓库信息修改
					</h2>
					
					<div class="smart-widget">
						<div class="smart-widget-header">
							仓库编号No.<%=wrid %> 信息
							<span class="smart-widget-option">
								<span class="refresh-icon-animated">
									<i class="fa fa-circle-o-notch fa-spin"></i>
								</span>
	                        </span>
						</div>
						<div class="smart-widget-inner">
							<div class="smart-widget-body">
								<form id="formToggleLine" class="form-horizontal no-margin form-border" action="wareroom.do?method=update" method="post">
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">修改人</label>
										<div class="col-lg-10">
											<input name="username" class="form-control" type="text" value="<%=username %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">仓库名称</label>
										<div class="col-lg-10">
											<input name="wrname" class="form-control" type="text" value="<%=wrname %>">
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">仓库编号</label>
										<div class="col-lg-10">
											<input name="wrid" class="form-control" type="text" value="<%=wrid %>" readonly>
											<span class="help-block">仓库编号禁止修改！</span>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">仓库描述</label>
										<div class="col-lg-10">
											<input name="wr_remark" class="form-control" rows="3" value="<%=wr_remark %>"></input>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">仓库容量</label>
										<div class="col-lg-10">
											<div class="input-group">
												<input name="wr_capacity" type="text" class="form-control" value="<%=wr_capacity %>">
											</div><!-- /input-group -->
											<span class="help-block">当前仓库所存产品有<%=nowpdtcount %>件！若修改容量，请大于此数字！</span>
										</div><!-- /.col -->
									</div><!-- /form-group -->
	
									
									<div class="form-group">
										<label class="col-lg-2 control-label"></label>
										<div class="col-lg-10">
											<input type="submit" class="btn btn-danger" data-toggle="modal" value="确认修改">
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									
								</form>
							</div>
						</div><!-- ./smart-widget-inner -->
					</div><!-- ./smart-widget -->
				</div><!-- ./padding-md -->
			</div><!-- /main-container -->
			

<%dbconntest.close(); %>
<%@include file="foot.jsp"%>
