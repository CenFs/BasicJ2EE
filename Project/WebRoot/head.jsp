<%@page contentType="text/html; charset=UTF-8"%>
<%
String islogin = (String)session.getAttribute("islogin");
int userid = (Integer)session.getAttribute("userid");
String username = (String)session.getAttribute("username");
/* System.out.println("username!!!!!" + username); */
if (islogin == "Y") {
} else {
	out.println("请先登录，谢谢!") ;
	out.println("<br>3秒后网页会自动进入登录页面!");
	session.invalidate();
	response.setHeader("Refresh","3;URL=login.jsp"); 
}
%>

<!DOCTYPE html>
<html lang="en">
  	<head>
	    <meta charset="utf-8">
	    <title>仓库管理系统</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <meta name="description" content="">
	    <meta name="author" content="">

	    <!-- Bootstrap core CSS -->
	    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
		
		<!-- Font Awesome -->
		<link href="css/font-awesome.min.css" rel="stylesheet">

		<!-- ionicons -->
		<link href="css/ionicons.min.css" rel="stylesheet">
		
		<!-- Morris -->
		<link href="css/morris.css" rel="stylesheet"/>	

		<!-- Datepicker -->
		<link href="css/datepicker.css" rel="stylesheet"/>	

		<!-- Animate -->
		<link href="css/animate.min.css" rel="stylesheet">

		<!-- Owl Carousel -->
		<link href="css/owl.carousel.min.css" rel="stylesheet">
		<link href="css/owl.theme.default.min.css" rel="stylesheet">

		<!-- Simplify -->
		<link href="css/simplify.min.css" rel="stylesheet">
		
		<!-- Slider -->
		<link href="css/bootstrap-slider.css" rel="stylesheet"/>

		<!-- Tag Input -->
		<link href="css/jquery.tagsinput.css" rel="stylesheet">

		<!-- Date Time Picker -->
		<link href="css/datetimepicker.css" rel="stylesheet">
		
		<!-- Select2 -->
		<link href="css/select2/select2.css" rel="stylesheet"/>	
		
		<!-- TimePicker -->
		<link rel="stylesheet" type="text/css" href="../css/main.css" />
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
		
		
		
  	</head>

  	<body class="overflow-hidden">
		<div class="wrapper preload">
			<header class="top-nav">
				<div class="top-nav-inner">
					<div class="nav-header">
						<button type="button" class="navbar-toggle pull-left sidebar-toggle" id="sidebarToggleSM">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a href="index.jsp" class="brand">
							<i class="fa fa-database"></i><span class="brand-name">仓库管理系统</span>
						</a>
					</div>
					<div class="nav-container">
						<button type="button" class="navbar-toggle pull-left sidebar-toggle" id="sidebarToggleLG">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<div class="pull-right m-right-sm">
							<div class="user-block hidden-xs">
								<a href="#" id="userToggle" data-toggle="dropdown">
									<img src="images/profile/profile1.jpg" alt="" class="img-circle inline-block user-profile-pic">
									<div class="user-detail inline-block">
										<%=username %>
										<i class="fa fa-angle-down"></i>
									</div>
								</a>
								<div class="panel border dropdown-menu user-panel">
									<div class="panel-body paddingTB-sm">
										<ul><!-- 
											<li>
												<a href="user.jsp">
													<i class="fa fa-edit fa-lg"></i><span class="m-left-xs">个人信息</span>
												</a>
											</li> -->
											<li>
												<a href="login.jsp">
													<i class="fa fa-power-off fa-lg"></i><span class="m-left-xs">注销</span>
												</a>
											</li>
										</ul>
									</div>
								</div>
							</div>
							
				</div><!-- ./top-nav-inner -->	
			</header>
			<aside class="sidebar-menu fixed">
				<div class="sidebar-inner scrollable-sidebar">
					<div class="main-menu">
						<ul class="accordion">
							<li class="menu-header">
								主菜单
							</li>
							<li class="bg-palette1 active">
								<a href="index.jsp">
									<span class="menu-content block">
										<span class="menu-icon"><i class="block fa fa-home fa-lg"></i></span>
										<span class="text m-left-sm"> </span>
									</span>
									<span class="menu-content-hover block">
										主页
									</span>
								</a>
							</li>
							<li class="openable bg-palette3">
								<a href="#">
									<span class="menu-content block">
										<span class="menu-icon"><i class="block fa fa-list fa-lg"></i></span>
										<span class="text m-left-sm">产品信息</span>
										<span class="submenu-icon"></span>									</span>
									<span class="menu-content-hover block">
										产品									</span>								</a>
								<ul class="submenu bg-palette4">
									<li><a href="product_add.jsp"><span class="submenu-label">产品信息添加</span></a></li>
									<li><a href="product.jsp"><span class="submenu-label">产品信息查看/更改/删除</span></a></li>
								</ul>
							</li>
							
							
							<li class="openable bg-palette4">
								<a href="#">
									<span class="menu-content block">
										<span class="menu-icon"><i class="block fa fa-envelope fa-lg"></i></span>
										<span class="text m-left-sm">出入库理由设置</span>
										<span class="submenu-icon"></span>									</span>
									<span class="menu-content-hover block">
										理由								</span>								</a>
								<ul class="submenu">
									<li><a href="reason_add.jsp"><span class="submenu-label">出入库理由添加</span></a></li>
									<li><a href="reason.jsp"><span class="submenu-label">出入库理由查看/删除</span></a></li>
								</ul>
							</li>
							
							
							<li class="openable bg-palette3">
								<a href="#">
									<span class="menu-content block">
										<span class="menu-icon"><i class="block fa fa-gift fa-lg"></i></span>
										<span class="text m-left-sm">仓库信息</span>
										<span class="submenu-icon"></span>									</span>
									<span class="menu-content-hover block">
										仓库									</span>								</a>
								<ul class="submenu">
									<li><a href="wareroom_add.jsp"><span class="submenu-label">仓库信息添加</span></a></li>
									<li><a href="wareroom.jsp"><span class="submenu-label">仓库信息查看/更改/删除</span></a></li>
								</ul>
							</li>
							
							
							<li class="openable bg-palette4">
								<a href="#">
									<span class="menu-content block">
										<span class="menu-icon"><i class="block fa fa-tags fa-lg"></i></span>
										<span class="text m-left-sm">入库信息</span>
										<span class="submenu-icon"></span>									</span>
									<span class="menu-content-hover block">
										入库								</span>								</a>
								<ul class="submenu">
									<li><a href="import_add.jsp"><span class="submenu-label">入库信息添加</span></a></li>
									<li><a href="import.jsp"><span class="submenu-label">入库信息查看/更改/删除</span></a></li>
									<li><a href="import_search.jsp"><span class="submenu-label">入库单查询</span></a></li>
								</ul>
							</li>
							
							
							<li class="openable bg-palette3">
								<a href="#">
									<span class="menu-content block">
										<span class="menu-icon"><i class="block fa fa-tags fa-lg"></i></span>
										<span class="text m-left-sm">出库信息</span>
										<span class="submenu-icon"></span>									</span>
									<span class="menu-content-hover block">
										出库								</span>								</a>
								<ul class="submenu bg-palette4">
									<li><a href="export_add.jsp"><span class="submenu-label">出库信息添加</span></a></li>
									<li><a href="export.jsp"><span class="submenu-label">出库信息查看/更改/删除</span></a></li>
									<li><a href="export_search.jsp"><span class="submenu-label">出库单查询</span></a></li>
								</ul>
							</li>
							
							
						</ul>
					</div>	
				</div><!-- sidebar-inner -->
			</aside>
