<%@ page import="model.dto.User" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
	<!--user (O):계정 수정, (X):계정 생성-->
	<c:set var="user" scope="page" value="${requestScope.user}"/>
	<c:choose>
		<c:when test="${user ne null}">
			<title>계정 수정</title>
		</c:when>
		<c:when test="${user eq null}">
			<title>계정 생성</title>
		</c:when>
	</c:choose>

	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<script src="https://kit.fontawesome.com/b2739fdad0.js" crossorigin="anonymous"></script>
	<style>
		.field-icon {
			float: right;
			padding-right:1.75em;
			margin-top: -25px;
			position: relative;
			z-index: 2;
		}
	</style>
</head>

<c:set var="role" scope="page" value="${param.role}"/>
<body onLoad="regFrm.userId.focus()">
 	<div class="header w3-padding-16 w3-center w3-container w3-margin">
 	<c:choose>
	    <c:when test="${role eq 'expert'&& user eq null}">
			<h2><b>전문가 계정 생성</b></h2>
	    </c:when>
	    <c:when test="${role eq 'child' && user eq null}">
			<h2><b>아동 계정 생성</b></h2>
	    </c:when>
		<c:when test="${role eq 'expert'&& user ne null}">
			<h2><b>전문가 계정 수정</b></h2>
		</c:when>
		<c:when test="${role eq 'child' && user ne null}">
			<h2><b>아동 계정 수정</b></h2>
		</c:when>
	</c:choose>
 	</div>
 	<hr>
 	<br>
	<div class="w3-row" style="height:100%;, width:100%;">
		<div class="w3-col s1 m2 l4">&nbsp;</div>
		<div class="w3-col s10 m8 l4 w3-padding-large w3-light-gray ">
		<form name="regFrm" method="post" id="frm" class="w3-container" onsubmit="return checkValue();">
			<div class="w3-margin-top">
				<label><span style="color:red; margin-left:-5px;">*</span>아이디</label>
				<div class="w3-row">
					<input type="text" class="w3-input w3-threequarter" id="userId" name="userId" placeholder="ID" value="${user.userLoginId}" required>
					<input type="hidden" id="originUserId" name="originUserId" value="${user.userId}">
					<input type="hidden" id="originUserLoginId" name="originUserLoginId" value="${user.userLoginId}">
					<input type="button" class="w3-quarter w3-input w3-button" id="checkId" style="color:white;background-color:#51459E;" value="중복확인">
				</div>
				<span id="check_id_m" class="msg"></span>
			</div>
			<div class="w3-margin-top">
				<label><span style="color:red; margin-left:-5px;">*</span>패스워드</label>
				<input type="password" class="w3-input" id="userPw" name="userPw" value="${user.userPassword}" placeholder="Password" required>
				<span class="fa fa-fw fa-eye field-icon toggle-password" id="pwToggleIcon" onclick="togglePasswordType()"></span>
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
				<input type="text" class="w3-input" id="userName" name="userName" value="${user.userName}" placeholder="Name" required>
				<span id="check_name_m" class="msg"></span>
			</div>
			<c:choose>
			    <c:when test="${role eq 'child'}">
					<div class="w3-margin-top">
						<div><span style="color:red; margin-left:-5px;">*</span>성별</div>
						<c:choose>
							<c:when test="${user eq null}">
								<label>남</label>
								<input type="radio" class="w3-radio" name="userGender" value="male" required>
								<label>여</label>
								<input type="radio" class="w3-radio" name="userGender" value="female" required>
							</c:when>
							<c:when test="${user.userGender eq 'male'}">
								<label>남</label>
								<input type="radio" class="w3-radio" name="userGender" value="male" checked required>
								<label>여</label>
								<input type="radio" class="w3-radio" name="userGender" value="female" required>
							</c:when>
							<c:when test="${user.userGender eq 'female'}">
								<label>남</label>
								<input type="radio" class="w3-radio" name="userGender" value="male" required>
								<label>여</label>
								<input type="radio" class="w3-radio" name="userGender" value="female" checked required>
							</c:when>
						</c:choose>

					</div>
					<div class="w3-margin-top">
						<label><span style="color:red; margin-left:-5px;">*</span>생년월일</label>
						<input type="date" class="w3-input" name="userBirth" value="${user.userBirth}" required><br />
					</div>
			    </c:when>
			    <c:otherwise>
				</c:otherwise>
			</c:choose>
			<div class="w3-margin-top">
				<label>이메일</label>
				<input type="text" class="w3-input" id="userEmail" name="userEmail" value="${user.userEmail}" placeholder="Email">
				<span id="check_email_m" class="msg"></span>
			</div>
			<div class="w3-margin-top w3-left">
				<div class="w3-button" style="color:white;background-color:#51459E;" onclick="history.go(-1);" > 뒤로가기 </div>
			</div>
			<div class="w3-margin-top w3-right">
				<c:choose>
					<c:when test="${user ne null}">
						<div class="w3-button" style="color:white;background-color:#51459E;" onclick="updateUser()"> 수정하기 </div>
					</c:when>
					<c:when test="${user eq null}">
						<div class="w3-button" style="color:white;background-color:#51459E;" onclick="registerUser()"> 회원 가입 </div>
					</c:when>
				</c:choose>
			</div>
			</form>
		</div>
		<div class="w3-col s1 m2 l4">&nbsp;</div>
	</div>
	<script type="text/javascript" src="./js/checkregister.js"></script>
<script>

	function togglePasswordType(){
		const pwInput = document.getElementById("userPw");
		const pwToggleIcon = document.getElementById("pwToggleIcon");

		if(pwInput.getAttribute("type") == "password"){
			pwInput.setAttribute("type","text");
			pwToggleIcon.classList.remove("fa-eye");
			pwToggleIcon.classList.add("fa-eye-slash");
		}else{
			pwInput.setAttribute("type","password");
			pwToggleIcon.classList.remove("fa-eye-slash");
			pwToggleIcon.classList.add("fa-eye");
		}
	}

	function registerUser(){
		const frm = document.getElementById("frm");
		frm.setAttribute("action","DoRegister");
		frm.submit();
	}

	function updateUser(){
		const frm = document.getElementById("frm");
		frm.setAttribute("action","UpdateUser");
		frm.submit();
	}
</script>
</body>
</html>