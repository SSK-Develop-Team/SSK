<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="model.dto.LangGame" %>
<%@ page import="util.process.LangGameProcessor" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>


<style>	

	.gameImg03 { display : none;}
	.gameImg05 { display : none;}
	.gameImg07 { display : none;}
	.gameImg09 { display : none;}
	.gametext02 { display : none;}
	
	.Quiz01 {
		display : none;
		height : 100%;
		width : 100%;
		position : relative;
	}
	.Quiz02 {
		display : none;
		height : 100%;
		width : 100%;
		position : relative;
	}
	.Quiz03 {
		display : none;
		height : 100%;
		width : 100%;
		position : relative;
	}
	.Quiz04 {
		display : none;
		height : 100%;
		width : 100%;
		position : relative;
	}
	.Quiz05 {
		display : none;
		height : 100%;
		width : 100%;
		position : relative;
	}
	

	.select01{
		position : absolute;
		left : 15%;
		top : 50%;
	}
	.select02{
		position : absolute;
		left : 60%;
		top : 50%;
	}
	
</style>
	
</head>


<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<title>54번 문항 직접 평가</title>
</head>
<body>
<%@ include file="sidebar.jsp" %>

<div class="w3-row">
	<div class="w3-col w3-hide-small m1 l3">&nbsp;</div>
	<div class="w3-col w3-container s12 m10 l6">
		<div style="font-size:1em;font-weight:bold;">직접평가 #54</div>
		<div>
		<img class="gameImg01" src="./image/LangGameImg/Age10/age10_4_1_0.png" width="100%" height="100%" alt="싸움"/>
			<div class="Quiz01">
				<img class="gameImg02" src="./image/LangGameImg/Age10/age10_4_1.png" width="100%" alt="싸움"/>  
				<img class="select01" onclick='wrongA()' src="./image/LangGameImg/Age10/age10_4_1_select01.png" height="40%"/>
				<img class="select02" onclick='correctA()'src="./image/LangGameImg/Age10/age10_4_1_select02.jpg" height="40%"/>	
			</div>
			
		<img class="gameImg03" src="./image/LangGameImg/Age10/age10_4_2_0.png" width="100%" height="100%" alt="꼬라"/>
			<div class="Quiz02">
				<img class="gameImg04" src="./image/LangGameImg/Age10/age10_4_2.png" width="100%" alt="꼬리"/>  
				<img class="select01" onclick='wrongA()' src="./image/LangGameImg/Age10/age10_4_2_select01.png" height="40%"/>
				<img class="select02" onclick='correctA()'src="./image/LangGameImg/Age10/age10_4_2_select02.png" height="40%"/>	
			</div>
			
		<img class="gameImg05" src="./image/LangGameImg/Age10/age10_4_3_0.png" width="100%" height="100%" alt="똥"/>
			<div class="Quiz03">
				<img class="gameImg06" src="./image/LangGameImg/Age10/age10_4_3.png" width="100%" alt="똥"/>  
				<img class="select01" onclick='correctA()' src="./image/LangGameImg/Age10/age10_4_3_select01.png" height="40%"/>
				<img class="select02" onclick='wrongA()'src="./image/LangGameImg/Age10/age10_4_3_select02.png" height="40%"/>	
			</div>
			
			
		<img class="gameImg07" src="./image/LangGameImg/Age10/age10_4_4_0.png" width="100%" height="100%" alt="짜장면"/>
			<div class="Quiz04">
				<img class="gameImg08" src="./image/LangGameImg/Age10/age10_4_4.png" width="100%" alt="짜장면"/>  
				<img class="select01" onclick='wrongA()' src="./image/LangGameImg/Age10/age10_4_4_select01.jpg" height="40%"/>
				<img class="select02" onclick='correctA()'src="./image/LangGameImg/Age10/age10_4_4_select02.jpg" height="40%"/>	
			</div>
			
			
		<img class="gameImg09" src="./image/LangGameImg/Age10/age10_4_5_0.png" width="100%" height="100%" alt="빵"/>
			<div class="Quiz05">
				<img class="gameImg10" src="./image/LangGameImg/Age10/age10_4_5.png" width="100%" alt="빵"/>  
				<img class="select01" onclick='correctA()' src="./image/LangGameImg/Age10/age10_4_5_select01.png" height="40%"/>
				<img class="select02" onclick='wrongA()'src="./image/LangGameImg/Age10/age10_4_5_select02.png" height="40%"/>	
			</div>
		
			
		</div>
		<div class="w3-container w3-round-large w3-padding" style="border:1px solid #12192C;">

			<div class="w3-container w3-padding-32">
				<div class="gametext">
					<div class="gametext01">아래의 글자를 읽어보세요.</div>
					<div class="gametext02">글자의 뜻에 맞는 그림을 찾아 눌러보세요.</div>
				</div>
			</div>
			<div class="w3-container w3-right">
				<button class="w3-button" onclick="contentBack();" style="border:none; background-color:#FFFFFF;"> &lt; 이전</button>
				<button class="w3-button" onclick="content();" style="border:none; background-color:#FFFFFF;">다음 &gt; </button>
			</div>
		</div>
	</div>
	<div class="w3-col w3-hide-small m1 l3">&nbsp;</div>
