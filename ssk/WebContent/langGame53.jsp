<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="model.dto.LangGame" %>
<%@ page import="util.process.LangGameProcessor" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>


<style>
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
	
	#chooseA1 {
		position : absolute;
		left : 50%;
		top : 20%;
	}
	
	#chooseA2 {
		position : absolute;
		left : 50%;
		top : 50%;
	}
	
	.gametext02 { display : none; }

</style>
	
</head>


<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<title>53번 문항 직접 평가</title>
</head>
<body>
<%@ include file="sidebar.jsp" %>

<div class="w3-row">
	<div class="w3-col w3-hide-small m1 l3">&nbsp;</div>
	<div class="w3-col w3-container s12 m10 l6">
		<div style="font-size:1em;font-weight:bold;">직접평가 #53</div>
		<div>
			<img class="gameImg01" src="./image/LangGameImg/Age10/age10_3_0.png" width="100%" alt="연필과 연필로 그은 곡선"/>
			<div class="Quiz01">
				<img class="gameImg02" src="./image/LangGameImg/Age10/age10_3_1.png" width="100%" alt="고양이가 쥐를 잡고 있는 그림"/>  
				<button class="w3-button w3-container w3-round-large" id="chooseA1" onclick='wrongA()' style="background-color:#ffffff; text-align:center;padding:10px; border:2px solid #000000;">고양이는 쥐에게 잡혀요.</button>	
				<button class="w3-button w3-container w3-round-large" id="chooseA2" onclick='correctA()' style="background-color:#ffffff; text-align:center;padding:10px; border:2px solid #000000;">고양이는 쥐를 잡아요.</button>	
			</div>
			
			<div class="Quiz02">
				<img class="gameImg03" src="./image/LangGameImg/Age10/age10_3_2.png" width="100%" alt="고양이가 물고기를 먹고 있는 그림"/>  
				<button class="w3-button w3-container w3-round-large" id="chooseA1" onclick='correctA()' style="background-color:#ffffff; text-align:center;padding:10px; border:2px solid #000000;">물고기는 고양이에게 먹혀요.</button>	
				<button class="w3-button w3-container w3-round-large" id="chooseA2" onclick='wrongA()' style="background-color:#ffffff; text-align:center;padding:10px; border:2px solid #000000;">물고기는 고양이를 먹어요.</button>	
			</div>

		</div>
	
	<div class="w3-container w3-round-large w3-padding" style="border:1px solid #12192C;">

		<div class="w3-container w3-padding-32">
			<div class="gametext">
				<div class="gametext01">그림을 보고 정답이라 생각하는 문장 버튼을 눌러보아요!</div>
				<div class="gametext02">그림을 바르게 설명하는 문장에 짝지어 보아요.</div>
			</div>
		</div>
		<div class="w3-container w3-right">
			<button class="w3-button" onclick="contentBack();" style="border:none; background-color:#FFFFFF;"> &lt; 이전</button>
			<button class="w3-button" onclick="content();" style="border:none; background-color:#FFFFFF;">다음 &gt; </button>
		</div>
	</div>
		<div class="w3-left" style="margin-top:5px;">
		
	      <button class="w3-button w3-round-large" onclick="document.getElementById('hint-modal').style.display='block';" style="background-color:#12192C; color:white; text-align:center;font-size:0.9em;margin-right:5px;">힌트 확인하기</button>
	      <div id="hint-modal" class="w3-modal">
	        <div class="w3-modal-content w3-animate-opacity w3-round-large" style="width:40vw;height: 40vh;">
	          <div class="w3-container w3-center">
	            <span onclick="document.getElementById('hint-modal').style.display='none'" class="w3-button w3-display-topright w3-round-xxlarge">&times;</span>
	            <p><br><br><br><br>들려주는 말에 맞는 그림을 고르는지 확인해주세요.<br>
	          </div>
	        </div>
	      </div>
		
			<button class="w3-button w3-round-large" onclick="document.getElementById('answer-modal').style.display='block';document.getElementById('answer-audio').autoplay();" style="background-color:#12192C; color:white; text-align:center;font-size:0.9em;margin-right:5px;">정답 확인하기</button>
			<div id="answer-modal" class="w3-modal">
				<div class="w3-modal-content w3-animate-opacity w3-round-large" style="width:40vw;height: 40vh;">
					<div class="w3-container w3-center">
						<span onclick="document.getElementById('answer-modal').style.display='none'" class="w3-button w3-display-topright w3-round-xxlarge">&times;</span>
						<p><br><br><br><br>1) 고양이는 쥐를 잡아요  2) 물고기는 고양이한테 먹혀요 
					</div>
				</div>
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
		var audio = new Audio('./audio/Age10/age_10_53_1.wav');
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
       	 	$("#gametext01").css('display', 'none');
       	 	$("#gametext02").css('display', 'inline');
	      	var audio = new Audio('./audio/Age10/age_10_53_1.wav');
			audio.play();
          }
		  else if(cnt == 2){
	      		$(".Quiz01").css('display', 'none');
	      		$(".Quiz02").css('display', 'block');
	      		$("#leftbtn").css('display', 'inline');
	      		$("#answer").css('display', 'inline');
		      	var audio = new Audio('./audio/Age10/age_10_53_1.wav');
				audio.play();
	       } 
          else if(cnt == 3){
      			if(!confirm("53번 문항의 게임을 종료하시겠습니까?")){return;}
        	  	location.href = './langTest.jsp';
          }
	}     
	
	function contentBack() {  
		  
		  cnt = cnt-1;
		  
		  if(cnt == 0){
				$(".gameImg01").css('display', 'inline');			
				$(".Quiz01").css('display', 'none');			
        		$("#answer").css('display', 'none');
        		$("#leftbtn").css('display', 'none');
           	 	$("#gametext01").css('display', 'inline');
           	 	$("#gametext02").css('display', 'none');
	          }
			  else if(cnt == 1){
	      		$(".Quiz01").css('display', 'block');
	      		$(".Quiz02").css('display', 'none');
	      		$("#answer").css('display', 'none');
		      	var audio = new Audio('./audio/Age10/age_10_53_1.wav');
				audio.play();
	       	} 
	      		
		}
	
</script>
<script type="text/javascript" src="js/moveLangGameContent.js" charset="UTF-8"></script>
</html>