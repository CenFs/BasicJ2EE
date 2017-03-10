<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");
/* product (pdtid, pdtname, pdt_wareroom, pdt_register_time, pdt_register_person, pdt_remark, pdt_price, pdt_quantity) */

int wrid = 0;
int wr_capacity = 0;
int wr_margin = 0;
String wrname = null;
int wrcount = 0;

ResultSet rswrcount = dbconntest.executeQuery("SELECT count(*) FROM bjy2016gp.wareroom");
while (rswrcount.next()) {
	wrcount = rswrcount.getInt("count(*)");
}

ResultSet rswr = dbconntest.executeQuery("SELECT * FROM bjy2016gp.wareroom");
%>


			<div class="main-container">
				<div class="padding-md">
					<h2 class="header-text">
						产品信息添加
					</h2>
					
					<div class="smart-widget">
						<div class="smart-widget-header">
							添加产品所需填写内容
							<span class="smart-widget-option">
								<span class="refresh-icon-animated">
									<i class="fa fa-circle-o-notch fa-spin"></i>
								</span>
	                        </span>
						</div>
						<div class="smart-widget-inner">
							<div class="smart-widget-body">
								<form id="formToggleLine" class="form-horizontal no-margin form-border" action="product.do?method=add" method="post">
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">录入人</label>
										<div class="col-lg-10">
											<input name="username" class="form-control" type="text" value="<%=username %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品名称</label>
										<div class="col-lg-10">
											<input name="pdtname" class="form-control" type="text" placeholder="产品名称">
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">录入时间</label>
										<div class="col-lg-10">
											<div class="input-group">
												<input name="pdt_register_time" id="currtime" class="datetimepicker-input form-control" type="text" readonly/>
												<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
											</div>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品描述</label>
										<div class="col-lg-10">
											<input name="pdt_remark" class="form-control" rows="3" placeholder="描述该产品。该产品用途、优势等简介。"></input>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品价格</label>
										<div class="col-lg-10">
											<div class="input-group">
												<span class="input-group-addon">¥</span>
												<input name="pdt_price" id="ip_pdt_price" type="text" class="form-control" placeholder="0.00">
											</div><!-- /input-group -->
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品数量</label>
										<div class="col-lg-10">
											<div class="row">
												<div class="col-lg-3">
													<input name="pdt_quantity" id="ip_pdt_quantity" type="text" class="form-control" placeholder="0">
												</div><!-- /.col -->
											</div><!-- /.row -->
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">所存仓库</label>
										<div class="col-lg-10">
											<div class="radio">
												<div class="custom-radio m-right-xs">
													<input name="pdt_wareroom" type="radio" id="radio0" value="0">
													<label for="radio0"></label>
												</div>
												<div class="inline-block vertical-top">
													该产品尚未入库。
												</div>
											</div>
										<%for (int i = 0; i < wrcount; i++) {
												if (rswr.next()) {
													wrid = rswr.getInt("wrid");
													wrname = rswr.getString("wrname");
													wr_capacity = rswr.getInt("wr_capacity");
													wr_margin = rswr.getInt("wr_margin");
												}%>
											<div class="radio">
												<div class="custom-radio m-right-xs">
													<input name="pdt_wareroom" type="radio" id="radio<%=wrid %>" value="<%=wrid %>">
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
