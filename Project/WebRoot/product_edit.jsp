<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");

String str = request.getParameter("pdtid");
int pdtid = 0;
if (str != null && !str.isEmpty()){
	pdtid = Integer.parseInt(request.getParameter("pdtid"));
} else {
	response.setHeader("Refresh","1;URL=product.jsp"); 
}
/* product (pdtid, pdtname, pdt_wareroom, pdt_register_time, pdt_register_person, pdt_remark, pdt_price, pdt_quantity) */
String pdtname = null, pdt_register_time = null, pdt_register_person = null, pdt_remark = null;
int pdt_wareroom = 0, pdt_quantity = 0, wrcount = 0;
double pdt_price = 0.00;
int wrid = 0, wr_capacity = 0, wr_margin = 0;
String wrname = null;
double pdt_total_price = 0.00;


String sql = "SELECT * FROM bjy2016gp.product where pdtid=" + pdtid;
ResultSet rs = dbconntest.executeQuery(sql);
while(rs.next()) {
	pdtname = rs.getString("pdtname");
	pdt_wareroom = rs.getInt("pdt_wareroom");
	pdt_remark = rs.getString("pdt_remark");
	pdt_register_time = rs.getString("pdt_register_time");
	pdt_price = rs.getDouble("pdt_price");
	pdt_quantity = rs.getInt("pdt_quantity");
	pdt_total_price = pdt_price * pdt_quantity;
}

ResultSet rswrcount = dbconntest.executeQuery("SELECT count(*) FROM bjy2016gp.wareroom");
while (rswrcount.next()) {
	wrcount = rswrcount.getInt("count(*)");
}

ResultSet rswr = dbconntest.executeQuery("SELECT * FROM bjy2016gp.wareroom");
%>


			<div class="main-container">
				<div class="padding-md">
					<h2 class="header-text">
						产品信息修改
					</h2>
					
					<div class="smart-widget">
						<div class="smart-widget-header">
							产品编号No.<%=pdtid %> 信息
							<span class="smart-widget-option">
								<span class="refresh-icon-animated">
									<i class="fa fa-circle-o-notch fa-spin"></i>
								</span>
	                        </span>
						</div>
						<div class="smart-widget-inner">
							<div class="smart-widget-body">
								<form id="formToggleLine" class="form-horizontal no-margin form-border" action="product.do?method=update" method="post">
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">修改人</label>
										<div class="col-lg-10">
											<input name="username" class="form-control" type="text" value="<%=username %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品名称</label>
										<div class="col-lg-10">
											<input name="pdtname" class="form-control" type="text" value="<%=pdtname %>">
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品编号</label>
										<div class="col-lg-10">
											<input name="pdtid" class="form-control" type="text" value="<%=pdtid %>" readonly>
											<span class="help-block">产品编号禁止修改！</span>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">修改时间</label>
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
											<input name="pdt_remark" class="form-control" rows="3" value="<%=pdt_remark %>"></input>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品价格</label>
										<div class="col-lg-10">
											<div class="input-group">
												<span class="input-group-addon">¥</span>
												<input name="pdt_price" id="ip_pdt_price" type="text" class="form-control" value="<%=pdt_price %>">
											</div><!-- /input-group -->
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品数量</label>
										<div class="col-lg-10">
											<div class="row">
												<div class="col-lg-3">
													<input name="pdt_quantity" id="ip_pdt_quantity" type="text" class="form-control" value="<%=pdt_quantity %>">
													<%-- <label class="col-lg-2 control-label"></label>
													<p class="form-control-static">当前总价：<%=pdt_total_price %></p> --%>
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
												}
												
												if (pdt_wareroom == wrid) {
												%>
											<div class="radio">
												<div class="custom-radio m-right-xs">
													<input name="pdt_wareroom" type="radio" id="radio<%=wrid %>" value="<%=wrid %>" checked>
													<label for="radio<%=wrid %>"></label>
												</div>
												<div class="inline-block vertical-top">
													<%=wrname %>，仓库容量<%=wr_capacity %>，当前剩余量：<%=wr_margin %>，该产品存在这个仓库。
												</div>
											</div>
											<%
											} else {
											%>
											<div class="radio">
												<div class="custom-radio m-right-xs">
													<input name="pdt_wareroom" type="radio" id="radio<%=wrid %>" value="<%=wrid %>">
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
			
			
			
<script type="text/javascript">
/* function mouseOut() {
	var tmp_pdt_quantity = $("#ip_pdt_quantity").val();
	var tmp_pdt_price = $("#ip_pdt_price").val();
	pdt_total_price = tmp_pdt_price * tmp_pdt_quantity;
} */

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
