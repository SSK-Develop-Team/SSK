<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="java.util.*" %>

<%
	/* User currUser = (User)session.getAttribute("currUser");	
	session.setAttribute("currUser", currUser); */
	
%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>직접 평가 47번 문항</title>

<style>
	.gametext02{ display : none; }
	.gametext03{ display : none; }
	
	#leftbtn{
		display : none;
		margin-right : 3%;
	}
	
	#rightbtn{
		display : inline;
	}
	
	html, body {
		height : 90%;
	}
	
	.container { 
		height : 50%;
		width : 100%;
	}
	
	.imgbox {
		overflow : hidden;
		margin-left : 25%;
		margin-right : 2%;
		margin-bottom : 2%;
		width : 50%;
	}
	
	.textbox { 
		overflow : hidden;
		height : 20%; 
		width : 50%;
		margin-left : 25%;
		margin-right : 2%;
		margin-bottom : 0.2%;
		border : 1px solid #12192C;;
		border-radius : 2px;
		text-align : center;
		
	}
	
	.gamebtnbox {
		margin-left : 80%;
		height : 25%;
	}
	
	.buttonbox { 
		height : 10%; 
	}


	.gamebtn {
		color : #000;
		background-color : #fff;
		border : #fff;
		font-size : 100%;
		font-weight : bold;
	}
	
	.gametext {
		padding-left : 2%;
		padding-right : 2%;
		padding-top : 2%;
		height : 50%;
	}
	
	.btn{
		border : 1px solid #1a2a3a;
		border-radius : 10px;
		background-color:#1a2a3a;
		color : white;
		width : 13%;
		margin-left : 2%;
		padding : 1%;
	}
	
	span {
		margin-left : 5%;
		padding-top : 0.5%;
		padding-bottom : 1%;
		padding-left : 2%;
		padding-right : 2%;
		background-color:#1a2a3a;
		color : white;
	}

	#correctAnswer { display : none; }
	
	.modalContent {
		position: fixed;
		top: 30%;
		left: 25%;
		transform: translate(-50%, -50%);
		width:20%;
		margin:0 auto;
		padding:20px 10px;
		background:#fff;
		border:2px solid #666;
		text-align : center;
	}
	
	audio{width : 100%;}
	
	#closeBtn {
		float : right;
		margin-right : 3%;
		background-color : #fff;
		color : #000;
		border : #fff;
		font-weight : bold;
	}
	
	.modalLayer {
		display : none;
		position:fixed;
		top:0;
		left:0;
		width:100%;
		height:100%;
		background:rgba(0, 0, 0, 0.5);
	}
	
	.answerModal {
		display : none;
		width:100%;
		height:100%;
	}
	
	#answer{
		display : none;
	}
	
	.Quiz01 {
		display : inline;
		position : relative;
		width : 100%;
		height : 70%:
	}
	
	.Quiz02 {
		display : none;
		position : relative;
		width : 100%;
		height : 70%:
	}
	
	.Quiz03 {
		display : none;
		position : relative;
		width : 100%;
		height : 70%:
	}
	
	#chooseA1, #chooseB1, #chooseC1{
		position : absolute;
		left : 40%;
		width : 20%;
		margin-top : 10%;
		background-color : #ffffff;
		font-size : 100%;
		font-weight : bold;
	}	
	
	#chooseA2, #chooseB2, #chooseC2{
		position : absolute;
		left : 40%;
		width : 20%;
		margin-top : 20%;
		background-color : #ffffff;
		font-size : 100%;
		font-weight : bold;
	}
		
	#chooseA3, #chooseB3, #chooseC3{
		position : absolute;
		left : 40%;
		width : 20%;
		margin-top : 30%;
		background-color : #ffffff;
		font-size : 100%;
		font-weight : bold;
	}
	
	</style>
	
