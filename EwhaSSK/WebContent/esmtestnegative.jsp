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
    	User currUser = (User)session.getAttribute("currUser");
    	String id = currUser.getUserLoginId();
    	String name = currUser.getUserName();
    	int userid = currUser.getUserId();

    	session.setAttribute("currUser", currUser);
%>
<%
	String active = (String)request.getParameter("active");
	String proud = (String)request.getParameter("proud");
	String passionate = (String)request.getParameter("passionate");
	String interested = (String)request.getParameter("interested");
	String excited = (String)request.getParameter("excited");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body{
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

#frm{
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

h3 {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 1%;
	font-size: 25px;
}

.emotion{
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	margin-top : 15px;
}

.btn {
	border : 1px solid #ff6666;
			border-radius : 10px;
			background-color:#ff6666;
			padding : 10px;
			margin : 20px;
			color : white;
			height : 50px;
			width : 350px;
			font-size : 20px;
}

.radio{
	margin : 20px;
}

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
	<h3>정서 반복 기록 기록하기</h3>
	<p>
		현재 우리 아이의 기분은 어떠한가요?<br>
		정도에 따라 모든 항목을 체크해 주세요.
	</p>
	<form name="form" id="frm" method="post" action="doESMTest">
	<input type="hidden" name="active" id="active" value=<%=active %>>
	<input type="hidden" name="proud" id="proud" value=<%=proud %>>
	<input type="hidden" name="passionate" id="passionate" value=<%=passionate %>>
	<input type="hidden" name="interested" id="interested" value=<%=interested %>>
	<input type="hidden" name="excited" id="excited" value=<%=excited %>>
	
		<div id="afraidStr" class="emotion">
			<div id="afraidKor" class="kor">두렵다</div>
			<div id="afraidEng" class="eng">Afraid</div>
		</div>
		<div class="radio">
			<input type="radio" style="width:25px; height:25px;" name="afraid" value="never" checked>
			<input type="radio" style="width:30px; height:30px;" name="afraid" value="no">
			<input type="radio" style="width:35px; height:35px;" name="afraid" value="soso">
			<input type="radio" style="width:40px; height:40px;" name="afraid" value="yes">
			<input type="radio" style="width:45px; height:45px;" name="afraid" value="very">
		</div>
		<div id="scaredStr" class="emotion">
			<div id="scaredKor" class="kor">겁이 난다</div>
			<div id="scaredEng" class="eng">Scared</div>
		</div>
		<div class="radio">
			<input type="radio" style="width:25px; height:25px;" name="scared" value="never" checked>
			<input type="radio" style="width:30px; height:30px;" name="scared" value="no">
			<input type="radio" style="width:35px; height:35px;" name="scared" value="soso">
			<input type="radio" style="width:40px; height:40px;" name="scared" value="yes">
			<input type="radio" style="width:45px; height:45px;" name="scared" value="very">
		</div>
		<div id="jitteryStr" class="emotion">
			<div id="jitteryKor" class="kor">초조하다</div>
			<div id="jitteryEng" class="eng">Jittery</div>
		</div>
		<div class="radio">
			<input type="radio" style="width:25px; height:25px;" name="jittery" value="never" checked>
			<input type="radio" style="width:30px; height:30px;" name="jittery" value="no">
			<input type="radio" style="width:35px; height:35px;" name="jittery" value="soso">
			<input type="radio" style="width:40px; height:40px;" name="jittery" value="yes">
			<input type="radio" style="width:45px; height:45px;" name="jittery" value="very">
		</div>
		<div id="nervousStr" class="emotion">
			<div id="nervousKor" class="kor">긴장하다</div>
			<div id="nervousEng" class="eng">Nervous</div>
		</div>
		<div class="radio">
			<input type="radio" style="width:25px; height:25px;" name="nervous" value="never" checked>
			<input type="radio" style="width:30px; height:30px;" name="nervous" value="no">
			<input type="radio" style="width:35px; height:35px;" name="nervous" value="soso">
			<input type="radio" style="width:40px; height:40px;" name="nervous" value="yes">
			<input type="radio" style="width:45px; height:45px;" name="nervous" value="very">
		</div>
		<div id="distressedStr" class="emotion">
			<div id="distressedKor" class="kor">괴롭다</div>
			<div id="distressedEng" class="eng">Distressed</div>
		</div>
		<div class="radio">
			<input type="radio" style="width:25px; height:25px;" name="distressed" value="never" checked>
			<input type="radio" style="width:30px; height:30px;" name="distressed" value="no">
			<input type="radio" style="width:35px; height:35px;" name="distressed" value="soso">
			<input type="radio" style="width:40px; height:40px;" name="distressed" value="yes">
			<input type="radio" style="width:45px; height:45px;" name="distressed" value="very">
		</div>
		<input type="submit" class="btn" id="submitESM" value="결과 제출하기">
		</form>
		<input type="button" class="btn" id="cancelSubmitESM" value="취소" onClick="location.href='esmtestmain.jsp'">
			
</body>
</html>