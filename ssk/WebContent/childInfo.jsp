<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.*" %>
<%@page import="model.dto.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>선택 아동 정보</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>

<%@ include file="header.jsp" %>
<body>
<%
	User selectedChild = (User)session.getAttribute("selectedChild"); 
	String genderKor = "";
	if(selectedChild.getUserGender().equals("male"))genderKor="남";
	else genderKor="여";
%>
<%@ include file="sidebar.jsp" %>
	<div class="header w3-row w3-container">
		<div class="w3-col" style="width:40%;border-bottom: 1.5px solid;">
		  <div style="display:inline-block;padding-right:5px;"><h2>아동 <b><%=selectedChild.getUserName()%></b>님 정보</h2></div>
		</div>
		<div class="w3-rest"></div>
	</div>
	<div class="w3-container w3-row">
		<div class="w3-container w3-half w3-row ">
			<div class="w3-card-4 w3-panel w3-light-grey w3-round-large w3-col l6 m8 w3-center" style="margin-top:3vh;">
				<div class="w3-container w3-center">
				  <h5><b>child</b></h5>
				  <img src="<%=selectedChild.getUserIcon()%>" alt="Avatar" style="width:80%">
				  <h2><%=selectedChild.getUserName()%></h2>
				</div>
			</div>
		</div>
		<div class="w3-container w3-half" style="margin-top:6vh;font-size:20px;font-weight:600;">
			<p>생년월일 : <%=selectedChild.getUserBirth() %></p>
			<p>성별 : <%=genderKor%></p>
		</div>
	</div>
	
</body>
</html>