</head>
<body>
<%@ include file="sidebar.jsp" %>
<div class="container">

	<!-- 게임 이미지 -->
	<div class="imgbox">
		<div style="font-size:1em;font-weight:bold;">직접평가 #47</div>
		<div class="Quiz01">
			<img class="gameImg01" src="./image/LangGameImg/Age09/age09_2_1.png" width="100%" alt="마녀의 퀴즈 1"/>  
			<button class="w3-button w3-container w3-round-large" id="chooseA1" onclick='wrongA()' style="background-color:#ffffff; text-align:center;padding:10px;">2마리</button>	
			<button class="w3-button w3-container w3-round-large" id="chooseA2" onclick='correctA()' style="background-color:#ffffff; text-align:center;padding:10px;">2개</button>	
			<button class="w3-button w3-container w3-round-large" id="chooseA3" onclick='wrongA()' style="background-color:#ffffff; text-align:center;padding:10px;">2송이</button>	
		</div>
		
		<div class="Quiz02">
			<img class="gameImg02" src="./image/LangGameImg/Age09/age09_2_2.png" width="100%" alt="마녀의 퀴즈 2"/>  
			<button class="w3-button w3-container w3-round-large" id="chooseB1" onclick='wrongA()' style="background-color:#ffffff; text-align:center;padding:10px;">4덩이</button>
			<button class="w3-button w3-container w3-round-large" id="chooseB2" onclick='wrongA()' style="background-color:#ffffff; text-align:center;padding:10px;">4마리</button>
			<button class="w3-button w3-container w3-round-large" id="chooseB3" onclick='correctA()' style="background-color:#ffffff; text-align:center;padding:10px;">4송이</button>
		</div>
		
		<div class="Quiz03">
			<img class="gameImg03" src="./image/LangGameImg/Age09/age09_2_3.png" width="100%" alt="마녀의 퀴즈 3"/>  
			<button class="w3-button w3-container w3-round-large" id="chooseC1" onclick='correctA()' style="background-color:#ffffff; text-align:center;padding:10px;">3마리</button>
			<button class="w3-button w3-container w3-round-large" id="chooseC2" onclick='wrongA()' style="background-color:#ffffff; text-align:center;padding:10px;">3대</button>
			<button class="w3-button w3-container w3-round-large" id="chooseC3" onclick='wrongA()' style="background-color:#ffffff; text-align:center;padding:10px;">3송이</button>
		</div>

	</div>
	
	<!-- 게임 텍스트 (말풍선) -->
	<div class="w3-container w3-round-large" style="background-color:#12192C; color:white; width:100px;text-align:center;padding:2px; margin-left:25%;">마녀</div>
	<div class="textbox">
		<div class="gametext">
			<div class="gametext01">내가 보여주는 것을 보고, 숫자를 세는 알맞은 단위가 무엇인지 맞춰보렴!</div>
			<div class="gametext02">그럼 이건?</div>
			<div class="gametext03">그럼 이건?</div>
		</div>
		
			<!-- 게임 이동 버튼 -->
		<div class="gamebtnbox">
			<input type="button" class="gamebtn" id="leftbtn" value="< 이전" onClick='contentBack()'>
			<input type="button" class="gamebtn" id="rightbtn" value="다음 >" onclick='content()'>
		</div>
	</div>

<div class="btnbox">
	<button class="w3-button w3-container w3-round-large" id="answer" onclick='modalOpen()' style="background-color:#12192C; color:white; text-align:center;padding:3px; margin-left:25.4%;">정답 확인하기</button>	
</div>
</div>


<!--s 모달  -->
<div class="modalLayer"></div>
	<div class = "answerModal">
		<div class = "modalContent">
			<button id = "closeBtn" onClick="modalClose()">X</button>
			<p>2개, 4송이, 3마리</p>
		</div>
	</div>
	
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<script type="text/javascript">
	
	function modalOpen(){
		$(".answerModal").css('display', 'block');
		$(".modalLayer").css('display', 'block');
	} 
	
	function modalClose(){
		$(".answerModal").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}
	
	function wrongA(){
		var audio = new Audio('./audio/wrong.wav');
		audio.play();
	}
	
	function correctA(){
		var audio = new Audio('./audio/correct.mp3');
		audio.play();
	}
	var cnt = 0;
	
	//음성 재생
	window.onload = function () {
		var audio = new Audio('./audio/Age09/age_09_47_1.wav');
		audio.play();
	}
	
	if (performance.navigation.type == 1) {
		$("#rightbtn").css('display', 'inline');
	}
	

	function gameBtnFunc(audio){
		audio.play();
	}
	
	function content() {  
		  
		  cnt = cnt+1;
		  
		  if(cnt == 1){
			$(".Quiz01").css('display', 'none');
			$(".Quiz02").css('display', 'inline');
          	$(".gametext01").css('display', 'none');
      		$(".gametext02").css('display', 'inline');  
       	 	$("#leftbtn").css('display', 'inline');

      		var audio = new Audio('./audio/Age09/age_09_47_2.wav');
      		gameBtnFunc(audio);
          }
		  else if(cnt == 2){
			 	$(".Quiz02").css('display', 'none');
				$(".Quiz03").css('display', 'inline');
	          	$(".gametext02").css('display', 'none');
	      		$(".gametext03").css('display', 'inline'); 
	      		$("#leftbtn").css('display', 'inline');
	      		$("#answer").css('display', 'inline');
	      		var audio = new Audio('./audio/Age09/age_09_47_2.wav');
	      		gameBtnFunc(audio);
	       } 
          else if(cnt == 3){
      			if(!confirm("47번 문항의 게임을 종료하시겠습니까?")){return;}
        	  	location.href = './langTest.jsp';
          }
	}     
	
	function contentBack() {  
		  
		  cnt = cnt-1;
		  
		  if(cnt == 0){
			 	$(".Quiz01").css('display', 'inline');
				$(".Quiz02").css('display', 'none');
	          	$(".gametext01").css('display', 'inline');
	      		$(".gametext02").css('display', 'none');  
	       	 	$("#leftbtn").css('display', 'none');
	      		var audio = new Audio('./audio/Age09/age_09_47_1.wav');
	      		gameBtnFunc(audio);
	          }
			  else if(cnt == 1){
			  	$(".Quiz02").css('display', 'inline');
				$(".Quiz03").css('display', 'none');
	          	$(".gametext02").css('display', 'inline');
	      		$(".gametext03").css('display', 'none'); 
	      		$("#leftbtn").css('display', 'none');
	      		$("#answer").css('display', 'none');
	      		var audio = new Audio('./audio/Age09/age_09_47_2.wav');
	      		gameBtnFunc(audio);
	       	} 
	      		
		}
	
</script>

</body>
</html>