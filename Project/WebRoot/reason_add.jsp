<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");
%>

		<div class="main-container">
				<div class="padding-md">
					<h2 class="header-text">
						出入库理由添加
					</h2>
					<div class="smart-widget m-top-lg widget-dark-blue">
						<div class="smart-widget-inner">
							<div class="smart-widget-body">
								<form action="reason.do?method=add" method="post">
									<div class="form-group">
										<label for="reasonname">出入库理由名称</label>
										<input type="text" class="form-control" id="reasonname" name="reasonname" placeholder="理由名称">
									</div><!-- /form-group -->
									<div class="form-group">
										<label for="reason_remark">出入库理由备注</label>
										<input type="text" class="form-control" id="reason_remark" name="reason_remark" placeholder="理由详述">
									</div><!-- /form-group -->
									<button type="submit" class="btn btn-danger btn-sm">确认添加</button>
								</form>
							</div>
						</div><!-- ./smart-widget-inner -->
					</div><!-- ./smart-widget -->

				</div><!-- ./padding-md -->
			</div><!-- /main-container -->
			
			
<%dbconntest.close(); %>
<%@include file="foot.jsp"%>
