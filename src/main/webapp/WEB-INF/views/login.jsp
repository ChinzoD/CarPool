<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp" %>
<div class="content">
	<!-- BEGIN LOGIN FORM -->
	<c:url value="/j_spring_security_check" var="loginUrl"/>  
	<%-- <form:form method="POST" class="login-form" action="${loginUrl}" method="post"> --%>
	<form:form id="loginForm" method="post" action="login?state=1" modelAttribute="loginUser" class="login-form" >
		<h3 class="form-title">Sign In</h3>

		<div class="alert alert-danger 
			<c:if test="${message != 0 }">
				display-hide
			</c:if>
		">
			<button class="close" data-close="alert"></button>
			<span>
			Invalid credentials !! </span>
		</div>
		<div class="form-group">
			<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
			<form:label path="username" class="control-label visible-ie8 visible-ie9">Username</form:label>
			<form:input class="form-control form-control-solid placeholder-no-fix" type="text" autocomplete="off" placeholder="Username" id="username" name="username" path="username" />
		</div>
		<div class="form-group">
			<form:label path="password" class="control-label visible-ie8 visible-ie9">Password</form:label>
			<form:input class="form-control form-control-solid placeholder-no-fix" type="password" id="password" name="password" path="password" autocomplete="off" placeholder="Password" />
		</div>
		<div class="form-actions">
			<button type="submit" class="btn btn-success uppercase">Login</button>
		</div>
		<div class="create-account">
			<p>
				<a href="javascript:;" id="register-btn" class="uppercase">Create an account</a>
			</p>
		</div>
	</form:form>
	<!-- END LOGIN FORM -->
	<!-- BEGIN REGISTRATION FORM -->
	<form:form method="POST" class="register-form" action="login?state=2"  modelAttribute="loginUser">
		<h3>Sign Up</h3>
		<p class="hint">
			 Enter your personal details below:
		</p>
		<div class="form-group">
			<form:label path="fullname" class="control-label visible-ie8 visible-ie9">Full Name</form:label>
			<form:input path="fullname" class="form-control placeholder-no-fix" type="text" placeholder="Full Name" id="fullname" name="fullname" />
		</div>
		<div class="form-group">
		    <form:label path="gender" class="control-label visible-ie8 visible-ie9">Gender</form:label>
			<form:select path="gender" name="gender" class="form-control">
				<option value="1">Male</option>
				<option value="0">Female</option>
			</form:select>
		</div>
		<div class="form-group">
			<form:label path="state" class="control-label visible-ie8 visible-ie9">State</form:label>
			<form:select path="state" name="state" class="form-control">
			    <option value="">States</option> 
				<option value="AL">Alabama</option> 
				<option value="AK">Alaska</option> 
				<option value="AZ">Arizona</option> 
				<option value="AR">Arkansas</option> 
				<option value="CA">California</option> 
				<option value="CO">Colorado</option> 
				<option value="CT">Connecticut</option> 
				<option value="DE">Delaware</option> 
				<option value="DC">District Of Columbia</option> 
				<option value="FL">Florida</option> 
				<option value="GA">Georgia</option> 
				<option value="HI">Hawaii</option> 
				<option value="ID">Idaho</option> 
				<option value="IL">Illinois</option> 
				<option value="IN">Indiana</option> 
				<option value="IA">Iowa</option> 
				<option value="KS">Kansas</option> 
				<option value="KY">Kentucky</option> 
				<option value="LA">Louisiana</option> 
				<option value="ME">Maine</option> 
				<option value="MD">Maryland</option> 
				<option value="MA">Massachusetts</option> 
				<option value="MI">Michigan</option> 
				<option value="MN">Minnesota</option> 
				<option value="MS">Mississippi</option> 
				<option value="MO">Missouri</option> 
				<option value="MT">Montana</option> 
				<option value="NE">Nebraska</option> 
				<option value="NV">Nevada</option> 
				<option value="NH">New Hampshire</option> 
				<option value="NJ">New Jersey</option> 
				<option value="NM">New Mexico</option> 
				<option value="NY">New York</option> 
				<option value="NC">North Carolina</option> 
				<option value="ND">North Dakota</option> 
				<option value="OH">Ohio</option> 
				<option value="OK">Oklahoma</option> 
				<option value="OR">Oregon</option> 
				<option value="PA">Pennsylvania</option> 
				<option value="RI">Rhode Island</option> 
				<option value="SC">South Carolina</option> 
				<option value="SD">South Dakota</option> 
				<option value="TN">Tennessee</option> 
				<option value="TX">Texas</option> 
				<option value="UT">Utah</option> 
				<option value="VT">Vermont</option> 
				<option value="VA">Virginia</option> 
				<option value="WA">Washington</option> 
				<option value="WV">West Virginia</option> 
				<option value="WI">Wisconsin</option> 
				<option value="WY">Wyoming</option>
			</form:select>
		</div>
		<div class="form-group">
			<form:label path="city" class="control-label visible-ie8 visible-ie9">City/Town</form:label>
			<form:input path="city" class="form-control placeholder-no-fix" type="text" placeholder="City/Town" name="city"/>
		</div>
		<div class="form-group">
			<form:label path="street" class="control-label visible-ie8 visible-ie9">Street</form:label>
			<form:input path="street" class="form-control placeholder-no-fix" type="text" placeholder="Street" name="street"/>
		</div>
		<div class="form-group">
			<form:label path="zipcode" class="control-label visible-ie8 visible-ie9">ZipCode</form:label>
			<form:input path="zipcode" class="form-control placeholder-no-fix" type="text" placeholder="Zip Code" name="zipcode"/>
		</div>
		<div class="form-group">
			<form:label path="birthyear" class="control-label visible-ie8 visible-ie9">Birth Year</form:label>
			<form:input path="birthyear" class="form-control placeholder-no-fix" id="birthyear" type="text" placeholder="Birth Year" name="birthyear"/>
			<span id="year-error" style="display:none;color:#a94442;">Only members with 18+ years old are allowed</span>
		</div>
		<div class="form-group">
			<form:label path="email" class="control-label visible-ie8 visible-ie9">Email</form:label>
			<form:input path="email" class="form-control placeholder-no-fix" type="text" placeholder="Email" name="email"/>
		</div>
		
		<p class="hint">
			 Enter your account details below:
		</p>
		<div class="form-group">
			<form:label path="username" class="control-label visible-ie8 visible-ie9">Username</form:label>
			<form:input path="username" class="form-control placeholder-no-fix" type="text" autocomplete="off" placeholder="Username" name="username"/>
		</div>
		<div class="form-group">
			<form:label path="password" class="control-label visible-ie8 visible-ie9">Password</form:label>
			<form:input path="password" class="form-control placeholder-no-fix" id="register_password" type="password" autocomplete="off" placeholder="Password" name="password"/>
			<span id="pwd-error" style="display:none;color:#a94442;">At least 6 letters and have at least one capital letter, one small letter, one number</span>
		</div>
		<div class="form-group">
			<label class="control-label visible-ie8 visible-ie9">Re-type Your Password</label>
			<input class="form-control placeholder-no-fix" type="password" autocomplete="off" placeholder="Re-type Your Password" name="rpassword"/>
		</div>
		<div class="form-actions">
			<button type="button" id="register-back-btn" class="btn btn-default">Back</button>
			<button type="submit" id="register-submit-btn" class="btn btn-success uppercase pull-right">Submit</button>
		</div>
	</form:form>
	<!-- END REGISTRATION FORM -->
</div>