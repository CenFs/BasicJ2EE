<%@ page language="java" import="java.util.*, java.sql.*, bjy.gp.test.dbconntest, java.io.*, java.text.*" pageEncoding="utf-8"%>
<jsp:useBean id="dbconn" class="bjy.gp.test.dbconntest" scope="page" />
<%@include file="head.jsp"%>

<%
request.setCharacterEncoding("utf8");

String str = request.getParameter("wrid");
int wrid = 0;
if (str != null && !str.isEmpty()){
	wrid = Integer.parseInt(request.getParameter("wrid"));
} else {
	response.setHeader("Refresh","1;URL=wareroom.jsp"); 
}



int wrwrcount = 0;
ResultSet rsimcount = dbconntest.executeQuery("SELECT count(*) FROM bjy2016gp.wareroom");
while (rsimcount.next()) {
	wrwrcount = rsimcount.getInt("count(*)");
}

int pagecount = 1;
int rspageid = 0;
ResultSet rspage = dbconntest.executeQuery("SELECT * FROM bjy2016gp.wareroom");
for (int i = 0; i < wrwrcount; i++){
	if(rspage.next()) {
		rspageid = rspage.getInt("wrid");
		if (rspageid == wrid) {
			break;
		}
		pagecount++;
	}
}

int nextwrid = 0, prevwrid = 0, lastwrid = 0;
int prevpage = pagecount - 1;
int nextpage = pagecount + 1;

String sqlnextpage = "select * from bjy2016gp.wareroom limit " + nextpage;
String sqlprevpage = "select * from bjy2016gp.wareroom limit " + prevpage;
String sqllastpage = "select * from bjy2016gp.wareroom limit " + wrwrcount;
ResultSet rsnextpage = dbconntest.executeQuery(sqlnextpage);
while(rsnextpage.next()) {
	nextwrid = rsnextpage.getInt("wrid");
}
ResultSet rsprevpage = dbconntest.executeQuery(sqlprevpage);
while(rsprevpage.next()) {
	prevwrid = rsprevpage.getInt("wrid");
}
ResultSet rslastpage = dbconntest.executeQuery(sqllastpage);
while(rslastpage.next()) {
	lastwrid = rslastpage.getInt("wrid");
}




/* wareroom (wrid, wrname, wr_person_in_charge, wr_capacity, wr_margin, wr_remark) */
String wrname = null, wr_person_in_charge = null, wr_remark = null;
int wr_capacity = 0, wr_margin = 0, count = 0;
double wr_margin_percent = 0.00;
int pdtcount = 0;
int pdtid = 0, pdt_quantity = 0;
String pdtname = null;

String sql = "SELECT * FROM bjy2016gp.wareroom where wrid=" + wrid;
ResultSet rs = dbconntest.executeQuery(sql);
while(rs.next()) {
	wrname = rs.getString("wrname");
	wr_person_in_charge = rs.getString("wr_person_in_charge");
	wr_capacity = rs.getInt("wr_capacity");
	wr_margin = rs.getInt("wr_margin");
	wr_remark = rs.getString("wr_remark");
	wr_margin_percent = (double)wr_margin / (double)wr_capacity;
	wr_margin_percent *= 100;
}

int nowpdtcount = wr_capacity - wr_margin;

String sqlpdtcount = "SELECT count(*) FROM bjy2016gp.product where pdt_wareroom=" + wrid;
ResultSet rspdtcount = dbconntest.executeQuery(sqlpdtcount);
while(rspdtcount.next()) {
	pdtcount = rspdtcount.getInt("count(*)");
}

String sqlpdt = "SELECT * FROM bjy2016gp.product where pdt_wareroom=" + wrid;
ResultSet rspdt = dbconntest.executeQuery(sqlpdt);

%>


			<div class="main-container">
				<div class="padding-md">
					<h2 class="header-text">
						仓库信息详情
					</h2>
					<div align="right">
						<%if (pagecount == 1) {%>
							<button type="submit" class="btn btn-default marginTB-xs" disabled>第一页</button>
							<button type="submit" class="btn btn-default marginTB-xs" disabled>上一页</button>
							<button id="nextpageto+<%=nextwrid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">下一页</button>
							<button id="lastpageto+<%=lastwrid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">最末页</button>
						<%} else if (pagecount == wrwrcount) {%>
							<button id="firstpageto+1" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">第一页</button>
							<button id="prevpageto+<%=prevwrid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">上一页</button>
							<button type="submit" class="btn btn-default marginTB-xs" disabled>下一页</button>
							<button type="submit" class="btn btn-default marginTB-xs" disabled>最末页</button>
						<%} else {%>
							<button id="firstpageto+1" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">第一页</button>
							<button id="prevpageto+<%=prevwrid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">上一页</button>
							<button id="nextpageto+<%=nextwrid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">下一页</button>
							<button id="lastpagetp+<%=lastwrid %>" onClick="changepage()" type="submit" class="btn btn-success marginTB-xs">最末页</button>
						<%}%>
						</div>
					<div class="smart-widget">
						<div class="smart-widget-header">
							仓库编号No.<%=wrid %> 信息
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
										<label class="col-lg-2 control-label">仓库名称</label>
										<div class="col-lg-10">
											<input name="wrname" class="form-control" type="text" value="<%=wrname %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">仓库编号</label>
										<div class="col-lg-10">
											<input name="wrid" class="form-control" type="text" value="<%=wrid %>" readonly>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">仓库描述</label>
										<div class="col-lg-10">
											<input name="wr_remark" class="form-control" rows="3" value="<%=wr_remark %>" readonly></input>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">仓库容量</label>
										<div class="col-lg-10">
											<div class="input-group">
												<input name="wr_capacity" type="text" class="form-control" value="<%=wr_capacity %>" readonly>
											</div><!-- /input-group -->
											<span class="help-block">当前仓库所存产品有<%=nowpdtcount %>件。</span>
										</div><!-- /.col -->
									</div><!-- /form-group -->
									
									
									<div class="form-group">
										<label class="col-lg-2 control-label">所存产品</label>
										<div class="col-lg-10">
											<%for (int i = 0; i < pdtcount; i++) {
												if (rspdt.next()) {
													pdtid = rspdt.getInt("pdtid");
													pdtname = rspdt.getString("pdtname");
													pdt_quantity = rspdt.getInt("pdt_quantity");
												}%>
											<div class="checkbox inline-block">
												<div class="custom-checkbox">
													<input type="checkbox" id="inlineCheckbox<%=pdtid %>" checked disabled>
													<label for="inlineCheckbox<%=pdtid %>"></label>
												</div>
												<div class="inline-block vertical-top">
													<%=pdtname %>，存有<%=pdt_quantity %>件。
												</div>
											</div>
											<%}; %>
										</div><!-- /.col -->
									</div><!-- /form-group -->
	
									
									<div class="form-group">
										<label class="col-lg-2 control-label"></label>
										<div class="col-lg-10">
											<button onClick="back()" class="btn btn-danger" data-toggle="modal">返回</button>
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
	window.location.href="wareroom_query.jsp?wrid=" + id;
}
</script>
<%dbconntest.close(); %>
<%@include file="foot.jsp"%>
