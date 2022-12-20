<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="model.dto.User" %>
<%@ page import="model.dto.SdqTestLog" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dto.SdqReply" %>
<%@ page import="model.dto.*" %>
<%
	User currUser = (User)session.getAttribute("currUser");
	String id = currUser.getUserLoginId();
	String name = currUser.getUserName();
	int userid = currUser.getUserId();
	
	session.setAttribute("currUser", currUser);
	ArrayList<SdqTestLog> test_list = (ArrayList<SdqTestLog>)session.getAttribute("testlist");
	
	boolean isTesting = true;
	session.setAttribute("isTesting", isTesting);
%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>esm test expert version</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
	.btn{
		border : 1px solid #1a2a3a;
		border-radius : 10px;
		background-color:#1a2a3a;
		padding : 10px;
		margin : 20px;
		color : white;
		height : 50px;
		width : 200px;
	}
	#submitBtn{
		border : 1px solid #ff6666;
		border-radius : 10px;
		background-color:#ff6666;
		padding : 10px;
		margin : 20px;
		color : white;
		height : 50px;
		width : 200px;
	}
	#cancelBtn{
		border : 1px solid #ff6666;
		border-radius : 10px;
		background-color:white;
		padding : 10px;
		margin : 20px;
		color : #ff6666;
		height : 50px;
		width : 200px;
	}
	.chat{
		border:1px solid #ff6666;
		border-radius : 0px 10px 10px 10px;
		background-color : #ff6666;
		clear : both;
		float : left;
		padding :15px;
		margin : 5px;
		color : white;
		display : flex;
		text-align : center;
		justify-content : center;
		align-items : center;
	}
	.userReply{
		border:1px solid #ff6666;
		border-radius : 10px;
		background-color : white;
		width : 100%;
		height : 50px;
		vertical-align : middle;
		padding :15px;
		margin : 5px;
		color : #1a2a3a;
		display : flex;
		flex-direction : column;
		text-align : center;
		justify-content : center;
		align-items : center;
	}
	.userChat{
		border:1px solid #ff6666;
		border-radius : 10px 10px 0px 10px;
		background-color : white;
		clear : both;
		float : left;
		padding :15px;
		margin : 5px;
		color : #ff6666;
		display : flex;
		text-align : center;
		justify-content : center;
		align-items : center;
		float : right;
	}
	#chatSection{
		float : left;
		width : 50%;
	}
	#userArea{
		position : fixed;
		right : 0;
		width : 50%;
		height : 100%;
	}
	#userReply{
		position : absolute;
		left : 30%;
		top : 30%;
		width : 40%;
		justify-content: center;
		align-items: center;
	}
	#userReplyBtnGroup{
		margin : 0px auto;
		justify-content: center;
		align-items: center;
	}
	#SDQchatbot{
		width : 100%;
		padding-right : 20px;
		border-right-style : dashed;
		border-right-color : #ff6666;
	}
	.userReply:hover {
	  background: transparent;
	  color: #ff6666;
	   box-shadow:
	   -4px -4px 20px 0px #fff9,
	   -4px -4px 20px 0px #fff9,
	   4px 4px 20px 0px #0002,
	   4px 4px 20px 0px #0001;
	   font-weight : bold;
	}
