<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>

<%
	User currUser = (User)session.getAttribute("currUser");
	String id = currUser.getUserLoginId();
	String name = currUser.getUserName();
	//int role = currUser.getUserRole();

	session.setAttribute("currUser", currUser);

	boolean isTesting = false;
	session.setAttribute("isTesting", isTesting);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정서/행동 발달 검사</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
	h3{
		font-size : 25px;
	}
	#sdqpart{
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
		#sdqpart{
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
	
	<%-- tablet --%>
	@media (min-width:600px){
		
	}
	
</style>
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	<div class="w3-container w3-center">
	<h3 class="w3-padding-48">정서/행동 발달 검사하기</h3>
	<div class="w3-center w3-padding-48 w3-pale-red" >
			<div id="testExplanation">
			우리 아이 : <%=name %><br><br>
			본 검사는 자녀의 정서/행동 특성을 평가하는 검사입니다. <br>
			총 10문항에 대해 응답해 주시면 자녀의 정서/행동 상태를 확인할 수 있습니다. <br>
		</div>
	</div>
	<div id="btndiv">
		<button class="w3-btn w3-round-xlarge btn" id="addSDQBtn" onClick="javascript:location.href='sdqselectversion.jsp'">검사하기</button>
		<button class="w3-btn w3-round-xlarge btn" id="getSDQResultBtn" onClick="javascript:location.href='../EwhaSSK/GetSDQAnalysisSelected';">결과 프로파일 확인하기</button>
	</div>
	</div>	
</body>
</html>