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
<title>직접 평가 7번 문항</title>

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
		height : 80%;
		width : 100%;
	}
	
	.imgbox {
		overflow : hidden;
		height : 60%; 
		margin-left : 25%;
		margin-right : 2%;
		margin-bottom : 2%;
		width : 70%;
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
	.gameModal {
		display : none;
		width:100%;
		height:100%;
	}
	
	.appleModal01 { display : none ;}
	.appleModal02 { display : none ;}
	.appleModal03 { display : none ;}
	.appleModal04 { display : none ;}
	
	.setReplyModal {
		display : none;
		width:100%;
		height:100%;
	}
	
	#answer{
		display : none;
	}
	
	.homeBack {
		display : none;
		height : 100%;
		width : 70%;
		position : relative;
	}

	.gameImg02{
		position : absolute;
		left : 0;
		top : 0;
	} 
	
	.numImg01{
		position : absolute;
		left : 47%;
		top : 52%;
	}
	.numImg02{
		position : absolute;
		left : 37%;
		top : 76%;
	}
	.numImg03{
		position : absolute;
		left : 83%;
		top : 10%;
	}
	.numImg04{
		position : absolute;
		left : 70%;
		top : 50%;
	}

	.modalBack{
		background-image : url('./image/age3_house.PNG');
		background-size : 100%;
		background-repeat : no-repeat;
	}
	
	</style>
	
</head>
<body>
<%@ include file="sidebar.jsp" %>
<h3>직접 평가 #07</h3>
<div class="container">

	<!-- 게임 이미지 -->
	<div class="imgbox">
		<img class="gameImg01" src="./image/minsu04.png" height="100%" alt="민수가 궁금해하고 있는 그림"/>
		<div class="homeBack">
			<img class="gameImg02" src="./image/age3_house.png" width="100%" height="100%" alt="거실 그림, 오른쪽 쇼파에는 엄마, 아빠, 여자아이가 앉아 있고 왼쪽 바닥에는 바나나, 오른쪽에는 책장이 있으며 그 맨 위에는 포도가 있다."/>
			<img class="numImg01" src="./image/age3_num1.png" height="6%" alt="1번 버튼" onClick="appleModal01Open()" />
			<img class="numImg02" src="./image/age3_num2.png" height="6%" alt="2번 버튼" onClick="appleModal02Open()"/>
			<img class="numImg03" src="./image/age3_num3.png" height="6%" alt="3번 버튼" onClick="appleModal03Open()"/>
			<img class="numImg04" src="./image/age3_num4.png" height="6%" alt="4번 버튼" onClick="appleModal04Open()"/>
		</div>
		<img class="gameImg03" src="./image/minsu03.png" height="100%" alt="민수가 신나서 만세하고 있는 그림"/>
		<img class="gameImg04" src="./image/age3_apple_01.png" height="30%" alt="사과"/>
	</div>
	
	<!-- 게임 텍스트 (말풍선) -->
	<div class="w3-container w3-round-large" style="background-color:#12192C; color:white; width:100px;text-align:center;padding:2px; margin-left:25%;">민수</div>
	<div class="textbox">
		<div class="gametext">
			<div class="gametext01">친구의 이모집에 떨어져 있을지 몰라</div>
			<div class="gametext02">숫자를 눌러 사과를 찾아볼까요?</div>
			<div class="gametext03">와 하나 찾았다!</div>
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


