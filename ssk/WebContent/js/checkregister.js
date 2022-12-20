function checkRegister() {
	alert('check');
	if (document.regFrm.user_login_id.value == "") {
		alert("아이디를 입력해 주세요.");
		document.regFrm.userid.focus();
		return;
	}
	if (document.regFrm.user_password.value == "") {
		alert("비밀번호를 입력해 주세요.");
		document.regFrm.password.focus();
		return;
	}
	if (document.regFrm.reuserpassword.value == "") {
		alert("비밀번호를 확인해 주세요");
		document.regFrm.repassword.focus();
		return;
	}
	if (document.regFrm.user_password.value != document.regFrm.reuserpassword.value) {
		alert("비밀번호가 일치하지 않습니다.");
		document.regFrm.repassword.value = "";
		document.regFrm.repassword.focus();
		return;
	}
	if (document.regFrm.user_name.value == "") {
		alert("아동의 이름을 입력해 주세요.");
		document.regFrm.username.focus();
		return;
	}
	if (document.regFrm.user_gender.value == "") {
		alert("아동의 성별을 선택해 주세요.");
		document.regFrm.usergender.focus();
		return;
	}
	if (document.regFrm.user_birth.value == "") {
		alert("아동의 생년월일을 입력해 주세요.");
		document.regFrm.userBirth.focus();
		return;
	}
	alert('check2');
	document.regFrm.submit();
}

function win_close() {
	self.close();
}