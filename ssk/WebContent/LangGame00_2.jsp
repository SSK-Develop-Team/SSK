<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<meta charset="UTF-8">
<title>직접 평가 2번 문항</title>
<style>
	.gametext02{ display : none; }
	.gametext03{ display : none; }
	.gametext04{ display : none; }
	.gametext05{ display : none; }
	
	.gameImg03{ display : none; }
	.gameImg04{ display : none; }
	
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
		margin-bottom : 5%;
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
	
	#mina { display : none; }
	
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
	
</style>
</head>
<body>
<%@ include file="sidebar.jsp" %>
<h3>직접 평가 #02</h3>
<div class="container">
	<!-- 게임 이미지 -->
	<div class="imgbox">
		<img class="gameImg01" src="./image/mina02.png" height="100%" alt="미나가 놀라고 있는 그림"/>
		<img class="gameImg02" src="./image/age3_Friend.png" height="100%" alt="남자 아이가 선물을 건네고 있는 그림"/>
		<img class="gameImg03" src="./image/age3_Friends.png" height="100%" alt="친구들이 선물을 바라보고 있는 그림"/>
		<img class="gameImg04" src="./image/mina04.png" height="100%" alt="미나가 궁금해하고 있는 그림"/>	
	</div>
	
	<!-- 게임 텍스트 (말풍선) -->
	<span id = "mina">미나</span>
	<span id = "friend">친구</span>
	<div class="textbox">
		<div class="gametext">
			<div class="gametext01">생일 축하해! 이건 네 선물이야.</div>
			<div class="gametext02">와, 고마워!</div>
			<div class="gametext03">와, 저 선물 좀 봐!</div>
			<div class="gametext04">누구 거지?</div>
			<div class="gametext05">나는 뭐라고 하면 될까?</div>
		</div>
		<!-- 게임 이동 버튼 -->
		<div class="gamebtnbox">
			<input type="button" class="gamebtn" id="leftbtn" value="< 이전" onClick='contentBack()'>
			<input type="button" class="gamebtn" id="rightbtn" value="다음 >" onclick='content()'>
			
		</div>
	</div>

	<div class="btnbox">
		<input type="button" class="btn" id="hint" value="힌트">
		<input type="button" class="btn" id="correctAnswer" value="정답 확인" onClick='modalOpen()'>
		<input type="button" class="btn" id="reply" value="결과 입력" onClick='replyModalOpen()'>
	</div>
	
</div>

<!-- 힌트 모달  -->
<div class="modalLayer"></div>
	<div class = "answerModal">
		<div class = "modalContent">
			<button id = "closeBtn" onClick="modalClose()">X</button>
			<p>내 거 / 내 선물</p>
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
		var audio = new Audio('./audio/gamesound3_9_0.wav');
		audio.play();
	  	audio.addEventListener("ended", function () {
		    audio.pause();
		    $("#rightbtn").css('display', 'inline');
		  }, false);
	}
	
	if (performance.navigation.type == 1) {
		$("#rightbtn").css('display', 'inline');
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
		    $(".gameImg01").attr("src", "./image/mina03.png");
		    $(".gameImg01").attr("alt", "미나가 기뻐하고 있는 그림");
          	$(".gametext01").css('display', 'none');
      		$(".gametext02").css('display', 'inline'); 
      		$("#mina").css('display', 'inline'); 
      		$("#friend").css('display', 'none'); 
      		var audio = new Audio('./audio/gamesound3_10_0.wav');
      		gameBtnFunc(audio);
          } 
          else if(cnt == 2){
        	gameBtnHide();  
  			$(".gameImg01").css('display', 'none');
  			$(".gameImg02").css('display', 'none');
			$(".gameImg03").css('display', 'inline');
          	$(".gametext02").css('display', 'none');
      		$(".gametext03").css('display', 'inline'); 
      		$("#mina").css('display', 'none'); 
      		$("#friend").css('display', 'inline');
      		var audio = new Audio('./audio/gamesound3_11_0.wav');
      		gameBtnFunc(audio);
          }
          else if(cnt == 3){
        	gameBtnHide();
        	$(".gametext03").css('display', 'none');
        	$(".gametext04").css('display', 'inline'); 
        	var audio = new Audio('./audio/gamesound3_12_0.wav');
      		gameBtnFunc(audio);
          }
          else if(cnt == 4){
        	gameBtnHide();
   			$(".gameImg03").css('opacity', '0.4');
   			$(".gameImg04").css('display', 'inline');
          	$(".gametext04").css('display', 'none');
      		$(".gametext05").css('display', 'inline');
      		$("#mina").css('display', 'inline'); 
      		$("#friend").css('display', 'none');
      		var audio = new Audio('./audio/gamesound3_14_0.wav');
      		gameBtnFunc(audio);
      		$("#hint").css('display', 'inline');  
      		$("#correctAnswer").css('display', 'inline'); 
      		$("#reply").css('display', 'inline'); 
          } 
          else if(cnt == 5){
        	  location.href = '../getLangGame'+ "?result="+ result;
          }
	}     
	
	function contentBack() {  
		  
		  cnt = cnt-1;
		  
		  	if(cnt == 0){
		  		gameBtnHide();
			    $(".gameImg01").attr("src", "./image/mina02.png");
			    $(".gameImg01").attr("alt", "미나가 놀라고 있는 그림");
		  		$(".gametext01").css('display', 'inline');
	       		$(".gametext02").css('display', 'none');
		  		$("#leftbtn").css('display', 'none');
		  		$("#mina").css('display', 'none'); 
	      		$("#friend").css('display', 'inline');
	      		var audio = new Audio('./audio/gamesound3_9_0.wav');
	      		gameBtnFunc(audio);
		  	}
		  	else if(cnt == 1){
		  		gameBtnHide();
		  		$(".gameImg03").css('display', 'none');
		  		$(".gameImg02").css('display', 'inline');
			    $(".gameImg01").attr("src", "./image/mina03.png");
			    $(".gameImg01").attr("alt", "미나가 기뻐하고 있는 그림");
		  		$(".gameImg01").css('display', 'inline');
		  		$(".gametext02").css('display', 'inline')
	       		$(".gametext03").css('display', 'none');
		  		$("#mina").css('display', 'inline'); 
	      		$("#friend").css('display', 'none');
	      		var audio = new Audio('./audio/gamesound3_10_0.wav');
	      		gameBtnFunc(audio);
	        } 
	        else if(cnt == 2){
	        	gameBtnHide();
	        	$(".gametext03").css('display', 'inline')
	       		$(".gametext04").css('display', 'none');
	        	var audio = new Audio('./audio/gamesound3_11_0.wav');
	      		gameBtnFunc(audio);
	        }
	        else if(cnt == 3){
	        	gameBtnHide();
	        	$(".gameImg03").css('opacity', '1');
	    		$(".gameImg04").css('display', 'none');
	           	$(".gametext04").css('display', 'inline')
	       		$(".gametext05").css('display', 'none');
	           	$("#mina").css('display', 'none'); 
	      		$("#friend").css('display', 'inline');
	      		var audio = new Audio('./audio/gamesound3_12_0.wav');
	      		gameBtnFunc(audio);
	      		$("#hint").css('display', 'none');  
	      		$("#correctAnswer").css('display', 'none'); 
	      		$("#reply").css('display', 'none'); 
	        }  
		}
	
</script>

</body>
</html>