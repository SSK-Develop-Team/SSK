<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.dto.LangQuestion"%>
<%@ page import="model.dto.User"%>

<%
	User currUser = (User) session.getAttribute("currUser");
	String currNumStr="";
	ArrayList<LangQuestion> currQuestionList = (ArrayList<LangQuestion>)session.getAttribute("currQuestionList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>언어 발달 평가</title>
<style>
.testBox {
	text-align: center;
	line-height: 100px;
}

.question {
	margin-left: 20px;
	margin-right: 20px;
}

.select {
	font-size: 15px;
}

.btn{
      border : 1px solid #1a2a3a;
      border-radius : 10px;
      background-color:#1a2a3a;
      padding : 10px;
      margin : 8px;
      color : white;
      height : 50px;
      width : 150px;
   }
   
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	<div class="container">
		<h3>언어 발달 평가</h3>
		<form method="post" action="DoLangTest" style="width:80%;margin-right:10%;margin-left:10%;">
		<% 
		for(int i=0; i < currQuestionList.size(); i++){
			if(currQuestionList.get(i).getLangQuestionId() < 10) currNumStr = "Q0" + currQuestionList.get(i).getLangQuestionId();
			else currNumStr = "Q" + currQuestionList.get(i).getLangQuestionId();
		%>
		<div class="w3-container w3-margin-top w3-margin-bottom">
			<div class="w3-container w3-padding-large">
				<div class="testNum"><b><%=currNumStr%></b></div>
				<div class="w3-container" style="background: #F4F4F4;">
					<div class="testBox"><%="우리 아이는 " + currQuestionList.get(i).getLangQuestionContent()%></div>
				</div>
			</div> 
			<div class="w3-row w3-margin">
				<div class="w3-col w3-padding-left w3-padding-right" style="width:20%;">
					<input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="0" checked="checked">
					<label>모르겠다</label>
				</div>
				<div class="w3-col w3-padding-left w3-padding-right" style="width:20%;">
					<input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="1"> 
					<label>못한다</label>
				</div>
				<div class="w3-col w3-padding-left w3-padding-right" style="width:20%;">
					<input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="2"> 
					<label>할 수 있다</label>
				</div>
				<div class="w3-col w3-padding-left w3-padding-right" style="width:20%;">
					<input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="3"> 
					<label>잘한다</label>
				</div>
				<div class="w3-col w3-padding-left w3-padding-right" style="width:20%;">
					<input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="4">
					<label>매우 잘한다</label>
				</div>
			</div>
		</div>
			<%} %>
			<p>
			<input type="button" class="btn" id="cancelLang" value="취소" onClick="location.href='../EwhaSSK/childHome.jsp'">
			<input type="submit" class="btn" id="submitLang" value="결과 제출">
		</form>
	</div>
	
</body>
</html>