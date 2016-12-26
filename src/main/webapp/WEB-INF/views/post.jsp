<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- BEGIN PROFILE CONTENT -->
<div class="profile-content">
	<div class="row">
		<div class="col-md-12">
			
			<div class="portlet light">
				<div class="portlet-title">
					<div class="form-body">
					<label class="control-label">Post content<span class="required">
					* </span>
					</label>
					    <!-- <div class="form-group">
							<div class="radio-list">
								<label class="radio-inline">
								<input type="radio" name="optionsRadios" id="optionsRadios4" value="option1" checked> Need a passenger(s)  </label>
								<label class="radio-inline">
								<input type="radio" name="optionsRadios" id="optionsRadios5" value="option2"> Need a ride </label>
							</div>
						</div> -->
						<textarea id="post_text" class="form-control" rows="8" placeholder="Post your request here"></textarea>
					</div>
					<button class="margin-top-20 btn btn-primary pull-right btnAddPost" type="button">Post</button>
		 
				</div>
		     </div>
			
	        <div id="paggingPost" data-pagingno="0" style="display:none"></div>
			<div id="lastDatePost" data-lastdatepost="${lastDatePost}" style="display:none"></div>
			<div class="post_container">
			<c:forEach items="${posts}" var="post">
				<div class="panel panel-default" id="post${post.postid}">
					<div class="panel-heading">
						<c:if test="${sessionScope.userid == post.user.userid }">
							<button  value="${post.postid}" type="button"
								class="btnDelPost btn btn-xs btn-default pull-right">X</button>
						</c:if>
						<strong>${post.user.username}</strong> ${post.datecreated}
					</div>
					<div class="panel-body">
						${post.post}
						<br/><br/>

							<c:if test="${post.isthisuserliked == false}">
								<a href="#" class="plike" 
								id="${post.postid}" >Like</a> 
							</c:if> 
							<c:if test="${post.isthisuserliked == true}">
								Liked 
							</c:if>
							<span> ${post.likes}</span>
						<div class="clearfix"></div>
						<hr>
						<div id="_${post.postid}_${sessionScope.userid}">
						<c:forEach items="${post.comments}" var="comment">
							<div style="border-bottom: 1px dotted #f2f2f2;padding-bottom: 5px;padding-top: 5px;">
								<strong>${comment.user.username}</strong>  | <span style="opacity: 0.5;">${comment.datecreated}</span><br/>
								${comment.comment}
							</div>
						</c:forEach>
						</div>
						<hr>
						<form>
							<div class="input-group">
								<input type="text" class="form-control" id="${post.postid}_${sessionScope.userid}" 
								placeholder="Add a comment..">
								<div class="input-group-btn">
									<button type="button" id="register-submit-btn"  name="${post.postid}" 
									class="btn green-haze uppercase btnAddCmnt">add</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</c:forEach>
			</div>
		</div>
	</div>
</div>
