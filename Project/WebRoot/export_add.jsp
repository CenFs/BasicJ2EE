<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");
/* export (exportid, exportname, export_person, export_time, export_remark, export_pdtid, export_wrid, export_reasonid, export_quantity) */

int exportid = 0;
int export_pdtid = 0;
int export_wrid = 0;
int export_reasonid = 0;
int export_quantity = 0;
String exportname = null, export_person = null, export_time = null, export_remark = null;


String pdtname = null;
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
							<h2 class="header-text">
								出库单填写
							</h2>
						</div>
						<div class="smart-widget-inner">
							
							<div class="smart-widget-body">
								<form id="formToggleLine" class="form-horizontal no-margin form-border" action="export.do?method=add" method="post">
									<div class="form-group">
										<label class="col-lg-2 control-label">出库单名称</label>
										<div class="col-lg-10">
											<input name="exportname" class="form-control" type="text" placeholder="出库单名称">
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
												<input name="export_time" id="currtime" class="datetimepicker-input form-control" type="text" readonly/>
												<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
											</div>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">出库备注</label>
										<div class="col-lg-10">
											<input name="export_remark" class="form-control" rows="3" placeholder="描述本次出库详细信息。"></input>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">出库产品</label>
										<div class="col-lg-10">
										<select class="form-control" name="pdtname">
										<%for (int i = 0; i < pdtcount; i++) {
												if (rspdt.next()) {
													pdtname = rspdt.getString("pdtname");
												}%>
												<option value="<%=pdtname %>"><%=pdtname %></option>
										<% }; %>
										</select>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									

									<div class="form-group">
										<label class="col-lg-2 control-label">出库产品数量</label>
										<div class="col-lg-10">
											<div class="row">
												<div class="col-lg-3">
													<input name="export_quantity" type="text" class="form-control" placeholder="0">
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
												}%>
											<div class="radio">
												<div class="custom-radio m-right-xs">
													<input name="export_wrid" type="radio" id="radio<%=wrid %>" value="<%=wrid %>">
													<label for="radio<%=wrid %>"></label>
												</div>
												<div class="inline-block vertical-top">
													<%=wrname %>，仓库容量<%=wr_capacity %>，当前剩余量：<%=wr_margin %>。
												</div>
											</div>	
											<% }; %>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">出库理由</label>
										<div class="col-lg-10">
										<select class="form-control" name="reasonid">
										<%for (int i = 0; i < reasoncount; i++) {
												if (rsreason.next()) {
													reasonid = rsreason.getInt("reasonid");
													reasonname = rsreason.getString("reasonname");
												}%>
												<option value="<%=reasonid %>"><%=reasonname %></option>
										<% }; %>
										</select>
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
			
			
			
<script type="text/javascript">
window.onload = function getTime(){
var ct = getNowFormatDate();
//对文本框赋值
document.getElementById("currtime").value = ct;
//设置过1000毫秒就是1秒，调用getNowFormatDate方法
setTimeout("getTime()",1000);
}

function getNowFormatDate() {
    var date = new Date();
    var strYear = date.getYear();
	strYear = "2016";
    var strMonth = date.getMonth()+1;
    var strDate = date.getDate();
    var strSeconds = date.getSeconds();
    
    if (strMonth >= 1 && strMonth <= 9) {
        strMonth = "0" + strMonth;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    if (strSeconds >= 0 && strSeconds <= 9) {
        strSeconds = "0" + strSeconds;
    }
    var currentdate = strYear + "-" + strMonth + "-" + strDate
            + " " + date.getHours() + ":" + date.getMinutes()
            + ":" + strSeconds;
    return currentdate;
}
</script>
<%dbconntest.close(); %>
<%@include file="foot.jsp"%>
