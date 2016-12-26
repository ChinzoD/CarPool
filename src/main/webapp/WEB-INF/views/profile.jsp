<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp" %>
<%@taglib prefix="cmsg" uri="/WEB-INF/custom.tld" %>

			<div class="portlet light">
				<div class="portlet-title tabbable-line">
					<div class="caption caption-md">
						<i class="icon-globe theme-font hide"></i>
						<span class="caption-subject font-blue-madison bold uppercase">Profile Account</span>
					</div>
					<ul class="nav nav-tabs">
						<li  <c:if test="${profileChangeResult != null}"> class="active"</c:if> 
						<c:if test="${profileChangeResult == null && passChangeResult == null}"> class="active"</c:if>
						>
							<a href="#tab_1_1" data-toggle="tab">Personal Info</a>
						</li>
						<li <c:if test="${passChangeResult != null}"> class="active"</c:if>>
							<a href="#tab_1_3" data-toggle="tab">Change Password</a>
						</li>
					</ul>
				</div>
				<div class="portlet-body">
					<div class="tab-content">
						<!-- PERSONAL INFO TAB -->
						<div class="tab-pane 
							<c:if test="${profileChangeResult != null}"> active</c:if>
							<c:if test="${profileChangeResult == null && passChangeResult == null}"> active</c:if>
						" id="tab_1_1">
							 <cmsg:cMessage success="Successfully updated. From custom tag :)" 
						    error="From custom tag :)" 
						    state="${profileChangeResult}" display="${profileChangeResult}"/>
						    
							<form:form method="POST" class="form" action="profile?state=1"  modelAttribute="UserProfile">
								<div class="form-group">
									<form:label path="fullname" class="control-label">Full Name</form:label>
									<form:input path="fullname" name="fullname" type="text" value="${UserProfile.fullname}" class="form-control"/>
								</div>
								<div class="form-group">
								    <form:label path="" class="control-form:label">Gender</form:label>
									<form:select path="gender" name="gender" class="form-control">
										<option value="1" 
											<c:if test="${UserProfile.gender == 1}">selected</c:if>
										>Male</option>
										<option value="0"
											<c:if test="${UserProfile.gender == 0}">selected</c:if>
										>Female</option>
									</form:select>
								</div>
								<div class="form-group">
									<form:label path="state" class="control-form:label">State</form:label>
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
									<form:label path="city" class="control-form:label">City/Town</form:label>
									<form:input path="city" value="${UserProfile.city}" class="form-control placeholder-no-fix" type="text" placeholder="City/Town" name="city"/>
								</div>
								<div class="form-group">
									<form:label path="street" class="control-form:label">Street</form:label>
									<form:input path="street" value="${UserProfile.street}" class="form-control placeholder-no-fix" type="text" placeholder="Street" name="street"/>
								</div>
								<div class="form-group">
									<form:label path="zipcode" class="control-form:label">ZipCode</form:label>
									<form:input path="zipcode" value="${UserProfile.zipcode}" class="form-control placeholder-no-fix" type="text" placeholder="Zip Code" name="zipcode"/>
								</div>
								<div class="form-group">
									<form:label path="birthyear" class="control-form:label">Birth Year</form:label>
									<form:input path="birthyear"  value="${UserProfile.birthyear}" class="form-control placeholder-no-fix" id="birthyear" type="text" placeholder="Birth Year" name="birthyear"/>
									<span id="year-error" style="display:none;color:#a94442;">Only members with 18+ years old are allowed</span>
								</div>
								<div class="form-group">
									<form:label path="email" class="control-form:label">Email</form:label>
									<form:input path="email" value="${UserProfile.email}" class="form-control placeholder-no-fix" type="text" placeholder="Email" name="email"/>
								</div>	
								<div class="margiv-top-10">
								
									<button type="submit" id="register-submit-btn" class="btn green-haze uppercase pull-right">Save Changes</button>
									<a href="#" class="btn default">
									Cancel </a>
								</div>
							</form:form>
						</div>
						<!-- END PERSONAL INFO TAB -->
						<!-- CHANGE PASSWORD TAB -->
						<div class="tab-pane  
							<c:if test="${passChangeResult != null}"> active</c:if>
						" id="tab_1_3">

						    <cmsg:cMessage success="Successfully changed. From custom tag :)" 
						    error="Your password is wrong. From custom tag :)" 
						    state="${passChangeResult}" display="${passChangeResult}"/>
							
							<form:form method="POST" class="form" action="profile?state=2"  modelAttribute="PasswordHelper">
								<div class="form-group">
									<form:label path="currentPassword" class="control-label">Current Password</form:label>
									<form:input path="currentPassword" name="newPassword"  type="password" class="form-control"/>
								</div>
								<div class="form-group">
									<form:label path="newPassword" class="control-label">New Password</form:label>
									<form:input path="newPassword" name="newPassword" type="password" class="form-control"/>
								</div>
								<div class="form-group">
									<label class="control-label">Re-type New Password</label>
									<input type="password" class="form-control"/>
								</div>
								<div class="margin-top-10">
									<button type="submit" id="register-submit-btn" class="btn green-haze uppercase pull-right">Change Password</button>
									<a href="#" class="btn default">
									Cancel </a>
								</div>
							</form:form>
						</div>
						<!-- END CHANGE PASSWORD TAB -->
					</div>
				</div>
			</div>
