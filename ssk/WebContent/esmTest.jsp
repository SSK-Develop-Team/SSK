<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="model.dto.User" %>
<%@ page import="model.dto.SdqTestLog" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>      
<%
	ArrayList<EsmEmotion> esmEmotionList = (ArrayList<EsmEmotion>)request.getAttribute("esmEmotionList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정서 반복 기록</title>
<style>
[type="radio"]:checked {
	border: 0.4em solid #ff6666;
}

[type="radio"]:hover {
	box-shadow: 0 0 0 max(4px, 0.2em) #ff9e9b;
	cursor: pointer;
}

[type="radio"] {
	vertical-align: middle;
	appearance: none;
	border: max(2px, 0.1em) solid gray;
	border-radius: 50%;
	width: 1.25em;
	height: 1.25em;
	transition: border 0.5s ease-in-out;
}
</style>
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	<div class="w3-container w3-center"><h4><b>정서/행동 발달 검사</b></h4></div>
	<div class="w3-row" >
		<div class="w3-col m3 l4">&nbsp;</div>
		<div class="w3-col s12 m6 l4" id="sdqChat" style="overflow:auto; height:55vh; background-color:#ededed;padding-bottom:6px;padding-top:6px;">
			<form id="esmForm" method="post" action="GetEsmTest">
			<input type="hidden" name="currEsmType" value="<%=esmEmotionList.get(0).getEsmType()%>"/>
			<%for(int i=0;i<esmEmotionList.size();i++){ %>
				<div class="w3-center">
					<div class=""><%=esmEmotionList.get(i).getEsmEmotionKr() %></div>
					<div class=""><%=esmEmotionList.get(i).getEsmEmotion() %></div>
					<div class="radio">
						<input type="radio" class="w3-radio" style="width:0.25em; height:0.25em;" name="<%=esmEmotionList.get(i).getEsmEmotion() %>" value="1" checked>
						<input type="radio" class="w3-radio" style="width:0.3em; height:0.3em;" name="<%=esmEmotionList.get(i).getEsmEmotion() %>" value="2">
						<input type="radio" class="w3-radio" style="width:0.35em; height:0.35em;" name="<%=esmEmotionList.get(i).getEsmEmotion() %>" value="3">
						<input type="radio" class="w3-radio" style="width:0.4em; height:0.4em;" name="<%=esmEmotionList.get(i).getEsmEmotion() %>" value="4">
						<input type="radio" class="w3-radio" style="width:0.45em; height:0.45em;" name="<%=esmEmotionList.get(i).getEsmEmotion() %>" value="5">
					</div>
				</div>
			<%} %>
			</form>
			<div class="w3-row">
				<div class="w3-col m8 l8">&nbsp;</div>
				<%if(esmEmotionList.get(0).getEsmType().equals("positive")){ %>
				<div class="w3-col s6 m2 l2">&nbsp;</div>
				<button class="w3-col s6 m2 l2" onclick="document.getElementById('esmForm').submit();">다음으로</button>
				<%}else{ %>
				<button class="w3-col s6 m2 l2">이전으로</button>
				<button class="w3-col s6 m2 l2" onclick="document.getElementById('esmForm').submit();">제출하기</button>
				<%} %>
			</div>
		</div>
		<div class="w3-col m3 l4">&nbsp;</div>
	</div>
</body>
</html>