<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");

/* wareroom (wrid, wrname, wr_person_in_charge, wr_capacity, wr_margin, wr_remark) */
String wrname = null, wr_person_in_charge = null, wr_remark = null;
int wr_capacity = 0;

%>


			<div class="main-container">
				<div class="padding-md">
					<h2 class="header-text">
						仓库信息添加
					</h2>
					
					<div class="smart-widget">
						<div class="smart-widget-header">
							添加仓库所需填写内容
							<span class="smart-widget-option">
								<span class="refresh-icon-animated">
									<i class="fa fa-circle-o-notch fa-spin"></i>
								</span>
	                        </span>
						</div>
						<div class="smart-widget-inner">
							<div class="smart-widget-body">
								<form id="formToggleLine" class="form-horizontal no-margin form-border" action="wareroom.do?method=add" method="post">
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">录入人</label>
										<div class="col-lg-10">
											<input name="username" class="form-control" type="text" value="<%=username %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">仓库名称</label>
										<div class="col-lg-10">
											<input name="wrname" class="form-control" type="text" placeholder="仓库名称">
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">仓库描述</label>
										<div class="col-lg-10">
											<input name="wr_remark" class="form-control" rows="3" placeholder="请对该仓库进行简单介绍。"></input>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">仓库容量</label>
										<div class="col-lg-10">
											<div class="input-group">
												<input name="wr_capacity" type="text" class="form-control" placeholder="请设置仓库容量(整数)">
											</div><!-- /input-group -->
										</div><!-- /.col -->
									</div><!-- /form-group -->
	
									
									<div class="form-group">
										<label class="col-lg-2 control-label"></label>
										<div class="col-lg-10">
											<input type="submit" class="btn btn-danger" data-toggle="modal" value="确认添加">
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
