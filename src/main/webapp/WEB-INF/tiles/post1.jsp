<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta charset="utf-8">
		<title>Car pooling</title>
		<meta name="generator" content="Bootply" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<!--<link href="css/bootstrap.min.css" rel="stylesheet">-->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		<link href="/carpool/resources/css/styles.css" rel="stylesheet">
	</head>
	<body>
		<div class="wrapper">
			<div class="box">
				<div class="row row-offcanvas row-offcanvas-left">
					<!-- main right col -->
					<div class="column col-sm-12 col-xs-12" id="main">
						<!-- top nav -->
						<div class="navbar navbar-blue navbar-static-top">  
							<div class="navbar-header">
							  <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							  </button>
							  <a href="#" class="navbar-brand logo">C</a>
							</div>
							<!-- 
							<nav class="collapse navbar-collapse" role="navigation">
							<form class="navbar-form navbar-left">
								<div class="input-group input-group-sm" style="max-width:1200px;">
								  <input type="text" class="form-control" placeholder="Search" name="srch-term" id="srch-term">
								  <div class="input-group-btn">
									<button id="btnSearch" class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
								  </div>
								</div>
							</form>
							<ul class="nav navbar-nav">
							  <li>
								<a href="#"><i class="glyphicon glyphicon-home"></i> Home</a>
							  </li>
							  <li>
								<a href="#postModal" role="button" data-toggle="modal"><i class="glyphicon glyphicon-plus"></i> Post</a>
							  </li>
							</ul>
							</nav>  -->
						</div>
						
						<!-- /top nav -->
						<div class="padding">
							<div class="full col-sm-9">
							  
								<!-- notification -->                      
								<div id="notification"></div>

								<!-- content -->                      
								<div class="row">
								  
								 <!-- main col left --> 
								 <div class="col-sm-5">
								   
								      <div id="userId" data-userid="${user.userid}" style="display:none"></div>
									  <div class="panel panel-default">
										<div class="panel-body" id="pnlUserProfile">
										  <p class="lead">${user.fullname}</p>
										  <p>${user.street}, ${user.state}, ${user.zipcode}</p>
										  <p>
										    <!--<div class="clearfix" id="pnlMap"></div>-->
											<img src="https://lh3.googleusercontent.com/uFp_tsTJboUY7kue5XAsGA=s28" width="28px" height="28px">
										  </p>
										</div>
									  </div>
									  
									  <div class="panel panel-default">
										<div class="panel-heading"><a href="http://maps.google.com" target="_blank" class="pull-right">Google Map</a> <h4>You are here</h4></div>
										  <div class="panel-body">
											<div id="googleMap" style="width:250px;height:250px;"></div>
										  </div>
									  </div>
									  
									  <div class="panel panel-default">
										<div class="panel-heading"><a href="http://openweathermap.org" target="_blank" class="pull-right">Weather</a> <h4>Local weather</h4></div>
										  <div class="panel-body">
											<!--<div class="clearfix" id="pnlWeather"></div>-->
											<iframe id="forecast_embed" type="text/html" frameborder="0" height="245" width="75%"
											src="http://forecast.io/embed/#lat=41.017057&lon=-91.967604&name=Fairfield, Iowa&color=#00aaff&font=Helvetica&units=us">
											</iframe>
										  </div>
									  </div>

								  </div>
								  
								  <!-- main col right -->
								  <div class="col-sm-7">
									    <div class="well"> 
										   <form class="form-horizontal" role="form">
										    <label><input type="radio" name="postType" value="passenger" /> Need a passenger(s) </label>
										    <label><input type="radio" name="postType" value="driver" /> Need a ride </label>
											<div class="form-group" style="padding:14px;">
											<textarea class="form-control" placeholder="Post your request here"></textarea>
											</div>
											<button class="btn btn-primary pull-right" type="button">Post</button><ul class="list-inline"><li><a href=""><i class="glyphicon glyphicon-upload"></i></a></li><li><a href=""><i class="glyphicon glyphicon-camera"></i></a></li><li><a href=""><i class="glyphicon glyphicon-map-marker"></i></a></li></ul>
										  </form>
									    </div>
									   
										<div class="well"> 
											<div id="postType" data-posttype="0" style="display:none"></div>
											<div class="input-group">
												<div id="radioBtn" class="btn-group">
													<a class="btn btn-primary btn-sm active" data-toggle="askingOffering" data-title="Y" id="btnOffer">OFFERING</a>
													<a class="btn btn-primary btn-sm notActive" data-toggle="askingOffering" data-title="N" id="btnAsk">ASKING</a>
												</div>
												<input type="hidden" name="askingOffering" id="askingOffering">
											</div>
										</div>

									  <div id="paggingPost" data-pagingno="0" style="display:none"></div>
									  <div id="lastDatePost" data-lastdatepost="${lastDatePost}" style="display:none"></div>
									  <div id="postList">
									   <c:forEach items="${posts}" var="post">
							               <div class="panel panel-default" id="post${post.postid}">
											 <div class="panel-heading">
											  <c:if test="${user.userid==post.user.userid}">
											    	<button id="btnDelPost" data-postid="${post.postid}" class="btn btn-xs btn-default pull-right">X</button>
						                      </c:if>
											  <strong>${post.user.username}</strong> ${post.datecreated}</div>
											  <div class="panel-body">
												${post.post}
												<p><a href="#">Like</a>&nbsp;&nbsp;<span class="glyphicon glyphicon-thumbs-up"> ${post.likes}</span></p>
												<div class="clearfix"></div>
												<hr>
												<c:forEach items="${post.comments}" var="comment">
												<p><span id="userID"><strong>${comment.user.username}</strong></span> ${comment.comment}</p>
												</c:forEach>
												<hr>
												<form>
												<div class="input-group">
												  <input type="text" class="form-control" placeholder="Add a comment..">
												  <div class="input-group-btn">
												  <button class="btn btn-default"><i class="glyphicon glyphicon-share"></i></button>
												  </div>
												</div>
												</form>
											  </div>
										   </div>
							           </c:forEach>
							          </div>
							          <div id="loader">
											LOADING...
									  </div>
								  </div>
							    </div><!--/row-->
							  		  
								<div class="row" id="footer">    
								  <div class="col-sm-6">
									
								  </div>
								  <div class="col-sm-6">
									<p>
									<a href="#" class="pull-right">Â©Copyright 2016</a>
									</p>
								  </div>
								</div>
							  <hr>
							  
							  <h4 class="text-center">
							  <a href="#" target="ext">MUM Car pooling template</a>
							  </h4>
							  <hr>
							  
							</div><!-- /col-9 -->
						</div><!-- /padding -->
					</div>
					<!-- /main -->
				</div>
			</div>
		</div>

		<!--post modal-->
		<div id="postModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
		  <div class="modal-dialog">
		  <div class="modal-content">
			  <div class="modal-header">
				  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">Ã</button>
					Post a request
			  </div>
			  <div class="modal-body">
				  <form class="form center-block">
					<div class="form-group">
					  &nbsp<label><input type="radio" name="postType" value="passenger" checked /> Need a passenger(s) </label>
				      <label><input type="radio" name="postType" value="driver" /> Need a ride </label>
					  <textarea class="form-control input-lg" autofocus="" placeholder="What do you want to post?"></textarea>
					</div>
				  </form>
			  </div>
			  <div class="modal-footer">
				  <div>
				  <button class="btn btn-primary btn-sm" data-dismiss="modal" aria-hidden="true">Post</button>
					<ul class="pull-left list-inline"><li><a href=""><i class="glyphicon glyphicon-upload"></i></a></li><li><a href=""><i class="glyphicon glyphicon-camera"></i></a></li><li><a href=""><i class="glyphicon glyphicon-map-marker"></i></a></li></ul>
				  </div>	
			  </div>
		  </div>
		  </div>
		</div>
		



		<!-- script references -->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
		<script src="http://maps.googleapis.com/maps/api/js"> </script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.5/ScrollMagic.min.js"></script>
		<script src="//cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.5/plugins/debug.addIndicators.min.js"></script>

		<script>
			function initialize() {
			  var mapProp = {
				center:new google.maps.LatLng(41.017057,-91.967604),
				zoom:15,
				mapTypeId:google.maps.MapTypeId.ROADMAP
			  };
			  var map=new google.maps.Map(document.getElementById("googleMap"), mapProp);
			}
			google.maps.event.addDomListener(window, 'load', initialize);
		</script>
		
		<script src="/carpool/resources/js/bootstrap.min.js"></script>
		<script src="/carpool/resources/js/jquery.noty.packaged.js"></script>
		<script src="/carpool/resources/js/scripts.js"></script>
	</body>
</html>