<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>계정 생성</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<c:set var="role" scope="page" value="${param.role}"/>
<body onLoad="regFrm.userId.focus()">
 	<div class="header w3-padding-16 w3-center w3-container w3-margin">
 	<c:choose>
	    <c:when test="${role eq 'expert'}">
			<h2><b>전문가 계정 생성</b></h2>
	    </c:when>
	    <c:when test="${role eq 'child'}">
			<h2><b>아동 계정 생성</b></h2>
	    </c:when>
	</c:choose>
 	</div>
 	<hr>
 	<br>
	<div class="w3-row" style="height:100%;, width:100%;">
		<div class="w3-col s1 m2 l4">&nbsp;</div>
		<div class="w3-col s10 m8 l4 w3-padding-large w3-light-gray ">
		<form name="regFrm" method="post" action="DoRegister" class="w3-container" onsubmit="return checkValue();">
			<div class="w3-margin-top">
				<label><span style="color:red; margin-left:-5px;">*</span>아이디</label>
				<div class="w3-row">
					<input type="text" class="w3-input w3-threequarter" id="userId" name="userId" placeholder="ID" required> 
					<input type="button" class="w3-quarter w3-input w3-button" id="checkId" style="color:white;background-color:#51459E;" value="중복확인">
				</div>
				<span id="check_id_m" class="msg"></span>
			</div>
			<div class="w3-margin-top">
				<label><span style="color:red; margin-left:-5px;">*</span>패스워드</label>
				<input type="password" class="w3-input" id="userPw" name="userPw" placeholder="Password" required>
			</div>
			<div class="w3-margin-top">
				<label><span style="color:red; margin-left:-5px;">*</span>패스워드 확인</label>
				<input type="password" class="w3-input" id="userPwChk" name="userPwChk" placeholder="Password Check" required>
				<span id="check_pw_m" class="msg"></span>
			</div>
			<div class="w3-margin-top">
				<c:choose>
				    <c:when test="${role eq 'expert'}">
						<label><span style="color:red; margin-left:-5px;">*</span>전문가 이름</label>
						<input type="hidden" id="userRole" name="userRole" value="EXPERT" required>
				    </c:when>
				    <c:when test="${role eq 'child'}">
						<label><span style="color:red; margin-left:-5px;">*</span>아동 이름</label>
						<input type="hidden" id="userRole" name="userRole" value="CHILD" required>
				    </c:when>
				</c:choose>
				<input type="text" class="w3-input" id="userName" name="userName" placeholder="Name" required>
				<span id="check_name_m" class="msg"></span>
			</div>
			<c:choose>
			    <c:when test="${role eq 'child'}">
					<div class="w3-margin-top">
						<div><span style="color:red; margin-left:-5px;">*</span>성별</div>
						<label>남</label>
						<input type="radio" class="w3-radio" name="userGender" value="male" required> 
						<label>여</label>
						<input type="radio" class="w3-radio" name="userGender" value="female" required>
					</div>
					<div class="w3-margin-top">
						<label><span style="color:red; margin-left:-5px;">*</span>생년월일</label>
						<input type="date" class="w3-input" name="userBirth" required><br />
					</div>
			    </c:when>
			    <c:otherwise>
				</c:otherwise>
			</c:choose>
			<div class="w3-margin-top">
				<label>이메일</label>
				<input type="text" class="w3-input" id="userEmail" name="userEmail" placeholder="Email">
				<span id="check_email_m" class="msg"></span>
			</div>
			<div class="w3-margin-top w3-left">
				<div class="w3-button" style="color:white;background-color:#51459E;" onclick="history.go(-1);" > 뒤로가기 </div>
			</div>
			<div class="w3-margin-top w3-right">
				<button type="submit" class="w3-button" style="color:white;background-color:#51459E;" > 회원 가입 </button>
			</div>
			</form>
		</div>
		<div class="w3-col s1 m2 l4">&nbsp;</div>
	</div>
	<script type="text/javascript" src="./js/checkregister.js"></script>
</body>
</html>