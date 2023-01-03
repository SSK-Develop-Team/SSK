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

	int gameID = (int)session.getAttribute("langGameIndex");
	
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
</head>
<body>
<%@ include file="sidebar.jsp" %>
<h2>직접평가 #<%= gameID %></h2>
<div class="w3-row">
<div class="w3-col m2 l3">&nbsp;</div>
<div class="w3-col w3-container s12 m8 l6">
	<div><img src="<%=currLangGameElement.getLangGameImg() %>" style="width:100%"/></div>
	<div class="w3-container w3-round-large" style="background-color:#12192C; color:white; width:100px;text-align:center;padding:2px;"><%=currLangGameElement.getLangGameSpeaker() %></div>
	<div class="w3-container w3-round-large w3-padding" style="border:1px solid #12192C;">
		
		<div class="w3-container w3-padding-32"><%=langGameContent%></div>
		<div class="w3-container w3-right">
		<%if(i>0){%>
			<button class="w3-button" onclick="getPrevContent(<%=i%>);" style="border:none; background-color:#FFFFFF;"> &lt; 이전</button>
			<button class="w3-button" onclick="getNextContent(<%=i%>, <%= gameID %>,<%=langGameList.size()%>);" style="border:none; background-color:#FFFFFF;">다음 &gt; </button>
		<%}%>
		</div>
	</div>
	<div class="w3-row w3-padding">
	<div class="w3-col w3-left"style="width:65%;">
		<%if(currLangGameElement.getLangGameHint()!=null||currLangGameElement.getLangGameHintVoice()!=null){ %>
		<button class="w3-button w3-container w3-round-large" onclick="document.getElementById('hint-modal').style.display='block';document.getElementById('hint-audio').autoplay();" style="background-color:#12192C; color:white; text-align:center;padding:3px;">힌트 확인하기</button>
		<div id="hint-modal" class="w3-modal">
		    <div class="w3-modal-content w3-animate-opacity">
		      <div class="w3-container">
		        <span onclick="document.getElementById('hint-modal').style.display='none'" class="w3-button w3-display-topright">&times;</span>
		        <%if(currLangGameElement.getLangGameHint()!=null){ %>
		        	<p><%=currLangGameElement.getLangGameHint() %></p>
		        <%}%>
		        <%if(currLangGameElement.getLangGameHintVoice()!=null){ %>
		        	<audio id="hint-audio" controls onended="document.getElementById('hint-modal').style.display='none'">
		        		<source src="<%=currLangGameElement.getLangGameHintVoice()%>">
		        	</audio>
		        <%}%>
		      </div>
		    </div>
	    </div>
		<%} %>
		<%if(currLangGameElement.getLangGameAnswer()!=null||currLangGameElement.getLangGameAnswerVoice()!=null){ %>
		<button class="w3-button w3-container w3-round-large" onclick="document.getElementById('answer-modal').style.display='block'" style="background-color:#12192C; color:white; text-align:center;padding:3px;">정답 확인하기</button>
		<div id="answer-modal" class="w3-modal">
		    <div class="w3-modal-content w3-animate-opacity">
		      <div class="w3-container">
		        <span onclick="document.getElementById('answer-modal').style.display='none'" class="w3-button w3-display-topright">&times;</span>
		        <%if(currLangGameElement.getLangGameAnswer()!=null){ %>
		        	<p><%=currLangGameElement.getLangGameAnswer() %></p>
		        <%} %>
		        <%if(currLangGameElement.getLangGameAnswerVoice()!=null){ %>
		        	<audio autoplay controls onended="document.getElementById('answer-modal').style.display='none'">
		        		<source src="<%=currLangGameElement.getLangGameAnswerVoice()%>">
		        	</audio>
		        <%} %>
		      </div>
		    </div>
	    </div>
		<%} %>
	</div>
	</div>
</div>
<div class="w3-col m2 l3">&nbsp;</div>
</div>
	
</body>
<script>

function getPrevContent(i){
	if(i<=0){
		alert("이전 페이지가 없습니다.");
	}else{
		var prevForm = document.createElement("form");
		prevForm.setAttribute("charset", "UTF-8");
		prevForm.setAttribute("method", "post");
		prevForm.setAttribute("action", "/EwhaSSK/GetLangGamePrevContent"); 
		document.body.appendChild(prevForm);
		prevForm.submit();
	}
}

function getNextContent(i,questionNum,gameSize){
	if(i>=gameSize-1){
		if(!confirm(questionNum + "번 문항의 게임을 종료하시겠습니까?")){return;}
	}
	var nextForm = document.createElement("form");
	nextForm.setAttribute("charset", "UTF-8");
	nextForm.setAttribute("method", "post");
	nextForm.setAttribute("action", "/EwhaSSK/GetLangGameNextContent"); 
	document.body.appendChild(nextForm);
	nextForm.submit();		
}

function inputResult(inputValue, i, questionNum, gameSize){
	if(i>=gameSize-1){
		if(!confirm(questionNum + "번 문항의 게임을 종료하시겠습니까?")){return;}
	}
	var nextForm = document.createElement("form");
	nextForm.setAttribute("charset", "UTF-8");
	nextForm.setAttribute("method", "post");
	nextForm.setAttribute("action", "/EwhaSSK/GetLangGameNextContent");
	
	var input = document.createElement('input');
	input.setAttribute('type','hidden');
	input.setAttribute('name','langGameResultInput');
	input.setAttribute('value',inputValue);
	
	nextForm.appendChild(input);
	
	document.body.appendChild(nextForm);
	nextForm.submit();		
	
}

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
</html>