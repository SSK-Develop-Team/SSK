<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model.dto.User" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dto.EsmReply" %>

<%
	User currUser = (User)session.getAttribute("currUser");
	String id = currUser.getUserLoginId();
	String name = currUser.getUserName();
	int userid = currUser.getUserId();
	
	boolean isTesting = false;
	session.setAttribute("isTesting", isTesting);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정서 반복 기록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
	h3{
		font-size : 25px;
	}
	#esmpart{
		background : #f1f1f1;
		display : flex;
		justify-content: center;
		align-items : center;
		padding-top : 60px;
		padding-bottom : 60px;
	}
	#testExplanation{
		font-size : 20px;
	}
	#btndiv{
		display : flex;
		flex-direction: column;
		justify-content : center;
		align-items : center;
		margin-top : 60px;
	}
	.btn{
			border : 1px solid #ff6666;
			background-color:#ff6666;
			padding : 10px;
			margin : 20px;
			color : white;
			height : 50px;
			width : 350px;
			font-size : 20px;
	}
	
	<%-- phone --%>
	@media (min-width:320px) and (max-width:500px){
	
		h3{
			font-size : 20px;
		}
		#esmpart{
			background : #f1f1f1;
			display : flex;
			justify-content: center;
			align-items : center;
			padding-top : 60px;
			padding-bottom : 60px;
		}
		#testExplanation{
			font-size : 15px;
		}
		#btndiv{
			display : flex;
			flex-direction: column;
			justify-content : center;
			align-items : center;
		margin-top : 40px;
		}
		.btn{
				border : 1px solid #ff6666;
				background-color:#ff6666;
				padding : 10px;
				margin : 20px;
				color : white;
				height : 50px;
				width : 100%;
				font-size : 15px;
		}
	}
</style>
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	<div class="w3-container w3-center">
		<h3 class="w3-padding-48">정서 반복 기록하기</h3>
		<div class="w3-center w3-padding-48 w3-pale-red">
			<div id="testExplanation">
				우리 아이 : <%=name %><br><br>
				<%=name %>(이)의 정서를 관찰할 시간입니다.<br>
				지금 이 시간, <%=name %>(이)의 정서를 정서 반복 기록에 기록해 주세요.<br>
				시간에 따른 자녀의 정서 변화를 시각화된 결과 프로파일로 확인할 수 있습니다. <br>
			</div>
		</div>
		
		<div id="btndiv">
			<button class="w3-btn w3-round-xlarge btn" id="addESMBtn" onClick="javascript:location.href='esmtestpositive.jsp'">기록하기</button>
			<button class="w3-btn w3-round-xlarge btn" id="getESMResultBtn">정서 반복 기록 조회하기(복구 예정)</button>
		</div>
	</div>	
</body>
</html>