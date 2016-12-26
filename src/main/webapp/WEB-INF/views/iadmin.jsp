<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Нэвтрэх хэсэг</title>
</head>
<body>
	<div  id="login_container">
		
	    <div id="login" class="section">
        	<h2>Нэвтрэх хэсэг</h2>
        	<c:url value="/j_spring_security_check" var="loginUrl"/>    	
			<form action="${loginUrl}" method="post">
				<label><strong>Хэрэглэгчийн нэр</strong></label><input type="text" name="j_username" id="j_username"  size="28" class="input"/>
				<br />
				<label><strong>Нууц үг</strong></label><input type="password" name="j_password" id="j_password"  size="28" class="input"/>
				<br />
				<input class="loginbutton" type="submit" class="submit" value="Нэвтрэх" />
				<br />
		  </form>
	    </div>
	</div>
</body>
</html>