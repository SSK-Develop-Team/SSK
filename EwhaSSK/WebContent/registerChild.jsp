<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>아동 계정 만들기</title>
<script type="text/javascript" src="./js/checkregister.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<%
	
%>
<script type="text/javascript">
	function idCheck(id) {
		frm = document.regFrm;
		if (id == "") {
			alert("아이디를 입력해 주세요.");
			frm.user_login_id.focus();
			return;
		}
		url = "../EwhaSSK/checkId?id=" + id;
		window.open(url, "IDCheck", "width=300,height=150");
	}

</script>

</head>
<body onLoad="regFrm.user_login_id.focus()">
 	<%@ include file="sidebar.jsp" %>
 	<div class="header w3-padding-16 w3-center">
 		<h2><b>아동 계정 만들기</b></h2>
 	</div>
 	<hr>
 	<br>
	<div class="w3-display-container" style="height:100%;, width:100%;">
		<div class="w3-display-topmiddle w3-padding-large w3-light-gray ">
		<form name="regFrm" method="post" action="DoRegisterChild" class="w3-container">
			<div class="w3-margin-top">
				<label>아이디</label>
				<div class="w3-row">
					<input type="text" class="reg w3-input w3-threequarter" name="userid" placeholder="ID"> 
					<input type="button" class="w3-quarter w3-input w3-button" style="color:white;background-color:#51459E;" value="중복확인" onClick="idCheck(this.form.userid.value)">
				</div>
			</div>
			<div class="w3-margin-top">
				<label>패스워드</label>
				<input type="password" class="reg w3-input" name="userpw" placeholder="Password">
			</div>
			<div class="w3-margin-top">
				<label>패스워드 확인</label>
				<input type="password" class="reg w3-input" name="userpwchk" placeholder="Password Check">
			</div>
			<div class="w3-margin-top">
				<label>아동 이름</label>
				<input type="text" class="reg w3-input" name="username" placeholder="Child Name">
			</div>
			<div class="w3-margin-top">
				<div>성별</div>
				<label>남</label>
				<input type="radio" class="w3-radio" name="usergender" value="male"> 
				<label>여</label>
			<input type="radio" class="w3-radio" name="usergender" value="female">
			</div>
			<div class="w3-margin-top">
				<label>생년월일</label>
				<input type="date" class="reg w3-input" name="userbirth"><br />
			</div>
			<div class="w3-margin-top w3-right">
				<button type="submit" class="w3-button" style="color:white;background-color:#51459E;" > 회원 가입 </button>
			</div>
			</form>
		</div>
		
	</div>
</body>
</html>