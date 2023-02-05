<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Vector"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.dto.LangQuestion"%>
<%@ page import="model.dto.User"%>

<%
	User currUser = (User) session.getAttribute("currUser");
	String currNumStr="";

	ArrayList<LangQuestion> currQuestionList = (ArrayList<LangQuestion>)session.getAttribute("currQuestionList");
	
	ArrayList<Integer> langProgList = new ArrayList<Integer>();
	if(session.getAttribute("langProgList") != null) langProgList = (ArrayList)session.getAttribute("langProgList");
	else {
		for(int i=0; i<5; i++){
			langProgList.add(0);
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>언어 발달 평가</title>
<style>
.textBox {
	text-align: center;
	line-height: 100px;
}

.question {
	margin-left: 20px;
	margin-right: 20px;
}

.select {
	font-size: 15px;
}

.btn{
      border : 1px solid #1a2a3a;
      border-radius : 10px;
      background-color:#1a2a3a;
      padding : 10px;
      margin : 8px;
      color : white;
      height : 50px;
      width : 150px;
   }
   
.textBox{
	font-size : 1.3em;
}
   
</style>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	<div class="container">
		
		<div class="tytleBox" style="margin-left: 12%;">
			<div class="w3-margin-top" style="font-weight:bold; font-size : 2.5em;">언어 발달 평가</div>
			<h6>질문에 답하기 어려울 경우, 직접 평가(게임)를 하고 다시 돌아와 결정해주세요.</h6>
		</div>

		<form method="post" action="ManageLangResult" style="width:80%;margin-right:10%;margin-left:10%;">
		
	<% 
		for(int i=0; i < currQuestionList.size(); i++){
			
			int gameID = currQuestionList.get(i).getLangQuestionId();
			
			if(gameID < 10) currNumStr = "Q0" + gameID;
			else currNumStr = "Q" + gameID;
		%>
		
		<div class="w3-container w3-margin-top w3-margin-bottom">
			<div class="w3-container w3-padding-large">
			 <div class="testNum"><b><%=currNumStr%></b></div>
				<div class="w3-row w3-margin">
					<div class="w3-col" style="width : 80%; background: #F4F4F4;">
						<div class="textBox"><%="우리 아이는 "  + currQuestionList.get(i).getLangQuestionContent() %></div>
					</div>
					<div class="w3-col" style="width : 15%; margin-left : 5%;">
						<div class="w3-button w3-block w3-round-large w3-padding-16" style="background-color:#51459E;color:white;margin-top:5%;" onclick="selectGame(<%=gameID%>);">게임하고 오기</div>
					</div>
				</div>
			</div> 
			<div class="w3-row w3-margin">
				<div class="w3-col w3-padding-left w3-padding-right" style="width:20%;">
					<%if(langProgList.get(i) == 1){ %> <input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="1" checked="checked">
					<%} else {%><input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="1"> <%} %>
					<label>못한다</label>
				</div>
				<div class="w3-col w3-padding-left w3-padding-right" style="width:20%;">
					<%if(langProgList.get(i) == 2){ %> <input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="2" checked="checked">
					<%} else {%><input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="2"> <%} %>
					<label>할 수 있다</label>
				</div>
				<div class="w3-col w3-padding-left w3-padding-right" style="width:20%;">
					<%if(langProgList.get(i) == 3){ %> <input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="3" checked="checked">
					<%} else {%><input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="3"> <%} %>
					<label>잘한다</label>
				</div>
				<div class="w3-col w3-padding-left w3-padding-right" style="width:20%;">
					<%if(langProgList.get(i) == 4){ %> <input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="4" checked="checked">
					<%} else {%><input type="radio" class="question w3-radio" id="reply" name="reply<%=i%>" value="4"> <%} %>
					<label>매우 잘한다</label>
				</div>
			</div>
		</div>
			<%} %>
			<p>
			<div class="btnBox" style="float : right; margin-top : 3%;">
				<input type="button" class="btn" id="cancelLang" value="취소" onClick="location.href='langTestMain.jsp'">
				<input type="submit" class="btn" id="submitLang" value="결과 제출">
			</div>
		</form>
	</div>
	
</body>

<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<script>

		
		var reply1 = "<%=langProgList.get(0)%>";
		var reply2 = "<%=langProgList.get(1)%>";
		var reply3 = "<%=langProgList.get(2)%>";
		var reply4 = "<%=langProgList.get(3)%>";
		var reply5 = "<%=langProgList.get(4)%>";
		
		$("input[name='reply0']").change(function(){
			if($("input[name='reply0']:checked")){
				reply1 = $("input[name='reply0']:checked").val();
			}
		});
		$("input[name='reply1']").change(function(){
			if($("input[name='reply1']:checked")){
				reply2 = $("input[name='reply1']:checked").val();
			}
		});
		$("input[name='reply2']").change(function(){
			if($("input[name='reply2']:checked")){
				reply3 = $("input[name='reply2']:checked").val();
			}
		});
		$("input[name='reply3']").change(function(){
			if($("input[name='reply3']:checked")){
				reply4 = $("input[name='reply3']:checked").val();
			}
		});
		$("input[name='reply4']").change(function(){
			if($("input[name='reply4']:checked")){
				reply5 = $("input[name='reply4']:checked").val();
			}
		});


	function selectGame(param){
		var form = document.createElement('form');
		form.setAttribute('method','post');
		form.setAttribute('action', 'GetLangGame');
		document.charset = "utf-8";

		var input = document.createElement('input');
		input.setAttribute('type', 'hidden');
		input.setAttribute('name', 'langGameID');
		input.setAttribute('value', param);
		
		var inputReply1 = document.createElement('input');
		inputReply1.setAttribute('type', 'hidden');
		inputReply1.setAttribute('name', 'langTestProgress1');
		inputReply1.setAttribute('value', reply1);
		
		var inputReply2 = document.createElement('input');
		inputReply2.setAttribute('type', 'hidden');
		inputReply2.setAttribute('name', 'langTestProgress2');
		inputReply2.setAttribute('value', reply2);
		
		var inputReply3 = document.createElement('input');
		inputReply3.setAttribute('type', 'hidden');
		inputReply3.setAttribute('name', 'langTestProgress3');
		inputReply3.setAttribute('value', reply3);
		
		var inputReply4 = document.createElement('input');
		inputReply4.setAttribute('type', 'hidden');
		inputReply4.setAttribute('name', 'langTestProgress4');
		inputReply4.setAttribute('value', reply4);
		
		var inputReply5 = document.createElement('input');
		inputReply5.setAttribute('type', 'hidden');
		inputReply5.setAttribute('name', 'langTestProgress5');
		inputReply5.setAttribute('value', reply5);
		
		form.appendChild(input);
		form.appendChild(inputReply1);
		form.appendChild(inputReply2);
		form.appendChild(inputReply3);
		form.appendChild(inputReply4);
		form.appendChild(inputReply5);

		document.body.appendChild(form);
		form.submit(); 		
		
	}	
	

</script>

</html>
