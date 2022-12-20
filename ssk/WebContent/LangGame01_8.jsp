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
<title>직접 평가 8번 문항</title>

<style>
	.gametext02{ display : none; }
	.gametext03{ display : none; }
	.gametext04{ display : none; }
	.gametext05{ display : none; }
	.gametext06{ display : none; }
	.gametext07{ display : none; }
	.gametext08{ display : none; }
	.gametext09{ display : none; }
	
	.gameImg03{ display : none; }
	.gameImg04{ display : none; }
	.gameImg05{ display : none; }
	.gameImg06{ display : none; }
	
	
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
	
	#aunt { display : none; }
	
	</style>
	
</head>
<body>
<%@ include file="sidebar.jsp" %>
<h3>직접 평가 #08</h3>
<div class="container">




<!-- alt 다시 수정하여 작성하기 -->




	<!-- 게임 이미지 -->
	<div class="imgbox">
		<img class="gameImg01" src="./image/mina04.png" height="100%" alt="미나가 궁금해하고 있는 그림"/>
		<img class="gameImg02" src="./image/age3_mom2.png" height="100%" alt="엄마가 집안일로 바쁘게 움직이고 있는 그림"/>
		<img class="gameImg03" src="./image/age3_baby1.png" height="80%" alt="아기가 우유를 먹고 있는 그림"/>
		<img class="gameImg04" src="./image/age3_mom3.png" height="100%" alt="엄마가 아기를 품에 안고 있는 그림"/>
		<img class="gameImg05" src="./image/age3_apple.png" height="50%" alt="사과 두 개가 접시에 올려져 있는 그림"/>
		<img class="gameImg06" src="./image/mina01.png" height="100%" alt="미나"/>
	</div>
	
	<!-- 게임 텍스트 (말풍선) -->
	<span id = "mina">미나</span>
	<span id = "aunt">이모</span>
	<div class="textbox">
		<div class="gametext">
			<div class="gametext01">이모 안녕하세요! 혹시 떨어져있는 사과 보셨나요?</div>
			<div class="gametext02">안녕! 어휴, 바쁘다 바뻐. <br> 사과? 잘 모르겠는데...</div>
			<div class="gametext03">내가 너무 바빠서 그러는데 아기 좀 잠깐 봐줄래?<br>내가 이것만 하고 사과 같이 찾아줄게.</div>
			<div class="gametext04">아기를 돌봐줘요!</div>
			<div class="gametext05">아기가 지금 뭐하고 있어?</div>
			<div class="gametext06">휴, 다 끝냈다! <br>아기를 봐줘서 정말 고마워. 청소하면서 사과를 찾았는데, 혹시 이거 네 거니?</div>
			<div class="gametext07">우와 네 맞아요! 고맙습니다!</div>
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
			<p>우유 마셔 / 우유 먹어 <br>먹어 / 마셔 <br>우유를 이렇게 하고 있어</p>
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
		var audio = new Audio('./audio/gamesound3_55_0.wav');
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
		var hint = new Audio('./audio/age3_08_hint.wav');
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
			$("#mina").css('display', 'none'); 
			$("#aunt").css('display', 'inline'); 
          	$(".gametext01").css('display', 'none');
      		$(".gametext02").css('display', 'inline');  
      		var audio = new Audio('./audio/gamesound3_56_0.wav');
      		gameBtnFunc(audio);
          }
		  else if(cnt == 2){
			gameBtnHide();
          	$(".gametext02").css('display', 'none');
      		$(".gametext03").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_57_0.wav');
      		gameBtnFunc(audio);
	       } 
		  else if(cnt == 3){
			gameBtnHide();
			$("#aunt").css('display', 'none');
			$(".gameImg01").attr("src", "./image/mina07.png");
			$(".gameImg01").attr("alt", "미나가 입 근처에 손을 가져다 대고 쉿 하고 있는 그림");
			$(".gameImg02").css('display', 'none');
			$(".gameImg03").css('display', 'inline');
          	$(".gametext03").css('display', 'none');
      		$(".gametext04").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_58_0.wav');
      		gameBtnFunc(audio);
	       } 
		  else if(cnt == 4){
			gameBtnHide();
			$("#mina").css('display', 'inline');
          	$(".gametext04").css('display', 'none');
      		$(".gametext05").css('display', 'inline'); 
      		$("#hint").css('display', 'inline');  
      		$("#correctAnswer").css('display', 'inline');  
      		$("#reply").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_60_0.wav');
      		gameBtnFunc(audio);
	       } 
		  else if(cnt == 5){
			gameBtnHide();
			$("#mina").css('display', 'none');
			$("#aunt").css('display', 'inline');
			$(".gametext05").css('display', 'none'); 
      		$("#hint").css('display', 'none');  
      		$("#correctAnswer").css('display', 'none'); 
      		$("#reply").css('display', 'none');
			$(".gameImg01").css('display', 'none');
			$(".gameImg03").css('display', 'none');
			$(".gameImg04").css('display', 'inline');
			$(".gameImg05").css('display', 'inline');
			$(".gameImg06").css('display', 'inline');
          	$(".gametext05").css('display', 'none');
      		$(".gametext06").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_62_0.wav');
      		gameBtnFunc(audio);
	       } 
		  else if(cnt == 6){
			gameBtnHide();
			$("#mina").css('display', 'inline');
			$("#aunt").css('display', 'none');
          	$(".gametext06").css('display', 'none');
      		$(".gametext07").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_63_0.wav');
      		gameBtnFunc(audio);
	       } 
          else if(cnt == 7){
        	  location.href = '../getLangGame'+ "?result="+ result;
          }
	}     
	
	function contentBack() {  
		  
		  cnt = cnt-1;
		  
		  if(cnt == 0){
				gameBtnHide();
				$("#mina").css('display', 'inline'); 
				$("#aunt").css('display', 'none'); 
	          	$(".gametext01").css('display', 'inline');
	      		$(".gametext02").css('display', 'none');  
	      		var audio = new Audio('./audio/gamesound3_55_0.wav');
	      		gameBtnFunc(audio);
	          }
			  else if(cnt == 1){
				gameBtnHide();
	          	$(".gametext02").css('display', 'inline');
	      		$(".gametext03").css('display', 'none'); 
	      		var audio = new Audio('./audio/gamesound3_56_0.wav');
	      		gameBtnFunc(audio);
		       } 
			  else if(cnt == 2){
				gameBtnHide();
				$("#aunt").css('display', 'inline');
				$(".gameImg01").attr("src", "./image/mina07.png");
				$(".gameImg01").attr("alt", "미나가 입 근처에 손을 가져다 대고 쉿 하고 있는 그림");
				$(".gameImg02").css('display', 'inline');
				$(".gameImg03").css('display', 'none');
	          	$(".gametext03").css('display', 'inline');
	      		$(".gametext04").css('display', 'none'); 
	      		var audio = new Audio('./audio/gamesound3_57_0.wav');
	      		gameBtnFunc(audio);
		       } 
			  else if(cnt == 3){
				gameBtnHide();
				$("#mina").css('display', 'none');
	          	$(".gametext04").css('display', 'inline');
	      		$(".gametext05").css('display', 'none'); 
	      		$("#hint").css('display', 'none');  
	      		$("#correctAnswer").css('display', 'none');  
	      		$("#reply").css('display', 'none'); 
	      		var audio = new Audio('./audio/gamesound3_58_0.wav');
	      		gameBtnFunc(audio);
		       } 
			  else if(cnt == 4){
				gameBtnHide();
				$("#mina").css('display', 'inline');
				$("#aunt").css('display', 'none');
				$(".gametext05").css('display', 'inline'); 
	      		$("#hint").css('display', 'inline');  
	      		$("#correctAnswer").css('display', 'inline'); 
	      		$("#reply").css('display', 'inline');
				$(".gameImg01").css('display', 'inline');
				$(".gameImg03").css('display', 'inline');
				$(".gameImg04").css('display', 'none');
				$(".gameImg05").css('display', 'none');
				$(".gameImg06").css('display', 'none');
	          	$(".gametext05").css('display', 'inline');
	      		$(".gametext06").css('display', 'none'); 
	      		var audio = new Audio('./audio/gamesound3_60_0.wav');
	      		gameBtnFunc(audio);
		       } 
			  else if(cnt == 5){
				gameBtnHide();
				$("#mina").css('display', 'none');
				$("#aunt").css('display', 'inline');
	          	$(".gametext06").css('display', 'inline');
	      		$(".gametext07").css('display', 'none'); 
	      		var audio = new Audio('./audio/gamesound3_62_0.wav');
	      		gameBtnFunc(audio);
		       } 
	      		
		}
	
</script>

</body>
</html>