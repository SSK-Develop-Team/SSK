function checkRegister() {
	alert('check');
	if (document.regFrm.user_login_id.value == "") {
		alert("���̵� �Է��� �ּ���.");
		document.regFrm.userid.focus();
		return;
	}
	if (document.regFrm.user_password.value == "") {
		alert("��й�ȣ�� �Է��� �ּ���.");
		document.regFrm.password.focus();
		return;
	}
	if (document.regFrm.reuserpassword.value == "") {
		alert("��й�ȣ�� Ȯ���� �ּ���");
		document.regFrm.repassword.focus();
		return;
	}
	if (document.regFrm.user_password.value != document.regFrm.reuserpassword.value) {
		alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		document.regFrm.repassword.value = "";
		document.regFrm.repassword.focus();
		return;
	}
	if (document.regFrm.user_name.value == "") {
		alert("�Ƶ��� �̸��� �Է��� �ּ���.");
		document.regFrm.username.focus();
		return;
	}
	if (document.regFrm.user_gender.value == "") {
		alert("�Ƶ��� ������ ������ �ּ���.");
		document.regFrm.usergender.focus();
		return;
	}
	if (document.regFrm.user_birth.value == "") {
		alert("�Ƶ��� ��������� �Է��� �ּ���.");
		document.regFrm.userBirth.focus();
		return;
	}
	alert('check2');
	document.regFrm.submit();
}

function win_close() {
	self.close();
}