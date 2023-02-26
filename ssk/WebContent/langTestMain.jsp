<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="model.dto.User" %>

<% 
	User currUser = (User)session.getAttribute("currUser"); 
	String name = currUser.getUserName();	
	int curAge = (int)session.getAttribute("curAge");
	
	int prevAge = 0;
	int prev2Age = 0;

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="css/selectAgeModal.css" type='text/css' >
<title>언어 발달 평가</title>
</head>
<body>
<%@ include file = "sidebar.jsp" %>
<div style="width:100%;background-color:#D9D9D9;">
<div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div>
<div class="w3-center" style="font-weight:bold;font-size:1.7em;"> 언어 발달 평가 </div>
<div class="w3-display-container" style="width:100%;height:150px;">
<div class="w3-display-middle" style="text-align:center;font-size:1em;"><%=name%>님, 현재 나이에 적합한 언어 발달 검사가 진행됩니다. <br>
			해당 언어 발달 검사가 아동에게 맞지 않는다면, 다른 나이대의 언어 발달 검사를 선택하여 진행해주세요.<br></div>
</div>
<div>&nbsp;</div><div>&nbsp;</div>
</div>
<div>&nbsp;</div><div>&nbsp;</div>
<div class="w3-row">
	<div class="w3-col s1 m3 l4">&nbsp;</div>
	<div class="w3-padding w3-col s10 m6 l4">
		<button class="w3-button w3-block w3-round-large w3-padding-16" style="background-color:#51459E;color:white;font-size:1.3em;" onclick="modalOpen()">검사하기</button>
		<div>&nbsp;</div>
		<button class="w3-button w3-block w3-round-large w3-padding-16" style="background-color:#51459E;color:white;font-size:1.3em;" onclick="location.href='AllLangResult'">결과보기</button>
	</div>
	<div class="w3-col s1 m3 l4">&nbsp;</div>
</div>
<div style="position: fixed; right: 2em; bottom: 2em;">
    <button class="w3-button w3-circle" style="background-color:#D9D9D9;width:2.7em;height:2.7em;padding:0;" onclick="location.href='childHome.jsp'">
		<img src="./image/home-icon.png" style="width:1.7em;height:1.7em;">
	</button>
</div>

<%	
	prevAge = curAge - 1;
	prev2Age = curAge - 2;
	
	if(prevAge < 0) prevAge = 14;
	if(prev2Age < 0) prev2Age = 14;
	
	String[] ageStr = new String[]{"3세 0개월 ~ 3세 3개월", "3세 4개월 ~ 3세 5개월", "3세 6개월 ~ 3세 8개월", "3세 9개월 ~ 3세 11개월", "4세 0개월 ~ 4세 3개월",
			"4세 4개월 ~ 4세 7개월", "4세 8개월 ~ 4세 11개월", "5세 0개월 ~ 5세 5개월", "5세 6개월 ~ 5세 11개월", "6세 0개월 ~ 6세 5개월", "6세 0개월 ~ 6세 11개월", 
			"7세 0개월 ~ 7세 11개월", "8세 0개월 ~ 8세 11개월", "9세 0개월 ~ 9세 11개월", ""};
	
	if(name.length() == 3){
		name = name.substring(1);
	}
	
	else if(name.length() == 4){
		name = name.substring(2);
	}
	
	char lastName = name.charAt(name.length() - 1);
	int index = (lastName - 0xAC00) % 28;
	if(index > 0) name = name + "이";
	
	session.setAttribute("curAge", curAge);
%>

	<!-- 연령 선택용 모달 -->
	<div class="modalLayer"></div>
	<div class = "modal">
		<div class = "modalFunc">
			<div class = "modalContent">
				<button class = "closeBtn" onClick="modalClose()">X</button>
				<p>현재 <%=name%>의 테스트 단계는 <span><%=curAge%></span>입니다.</p> 
				<p>(<%=ageStr[curAge] %>)</p>
				<p>해당 단계를 진행하시겠습니까?</p>
				<button id="otherBtn" onClick="selectModalOpen()">다른 단계 진행</button>
				<button id="testBtn" onClick="location.href='GetLangTest'">해당 단계 진행</button>
			</div>
		</div>
	</div>
	
	<form method="get" class = "selectModal" action="GetLangTest">
		<div class = "selectModalFunc">
			<div class = "selectModalContent">
				<button class = "closeBtn" onClick="selectModalClose()">X</button>
				<p>평가를 진행할 단계를 선택해주세요.</p> 
				
				<select id = "ageGroupSelect" name="ageGroup">
				<%if(prev2Age>=0){ %>
				    <option value="prev2Age"><%=ageStr[prev2Age] %></option>
				    <%}
				if(prevAge>=0){ %>
				    <option value="prevAge"><%=ageStr[prevAge] %></option>
				    <%} %>
				    <option value="curAge" selected="selected"><%=ageStr[curAge] %> (현재 단계)</option>
				</select>
				
				<button id="okBtn" type="submit">확인</button>
			</div>
		</div>
	</form>

</body>

<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<script type="text/javascript">

	function modalOpen(){
		$(".modal").css('display', 'block');
		$(".modalLayer").css('display', 'block');
	}
	
	function selectModalOpen(){
		$(".modal").css('display', 'none');
		$(".selectModal").css('display', 'block');
		$(".modalLayer").css('display', 'block');

		if(<%=prevAge%> === 14){
			$('#ageGroupSelect').children("[value='prevAge']").remove();
		}
		
		if(<%=prev2Age%> === 14){
			$('#ageGroupSelect').children("[value='prev2Age']").remove();
		}
	}

	function modalClose(){
		$(".modal").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}	

	function selectModalClose(){
		$(".selectModal").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}	
</script>

</html>