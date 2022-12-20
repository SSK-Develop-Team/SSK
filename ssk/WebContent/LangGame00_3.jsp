<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<meta charset="UTF-8">
<title>직접 평가 3번 문항</title>
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
<h3>직접 평가 #03</h3>
<div class="container">
	<!-- 게임 이미지 -->
	<div class="imgbox">
		<img class="gameImg01" src="./image/mina05.png" height="100%" alt="미나가 신나서 만세하고 있는 그림"/>
		<img class="gameImg02" src="./image/mina01.png" height="100%" alt="미나가 손을 들고 있는 그림"/>
		<img class="gameImg03" src="./image/age3_foodtab1.png" height="100%" alt="과일, 음식, 기타"/>
		<img class="gameImg04" src="./image/age3_table.png" height="30%" alt="식탁"/>
		<img class="gameImg05" src="./image/age3_fruits.png" height="100%" alt="바나나, 블루베리, 사과, 오렌지, 레몬, 파인애플, 딸기, 수박, 포도가 그려져 있는 그림"/>
	</div>
	
	<!-- 게임 텍스트 (말풍선) -->
	<span id = "mina">미나</span>
	<div class="textbox">
		<div class="gametext">
			<div class="gametext01">친구들도 모두 초대했으니 이제 음식을 준비해볼까?</div>
			<div class="gametext02">식탁 위를 채워볼까?</div>
			<div class="gametext03">이중에 아는 과일 이름을 모두 말해볼래?</div>
			<div class="gametext04">이중에 아는 음식 이름을 모두 말해볼래?</div>
			<div class="gametext05">그럼, 여기 있는 것들은 이름이 뭐야?</div>
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
			<p>과일, 음식, 기타 합하여 20개 이상이면 정답</p>
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
		var audio = new Audio('./audio/gamesound3_16_0.wav');
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
			$(".gameImg01").css('display', 'none');
			$(".gameImg02").css('display', 'inline');
			$(".gameImg03").css('display', 'inline');
			$(".gameImg04").css('display', 'inline');
			$(".gametext01").css('display', 'none');
			$(".gametext02").css('display', 'inline');
			var audio = new Audio('./audio/gamesound3_17_0.wav');
      		gameBtnFunc(audio);
          } 
          else if(cnt == 2){
        	  gameBtnHide();
        	$(".gameImg03").attr("src", "./image/age3_foodtab2.png");
			$(".gameImg03").attr("alt", "과일");
			$(".gameImg04").css('display', 'none');
		  	$(".gameImg05").css('display', 'inline');
          	$(".gametext02").css('display', 'none');
      		$(".gametext03").css('display', 'inline');
      		var audio = new Audio('./audio/gamesound3_19_0.wav');
      		gameBtnFunc(audio);
          }
          else if(cnt == 3){
        	  gameBtnHide();
          	$(".gameImg03").attr("src", "./image/age3_foodtab3.png");
			$(".gameImg03").attr("alt", "음식"); 
          	$(".gameImg05").attr("src", "./image/age3_foods.png");
			$(".gameImg05").attr("alt", "핫도그, 햄버거, 피자, 국수, 치킨, 계란프라이, 생선, 새우, 볶음밥이 그려져 있는 그림"); 
          	$(".gametext03").css('display', 'none');
      		$(".gametext04").css('display', 'inline');
      		var audio = new Audio('./audio/gamesound3_20_0.wav');
      		gameBtnFunc(audio);
          }
          else if(cnt == 4){
        	  gameBtnHide();
         	$(".gameImg03").attr("src", "./image/age3_foodtab4.png");
 			$(".gameImg03").attr("alt", "기타"); 
           	$(".gameImg05").attr("src", "./image/age3_cookies.png");
 			$(".gameImg05").attr("alt", "아이스크림, 쿠키, 음료수, 사탕, 유리컵, 도너츠, 주전자, 숟가락, 포크가 그려져 있는 그림"); 
           	$(".gametext04").css('display', 'none');
       		$(".gametext05").css('display', 'inline');
       		var audio = new Audio('./audio/gamesound3_21_0.wav');
      		gameBtnFunc(audio);
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
			  	$(".gameImg01").css('display', 'inline');
			  	$(".gameImg02").css('display', 'none');
			  	$(".gameImg03").css('display', 'none');
			  	$(".gameImg04").css('display', 'none');
	          	$(".gametext02").css('display', 'none');
	      		$(".gametext01").css('display', 'inline');	
	      		var audio = new Audio('./audio/gamesound3_16_0.wav');
	      		gameBtnFunc(audio);
		  	}
		  	else if(cnt == 1){
		  		gameBtnHide();
		  		$(".gameImg03").attr("src", "./image/age3_foodtab1.png");
				$(".gameImg03").attr("alt", "과일, 음식, 기타");
				$(".gameImg04").css('display', 'inline');
			  	$(".gameImg05").css('display', 'none');
	          	$(".gametext03").css('display', 'none');
	      		$(".gametext02").css('display', 'inline');
	      		var audio = new Audio('./audio/gamesound3_17_0.wav');
	      		gameBtnFunc(audio);
	        } 
	        else if(cnt == 2){
	        	gameBtnHide();
	        	$(".gameImg03").attr("src", "./image/age3_foodtab2.png");
				$(".gameImg03").attr("alt", "과일"); 
	          	$(".gameImg05").attr("src", "./image/age3_fruits.png");
				$(".gameImg05").attr("alt", "바나나, 블루베리, 사과, 오렌지, 레몬, 파인애플, 딸기, 수박, 포도가 그려져 있는 그림"); 
	          	$(".gametext04").css('display', 'none');
	      		$(".gametext03").css('display', 'inline');
	      		var audio = new Audio('./audio/gamesound3_19_0.wav');
	      		gameBtnFunc(audio);
	        }
	        else if(cnt == 3){
	        	gameBtnHide();
	        	$(".gameImg03").attr("src", "./image/age3_foodtab3.png");
	 			$(".gameImg03").attr("alt", "음식"); 
	           	$(".gameImg05").attr("src", "./image/age3_foods.png");
	 			$(".gameImg05").attr("alt", "핫도그, 햄버거, 피자, 국수, 치킨, 계란프라이, 생선, 새우, 볶음밥이 그려져 있는 그림"); 
	           	$(".gametext05").css('display', 'none');
	       		$(".gametext04").css('display', 'inline');
	       		var audio = new Audio('./audio/gamesound3_20_0.wav');
	      		gameBtnFunc(audio);
	      		$("#correctAnswer").css('display', 'none'); 
	      		$("#reply").css('display', 'none'); 
	        }  
		}
	
</script>

</body>
</html>