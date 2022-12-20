<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="java.util.*" %>

<%
	User currUser = (User)session.getAttribute("currUser");
	String name = currUser.getUserName();
	String name1 = ""; //이는, 는
	String name2 = ""; //아, 야
	
	if(name.length() == 3){
		name = name.substring(1);
	}
	
	else if(name.length() == 4){
		name = name.substring(2);
	}
	
	char lastName = name.charAt(name.length() - 1);
	int index = (lastName - 0xAC00) % 28;
	if(index > 0){
		name1 = name + "이";
		name2 = name + "아";
	} else {
		name2 = name + "야";
		name1 = name;
	}
	
	session.setAttribute("currUser", currUser);
%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<meta charset="UTF-8">
<title>직접 평가 4번 문항</title>
<style>
	.gametext02{ display : none; }
	.gametext03{ display : none; }
	.gametext04{ display : none; }
	.gametext05{ display : none; }
	
	.gameImg01{ align : center; }
	.gameImg02{ display : none; }
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
<h3>직접 평가 #04</h3>
<div class="container">

	<!-- 게임 이미지 -->
	<div class="imgbox">
		<img class="gameImg01" src="./image/age3_Friends2.png" height="100%" alt="미나와 친구들이 함께 있는 그림"/>
		<img class="gameImg02" src="./image/mina04.png" height="100%" alt="미나가 궁금해하고 있는 그림"/>
		<img class="gameImg03" src="./image/age3_verses1.png" height="100%" alt="우유와 아이스크림"/>
	</div>
	
	<!-- 게임 텍스트 (말풍선) -->
	<span id = "mina">미나</span>
	<span id = "friend">친구</span>
	<div class="textbox">
		<div class="gametext">
			<div class="gametext01">우리 이제 게임을 해볼까?</div>
			<div class="gametext02">무슨 게임?</div>
			<div class="gametext03">둘 중에 좋아하는 거 하나 고르기 게임 어때? <%=name1 %>도 같이 하자.</div>
			<div class="gametext04"><%=name2 %>, 우리 이제 둘 중에 더 좋아하는 것을 고르는 게임을 할 거야. <br> <%=name1 %>는 뭐가 더 좋아?</div>
			<div class="gametext05">둘 중에 뭐가 더 좋아?</div>
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
			<p>첫 소리를 정확하게 말하면 정답.</p>
			<audio controls src="./audio/lang00_4.m4a"></audio>
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
	
	//음성 재생 (이후 DB 연결로 사용)
	window.onload = function () {
		var audio = new Audio('./audio/gamesound3_23_0.wav');
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
		var hint = new Audio('./audio/age3_04_hint.wav');
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
          	$(".gametext01").css('display', 'none');
      		$(".gametext02").css('display', 'inline');
      		var audio = new Audio('./audio/gamesound3_24_0.wav');
      		gameBtnFunc(audio);
          } 
          else if(cnt == 2){
        	  gameBtnHide();
          	$(".gametext02").css('display', 'none');
      		$(".gametext03").css('display', 'inline');
      		$("#mina").css('display', 'inline'); 
      		$("#friend").css('display', 'none');
      		var audio = new Audio('./audio/gamesound3_25_0.wav');
      		gameBtnFunc(audio);
          }
          else if(cnt == 3){
        	  gameBtnHide();
        	$(".gameImg01").css('display', 'none');
		  	$(".gameImg02").css('display', 'inline');
		  	$(".gameImg03").css('display', 'inline');
          	$(".gametext03").css('display', 'none');
      		$(".gametext04").css('display', 'inline');
      		$("#voicebtn").css('display', 'inline'); 
      		var audio = new Audio('./audio/gamesound3_27_0.wav');
      		gameBtnFunc(audio);
          }
          else if(cnt == 4){
        	  gameBtnHide();
         	$(".gameImg03").attr("src", "./image/age3_verses2.png");
 			$(".gameImg03").attr("alt", "바나나와 배"); 
           	$(".gametext04").css('display', 'none');
       		$(".gametext05").css('display', 'inline');
       		var audio = new Audio('./audio/gamesound3_28_0.wav');
      		gameBtnFunc(audio);
          } 
          else if(cnt == 5){
        	  gameBtnHide();
         	$(".gameImg03").attr("src", "./image/age3_verses3.png");
 			$(".gameImg03").attr("alt", "포도와 포도주스"); 
           	$(".gametext04").css('display', 'none');
       		$(".gametext05").css('display', 'inline');
       		var audio = new Audio('./audio/gamesound3_29_0.wav');
       		$("#hint").css('display', 'inline');  
      		$("#correctAnswer").css('display', 'inline');
      		$("#reply").css('display', 'inline'); 
      		gameBtnFunc(audio);
          } 
          else if(cnt == 6){
        	  location.href = '../getLangGame'+ "?result="+ result;
          }
	}     
	
	function contentBack() {  
		  
		  cnt = cnt-1;
		  
		  	if(cnt == 0){
		  		gameBtnHide();
		  		$(".gametext01").css('display', 'inline');
	      		$(".gametext02").css('display', 'none');
	      		var audio = new Audio('./audio/gamesound3_23_0.wav');
	      		gameBtnFunc(audio);
		  	}
		  	else if(cnt == 1){
		  		gameBtnHide();
	          	$(".gametext02").css('display', 'inline');
	      		$(".gametext03").css('display', 'none');
	      		$("#mina").css('display', 'none'); 
	      		$("#friend").css('display', 'inline')
	      		var audio = new Audio('./audio/gamesound3_24_0.wav');
	      		gameBtnFunc(audio);
	        } 
	        else if(cnt == 2){
	        	gameBtnHide();
	        	$(".gameImg01").css('display', 'inline');
			  	$(".gameImg02").css('display', 'none');
			  	$(".gameImg03").css('display', 'none');
	          	$(".gametext03").css('display', 'inline');
	      		$(".gametext04").css('display', 'none');
	      		var audio = new Audio('./audio/gamesound3_25_0.wav');
	      		gameBtnFunc(audio);
	        }
	        else if(cnt == 3){
	        	gameBtnHide();
	        	$(".gameImg03").attr("src", "./image/age3_verses1.png");
	 			$(".gameImg03").attr("alt", "우유와 아이스크림"); 
	           	$(".gametext04").css('display', 'inline');
	       		$(".gametext05").css('display', 'none');
	       		var audio = new Audio('./audio/gamesound3_27_0.wav');
	      		gameBtnFunc(audio);
	        }  
	        else if(cnt == 4){
	        	gameBtnHide();
	        	$(".gameImg03").attr("src", "./image/age3_verses2.png");
	 			$(".gameImg03").attr("alt", "바나나와 배"); 
	 			var audio = new Audio('./audio/gamesound3_28_0.wav');
	      		gameBtnFunc(audio);
	      		$("#hint").css('display', 'none');  
	      		$("#correctAnswer").css('display', 'none'); 
	      		$("#reply").css('display', 'none'); 
	        }  
		}
	
</script>

</body>
</html>