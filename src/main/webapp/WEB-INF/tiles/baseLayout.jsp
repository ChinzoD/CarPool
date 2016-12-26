<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<meta charset="utf-8"/>
<title>Carpool</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta content="" name="description"/>
<meta content="" name="author"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="author" content="OpenWeatherMap.org">
<meta name="domain" content="OpenWeatherMap.org" >
<meta http-equiv="pragma" content="no-cache" >
<meta http-equiv="Expires" content="-1" >
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/metronic/assets/global/plugins/font-awesome/css/font-awesome.min.css" />" />
<link href="<c:url value="/metronic/assets/global/plugins/font-awesome/css/font-awesome.min.css" />" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/metronic/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" />" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/metronic/assets/global/plugins/bootstrap/css/bootstrap.min.css" />" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/metronic/assets/global/plugins/uniform/css/uniform.default.css" />" rel="stylesheet" type="text/css"/>
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN PAGE LEVEL STYLES -->
<link href="<c:url value="/metronic/assets/admin/pages/css/profile.css" />" rel="stylesheet" type="text/css"/>
<!-- END PAGE LEVEL SCRIPTS -->
<!-- BEGIN THEME STYLES -->
<link href="<c:url value="/metronic/assets/global/css/components.css" />" id="style_components" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/metronic/assets/global/css/plugins.css" />" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/metronic/assets/admin/layout3/css/layout.css" />" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/metronic/assets/admin/layout3/css/themes/default.css" />" rel="stylesheet" type="text/css" id="style_color"/>
<link href="<c:url value="/metronic/assets/admin/layout3/css/custom.css" />" rel="stylesheet" type="text/css"/>
<!-- END THEME STYLES -->
<link rel="shortcut icon" href="favicon.ico"/>

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<!-- BEGIN HEADER -->
	<div class="page-header">
		<!-- BEGIN HEADER TOP -->
		<div class="page-header-top">
			<div class="container">
				<div class="page-logo">
					<a href="index.html"><img src="<c:url value="/metronic/assets/carpool.png" />" width="300px;" alt="logo" class="logo-default"></a>
				</div>
				<!-- BEGIN RESPONSIVE MENU TOGGLER -->
				<a href="javascript:;" class="menu-toggler"></a>
				<!-- END RESPONSIVE MENU TOGGLER -->
				<!-- BEGIN TOP NAVIGATION MENU -->
				<div class="top-menu">
					<ul class="nav navbar-nav pull-right">
						<!-- BEGIN USER LOGIN DROPDOWN -->
						<li class="dropdown dropdown-user dropdown-dark">
							<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
							<span class="username username-hide-mobile">Welcome ${sessionScope.username} !</span>
							</a>
							<ul class="dropdown-menu dropdown-menu-default">
								<li>
									<a href="<c:url value="/user/profile" />">
									<i class="icon-user"></i> My Profile </a>
								</li>
								<li class="divider">
								</li>
								<li>
									<a href="extra_lock.html">
									<i class="icon-lock"></i> Lock Screen </a>
								</li>
								<li>
									<a href="<c:url value="/logout" />" >
									<i class="icon-key"></i> Log Out </a>
								</li>
							</ul>
						</li>
						<!-- END USER LOGIN DROPDOWN -->
					</ul>
				</div>
				<!-- END TOP NAVIGATION MENU -->
			</div>
		</div>
		<!-- END HEADER TOP -->
			<!-- BEGIN HEADER MENU -->
	<div class="page-header-menu">
		<div class="container">
			<!-- BEGIN MEGA MENU -->
			<!-- DOC: Apply "hor-menu-light" class after the "hor-menu" class below to have a horizontal menu with white background -->
			<!-- DOC: Remove data-hover="dropdown" and data-close-others="true" attributes below to disable the dropdown opening on mouse hover -->
			<div class="hor-menu ">
				<ul class="nav navbar-nav">
					<li>
						<a href="<c:url value="/user/profile" />">User Profile</a>
					</li>
					<li>
						<a href="<c:url value="/user/post" />">Posts</a>
					</li>
				</ul>
			</div>
			<!-- END MEGA MENU -->
		</div>
	</div>
	<!-- END HEADER MENU -->
	</div>
	<!-- END HEADER -->
	
	<!-- BEGIN PAGE CONTAINER -->
	<div class="page-container">
	    <!-- BEGIN PAGE CONTENT -->
		<div class="page-content">
			<div class="container">
				<div class="row margin-top-10">
					<div class="col-md-12">
						<!-- BEGIN PROFILE SIDEBAR -->
						<div class="profile-sidebar" style="width: 410px;">
							<!-- PORTLET MAIN -->
							<div class="portlet light profile-sidebar-portlet">
								<div class="panel-heading"><a href="http://openweathermap.org" target="_blank" class="pull-right">Weather</a> <h4>Local weather</h4></div>
								<div class="panel-body">
									<!--<div class="clearfix" id="pnlWeather"></div>-->
									<iframe id="forecast_embed" type="text/html" frameborder="0" height="200" width="95%"
									src="http://forecast.io/embed/#lat=41.017057&lon=-91.967604&name=Fairfield, Iowa&color=#00aaff&font=Helvetica&units=us">
									</iframe>
								</div>
							</div>
							<!-- END PORTLET MAIN -->
							<!-- PORTLET MAIN -->
							<div class="portlet light">
								<tiles:insertAttribute name="sidebar"></tiles:insertAttribute>
							</div>
							<!-- END PORTLET MAIN -->
						</div>
						<!-- END BEGIN PROFILE SIDEBAR -->
						<!-- BEGIN PROFILE CONTENT -->
						<div class="profile-content">
							<div class="row">
								<div class="col-md-12">
									<tiles:insertAttribute name="content"></tiles:insertAttribute>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- END PAGE CONTENT -->
	</div>
	<!-- END PAGE CONTAINER -->
	
	<!-- BEGIN PRE-FOOTER -->
	<div class="page-prefooter">
		<div class="container">
			
		</div>
    </div>
	<!-- END PRE-FOOTER -->
	<!-- BEGIN FOOTER -->
	<div class="page-footer">
		<div class="container">
			 2014 &copy; Metronic. All Rights Reserved.
		</div>
	</div>
	<div class="scroll-to-top">
		<i class="icon-arrow-up"></i>
	</div>
	<!-- END FOOTER -->

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<!--[if lt IE 9]>
<script src="../../assets/global/plugins/respond.min.js"></script>
<script src="../../assets/global/plugins/excanvas.min.js"></script> 
<![endif]-->
<script src="<c:url value="/metronic/assets/global/plugins/jquery.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/jquery-migrate.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/bootstrap/js/bootstrap.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/jquery.blockui.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/uniform/jquery.uniform.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/jquery.cokie.min.js" />" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="<c:url value="/metronic/assets/global/plugins/jquery.sparkline.min.js" />" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="<c:url value="/metronic/assets/global/scripts/metronic.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/admin/layout3/scripts/layout.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/admin/layout3/scripts/demo.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/admin/pages/scripts/profile.js" />" type="text/javascript"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script>
	jQuery(document).ready(function() {       
	   	// initiate layout and plugins
	   	Metronic.init(); // init metronic core components
		Layout.init(); // init current layout
		Demo.init(); // init demo features
		Profile.init(); // init page demo
		
		$(".btnAddCmnt").live("click",function(){

			var postid = $(this).attr("name");
			if($("#"+postid+"_${sessionScope.userid}").val()!=""){
				var Comments = {}; //The Object to Send Data Back to the Controller
				Comments.postid = postid;
				Comments.comment = $("#"+postid+"_${sessionScope.userid}").val();
				$.ajax({
					type: 'POST',
					url: '/carpool/user/addComment',
					contentType : 'application/json; charset=utf-8',
				    dataType : 'json',
	                data: JSON.stringify(Comments),
	                success: function (evt) {
	                	var date = new Date().toLocaleString();
	                	var str = "<div style='border-bottom: 1px dotted #f2f2f2;padding-bottom: 5px;padding-top: 5px;'>"+
							"<strong>"+
							"${sessionScope.username}" +
							"</strong>  | <span style='opacity: 0.5;'>"+
							date +
							"</span><br/>"+Comments.comment+
							"</div>";
	                	$("#_"+postid+"_${sessionScope.userid}").append(str).fadeIn(10000);
	                	$("#_"+postid+"_${sessionScope.userid}").val("");
	                }
				});
			}
		});
		
		$(".btnAddPost").click(function(){

			if($("#post_text").val()!=""){
				var Posts = {}; //The Object to Send Data Back to the Controller
				Posts.post = $("#post_text").val();
				$.ajax({
					type: 'POST',
					url: '/carpool/user/addPost',
					contentType : 'application/json; charset=utf-8',
				    dataType : 'json',
	                data: JSON.stringify(Posts),
	                success: function (data) {

	                	var date = new Date().toLocaleString();
	                	var str ="<div class='panel panel-default' id='post"+data.postid+"'>" +
	                	"<div class='panel-heading'>" +
	                	"<button class='btnDelPost btn btn-xs btn-default pull-right' type='button' value='"+data.postid+"' " +
	                	"class='btn btn-xs btn-default pull-right'>X</button>" +
	                	"<strong>${sessionScope.username} </strong> " + date +
	                	"</div>"+
	                	"<div class='panel-body'>" +
	                	$("#post_text").val() +
	                	"<br/><br/>" +
	                	"<a href='#' class='plike' id='"+data.postid+"'>Like</a><span>0</span>" +
	                	"<div class='clearfix'></div>" +
	                	"<hr>" +
	                	"<div id='_"+data.postid+"_"+${sessionScope.userid}+"'>" +
	                	"</div>" +
	                	"<hr>" +
	                	"<form>" +
	                	"<div class='input-group'>" +
	                	"<input type='text' class='form-control' id='"+data.postid+"_${sessionScope.userid}' " +
	                	"placeholder='Add a comment..'>" +
	                	"<div class='input-group-btn'>" +
	                	"<button type='button' id='register-submit-btn'  name='"+ data.postid+"' " +
	                	"class='btn green-haze uppercase btnAddCmnt'>add</button>" +
	                	"</div></div></form></div></div>";
	                	
	                	
	                	$(".post_container").prepend(str).fadeIn(10000);
	                	$("#post_text").val("");
	                }
				});
			}
		});
		
		$(".btnDelPost").live("click",function(){
			var id = $(this).val();
			$.ajax({
				url: '/carpool/user/deletePost?postid=' + id,
				method: 'POST'
				}).done(function(data) {					
			});
			$("#post"+id).remove();
		});
		
		$(".plike").live("click",function(){
			var c = parseInt($(this).next("span").text())+1;

			var postid = $(this).attr("id");

			$(this).next("span").text(c);
			$(this).removeClass("plike");
			$.ajax({
				url: '/carpool/user/likePost?postid=' + postid,
				method: 'POST'
				}).done(function(data) {					
			});
		});
	});
</script>
<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>