<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>

<%
	User currUser = (User)session.getAttribute("currUser");
	String id = currUser.getUserLoginId();
	String name = currUser.getUserName();
	boolean isTesting = true;
	session.setAttribute("isTesting", isTesting);
	session.setAttribute("currUser", currUser);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정서/행동 발달 검사</title>
<style>
	html, body{
		height : 100%;
	}
	#versionBtnGroup{
		display : flex;
		justify-content : center;
		align-items : center;
		height : 100%;
	}
	#versionBtnGroup button{
		border : 1px solid #ff6666;
		border-radius : 10px;
		background-color:#ff6666;
		padding : 10px;
		margin : 40px;
		color : white;
		height : 250px;
		width : 250px;
		font-size : 20px;
	}
</style>
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	<div id="versionBtnGroup">
		<button class="w3-container w3-half" onClick="javascript:location.href='../EwhaSSK/GetTestList'">부모용 검사</button>
		<button class="w3-container w3-half" onClick="javascript:location.href='sdqtestchild.jsp'">아동용 검사</button>
	</div>	
	
</body>
</html>