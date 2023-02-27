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
<title>직접 평가 52번 문항</title>

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
	
	.closeBtn {
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
	
	.oceanBack1 {
		display : block;
		height : 100%;
		width : 100%;
		position : relative;
	}
	
	.oceanBack2 {
		display : none;
		height : 100%;
		width : 100%;
		position : relative;
	}
	

	.selectImg01{
		position : absolute;
		left : 15%;
		top : 23%;
	}
	.selectImg02{
		position : absolute;
		left : 60%;
		top : 20%;
	}
	.selectImg03{
		position : absolute;
		left : 23%;
		top : 16%;
	}
	.selectImg04{
		position : absolute;
		left : 72%;
		top : 23%;
	}
	
	#answer { display : none ;}
	</style>
	
</head>
<body>
<%@ include file="sidebar.jsp" %>
<div class="container">

	<!-- 게임 이미지 -->
	<div class="imgbox">
		<div style="font-size:1em;font-weight:bold;">직접평가 #52</div>
		
		<div class="oceanBack1">
			<img class="gameImg01" src="./image/LangGameImg/Age10/age10_2_1.png" width="100%" height="100%" alt="바다의 틀린그림 찾기, 오른쪽 위에 물고기 두 마리."/>
			<img class="selectImg01" src="./image/LangGameImg/Age10/age10_2_1_icon01.png" width="4%" alt="작은 문어" onClick="modal01Open()" />
			<img class="selectImg02" src="./image/LangGameImg/Age10/age10_2_1_icon01.png" width="12%" alt="큰 문어" onClick="modal01Open()" />
		</div>
		
		<div class="oceanBack2">
			<img class="gameImg02" src="./image/LangGameImg/Age10/age10_2_2.png" width="100%" height="100%" alt="바다의 틀린그림 찾기 2, 왼쪽 아래에 해초."/>
			<img class="selectImg03" src="./image/LangGameImg/Age10/age10_2_1_icon02.png" height="40%" alt="큰 거북" onClick="modal02Open()" />
			<img class="selectImg04" src="./image/LangGameImg/Age10/age10_2_1_icon02.png" height="20%" alt="작은 거북" onClick="modal02Open()" />
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
			<button class = "closeBtn" onClick="modalClose()">X</button>
			<p>더 커요 / 더 작아요</p>
		</div>
	</div>
	
<!-- 클릭 가능한 버튼 -->
	<div class = "modal01">
		<div class = "modalContent">
			<button class = "closeBtn" onClick="modal01Close()">X</button>
			<img src="./image/LangGameImg/Age10/age10_2_1_modal01.png" width="90%">
		</div>
	</div>
	
	<div class = "modal02">
		<div class = "modalContent">
			<button class = "closeBtn" onClick="modal02Close()">X</button>
			<img src="./image/LangGameImg/Age10/age10_2_2_modal02.png" width="90%">
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
	
	function modal01Open(){
		$(".modal01").css('display', 'block');
		$(".modalLayer").css('display', 'block');
		var audio = new Audio('./audio/Age10/age_10_52_1.wav');
		audio.play();
	} 
	
	function modal01Close(){
		$(".modal01").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}
	
	function modal02Open(){
		$(".modal02").css('display', 'block');
		$(".modalLayer").css('display', 'block');
		var audio = new Audio('./audio/Age10/age_10_52_1.wav');
		audio.play();
	} 
	
	function modal02Close(){
		$(".modal02").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}
	
	var cnt = 0;
	
	//음성 재생
	window.onload = function () {
		var audio = new Audio('./audio/Age10/age_10_51_1.wav');
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
			$(".oceanBack1").css('display', 'none');		
			$(".oceanBack2").css('display', 'block');		
       	 	$("#leftbtn").css('display', 'inline');
	      	var audio = new Audio('./audio/Age10/age_10_51_1.wav');
			audio.play();
          } 
          else if(cnt == 2){
      			if(!confirm("52번 문항의 게임을 종료하시겠습니까?")){return;}
        	  	location.href = './langTest.jsp';
          }
	}     
	
	function contentBack() {  
		  
		  cnt = cnt-1;
		  
		  if(cnt == 0){
				$(".oceanBack2").css('display', 'none');		
				$(".oceanBack1").css('display', 'block');			
        		$("#answer").css('display', 'none');
        		$("#leftbtn").css('display', 'none');
    	      	var audio = new Audio('./audio/Age10/age_10_51_1.wav');
    			audio.play();
	          }
		}
	
</script>

</body>
</html>