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
<title>직접 평가 51번 문항</title>

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
		height : 70%; 
		margin-left : 15%;
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
	
	.modal01 { display : none ;}
	.modal02 { display : none ;}
	.modal03 { display : none ;}
	.modal04 { display : none ;}
	.modal05 { display : none ;}
	.modal06 { display : none ;}
	
	.roomBack {
		display : inline;
		height : 100%;
		width : 100%;
		position : relative;
	}
	
	.playBack {
		display : none;
		height : 100%;
		width : 100%;
		position : relative;
	}
	
	.snowBack {
		display : none;
		height : 100%;
		width : 100%;
		position : relative;
	}
	
	.selectImg01{
		position : absolute;
		left : 15%;
		top : 10%;
	}
	.selectImg02{
		position : absolute;
		left : 25%;
		margin-top : 7%;
	}
	.selectImg03{
		position : absolute;
		left : 62%;
		margin-top : 10%;
	}
	.selectImg04{
		position : absolute;
		left : 71%;
		margin-top : 7%;
	}
	
	.selectImg05{
		position : absolute;
		left : 47%;
		top : 52%;
	}
	.selectImg06{
		position : absolute;
		left : 37%;
		top : 76%;
	}
	.selectImg07{
		position : absolute;
		left : 83%;
		top : 10%;
	}
	.selectImg08{
		position : absolute;
		left : 70%;
		top : 50%;
	}
	
	.selectImg09{
		position : absolute;
		left : 47%;
		top : 52%;
	}
	.selectImg10{
		position : absolute;
		left : 37%;
		top : 76%;
	}
	.selectImg11{
		position : absolute;
		left : 83%;
		top : 10%;
	}
	.selectImg12{
		position : absolute;
		left : 70%;
		top : 50%;
	}
	</style>
	
</head>
<body>
<%@ include file="sidebar.jsp" %>
<h3>직접 평가 #07</h3>
<div class="container">

	<!-- 게임 이미지 -->
	<div class="imgbox">
	
	<!-- 거실 틀린그림 찾기  -->
		<div class="roomBack">
			<img class="gameImg01" src="./image/LangGameImg/Age10/age10_1_1.png" width="100%" height="100%" alt="거실의 틀린그림 찾기, 가운데 쇼파가 있고 회색 벽돌로 된 벽에는 세 개의 액자가 걸려있다."/>
			<img class="selectImg01" src="./image/LangGameImg/Age10/age10_1_1_icon01.png" width="5%" alt="로켓" onClick="modal01Open()" />
			<img class="selectImg02" src="./image/LangGameImg/Age10/age10_1_1_icon02.png" width="5%" alt="분홍색 리본" onClick="modal02Open()" />
			<img class="selectImg03" src="./image/LangGameImg/Age10/age10_1_1_icon03.png" width="5%" alt="로봇" onClick="modal01Open()" />
			<img class="selectImg04" src="./image/LangGameImg/Age10/age10_1_1_icon04.png" width="5%" alt="빨간색 리본" onClick="modal02Open()" />
		</div>
		
	<!-- 놀이터 틀린그림 찾기  -->
		<div class="playBack">
			<img class="gameImg02" src="./image/LangGameImg/Age10/age10_1_2.png" width="100%" height="100%" alt="놀이터의 틀린그림 찾기, 가운데 코끼리 모양 미끄럼틀이 있고 여자아이와 남자아이가 놀고 있다."/>
			<img class="selectImg05" src="./image/LangGameImg/Age10/age10_1_2_icon01.png" height="6%" alt="비행기" onClick="modal03Open()" />
			<img class="selectImg06" src="./image/LangGameImg/Age10/age10_1_2_icon02.png" height="6%" alt="파랑새" onClick="modal04Open()" />
			<img class="selectImg07" src="./image/LangGameImg/Age10/age10_1_2_icon03.png" height="6%" alt="모래놀이" onClick="modal03Open()" />
			<img class="selectImg08" src="./image/LangGameImg/Age10/age10_1_2_icon04.png" height="6%" alt="시소" onClick="modal04Open()" />
		</div>
		
	<!-- 눈언덕 틀린그림 찾기  -->
		<div class="snowBack">
			<img class="gameImg03" src="./image/LangGameImg/Age10/age10_1_3.png" width="100%" height="100%" alt="눈 쌓인 언덕의 틀린그림 찾기, 눈이 펑펑 내리고 뒤로는 큰 보름달이 떠있다."/>
			<img class="selectImg09" src="./image/LangGameImg/Age10/age10_1_3_icon01.png" height="6%" alt="눈사람" onClick="modal05Open()" />
			<img class="selectImg10" src="./image/LangGameImg/Age10/age10_1_3_icon02.png" height="6%" alt="북극곰" onClick="modal06Open()" />
			<img class="selectImg11" src="./image/LangGameImg/Age10/age10_1_3_icon03.png" height="6%" alt="순록과 산타" onClick="modal05Open()" />
			<img class="selectImg12" src="./image/LangGameImg/Age10/age10_1_3_icon04.png" height="6%" alt="썰매와 산타" onClick="modal06Open()" />
		</div>

	</div>
	
	<!-- 게임 텍스트 (말풍선) -->
	<div class="textbox">
		<div class="gametext">
			<div class="gametext01">두 그림에서 서로 다른 부분을 찾아 눌러보세요.</div>
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


<!-- 정답 모달  -->
<div class="modalLayer"></div>

	<div class = "answerModal">
		<div class = "modalContent">
			<button id = "closeBtn" onClick="modalClose()">X</button>
			<p>로봇, 로켓, 리본, 빨간색, 분홍색, 새, 시소, 삽, 썰매, 산타(싼타), 눈사람</p>
			<audio controls src="./audio/lang01_7.m4a"></audio>
		</div>
	</div>
	
<!-- 클릭 가능한 버튼 -->
	<!-- <div class = "modal01">
		<div class = "modalContent">
			<button id = "closeBtn" onClick="modal01Close()">X</button>
			<img src="./image/LangGameImg/Age10/age10_1_1_modal01.png">
			<p>무엇이 어떻게 다른지 설명해보아요.</p>
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
	</div>  -->
	
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