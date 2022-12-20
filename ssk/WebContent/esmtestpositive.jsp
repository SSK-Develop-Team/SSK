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

		boolean isTesting = true;
		session.setAttribute("isTesting", isTesting);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정서 반복 기록</title>
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
		<form name="form" id="frm" method="post" action="esmtestnegative.jsp">
		<div id="activeStr" class="emotion">
			<div id="activeKor" class="kor">활기차다</div>
			<div id="activeEng" class="eng">Active</div>
		</div>
		<div class="radio">
			<input type="radio" style="width:25px; height:25px;" name="active" value="never" checked>
			<input type="radio" style="width:30px; height:30px;" name="active" value="no">
			<input type="radio" style="width:35px; height:35px;" name="active" value="soso">
			<input type="radio" style="width:40px; height:40px;" name="active" value="yes">
			<input type="radio" style="width:45px; height:45px;" name="active" value="very">
		</div>
		<div id="proudStr" class="emotion">
			<div id="proudKor" class="kor">자랑스럽다</div>
			<div id="proudEng" class="eng">Proud</div>
		</div>
		<div class="radio">
			<input type="radio" style="width:25px; height:25px;" name="proud" value="never" checked>
			<input type="radio" style="width:30px; height:30px;" name="proud" value="no">
			<input type="radio" style="width:35px; height:35px;" name="proud" value="soso">
			<input type="radio" style="width:40px; height:40px;" name="proud" value="yes">
			<input type="radio" style="width:45px; height:45px;" name="proud" value="very">
		</div>
		<div id="passionateStr" class="emotion">
			<div id="passionateKor" class="kor">열정적이다</div>
			<div id="passionateEng" class="eng">Passionate</div>
		</div>
		<div class="radio">
			<input type="radio" style="width:25px; height:25px;" name="passionate" value="never" checked>
			<input type="radio" style="width:30px; height:30px;" name="passionate" value="no">
			<input type="radio" style="width:35px; height:35px;" name="passionate" value="soso">
			<input type="radio" style="width:40px; height:40px;" name="passionate" value="yes">
			<input type="radio" style="width:45px; height:45px;" name="passionate" value="very">
		</div>
		<div id="interestedStr" class="emotion">
			<div id="interestedKor" class="kor">흥미롭다</div>
			<div id="interestedEng" class="eng">Interested</div>
		</div>
		<div class="radio">
			<input type="radio" style="width:25px; height:25px;" name="interested" value="never" checked>
			<input type="radio" style="width:30px; height:30px;" name="interested" value="no">
			<input type="radio" style="width:35px; height:35px;" name="interested" value="soso">
			<input type="radio" style="width:40px; height:40px;" name="interested" value="yes">
			<input type="radio" style="width:45px; height:45px;" name="interested" value="very">
		</div>
		<div id="excitedStr" class="emotion">
			<div id="excitedKor" class="kor">신난다</div>
			<div id="excitedEng" class="eng">Excited</div>
		</div>
		<div class="radio">
			<input type="radio" style="width:25px; height:25px;" name="excited" value="never" checked>
			<input type="radio" style="width:30px; height:30px;" name="excited" value="no">
			<input type="radio" style="width:35px; height:35px;" name="excited" value="soso">
			<input type="radio" style="width:40px; height:40px;" name="excited" value="yes">
			<input type="radio" style="width:45px; height:45px;" name="excited" value="very">
		</div>
		<input type="submit" class="btn" id="goToNext" value="다음으로 넘어가기">
		</form>
		<input type="button" class="btn" id="cancelESM" value="취소" onClick="location.href='esmtestmain.jsp'">
			
</body>
</html>