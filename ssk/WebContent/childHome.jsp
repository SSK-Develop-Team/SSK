<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<title>EWHA SSK WEB</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="css/childHome.css" type='text/css' >
<%
	User currUser = (User)session.getAttribute("currUser");
	
	ArrayList<LangReply> langResultList = (ArrayList<LangReply>)session.getAttribute("langResultList");
%>

<!-- 모달창 -->

</head>
<%@ include file="header.jsp" %>
<body>
	<%@ include file="sidebar.jsp" %>
	<div class = "container">
		<div class = "menuBox">
			<video id = "howToUse" src="#" poster = "./image/SSK.jpg" controls></video>
			<div class="testLine">언어</div>
			
			<div class = "langGroup">
				<table width = "70%">
					<tr>
						<td><button onClick="location.href='langtestmain.jsp'">언어 발달 평가</button></td>
					</tr>
				</table>
			</div>
			
			<div class="testLine">정서</div>
			
			<div class = "sdqGroup">
				<table width="70%">
					<tr>
						<%if(currUser!=null){ %><td><button onClick="javascript:location.href='sdqtestmain.jsp'">정서/행동 발달 검사</button></td>
						<%}else{ %><td><button onClick="alertLogin();">정서/행동 발달 검사</button></td><%} %>
					</tr>
					
					<tr>
						<%if(currUser!=null){ %><td><button onClick="javascript:location.href='esmtestmain.jsp'">정서 반복 기록</button></td>
						<%}else{ %><td><button onClick="alertLogin();">정서 반복 기록</button></td><%} %>
					</tr>
					
					<tr>
						<%if(currUser!=null){ %><td><button onClick="javascript:location.href='../EwhaSSK/GetEsmRecord';">정서 다이어리</button></td>
						<%}else{ %><td><button onClick="alertLogin();">정서 다이어리</button></td><%} %>
					</tr>
				</table>

			</div>
		</div>
	</div>
	
</body>
</html>