</div>

</body>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<script type="text/javascript">
	var cnt = 0;
	
	//음성 재생
	window.onload = function () {
		var audio = new Audio('./audio/Age10/age_10_54_1.wav');
		audio.play();
	}
	
	if (performance.navigation.type == 1) {
		$("#rightbtn").css('display', 'inline');
	}
	
	function wrongA(){
		var audio = new Audio('./audio/wrong.mp3');
		audio.play();
	}
	
	function correctA(){
		var audio = new Audio('./audio/correct.mp3');
		audio.play();
	}
	
	function content() {  
		  
		  cnt = cnt+1;
		  
		  if(cnt == 1){
			$(".gameImg01").css('display', 'none');		
			$(".Quiz01").css('display', 'block');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'none');
       	 	$(".gametext02").css('display', 'inline');
	      	var audio = new Audio('./audio/Age10/age_10_54_2.wav');
			audio.play();
          } 
		  else if(cnt == 2){
			$(".gameImg03").css('display', 'inline');		
			$(".Quiz01").css('display', 'none');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'inline');
       	 	$(".gametext02").css('display', 'none');
	      	var audio = new Audio('./audio/Age10/age_10_54_1.wav');
			audio.play();
          }
		  else if(cnt == 3){
			$(".gameImg03").css('display', 'none');		
			$(".Quiz02").css('display', 'block');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'none');
       	 	$(".gametext02").css('display', 'inline');
	      	var audio = new Audio('./audio/Age10/age_10_54_2.wav');
			audio.play();
          } 
		  else if(cnt == 4){
			$(".gameImg05").css('display', 'inline');		
			$(".Quiz02").css('display', 'none');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'inline');
       	 	$(".gametext02").css('display', 'none');
	      	var audio = new Audio('./audio/Age10/age_10_54_1.wav');
			audio.play();
          }
		  else if(cnt == 5){
			$(".gameImg05").css('display', 'none');		
			$(".Quiz03").css('display', 'block');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'none');
       	 	$(".gametext02").css('display', 'inline');
	      	var audio = new Audio('./audio/Age10/age_10_54_2.wav');
			audio.play();
          } 
		  else if(cnt == 6){
			$(".gameImg07").css('display', 'inline');		
			$(".Quiz03").css('display', 'none');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'inline');
       	 	$(".gametext02").css('display', 'none');
	      	var audio = new Audio('./audio/Age10/age_10_54_1.wav');
			audio.play();
          }
		  else if(cnt == 7){
			$(".gameImg07").css('display', 'none');		
			$(".Quiz04").css('display', 'block');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'none');
       	 	$(".gametext02").css('display', 'inline');
	      	var audio = new Audio('./audio/Age10/age_10_54_2.wav');
			audio.play();
          } 
		  else if(cnt == 8){
			$(".gameImg09").css('display', 'inline');		
			$(".Quiz04").css('display', 'none');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'inline');
       	 	$(".gametext02").css('display', 'none');
	      	var audio = new Audio('./audio/Age10/age_10_54_1.wav');
			audio.play();
          }
		  else if(cnt == 9){
			$(".gameImg09").css('display', 'none');		
			$(".Quiz05").css('display', 'block');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'none');
       	 	$(".gametext02").css('display', 'inline');
	      	var audio = new Audio('./audio/Age10/age_10_54_2.wav');
			audio.play();
          }   
		  else if(cnt == 10){
   			if(!confirm("54번 문항의 게임을 종료하시겠습니까?")){return;}
      	  	location.href = './langTest.jsp';
          }
	}     
	
	function contentBack() {  
		  
		  cnt = cnt-1;
		  
		  if(cnt == 0){
			$(".gameImg01").css('display', 'inline');		
			$(".Quiz01").css('display', 'none');		
       	 	$("#leftbtn").css('display', 'none');
       	 	$(".gametext01").css('display', 'inline');
       	 	$(".gametext02").css('display', 'none');
	      	var audio = new Audio('./audio/Age10/age_10_54_1.wav');
			audio.play();
          } 
		  else if(cnt == 1){
			$(".gameImg03").css('display', 'none');		
			$(".Quiz01").css('display', 'block');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'none');
       	 	$(".gametext02").css('display', 'inline');
	      	var audio = new Audio('./audio/Age10/age_10_54_2.wav');
			audio.play();
          }
		  else if(cnt == 2){
			$(".gameImg03").css('display', 'inline');		
			$(".Quiz02").css('display', 'none');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'inline');
       	 	$(".gametext02").css('display', 'none');
	      	var audio = new Audio('./audio/Age10/age_10_54_1.wav');
			audio.play();
          } 
		  else if(cnt == 3){
			$(".gameImg05").css('display', 'none');		
			$(".Quiz02").css('display', 'block');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'none');
       	 	$(".gametext02").css('display', 'inline');
	      	var audio = new Audio('./audio/Age10/age_10_54_2.wav');
			audio.play();
          }
		  else if(cnt == 4){
			$(".gameImg05").css('display', 'inline');		
			$(".Quiz03").css('display', 'none');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'inline');
       	 	$(".gametext02").css('display', 'none');
	      	var audio = new Audio('./audio/Age10/age_10_54_1.wav');
			audio.play();
          } 
		  else if(cnt == 5){
			$(".gameImg07").css('display', 'none');		
			$(".Quiz03").css('display', 'block');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'none');
       	 	$(".gametext02").css('display', 'inline');
	      	var audio = new Audio('./audio/Age10/age_10_54_2.wav');
			audio.play();
          }
		  else if(cnt == 6){
			$(".gameImg07").css('display', 'inline');		
			$(".Quiz04").css('display', 'none');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'inline');
       	 	$(".gametext02").css('display', 'none');
	      	var audio = new Audio('./audio/Age10/age_10_54_1.wav');
			audio.play();
          } 
		  else if(cnt == 7){
			$(".gameImg09").css('display', 'none');		
			$(".Quiz04").css('display', 'block');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'none');
       	 	$(".gametext02").css('display', 'inline');
	      	var audio = new Audio('./audio/Age10/age_10_54_2.wav');
			audio.play();
          }
		  else if(cnt == 8){
			$(".gameImg09").css('display', 'inline');		
			$(".Quiz05").css('display', 'none');		
       	 	$("#leftbtn").css('display', 'inline');
       	 	$(".gametext01").css('display', 'inline');
       	 	$(".gametext02").css('display', 'none');
	      	var audio = new Audio('./audio/Age10/age_10_54_1.wav');
			audio.play();
          }   
		}
	
</script>
<script type="text/javascript" src="js/moveLangGameContent.js" charset="UTF-8"></script>
</html>