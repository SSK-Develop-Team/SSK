<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="java.util.*" %>

<%
	User currUser = (User)session.getAttribute("currUser");	
	session.setAttribute("currUser", currUser);
	
%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<meta charset="UTF-8">
<title>직접 평가 6번 문항</title>

<style>
	.gametext02{ display : none; }
	.gametext03{ display : none; }
	.gametext04{ display : none; }
	.gametext05{ display : none; }
	.gametext06{ display : none; }
	.gametext07{ display : none; }
	.gametext08{ display : none; }
	.gametext09{ display : none; }
	
	
	#leftbtn{
		display : none;
		margin-right : 3%;
	}
	
	#rightbtn{
		display : none;
	}
	
	html, body {
		height : 100%;
	}
	
	.container { 
		height : 80%;
		width : 50%;
	}
	
	.imgbox {
		overflow : hidden;
		height : 40%; 
		margin-left : 2%;
		margin-right : 2%;
		margin-bottom : 2%;
		width : 100%;
	}
	
	.textbox { 
		overflow : hidden;
		height : 20%; 
		margin-left : 2%;
		margin-right : 2%;
		margin-bottom : 2%;
		border : 3px solid #1a2a3a;
		border-radius : 5px;
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

	#hint { display : none; }
	#correctAnswer { display : none; }
	#reply { display : none; }
	
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
	
	.setReplyModal {
		display : none;
		width:100%;
		height:100%;
	}
	
	.replybtn{
		background: rgba(0, 0, 0, 0);
		border: rgba(0, 0, 0, 0);
		width : 30%;
	}
	#Obtn { margin-right : 5%; }
	
	#mina { display : none; }
	#minsu { display : none; }
	
	</style>
	
</head>
<body>
<%@ include file="sidebar.jsp" %>
<h3>직접 평가 #06</h3>
<div class="container">

	<!-- 게임 이미지 -->
	<div class="imgbox">
		<img class="gameImg01" src="./image/minsu01.png" height="100%" alt="민수가 손을 들고 있는 그림"/>
		<img class="gameImg02" src="./image/mina01.png" height="100%" alt="미나가 손을 들고 있는 그림"/>
		<img class="gameImg03" src="./image/age3_crygirl.png" height="100%" alt="여자아이가 울고 있는 그림"/>
	</div>
	
	<!-- 게임 텍스트 (말풍선) -->
	<span id = "mina">미나</span>
	<span id = "minsu">민수</span>
	<span id = "friend">친구</span>
	<div class="textbox">
		<div class="gametext">
			<div class="gametext01">으아앙...</div>
			<div class="gametext02">너 왜 여기서 울고 있어?</div>
			<div class="gametext03">무슨 일이야?</div>
			<div class="gametext04">몽땅 잃어버렸어... 집에 가져가야 하는데!</div>
			<div class="gametext05">우리 친구를 도와줄까?</div>
			<div class="gametext06">그래 도와주자!</div>
			<div class="gametext07">찾기 위해 우리가 알아야 하는 것이 있어!</div>
			<div class="gametext08">무엇을 잃어버렸는지 물어봐요.</div>
			<div class="gametext09">사과를 잃어버렸어...</div>

		</div>
		
			<!-- 게임 이동 버튼 -->
		<div class="gamebtnbox">
			<input type="button" class="gamebtn" id="leftbtn" value="< 이전" onClick='contentBack()'>
			<input type="button" class="gamebtn" id="rightbtn" value="다음 >" onclick='content()'>
		</div>
	</div>

<div class="btnbox">
	<input type="button" class="btn" id="hint" value="힌트" onClick='hintSound()'>
	<input type="button" class="btn" id="correctAnswer" value="정답 확인" onClick='modalOpen()'>
	<input type="button" class="btn" id="reply" value="결과 입력" onClick='replyModalOpen()'>
</div>
</div>


<!-- 힌트 모달  -->
<div class="modalLayer"></div>
	<div class = "answerModal">
		<div class = "modalContent">
			<button id = "closeBtn" onClick="modalClose()">X</button>
			<p>1. 무엇을 잃어버렸어? 2. 어디서 잃어버렸어? <br> 3. 언제 잃어버렸어?</p>
		</div>
	</div>

	
	<div class = "setReplyModal">
		<div class = "modalContent">
			<button id = "closeBtn" onClick="replyModalClose()">X</button>
			<p>아이의 말을 듣고 맞으면 O, 틀리면 X를 누르세요.</p>
				<button class="replybtn" id="Obtn" onClick="checkOReply()"><img class="btn-img" src="./image/OButton.png" width = "100%"></button>
				<button class="replybtn" id="Xbtn" onClick="checkXReply()"><img class="btn-img" src="./image/XButton.png" width = "100%"></button>
		</div>
	</div>
	
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<script type="text/javascript">

	let result = "X";
	
	function checkOReply(){
		result = "O";
		replyModalClose();
	}
	
	function checkXReply(){
		result = "X";
		replyModalClose();
	}
	
	function modalOpen(){
		$(".answerModal").css('display', 'block');
		$(".modalLayer").css('display', 'block');
	} 
	
	function modalClose(){
		$(".answerModal").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}
	
	function replyModalOpen(){
		$(".setReplyModal").css('display', 'block');
		$(".modalLayer").css('display', 'block');
	} 
	
	function replyModalClose(){
		$(".setReplyModal").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}
	
	var cnt = 0;
	
	//음성 재생
	window.onload = function () {
		var audio = new Audio('./audio/gamesound3_38_0.wav');
		audio.play();
	  	audio.addEventListener("ended", function () {
		    audio.pause();
		    $("#rightbtn").css('display', 'inline');
		  }, false);
	}
	
	if (performance.navigation.type == 1) {
		$("#rightbtn").css('display', 'inline');
	}
	
	function hintSound(){
		var hint = new Audio('./audio/age3_06_hint.wav');
		hint.play();
	}
	function gameBtnFunc(audio){
		audio.play();
	  	audio.addEventListener("ended", function () {
		    audio.pause();
		    $("#rightbtn").css('display', 'inline');
		    $("#leftbtn").css('display', 'inline');
		  }, false);
	}
	
	function gameBtnHide(){
		$("#rightbtn").css('display', 'none');
		$("#leftbtn").css('display', 'none');
	}
	
	function content() {  
		  
		  cnt = cnt+1;
		  
		  if(cnt == 1){
			gameBtnHide();
			$("#minsu").css('display', 'inline'); 
      		$("#friend").css('display', 'none');
			$(".gameImg01").attr("src", "./image/minsu02.png");
			$(".gameImg01").attr("alt", "민수가 놀라고 있는 그림");
			$(".gameImg02").attr("src", "./image/mina07.png");
			$(".gameImg02").attr("alt", "미나가 입 근처에 손을 가져다 대고 쉿 하고 있는 그림");
          	$(".gametext01").css('display', 'none');
      		$(".gametext02").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_39_0.wav');
      		gameBtnFunc(audio);
          } 
		  else if(cnt == 2){
			gameBtnHide();
			$("#mina").css('display', 'inline'); 
      		$("#minsu").css('display', 'none');
          	$(".gametext02").css('display', 'none');
      		$(".gametext03").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_40_0.wav');
      		gameBtnFunc(audio);
          } 
		  else if(cnt == 3){
			gameBtnHide();
			$("#friend").css('display', 'inline'); 
      		$("#mina").css('display', 'none');
          	$(".gametext03").css('display', 'none');
      		$(".gametext04").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_41_0.wav');
      		gameBtnFunc(audio);
          } 
		  else if(cnt == 4){
			gameBtnHide();
			$("#minsu").css('display', 'inline'); 
      		$("#friend").css('display', 'none');
      		$(".gameImg01").attr("src", "./image/minsu03.png");
			$(".gameImg01").attr("alt", "민수가 만세하고 있는 그림");
			$(".gameImg02").attr("src", "./image/mina08.png");
			$(".gameImg02").attr("alt", "미나가 양 손을 모으고 웃고 있는 그림");
          	$(".gametext04").css('display', 'none');
      		$(".gametext05").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_42_0.wav');
      		gameBtnFunc(audio);
          } 
		  else if(cnt == 5){
			gameBtnHide();
			$("#mina").css('display', 'inline'); 
      		$("#minsu").css('display', 'none');
          	$(".gametext05").css('display', 'none');
      		$(".gametext06").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_43_0.wav');
      		gameBtnFunc(audio);
          } 
		  else if(cnt == 6){
			gameBtnHide();
			$("#minsu").css('display', 'inline'); 
      		$("#mina").css('display', 'none');
          	$(".gametext06").css('display', 'none');
      		$(".gametext07").css('display', 'inline'); 
      		$(".gameImg01").attr("src", "./image/minsu04.png");
			$(".gameImg01").attr("alt", "민수가 궁금해하고 있는 그림");
      		$(".gameImg02").attr("src", "./image/mina07.png");
			$(".gameImg02").attr("alt", "미나가 입 근처에 손을 가져다 대고 쉿 하고 있는 그림");
      		var audio = new Audio('./audio/gamesound3_44_0.wav');
      		gameBtnFunc(audio);
          } 
          else if(cnt == 7){
        	gameBtnHide();
        	$("#minsu").css('display', 'none');
          	$(".gametext07").css('display', 'none');
      		$(".gametext08").css('display', 'inline'); 
      		$("#hint").css('display', 'inline');  
      		$("#correctAnswer").css('display', 'inline');  
      		$("#reply").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_45_0.wav');
      		gameBtnFunc(audio);
          }
          else if(cnt == 7){
        	gameBtnHide();
        	$("#friend").css('display', 'inline');
          	$(".gametext08").css('display', 'none');
      		$(".gametext09").css('display', 'inline'); 
      		$("#hint").css('display', 'none');  
      		$("#correctAnswer").css('display', 'none');  
      		$("#reply").css('display', 'none'); 
      		var audio = new Audio('./audio/gamesound3_47_1.wav');
      		gameBtnFunc(audio);
          }
          
          else if(cnt == 8){
        	  location.href = '../getLangGame'+ "?result="+ result;
          }
	}     
	
	function contentBack() {  
		  
		  cnt = cnt-1;
		  
		  if(cnt == 0){
				gameBtnHide();
				$("#minsu").css('display', 'none'); 
	      		$("#friend").css('display', 'inline');
				$(".gameImg01").attr("src", "./image/minsu01.png");
				$(".gameImg01").attr("alt", "민수가 손을 들고 있는 그림");
				$(".gameImg02").attr("src", "./image/mina01.png");
				$(".gameImg02").attr("alt", "미나가 손을 들고 있는 그림");
	          	$(".gametext01").css('display', 'inline');
	      		$(".gametext02").css('display', 'none'); 
	      		var audio = new Audio('./audio/gamesound3_38_0.wav');
	      		gameBtnFunc(audio);
	          } 
			  else if(cnt == 1){
				gameBtnHide();
				$("#mina").css('display', 'none'); 
	      		$("#minsu").css('display', 'inline');
	          	$(".gametext02").css('display', 'inline');
	      		$(".gametext03").css('display', 'none'); 
	      		var audio = new Audio('./audio/gamesound3_39_0.wav');
	      		gameBtnFunc(audio);
	          } 
			  else if(cnt == 2){
				gameBtnHide();
				$("#friend").css('display', 'none'); 
	      		$("#mina").css('display', 'inline');
	          	$(".gametext03").css('display', 'inline');
	      		$(".gametext04").css('display', 'none'); 
	      		var audio = new Audio('./audio/gamesound3_40_0.wav');
	      		gameBtnFunc(audio);
	          } 
			  else if(cnt == 3){
				gameBtnHide();
				$("#minsu").css('display', 'none'); 
	      		$("#friend").css('display', 'inline');
	      		$(".gameImg01").attr("src", "./image/minsu02.png");
				$(".gameImg01").attr("alt", "민수가 놀라고 있는 그림");
				$(".gameImg02").attr("src", "./image/mina07.png");
				$(".gameImg02").attr("alt", "미나가 입 근처에 손을 가져다 대고 쉿 하고 있는 그림");
	      		$(".gametext05").css('display', 'none'); 
	      		var audio = new Audio('./audio/gamesound3_41_0.wav');
	      		gameBtnFunc(audio);
	          } 
			  else if(cnt == 4){
				gameBtnHide();
				$("#mina").css('display', 'none'); 
	      		$("#minsu").css('display', 'inline');
	          	$(".gametext05").css('display', 'inline');
	      		$(".gametext06").css('display', 'none'); 
	      		var audio = new Audio('./audio/gamesound3_42_0.wav');
	      		gameBtnFunc(audio);
	          } 
			  else if(cnt == 5){
				gameBtnHide();
				$("#minsu").css('display', 'none'); 
	      		$("#mina").css('display', 'inline');
	          	$(".gametext06").css('display', 'inline');
	      		$(".gametext07").css('display', 'none'); 
	      		$(".gameImg01").attr("src", "./image/minsu03.png");
				$(".gameImg01").attr("alt", "민수가 만세하고 있는 그림");
	      		$(".gameImg02").attr("src", "./image/mina08.png");
				$(".gameImg02").attr("alt", "미나가 양 손을 모으고 웃고 있는 그림");
	      		var audio = new Audio('./audio/gamesound3_43_0.wav');
	      		gameBtnFunc(audio);
	          } 
	          else if(cnt == 6){
	        	gameBtnHide();
	        	$("#minsu").css('display', 'inline');
	          	$(".gametext07").css('display', 'inline');
	      		$(".gametext08").css('display', 'none'); 
	      		$("#hint").css('display', 'none');  
	      		$("#correctAnswer").css('display', 'none');  
	      		$("#reply").css('display', 'none'); 
	      		var audio = new Audio('./audio/gamesound3_44_0.wav');
	      		gameBtnFunc(audio);
	          }
	          else if(cnt == 7){
	        	gameBtnHide();
	        	$("#friend").css('display', 'none');
	          	$(".gametext08").css('display', 'inline');
	      		$(".gametext09").css('display', 'none'); 
	      		$("#hint").css('display', 'inline');  
	      		$("#correctAnswer").css('display', 'inline');  
	      		$("#reply").css('display', 'inline'); 
	      		var audio = new Audio('./audio/gamesound3_45_0.wav');
	      		gameBtnFunc(audio);
	          }
		}
	
</script>

</body>
</html>