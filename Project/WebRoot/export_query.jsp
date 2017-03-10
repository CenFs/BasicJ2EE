<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");
/* export (exportid, exportname, export_person, export_time, export_remark, export_pdtid, export_wrid, export_reasonid, export_quantity) */

String str = request.getParameter("exportid");
int exportid = 0;
if (str != null && !str.isEmpty()){
	exportid = Integer.parseInt(request.getParameter("exportid"));
} else {
	response.setHeader("Refresh","1;URL=export.jsp"); 
}

int export_pdtid = 0;
int export_wrid = 0;
int export_reasonid = 0;
int export_quantity = 0;
String exportname = null, export_person = null, export_time = null, export_remark = null;

String sql = "SELECT * FROM bjy2016gp.export where exportid=" + exportid;
ResultSet rs = dbconntest.executeQuery(sql);
while (rs.next()) {
	exportname = rs.getString("exportname");
	export_time = rs.getString("export_time");
	export_remark = rs.getString("export_remark");
	export_pdtid = rs.getInt("export_pdtid");
	export_wrid = rs.getInt("export_wrid");
	export_reasonid = rs.getInt("export_reasonid");
	export_quantity = rs.getInt("export_quantity");
}

String pdtname = null;
String sqlpdtname = "SELECT * FROM bjy2016gp.product where pdtid=" + export_pdtid;
ResultSet rspdtname = dbconntest.executeQuery(sqlpdtname);
while (rspdtname.next()) {
	pdtname = rspdtname.getString("pdtname");
}

int wrcount = 0;
ResultSet rswrcount = dbconntest.executeQuery("SELECT count(*) FROM bjy2016gp.wareroom");
while (rswrcount.next()) {
	wrcount = rswrcount.getInt("count(*)");
}
ResultSet rswr = dbconntest.executeQuery("SELECT * FROM bjy2016gp.wareroom");


String wrname = null, wr_person_in_charge = null, wr_remark = null;
int wr_capacity = 0, wr_margin = 0, wrid = 0;
int pdtcount = 0;
ResultSet rspdtcount = dbconntest.executeQuery("SELECT COUNT(DISTINCT pdtname) FROM bjy2016gp.product");
while (rspdtcount.next()) {
	pdtcount = rspdtcount.getInt("COUNT(DISTINCT pdtname)");
}
ResultSet rspdt = dbconntest.executeQuery("SELECT DISTINCT pdtname FROM bjy2016gp.product");


int reasonid = 0;
String reasonname = null;
int reasoncount = 0;
ResultSet rsreasoncount = dbconntest.executeQuery("SELECT COUNT(*) FROM bjy2016gp.reason");
while (rsreasoncount.next()) {
	reasoncount = rsreasoncount.getInt("COUNT(*)");
}
ResultSet rsreason = dbconntest.executeQuery("SELECT * FROM bjy2016gp.reason");

%>


			<div class="main-container">
				<div class="padding-md">
					<div class="smart-widget">
						<div class="smart-widget-header">
							出库单详情
						</div>
						<div class="smart-widget-inner">
							
							<div class="smart-widget-body">
								<form id="formToggleLine" class="form-horizontal no-margin form-border">
									<div class="form-group">
										<label class="col-lg-2 control-label">出库单名称</label>
										<div class="col-lg-10">
											<input name="exportname" class="form-control" type="text" value="<%=exportname %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">出库负责人</label>
										<div class="col-lg-10">
											<input name="username" class="form-control" type="text" value="<%=username %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">出库时间</label>
										<div class="col-lg-10">
											<div class="input-group">
												<input name="export_time" id="currtime" class="datetimepicker-input form-control" type="text" value="<%=export_time %>" readonly/>
												<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
											</div>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">出库备注</label>
										<div class="col-lg-10">
											<input name="export_remark" class="form-control" rows="3" value="<%=export_remark %>" readonly></input>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">出库产品</label>
										<div class="col-lg-10">
											<input class="form-control" type="text" value="<%=pdtname %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									

									<div class="form-group">
										<label class="col-lg-2 control-label">出库产品数量</label>
										<div class="col-lg-10">
											<div class="row">
												<div class="col-lg-3">
													<input name="export_quantity" type="text" class="form-control" value="<%=export_quantity %>" readonly>
												</div><!-- /.col -->
											</div><!-- /.row -->
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">出库仓库</label>
										<div class="col-lg-10">
										<%for (int i = 0; i < wrcount; i++) {
												if (rswr.next()) {
													wrid = rswr.getInt("wrid");
													wrname = rswr.getString("wrname");
													wr_capacity = rswr.getInt("wr_capacity");
													wr_margin = rswr.getInt("wr_margin");
												}
												if (wrid == export_wrid) {
												%>
											<div class="radio">
												<div class="custom-radio m-right-xs">
													<input name="export_wrid" type="radio" id="radio<%=wrid %>" value="<%=wrid %>" checked disabled>
													<label for="radio<%=wrid %>"></label>
												</div>
												<div class="inline-block vertical-top">
													<%=wrname %>，仓库容量<%=wr_capacity %>，当前剩余量：<%=wr_margin %>。本条记录中向此仓库出库。
												</div>
											</div>
											<%} }; %>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">出库理由</label>
										<div class="col-lg-10">
										<select class="form-control" name="reasonid" disabled>
										<%for (int i = 0; i < reasoncount; i++) {
												if (rsreason.next()) {
													reasonid = rsreason.getInt("reasonid");
													reasonname = rsreason.getString("reasonname");
												}
												if (reasonid == export_reasonid) {%>
												<option value="<%=reasonid %>"><%=reasonname %>。</option>
												<%} }; %>
										</select>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label"></label>
										<div class="col-lg-10">
											<button type="submit" class="btn btn-danger" data-toggle="modal" onClick="back()">返回</button>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									
								</form>
							</div>
						</div><!-- ./smart-widget-inner -->
					</div><!-- ./smart-widget -->
				</div><!-- ./padding-md -->
			</div><!-- /main-container -->
			
			
			
<script type="text/javascript">
function back(){
	history.back(-1);
}
</script>
<%dbconntest.close(); %>
<%@include file="foot.jsp"%>
