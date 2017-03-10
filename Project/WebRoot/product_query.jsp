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

int pdtcount = 0;
ResultSet rspdtcount = dbconntest.executeQuery("SELECT count(*) FROM bjy2016gp.product");
while (rspdtcount.next()) {
	pdtcount = rspdtcount.getInt("count(*)");
}

int pagecount = 1;
int rspageid = 0;
ResultSet rspage = dbconntest.executeQuery("SELECT * FROM bjy2016gp.product");
for (int i = 0; i < pdtcount; i++){
	if(rspage.next()) {
		rspageid = rspage.getInt("pdtid");
		if (rspageid == pdtid) {
			break;
		}
		pagecount++;
	}
}
// System.out.println("current product is the No." + pagecount + "!!! pdtcount:" + pdtcount + " and pdtid:" + pdtid);

int prevpage = pagecount - 1;
int nextpage = pagecount + 1;
int prevpdtid = 0, nextpdtid = 0, lastpdtid = 0;

String sqlnextpage = "select * from bjy2016gp.product limit " + nextpage;
String sqlprevpage = "select * from bjy2016gp.product limit " + prevpage;
String sqllastpage = "select * from bjy2016gp.product limit " + pdtcount;
ResultSet rsnextpage = dbconntest.executeQuery(sqlnextpage);
while(rsnextpage.next()) {
	nextpdtid = rsnextpage.getInt("pdtid");
}

ResultSet rsprevpage = dbconntest.executeQuery(sqlprevpage);
while(rsprevpage.next()) {
	prevpdtid = rsprevpage.getInt("pdtid");
}

ResultSet rslastpage = dbconntest.executeQuery(sqllastpage);
while(rslastpage.next()) {
	lastpdtid = rslastpage.getInt("pdtid");
}
/* 
System.out.println("prevpdtid:" + prevpdtid);
System.out.println("nextpdtid:" + nextpdtid);
System.out.println("lastpdtid:" + lastpdtid);

 */



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
						产品信息详情
					</h2>
						<div align="right">
						<%if (pagecount == 1) {%>
							<button type="submit" class="btn btn-default marginTB-xs" disabled>第一页</button>
							<button type="submit" class="btn btn-default marginTB-xs" disabled>上一页</button>
							<button id="nextpageto+<%=nextpdtid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">下一页</button>
							<button id="lastpageto+<%=lastpdtid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">最末页</button>
						<%} else if (pagecount == pdtcount) {%>
							<button id="firstpageto+1" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">第一页</button>
							<button id="prevpageto+<%=prevpdtid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">上一页</button>
							<button type="submit" class="btn btn-default marginTB-xs" disabled>下一页</button>
							<button type="submit" class="btn btn-default marginTB-xs" disabled>最末页</button>
						<%} else {%>
							<button id="firstpageto+1" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">第一页</button>
							<button id="prevpageto+<%=prevpdtid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">上一页</button>
							<button id="nextpageto+<%=nextpdtid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">下一页</button>
							<button id="lastpagetp+<%=lastpdtid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">最末页</button>
						<%}%>
						</div>
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
								<form id="formToggleLine" class="form-horizontal no-margin form-border">
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">修改人</label>
										<div class="col-lg-10">
											<input name="username" class="form-control" type="text" value="<%=username %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品名称</label>
										<div class="col-lg-10">
											<input name="pdtname" class="form-control" type="text" value="<%=pdtname %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品编号</label>
										<div class="col-lg-10">
											<input name="pdtid" class="form-control" type="text" value="<%=pdtid %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">修改时间</label>
										<div class="col-lg-10">
											<div class="input-group">
												<input name="pdt_register_time" id="currtime" class="datetimepicker-input form-control" type="text" value="<%=pdt_register_time %>" readonly/>
												<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
											</div>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品描述</label>
										<div class="col-lg-10">
											<input name="pdt_remark" class="form-control" rows="3" value="<%=pdt_remark %>" readonly></input>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品价格</label>
										<div class="col-lg-10">
											<div class="input-group">
												<span class="input-group-addon">¥</span>
												<input name="pdt_price" id="ip_pdt_price" type="text" class="form-control" value="<%=pdt_price %>" readonly>
											</div><!-- /input-group -->
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">产品数量</label>
										<div class="col-lg-10">
											<div class="row">
												<div class="col-lg-3">
													<input name="pdt_quantity" id="ip_pdt_quantity" type="text" class="form-control" value="<%=pdt_quantity %>" readonly>
													<%-- <label class="col-lg-2 control-label"></label>
													<p class="form-control-static">当前总价：<%=pdt_total_price %></p> --%>
												</div><!-- /.col -->
											</div><!-- /.row -->
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">所存仓库</label>
										<div class="col-lg-10">
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
													<input name="pdt_wareroom" type="radio" id="radio<%=wrid %>" value="<%=wrid %>" checked readonly>
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
											<button type="text" class="btn btn-danger" data-toggle="modal" onClick="back()">返回</button>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
								</form>
							</div>
						</div><!-- ./smart-widget-inner -->
					</div><!-- ./smart-widget -->
				</div><!-- ./padding-md -->
			</div><!-- /main-container -->
			
			
			
<script language="javascript" type="text/javascript">
function back() {
	history.back(-1);
}
function changepage(){
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="product_query.jsp?pdtid=" + id;
}
</script>
<%dbconntest.close(); %>
<%@include file="foot.jsp"%>
