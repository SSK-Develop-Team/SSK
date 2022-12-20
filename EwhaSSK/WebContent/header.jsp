<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<div class="header">
		<div class="w3-bar w3-xlarge">
			<c:set var="user" scope="page" value="${sessionScope.currUser }" />
	  		<c:choose>
	  			<c:when test="${user eq null }">
		  			<button class="w3-bar-item w3-button w3-text-white w3-hover-text-black w3-padding-right w3-right w3-round-xlarge" style="background-color:#1A2A3A;font-size:1.2rem;margin-right:30px;" onclick="location.href='registerExpert.jsp';">회원 가입</button>
					<button class="w3-bar-item w3-button w3-text-white w3-hover-text-black w3-padding-right w3-right w3-round-xlarge" style="background-color:#1A2A3A;font-size:1.2rem;margin-right:20px;" onclick="location.href='login.jsp';">로그인</button>				
				</c:when>
				<c:when test="${user.userRole eq 'CHILD'}">
		  			<form id="f" name = "post" action = "logout">
			  			<button class="w3-bar-item w3-button w3-text-white w3-hover-text-black w3-padding-right w3-right w3-round-xlarge" style="background-color:#1A2A3A;font-size:1.2rem;margin-right:30px;" href="javascript:void(0);" onclick="doLogout();">로그아웃</button>
		  				<a class="w3-bar-item w3-button w3-hover-none w3-text-black w3-hover-text-blue w3-padding-right w3-right w3-margin-right"style="font-size:1.5rem;" onclick="location.href='../EwhaSSK/childHome.jsp'">${user.userName}&nbsp;님</a>				
		  			</form>				
				</c:when>
				<c:when test="${user.userRole eq 'EXPERT'}">
		  			<form id="f" name = "post" action = "logout">
			  			<button class="w3-bar-item w3-button w3-text-white w3-hover-text-black w3-padding-right w3-right w3-round-xlarge" style="background-color:#1A2A3A;font-size:1.2rem;margin-right:30px;" href="javascript:void(0);" onclick="doLogout();">로그아웃</button>
		  				<a class="w3-bar-item w3-button w3-hover-none w3-text-black w3-hover-text-blue w3-padding-right w3-right w3-margin-right"style="font-size:1.5rem;" onclick="location.href='../EwhaSSK/GetExpertHome'">${user.userName}&nbsp;님</a>				
		  			</form>				
				</c:when>
	  			<c:otherwise>
		  			<form id="f" name = "post" action = "logout">
			  			<button class="w3-bar-item w3-button w3-text-white w3-hover-text-black w3-padding-right w3-right w3-round-xlarge" style="background-color:#1A2A3A;font-size:1.2rem;margin-right:30px;" href="javascript:void(0);" onclick="doLogout();">로그아웃</button>
		  				<a class="w3-bar-item w3-button w3-hover-none w3-text-black w3-hover-text-blue w3-padding-right w3-right w3-margin-right"style="font-size:1.5rem;" onclick="location.href='../EwhaSSK/GetSuperExpertHome'">${user.userName}&nbsp;님</a>				
		  			</form>
	  			</c:otherwise>
	  		</c:choose>
	  		<c:remove var="userId" scope="page" />
		</div>
	</div>
	<script type="text/javascript" src="js/logout.js" charset="UTF-8"></script>
</body>
</html>