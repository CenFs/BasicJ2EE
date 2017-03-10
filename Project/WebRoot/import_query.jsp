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


int imcount = 0;
ResultSet rsimcount = dbconntest.executeQuery("SELECT count(*) FROM bjy2016gp.import");
while (rsimcount.next()) {
	imcount = rsimcount.getInt("count(*)");
}

int pagecount = 1;
int rspageid = 0;
ResultSet rspage = dbconntest.executeQuery("SELECT * FROM bjy2016gp.import");
for (int i = 0; i < imcount; i++){
	if(rspage.next()) {
		rspageid = rspage.getInt("importid");
		if (rspageid == importid) {
			break;
		}
		pagecount++;
	}
}

int prevpage = pagecount - 1;
int nextpage = pagecount + 1;
int previmid = 0, nextimid = 0, lastimid = 0;

String sqlnextpage = "select * from bjy2016gp.import limit " + nextpage;
String sqlprevpage = "select * from bjy2016gp.import limit " + prevpage;
String sqllastpage = "select * from bjy2016gp.import limit " + imcount;
ResultSet rsnextpage = dbconntest.executeQuery(sqlnextpage);
while(rsnextpage.next()) {
	nextimid = rsnextpage.getInt("importid");
}
ResultSet rsprevpage = dbconntest.executeQuery(sqlprevpage);
while(rsprevpage.next()) {
	previmid = rsprevpage.getInt("importid");
}
ResultSet rslastpage = dbconntest.executeQuery(sqllastpage);
while(rslastpage.next()) {
	lastimid = rslastpage.getInt("importid");
}
/* 
System.out.println("previmid:" + previmid);
System.out.println("nextimid:" + nextimid);
System.out.println("lastimid:" + lastimid);
 */


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
						<div align="right">
						<%if (pagecount == 1) {%>
							<button type="submit" class="btn btn-default marginTB-xs" disabled>第一页</button>
							<button type="submit" class="btn btn-default marginTB-xs" disabled>上一页</button>
							<button id="nextpageto+<%=nextimid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">下一页</button>
							<button id="lastpageto+<%=lastimid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">最末页</button>
						<%} else if (pagecount == imcount) {%>
							<button id="firstpageto+1" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">第一页</button>
							<button id="prevpageto+<%=previmid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">上一页</button>
							<button type="submit" class="btn btn-default marginTB-xs" disabled>下一页</button>
							<button type="submit" class="btn btn-default marginTB-xs" disabled>最末页</button>
						<%} else {%>
							<button id="firstpageto+1" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">第一页</button>
							<button id="prevpageto+<%=previmid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">上一页</button>
							<button id="nextpageto+<%=nextimid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">下一页</button>
							<button id="lastpagetp+<%=lastimid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">最末页</button>
						<%}%>
						</div>
						<div class="smart-widget-inner">
							
							<div class="smart-widget-body">
								<form id="formToggleLine" class="form-horizontal no-margin form-border">
									<div class="form-group">
										<label class="col-lg-2 control-label">入库单名称</label>
										<div class="col-lg-10">
											<input name="importname" class="form-control" type="text" value="<%=importname %>" readonly>
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
												<input name="import_time" id="currtime" class="datetimepicker-input form-control" type="text" value="<%=import_time %>" readonly/>
												<span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
											</div>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">入库备注</label>
										<div class="col-lg-10">
											<input name="import_remark" class="form-control" rows="3" value="<%=import_remark %>" readonly></input>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">入库产品</label>
										<div class="col-lg-10">
											<input class="form-control" type="text" value="<%=pdtname %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									

									<div class="form-group">
										<label class="col-lg-2 control-label">入库产品数量</label>
										<div class="col-lg-10">
											<div class="row">
												<div class="col-lg-3">
													<input name="import_quantity" type="text" class="form-control" value="<%=import_quantity %>" readonly>
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
													<input name="import_wrid" type="radio" id="radio<%=wrid %>" value="<%=wrid %>" checked disabled>
													<label for="radio<%=wrid %>"></label>
												</div>
												<div class="inline-block vertical-top">
													<%=wrname %>，仓库容量<%=wr_capacity %>，当前剩余量：<%=wr_margin %>。本条记录中向此仓库入库。
												</div>
											</div>
											<%} }; %>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">入库理由</label>
										<div class="col-lg-10">
										<select class="form-control" name="reasonid" disabled>
										<%for (int i = 0; i < reasoncount; i++) {
												if (rsreason.next()) {
													reasonid = rsreason.getInt("reasonid");
													reasonname = rsreason.getString("reasonname");
												}
												if (reasonid == import_reasonid) {%>
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
function changepage(){
	var id = event.target.id;
	id = id.substring(id.indexOf('+') + 1, id.length);
	window.location.href="import_query.jsp?importid=" + id;
}
</script>
<%dbconntest.close(); %>
<%@include file="foot.jsp"%>
