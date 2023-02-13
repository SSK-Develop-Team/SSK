<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="model.dto.SdqQuestion" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>정서 행동 발달 검사</title>
<style>
.sdqAnswerBtn{
	width:19%;
	margin-right:0.2em;
	border:1px solid #ff6666;
	border-radius : 10px;
	background-color:white;
	color : #ff6666;
	height:50px;
	font-size:0.8em;
	align-items:center;
	text-align:center;
}

.sdqPreviousBtn{
	width:19%;
	margin-right:0.2em;
	border:1px solid #ff6666;
	border-radius : 10px;
	background-color:#ff6666;
	color : white;
	height:50px;
	font-size:0.8em;
	align-items:center;
	text-align:center;
}
#sdqSubmitBtn{
	border:1px solid #ff6666;
	border-radius : 10px;
	background-color:#ff6666;
	color : white;
	height:50px;
	font-size:1em;
	align-items:center;
	text-align:center;
	display:none;
}
#sdqChat::-webkit-scrollbar {
  width: 5px;
}
#sdqChat::-webkit-scrollbar-track {
  background-color: transparent;
}
#sdqChat::-webkit-scrollbar-thumb {
  border-radius: 5px;
  background-color: grey;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
var cursor = 0;
window.onload = function(){
	addQuestionChat();
}
function addQuestionChat(){
	document.getElementById("sdqQuestion"+cursor).style.display = "flex";
	ableBtn();
	scrollSmoothToBottom("sdqChat");
}
function addAnswerChat(answerStr, answerNum){
	disableBtn();
	var answerDiv = document.getElementById("sdqAnswer"+cursor);
	answerDiv.innerHTML = answerStr;
	answerDiv.style.display = "flex";
	
	var answerInput = document.getElementById("sdqInput"+cursor);
	answerInput.value = answerNum;
	scrollSmoothToBottom("sdqChat");
	
	if(cursor==9){
		document.getElementById("sdqSubmitBtn").style.display = "inline-block";
	}else{
		cursor=cursor+1;
		setTimeout(() => addQuestionChat(), 600);
	}
}

function backAnswerChat(){
	if(cursor>=9){
		document.getElementById("sdqAnswer"+cursor).style.display = "none";
		document.getElementById("sdqSubmitBtn").style.display = "none";
	}else if(cursor>0){
		document.getElementById("sdqQuestion"+cursor).style.display = "none";
		cursor = cursor-1;
		document.getElementById("sdqAnswer"+cursor).style.display = "none";
	}
	ableBtn();
	scrollSmoothToBottom("sdqChat");
}

function scrollSmoothToBottom (id) {
   var div = document.getElementById(id);
   $('#' + id).animate({
      scrollTop: div.scrollHeight - div.clientHeight
   }, 500);
}
function disableBtn(){
	const buttons = document.getElementsByClassName("sdqAnswerBtn");
	for (var i = 0; i < buttons.length; i++) {
	  buttons[i].disabled=true;
	}
}

function ableBtn(){
	const buttons = document.getElementsByClassName("sdqAnswerBtn");
	for (var i = 0; i < buttons.length; i++) {
	  buttons[i].disabled=false;
	}
}

</script>
</head>
<body>
<%@ include file = "sidebar.jsp" %>
<%
	ArrayList<SdqQuestion> sdqQuestionList = (ArrayList<SdqQuestion>)session.getAttribute("sdqQuestionList");
%>
	<div class="w3-container w3-center"><h4><b>정서/행동 발달 검사</b></h4></div>
	
	<div class="w3-row" >
		<div class="w3-col m2 l2">&nbsp;</div>
		<div class="w3-col s12 m8 l8" id="sdqChat" style="overflow:auto; height:55vh; background-color:#ededed;padding-bottom:6px;padding-top:6px;">
			<form id="sdqForm" method="post" action="DoSdqTest">
			<%for(int i=0;i<sdqQuestionList.size();i++){ %>
				<div class="w3-margin w3-padding " id="sdqQuestion<%=i%>" style="border:1px solid #ff6666;border-radius : 0px 10px 10px 10px;clear:both;float:left;background-color:#ff6666;color : white;height:50px;font-size:1em;display:none;align-items : center;"><%=sdqQuestionList.get(i).getSdqQuestionContent() %></div>
				<div class="w3-margin w3-padding" id="sdqAnswer<%=i%>" style="border:1px solid #ff6666;border-radius : 10px 10px 0px 10px;clear:both;float:right;background-color:white;color : #ff6666;height:50px;font-size:1em;display:none;align-items:center;">아니다</div>
				<input type="hidden" id="sdqInput<%=i%>" name="sdqInput<%=i%>" value="0"/>
			<%} %>
			</form>
		</div>
		<div class="w3-col m2 l2">&nbsp;</div>
	</div>
	<div class="w3-row w3-margin">
		<div class="w3-col m2 l2 w3-hide-small">&nbsp;</div>
		<div class="w3-col w3-row s12 m8 l8">
			<button class="w3-button w3-col sdqAnswerBtn w3-center" style="padding:0px;" onclick="addAnswerChat('매우 그렇다', 4)">매우 그렇다</button>
			<button class="w3-button w3-col sdqAnswerBtn" style="padding:0px;" onclick="addAnswerChat('그렇다', 3)">그렇다</button>
			<button class="w3-button w3-col sdqAnswerBtn" style="padding:0px;" onclick="addAnswerChat('조금 그렇다', 2)">조금 그렇다</button>
			<button class="w3-button w3-col sdqAnswerBtn" style="padding:0px;" onclick="addAnswerChat('전혀 아니다', 1)">전혀 아니다</button>
			<button class="w3-button w3-col sdqPreviousBtn" style="padding:0px;" onclick="backAnswerChat()">되돌리기</button>
		</div>
		<div class="w3-col m2 l2 w3-hide-small">&nbsp;</div>
	</div>
	<div class="w3-row w3-margin">
		<div class="w3-col m2 l2 w3-hide-small">&nbsp;</div>
		<div class="w3-col w3-row s12 m8 l8">
			<button class="w3-button w3-col w3-padding" id="sdqSubmitBtn" onclick="document.getElementById('sdqForm').submit();">제출하기</button>
		</div>
		<div class="w3-col m2 l2 w3-hide-small">&nbsp;</div>
	</div>
</body>
</html>