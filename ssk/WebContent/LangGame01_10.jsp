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
<title>직접 평가 10번 문항</title>

<style>
	.gametext02{ display : none; }
	.gametext03{ display : none; }
	
	.gameImg04{ display : none; }
	.gameImg05{ display : none; }
	.gameImg06{ display : none; }
	.gameImg07{ display : none; }

	
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
	
	#minsu { display : none; }
	#friend { display : none; }
	
	</style>
	
</head>
<body>
<%@ include file="sidebar.jsp" %>
<h3>직접 평가 #10</h3>
<div class="container">

	<!--  checkplz! 게임 이미지 변경 -->
	<!-- 게임 이미지 -->
	<div class="imgbox">
		<img class="gameImg01" src="./image/minsu01.png" height="100%" alt="민수가 손을 들고 있는 그림"/>
		<img class="gameImg02" src="./image/mina02.png" height="100%" alt="미나가 놀라고 있는 그림"/>
		<img class="gameImg03" src="./image/age3_crygirl.png" height="100%" alt="여자아이가 울고 있는 그림"/>
		<img class="gameImg04" src="./image/minsu03.png" height="100%" alt="민수가 신나서 만세하고 있는 그림"/>
		<img class="gameImg05" src="./image/mina05.png" height="100%" alt="미나가 신나서 만세하고 있는 그림"/>
		<img class="gameImg06" src="./image/age3_fullbasket.png" height="40%" alt="사과로 가득찬 바구니"/>
		<img class="gameImg07" src="./image/age3_happygirl.png" height="100%" alt="여자아이가 기뻐하고 있는 그림"/>
	</div>
	
	<!-- 게임 텍스트 (말풍선) -->
	<span id = "minsu">민수</span>
	<span id = "friend">친구</span>
	<div class="textbox">
		<div class="gametext">
			<div class="gametext01">친구들에게 어디에 갔었는지 물어볼까?</div>
			<div class="gametext02">이모 집에 갔었어.</div>
			<div class="gametext03">우와 사과를 다 찾아주었네, 정말 고마워!</div>
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
			<p>어디 갔었어?</p>
			<audio controls src="./audio/lang01_10.m4a"></audio>
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
		var audio = new Audio('./audio/gamesound3_71_0.wav');
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
		var hint = new Audio('./audio/age3_10_hint.wav');
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
          	$(".gametext01").css('display', 'none');
      		$(".gametext02").css('display', 'inline');  
      		$("#hint").css('display', 'none');  
      		$("#correctAnswer").css('display', 'none'); 
      		$("#reply").css('display', 'none');
      		var audio = new Audio('./audio/gamesound3_71_1.wav');
      		gameBtnFunc(audio);
          }
		  else if(cnt == 2){
			gameBtnHide();
			$("#friend").css('display', 'inline'); 
			$("#minsu").css('display', 'none'); 
			$(".gameImg01").css('display', 'none');
			$(".gameImg02").css('display', 'none');
			$(".gameImg03").css('display', 'none');
			$(".gameImg04").css('display', 'inline');
			$(".gameImg05").css('display', 'inline');
			$(".gameImg06").css('display', 'inline');
			$(".gameImg07").css('display', 'inline');
          	$(".gametext02").css('display', 'none');
      		$(".gametext03").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_72_0.wav');
      		gameBtnFunc(audio);
	       } 
          else if(cnt == 3){
        	  location.href = '../getLangGame'+ "?result="+ result;
          }
	}     
	
	function contentBack() {  
		  
		  cnt = cnt-1;
		  
		  if(cnt == 0){
				gameBtnHide();
				$("#minsu").css('display', 'none'); 
	          	$(".gametext01").css('display', 'inline');
	      		$(".gametext02").css('display', 'none');  
	      		$("#hint").css('display', 'inline');  
	      		$("#correctAnswer").css('display', 'inline'); 
	      		$("#reply").css('display', 'inline');
	      		var audio = new Audio('./audio/gamesound3_71_0.wav');
	      		gameBtnFunc(audio);
	          }
			  else if(cnt == 1){
				gameBtnHide();
				$("#friend").css('display', 'none'); 
				$("#minsu").css('display', 'inline'); 
				$(".gameImg01").css('display', 'inline');
				$(".gameImg02").css('display', 'inline');
				$(".gameImg03").css('display', 'inline');
				$(".gameImg04").css('display', 'none');
				$(".gameImg05").css('display', 'none');
				$(".gameImg06").css('display', 'none');
				$(".gameImg07").css('display', 'none');
	          	$(".gametext02").css('display', 'inline');
	      		$(".gametext03").css('display', 'none'); 
	      		var audio = new Audio('./audio/gamesound3_71_1.wav');
	      		gameBtnFunc(audio);
		       } 

		}
	
</script>

</body>
</html>