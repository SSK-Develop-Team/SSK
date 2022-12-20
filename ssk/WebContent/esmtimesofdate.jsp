<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="model.dto.User" %>
<%@ page import="java.util.ArrayList" %>
<%
	User focusUser = new User();
	if((User)session.getAttribute("selectedChild")!=null) {
		focusUser = (User)session.getAttribute("selectedChild");
	}else {
		focusUser = (User)session.getAttribute("currUser");
	}
	String id = focusUser.getUserLoginId();
	String name = focusUser.getUserName();
	int userid = focusUser.getUserId();
	int totalNumberOfEsmTest = focusUser.getTotalNumberOfEsmTest();
	String date = request.getParameter("date");
	System.out.println("date: " + date);
	
	ArrayList<String> times = (ArrayList<String>)request.getAttribute("times");
%>
<!DOCTYPE html>
<html>
<head>
<style>
	.dates{
		border : 1px solid #ff6666;
		border-radius : 10px;
		background-color:#ff6666;
		padding : 10px;
		margin : 20px;
		color : white;
		height : 80px;
		width : 200px;
	}
</style>
<meta charset="UTF-8">
<title>esm result of <%=date %></title>
</head>

<body>
	<%@ include file="sidebar.jsp"%>

	<h3>ESM 결과 프로파일</h3>
	<div id="sdqDates">
		<% for(int i = 0; i < times.size(); i++){ %>
			<button class="dates" onclick="javascript:location.href='../EwhaSSK/getESMResultSelected?time=<%=times.get(i)%>'"><%=times.get(i) %></button>
		<%} %>
	</div>

</body>
</html>