<!-- 힌트 모달  -->
<div class="modalLayer"></div>
	<div class = "answerModal">
		<div class = "modalContent">
			<button id = "closeBtn" onClick="modalClose()">X</button>
			<p>엄마, 바나나, 포도, 아빠</p>
			<audio controls src="./audio/lang01_7.m4a"></audio>
		</div>
	</div>
	
	<!-- 사과 찾기 -->
	<div class = "appleModal01">
		<div class = "modalContent">
			<button id = "closeBtn" onClick="appleModal01Close()">X</button>
			<p>잘 듣고 따라해보세요, "엄마"</p>
			<audio controls src="./audio/Age09/age_01_7_3.wav"></audio>
		</div>
	</div>
	
	<div class = "appleModal02">
		<div class = "modalContent">
			<button id = "closeBtn" onClick="appleModal02Close()">X</button>
			<p>잘 듣고 따라해보세요, "바나나"</p>
			<audio controls src="./audio/Age09/age_01_7_5.wav"></audio>
		</div>
	</div>
	
	<div class = "appleModal03">
		<div class = "modalContent">
			<button id = "closeBtn" onClick="appleModal03Close()">X</button>
			<p>잘 듣고 따라해보세요, "포도"</p>
			<audio controls src="./audio/Age09/age_01_7_6_1.wav"></audio>
		</div>
	</div>
	
	<div class = "appleModal04">
		<div class = "modalContent">
			<button id = "closeBtn" onClick="appleModal04Close()">X</button>
			<p>잘 듣고 따라해보세요, "아빠"</p>
			<audio controls src="./audio/Age09/age_01_7_7.wav"></audio>
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
	
	//사과 찾기
	function appleModal01Open(){
		$(".appleModal01").css('display', 'block');
		$(".modalLayer").css('display', 'block');
	} 
	
	function appleModal01Close(){
		$(".appleModal01").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}
	function appleModal02Open(){
		$(".appleModal02").css('display', 'block');
		$(".modalLayer").css('display', 'block');
	} 
	
	function appleModal02Close(){
		$(".appleModal02").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}
	function appleModal03Open(){
		$(".appleModal03").css('display', 'block');
		$(".modalLayer").css('display', 'block');
	} 
	
	function appleModal03Close(){
		$(".appleModal03").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}
	function appleModal04Open(){
		$(".appleModal04").css('display', 'block');
		$(".modalLayer").css('display', 'block');
	} 
	
	function appleModal04Close(){
		$(".appleModal04").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}
	
	
	var cnt = 0;
	
	//음성 재생
	window.onload = function () {
		var audio = new Audio('./audio/Age09/age_01_7_1.wav');
		audio.play();
	}
	
	if (performance.navigation.type == 1) {
		$("#rightbtn").css('display', 'inline');
	}
	

	function gameBtnFunc(audio){
		audio.play();
	}
	
	function gameBtnHide(){
		$("#rightbtn").css('display', 'none');
		$("#leftbtn").css('display', 'none');
	}
	
	function content() {  
		  
		  cnt = cnt+1;
		  
		  if(cnt == 1){
			$("#minsu").css('display', 'none'); 
			$(".gameImg01").css('display', 'none');
			$(".homeBack").css('display', 'block');			
          	$(".gametext01").css('display', 'none');
      		$(".gametext02").css('display', 'inline');  
      		$("#answer").css('display', 'inline');
       	 	$("#leftbtn").css('display', 'inline');

      		var audio = new Audio('./audio/Age09/age_01_7_2.wav');
      		gameBtnFunc(audio);
          }
		  else if(cnt == 2){
				$("#minsu").css('display', 'inline'); 
	          	$(".gametext02").css('display', 'none');
	      		$(".gametext03").css('display', 'inline'); 
	      		$(".homeBack").css('display', 'none');
	      		$(".gameImg03").css('display', 'inline');
	      		$(".gameImg04").css('display', 'inline');
	      		$("#leftbtn").css('display', 'inline');
	      		$("#answer").css('display', 'none');
	      		var audio = new Audio('./audio/Age09/age_01_7_8.wav');
	      		gameBtnFunc(audio);
	       } 
          else if(cnt == 3){
      			if(!confirm("7번 문항의 게임을 종료하시겠습니까?")){return;}
        	  	location.href = './langTest.jsp';
          }
	}     
	
	function contentBack() {  
		  
		  cnt = cnt-1;
		  
		  if(cnt == 0){
				$("#minsu").css('display', 'inline'); 
				$(".gameImg01").css('display', 'inline');
				$(".homeBack").css('display', 'none');			
	          	$(".gametext01").css('display', 'inline');
	      		$(".gametext02").css('display', 'none'); 
          		$("#answer").css('display', 'none');
	      		var audio = new Audio('./audio/Age09/age_01_7_1.wav');
	      		gameBtnFunc(audio);
	          }
			  else if(cnt == 1){
				$("#minsu").css('display', 'none'); 
	          	$(".gametext02").css('display', 'inline');
	      		$(".gametext03").css('display', 'none'); 
	      		$(".homeBack").css('display', 'block');
	      		$(".gameImg03").css('display', 'none');
	      		$(".gameImg04").css('display', 'none');
	      		$("#leftbtn").css('display', 'inline');
	      		$("#answer").css('display', 'inline');
	      		var audio = new Audio('./audio/Age09/age_01_7_2.wav');
	      		gameBtnFunc(audio);
	       	} 
	      		
		}
	
</script>

</body>
</html>