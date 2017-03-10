<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");
/* import (importid, importname, import_person, import_time, import_remark, import_pdtid, import_wrid, import_reasonid, import_quantity) */

%>

			<div class="main-container">
				<div class="padding-md">
					<div class="smart-widget">
						<div class="smart-widget-header">
							<h2 class="header-text">
								入库单查询
							</h2>
						</div>
						<div class="smart-widget-inner">
							
							<div class="smart-widget-body">
								<form id="formToggleLine" class="form-horizontal no-margin form-border" action="search.do?method=imbytime" method="post">
								
									<div class="form-group">
										<label class="col-lg-2 control-label">选择查询起始时间</label>
										<div class="col-lg-10">
											<div class="input-group">
												<input name="time_begin" type="text" id="timepicker1" class="datepicker-input form-control">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
											</div>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									<div class="form-group">
										<label class="col-lg-2 control-label">选择查询结束时间</label>
										<div class="col-lg-10">
											<div class="input-group">
												<input name="time_end" type="text" id="timepicker2" class="datepicker-input form-control">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
											</div>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label"></label>
										<div class="col-lg-10">
											<input name="username" type="hidden" value="<%=username %>" />
											<input type="submit" class="btn btn-success" data-toggle="modal" value="确认查询">
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									
								</form>
							</div>
						</div><!-- ./smart-widget-inner -->
					</div><!-- ./smart-widget -->
				</div><!-- ./padding-md -->
			</div><!-- /main-container -->

<%@include file="foot.jsp"%>
