<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model.dto.User" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dto.EsmResult" %>

<%
	User currUser = (User)session.getAttribute("currUser");
	String id = currUser.getUserLoginId();
	String name = currUser.getUserName();
	int userid = currUser.getUserId();
	int totalNumberOfEsmTest = currUser.getTotalNumberOfEsmTest();
	
	User focusUser = (User)session.getAttribute("selectedChild");
	String focusChildName = focusUser.getUserName();
	
	boolean isTesting = false;
	session.setAttribute("isTesting", isTesting);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정서 반복 기록</title>
<style>
	h3{
		display : flex;
		justify-content : center;
		align-items : center;
		padding : 5%;
		font-size : 25px;
	}
	#esmpart{
		width : 100%;
		height : 50%;
		background : #f1f1f1;
		display : flex;
		justify-content: center;
		align-items : center;
		padding-top : 60px;
		padding-bottom : 60px;
	}
	#explanation{
		font-size : 20px;
	}
	#btndiv{
		display : flex;
		flex-direction: column;
		justify-content : center;
		align-items : center;
		margin : 60px;
	}
	.btn{
			border : 1px solid #ff6666;
			border-radius : 10px;
			background-color:#ff6666;
			padding : 10px;
			margin : 20px;
			color : white;
			height : 50px;
			width : 350px;
			font-size : 20px;
	}
</style>
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	<h3>정서 반복 기록 기록하기</h3>
	
	<div id="esmpart">
		<div id="explanation">
			선택된 아동 이름 : <%=focusChildName %><br>
			<%=focusChildName %>의 정서 반복 기록 결과를 확인할 수 있습니다. <br>
			'그래프로 확인' 시 일별, 시간별 꺾은선 그래프로 확인할 수 있습니다. <br>
			'프로파일 확인' 시 모든 결과를 막대그래프로 확인할 수 있습니다. <br>
		</div>
	</div>
	
	<div id="btndiv">
		<button class="btn" id="getESMResultBtn" onClick="javascript:location.href='../EwhaSSK/GetESMResultsAllOfGraph'">그래프로 확인하기</button>
		<button class="btn" id="getESMProfileBtn" onClick="javascript:location.href='../EwhaSSK/GetESMResultsAll'">프로파일 확인하기</button>
	</div>
</body>
</html>