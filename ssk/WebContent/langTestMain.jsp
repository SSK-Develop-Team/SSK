<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>언어 발달 평가</title>
</head>
<body>
<%@ include file = "sidebar.jsp" %>
<% 
	User currUser = (User)session.getAttribute("currUser"); 
	String name = currUser.getUserName();
%>
<div>&nbsp;</div><div>&nbsp;</div>
<div style="width:100%;background-color:#D9D9D9;">
<div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div>
<div class="w3-center" style="font-weight:bold;font-size:30px;"> 언어 발달 평가 </div>
<div class="w3-display-container" style="width:100%;height:150px;">
<div class="w3-display-middle" style="text-align:center;"><%=name%>님, 현재 나이에 적합한 언어 발달 검사가 진행됩니다. <br>
			해당 언어 발달 검사가 아동에게 맞지 않는다면, 다른 나이대의 언어 발달 검사를 선택하여 진행해주세요.<br></div>
</div>
<div>&nbsp;</div><div>&nbsp;</div>
</div>
<div>&nbsp;</div><div>&nbsp;</div>
<div class="w3-row">
	<div class="w3-col s1 m3 l4">&nbsp;</div>
	<div class="w3-padding w3-col s10 m6 l4">
		<button class="w3-button w3-block w3-round-large w3-padding-16" style="background-color:#51459E;color:white;" onclick="location.href='GetLangTest'">검사하기</button>
		<div>&nbsp;</div>
		<button class="w3-button w3-block w3-round-large w3-padding-16" style="background-color:#51459E;color:white;" onclick="location.href='GetLangTestResult'">결과보기</button>
	</div>
	<div class="w3-col s1 m3 l4">&nbsp;</div>
</div>
</body>
</html>