</style>
<script>

	var social = 0; //사회지향행동
	var excessive = 0; //과잉행동
	var emotion = 0; //정서증상
	var behavior = 0; //품행문제
	var peer = 0; //또래문제
	
	var vlist = <%=test_list%>;

	console.log(vlist[0]);

	var testTime = 1;
	
	window.onload = function(){
		addChat(0);
	}
	
	function afterUserReply(testNum){
		
		setTimeout(addChat(testNum), 2000);
		
	}
	
	function addScore(score, replyStr, testNum){

		if(testTime >= 11){
			document.getElementById('never').disabled = true;
			document.getElementById('little').disabled = true;
			document.getElementById('yes').disabled = true;
			document.getElementById('very').disabled = true;
			testTime++;
			return;
		}
		else{
			console.log(score);
			document.getElementById('answer'+testNum).value = score;

			console.log("addScore testTime : " + testNum);
			userReply(replyStr, testNum);
			if(testNum < 3){
				social += score;
			}
			else if(testNum < 5){
				excessive += score;
			}
			else if(testNum < 7){
				emotion += score;
			}
			else if(testNum < 9){
				behavior += score;
			}
			else if(testNum < 11) {
				peer += score;
			}
			if(testTime == 10)
				finishTest('테스트가 끝났습니다. 결과를 제출해 주세요.');
			testTime++;
		}
		
	}
	function addChat(testNum){
		if(testTime >= 11){
			console.log("testTIME IS 11");
			return;
		}
		else{
			console.log("addChat");
			var div = document.createElement('div');
			div.className =  'chat'
			div.innerHTML = vlist[testNum];
			document.getElementById('SDQchatbot').appendChild(div);
			document.getElementById('never').disabled = false;
			document.getElementById('little').disabled = false;
			document.getElementById('yes').disabled = false;
			document.getElementById('very').disabled = false;
		}
		

	}
	function finishTest(str){
		var div = document.createElement('div');
		div.className = 'chat'
		div.innerHTML = str;
		document.getElementById('SDQchatbot').appendChild(div);
		document.getElementById('never').disabled = false;
		document.getElementById('little').disabled = false;
		document.getElementById('yes').disabled = false;
		document.getElementById('very').disabled = false;
		
		document.getElementById('never').style.display = 'none';
		document.getElementById('little').style.display = 'none';
		document.getElementById('yes').style.display = 'none';
		document.getElementById('very').style.display = 'none';
		
		document.getElementById('cancelBtn').style.display = 'block';
		document.getElementById('submitBtn').style.display = 'block';
		document.getElementById('result').style.display = 'block';
		document.getElementById('socialDiv').style.display = 'block';
		document.getElementById('excessiveDiv').style.display = 'block';
		document.getElementById('emotionDiv').style.display = 'block';
		document.getElementById('behaviorDiv').style.display = 'block';
		document.getElementById('peerDiv').style.display = 'block';

	}
	
	function addReply(replyStr){
		var userAnswer
	}
	
	function userReply(reply, testNum){
		if(testTime >= 11){
			return;
		}

		console.log("addChat");
		document.getElementById('never').disabled = true;
		document.getElementById('little').disabled = true;
		document.getElementById('yes').disabled = true;
		document.getElementById('very').disabled = true;
		
		var userAnswerChat = document.createElement('div');
		userAnswerChat.className = 'userChat';
		userAnswerChat.innerHTML = reply;
		document.getElementById('SDQchatbot').appendChild(userAnswerChat);
		
		if(testTime != 10)
			afterUserReply(testNum);
	}
	
	
	//scroll to chat bottom
	function scrollToBottom() {
		window.scrollTo({ top: document.getElementById('SDQchatbot').scrollHeight, behavior: 'smooth' });
	}
	
	setInterval(function() { scrollToBottom(); }, 100);
</script>
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	<h3>정서/행동 발달 검사하기(전문가용)</h3>
	<div id="chatSection">
	
		<div id="SDQchatbot" style="overflow : auto; float : left" >
		</div>
		
	</div>
	<div class="w3-container" id="userArea">
		<div class="w3-bottom" id="userReply">
			<div id="userReplyBtnGroup">
				<button id="never" class="userReply" onclick="addScore(0, '전혀 아니다', testTime);">전혀 아니다</button>
				<button id="little" class="userReply" onclick="addScore(1, '조금 그렇다', testTime);">조금 그렇다</button>
				<button id="yes" class="userReply" onclick="addScore(2, '그렇다', testTime);">그렇다</button>
				<button id="very" class="userReply" onclick="addScore(3, '매우 그렇다', testTime);">매우 그렇다</button>
				
				<form action = "doSDQTest" method="POST">
					<input type="hidden" name="answer1" id="answer1">
					<input type="hidden" name="answer2" id="answer2">
					<input type="hidden" name="answer3" id="answer3">
					<input type="hidden" name="answer4" id="answer4">
					<input type="hidden" name="answer5" id="answer5">
					<input type="hidden" name="answer6" id="answer6">
					<input type="hidden" name="answer7" id="answer7">
					<input type="hidden" name="answer8" id="answer8">
					<input type="hidden" name="answer9" id="answer9">
					<input type="hidden" name="answer10" id="answer10">
					
					<button id="submitBtn" class="btn" onclick="submitTestResult();" style="display:none;">제출하기</button>
					<button id="cancelBtn" class="btn" onclick="this.form.onsubmit=function() { history.back(); location.href='sdqtestmain.jsp'; return false; }" style="display:none;">돌아가기</button>
				</form>
					
				
			</div>
		</div>
	</div>
</body>
</html>