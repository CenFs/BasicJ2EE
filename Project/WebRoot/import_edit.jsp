<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");
/* import (importid, importname, import_person, import_time, import_remark, import_pdtid, import_wrid, import_reasonid, import_quantity) */

String str = request.getParameter("importid");
int importid = 0;
if (str != null && !str.isEmpty()){
	importid = Integer.parseInt(request.getParameter("importid"));
} else {
	response.setHeader("Refresh","1;URL=import.jsp"); 
}

int import_pdtid = 0;
int import_wrid = 0;
int import_reasonid = 0;
int import_quantity = 0;
String importname = null, import_person = null, import_time = null, import_remark = null;

String sql = "SELECT * FROM bjy2016gp.import where importid=" + importid;
ResultSet rs = dbconntest.executeQuery(sql);
while (rs.next()) {
	importname = rs.getString("importname");
	import_time = rs.getString("import_time");
	import_remark = rs.getString("import_remark");
	import_pdtid = rs.getInt("import_pdtid");
	import_wrid = rs.getInt("import_wrid");
	import_reasonid = rs.getInt("import_reasonid");
	import_quantity = rs.getInt("import_quantity");
}

String pdtname = null;
String sqlpdtname = "SELECT * FROM bjy2016gp.product where pdtid=" + import_pdtid;
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
							入库单详情
						</div>
						<div class="smart-widget-inner">
							
							<div class="smart-widget-body">
								<form id="formToggleLine" class="form-horizontal no-margin form-border" action="import.do?method=update" method="post">
									<div class="form-group">
										<label class="col-lg-2 control-label">入库单名称</label>
										<div class="col-lg-10">
											<input name="importname" class="form-control" type="text" value="<%=importname %>">
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">入库单编号</label>
										<div class="col-lg-10">
											<input name="importid" class="form-control" type="text" value="<%=importid %>" readonly>
											<span class="help-block">入库单编号禁止修改！</span>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">入库负责人</label>
										<div class="col-lg-10">
											<input name="username" class="form-control" type="text" value="<%=username %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">入库时间</label>
										<div class="col-lg-10">
											<div class="input-group">
												<input name="import_time" id="currtime" class="datetimepicker-input form-control" type="text" readonly/>
												<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
											</div>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">入库备注</label>
										<div class="col-lg-10">
											<input name="import_remark" class="form-control" rows="3" value="<%=import_remark %>"></input>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">入库产品</label>
										<div class="col-lg-10">
											<input name="pdtname" class="form-control" type="text" value="<%=pdtname %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									

									<div class="form-group">
										<label class="col-lg-2 control-label">入库产品数量</label>
										<div class="col-lg-10">
											<div class="row">
												<div class="col-lg-3">
													<input name="import_quantity" type="text" class="form-control" value="<%=import_quantity %>">
												</div><!-- /.col -->
											</div><!-- /.row -->
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">入库仓库</label>
										<div class="col-lg-10">
										<%for (int i = 0; i < wrcount; i++) {
												if (rswr.next()) {
													wrid = rswr.getInt("wrid");
													wrname = rswr.getString("wrname");
													wr_capacity = rswr.getInt("wr_capacity");
													wr_margin = rswr.getInt("wr_margin");
												}
												if (wrid == import_wrid) {
												%>
											<div class="radio">
												<div class="custom-radio m-right-xs">
													<input name="import_wrid" type="radio" id="radio<%=wrid %>" value="<%=wrid %>" checked>
													<label for="radio<%=wrid %>"></label>
												</div>
												<div class="inline-block vertical-top">
													<%=wrname %>，仓库容量<%=wr_capacity %>，当前剩余量：<%=wr_margin %>。本条记录中向此仓库入库。
												</div>
											</div>
											<%} else { %>
											<div class="radio">
												<div class="custom-radio m-right-xs">
													<input name="import_wrid" type="radio" id="radio<%=wrid %>" value="<%=wrid %>">
													<label for="radio<%=wrid %>"></label>
												</div>
												<div class="inline-block vertical-top">
													<%=wrname %>，仓库容量<%=wr_capacity %>，当前剩余量：<%=wr_margin %>。
												</div>
											</div>	
											<%} }; %>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">入库理由</label>
										<div class="col-lg-10">
										<select class="form-control" name="reasonid">
										<%for (int i = 0; i < reasoncount; i++) {
												if (rsreason.next()) {
													reasonid = rsreason.getInt("reasonid");
													reasonname = rsreason.getString("reasonname");
												}
												if (reasonid == import_reasonid) {%>
												<option value="<%=reasonid %>"><%=reasonname %>。此为本条记录入库理由。</option>
												<%} else { %>
												<option value="<%=reasonid %>"><%=reasonname %></option>
										<%} }; %>
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
