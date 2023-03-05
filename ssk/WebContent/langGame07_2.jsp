<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="model.dto.LangGame" %>
<%@ page import="util.process.LangGameProcessor" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<%
		User currUser = (User)session.getAttribute("currUser");
		int gameID = (int)session.getAttribute("langGameID");

		ArrayList<LangGame> langGameList = (ArrayList<LangGame>)session.getAttribute("currLangGameList");
		int i = (int)session.getAttribute("currLangGameIndex");

		LangGame currLangGameElement = langGameList.get(i);
		int audioEndedNextFlag = 0;
		if(currLangGameElement.getLangGameHint()==null&&currLangGameElement.getLangGameHintVoice()==null&&currLangGameElement.getLangGameAnswer()==null&&currLangGameElement.getLangGameAnswerVoice()==null){
			audioEndedNextFlag = 1;
		}

		String langGameContent = LangGameProcessor.changeNameOfLangGameContent(currLangGameElement.getLangGameContent(), currUser.getUserName()) ;
	%>
	<title><%= gameID %>번 문항 직접 평가</title>
	<link href="css/langGame07_2.css" rel="stylesheet" type='text/css' >
</head>
<body>
<%@ include file="sidebar.jsp" %>

<div class="w3-row">
	<div class="w3-col w3-hide-small m1 l3">&nbsp;</div>
	<div class="w3-col w3-container s12 m10 l6">
		<div style="font-size:1em;font-weight:bold;">직접평가 #<%= gameID %></div>
		<div class="container">
			<img src="<%=currLangGameElement.getLangGameImg() %>" style="width:100%"/>
			<img class="numImg" id="numImg01" src="./image/age3_num1.png" alt="1번 엄마 버튼"/>
			<img class="numImg" id="numImg02" src="./image/age3_num2.png" alt="2번 바나나 버튼"/>
			<img class="numImg" id="numImg03" src="./image/age3_num3.png" alt="3번 포도 버튼"/>
			<img class="numImg" id="numImg04" src="./image/age3_num4.png" alt="4번 아빠 버튼"/>
			<div id="click-modal" class="w3-modal modal">
				<div class="modal-content w3-modal-content w3-animate-opacity w3-round-large">
					<div class="w3-container w3-center">
						<span onclick="document.getElementById('click-modal').style.display='none'" class="w3-button w3-display-topright w3-round-xxlarge">&times;</span>
						<p id="click-content-text"></p>
						<audio id="click-content-audio" controls onended="document.getElementById('click-modal').style.display='none'">
							<source src="">
						</audio>
					</div>
				</div>
			</div>
		</div>
		<% if(currLangGameElement.getLangGameSpeaker().equals("-")) { %><div class="w3-col m2 l3">&nbsp;</div><%} %>
		<% if(! currLangGameElement.getLangGameSpeaker().equals("-")){%><div class="w3-container w3-round-large" style="background-color:#12192C; color:white; width:100px;text-align:center;padding:2px;"><%=currLangGameElement.getLangGameSpeaker() %></div><%} %>
		<div class="w3-container w3-round-large w3-padding" style="border:1px solid #12192C;">

			<div class="w3-container w3-padding-32"><%=langGameContent%></div>
			<div class="w3-container w3-right">
				<%if(i>0){%><button class="w3-button" onclick="getPrevContent(<%=i%>);" style="border:none; background-color:#FFFFFF;"> &lt; 이전</button><%} %>
				<%if(i<=langGameList.size()-1){ %><button class="w3-button" onclick="getNextContent(<%=i%>, <%= gameID %>,<%=langGameList.size()%>);" style="border:none; background-color:#FFFFFF;">다음 &gt; </button><%}%>
			</div>
		</div>
		<div class="w3-left" style="margin-top:5px;">
			<%if(currLangGameElement.getLangGameHint()!=null||currLangGameElement.getLangGameHintVoice()!=null){ %>
			<button class="w3-button w3-round-large" onclick="document.getElementById('hint-modal').style.display='block';document.getElementById('hint-audio').autoplay();" style="background-color:#12192C; color:white; text-align:center;font-size:0.9em;margin-right:5px;">힌트 확인하기</button>
			<div id="hint-modal" class="w3-modal">
				<div class="w3-modal-content w3-animate-opacity w3-round-large" style="width:40vw;height: 50vh;">
					<div class="w3-container w3-center">
						<span onclick="document.getElementById('hint-modal').style.display='none'" class="w3-button w3-display-topright w3-round-xxlarge">&times;</span>
						<%if(currLangGameElement.getLangGameHint()!=null){ %>
						<p><br><br><br><br><%=currLangGameElement.getLangGameHint() %></p>
						<%}%>
					</div>
				</div>
			</div>
			<%} %>
			<%if(currLangGameElement.getLangGameAnswer()!=null||currLangGameElement.getLangGameAnswerVoice()!=null){ %>
			<button class="w3-button w3-round-large" onclick="document.getElementById('answer-modal').style.display='block';document.getElementById('answer-audio').autoplay();" style="background-color:#12192C; color:white; text-align:center;font-size:0.9em;margin-right:5px;">정답 확인하기</button>
			<div id="answer-modal" class="w3-modal">
				<div class="w3-modal-content w3-animate-opacity w3-round-large" style="width:40vw;height: 40vh;">
					<div class="w3-container w3-center">
						<span onclick="document.getElementById('answer-modal').style.display='none'" class="w3-button w3-display-topright w3-round-xxlarge">&times;</span>
						<%if(currLangGameElement.getLangGameAnswer()!=null){ %>
						<p><br><br><br><br><%=currLangGameElement.getLangGameAnswer() %></p>
						<%} %>
						<%if(currLangGameElement.getLangGameAnswerVoice()!=null){ %>
						<audio controls onended="document.getElementById('answer-modal').style.display='none'">
							<source src="<%=currLangGameElement.getLangGameAnswerVoice()%>">
						</audio>
						<%} %>
					</div>
				</div>
			</div>
			<%} %>
		</div>
	</div>
	<div class="w3-col w3-hide-small m1 l3">&nbsp;</div>
</div>

</body>
<script>
	window.onload = function () {
		var audio = new Audio();
		audio.src="<%=langGameList.get(i).getLangGameVoice()%>";
		if(<%=audioEndedNextFlag%>==1){
			audio.addEventListener("onended",function(){
				alert("end");
				getNextContent(<%=i%>,<%=gameID%>,<%=langGameList.size()%>);
			});
		}
		audio.play();
	}
</script>
<script type="text/javascript" src="js/moveLangGameContent.js" charset="UTF-8"></script>
</html>