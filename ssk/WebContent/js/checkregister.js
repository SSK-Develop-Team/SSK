/**
 * @author Jiwon Lee - Copyright 2023 Hong Lab
 * ����媛��� ���⑥�� 寃��� 
 *  - ���대�� 以�蹂� 寃���
 *  - �대��� ���� 寃���
 *  - 鍮�諛�踰��� �쇱� 寃���
 *  - 鍮�移� 寃���
 */

let checkedId = false;//���대�� ����
let checkedEmail = false;//�대��� ����
let checkedPW = false;//鍮�諛�踰��� ����

const idInput = document.getElementById("userId");
const checkIdBtn = document.getElementById("checkId");
const pwInput = document.getElementById("userPw");
const pwChkInput = document.getElementById("userPwChk");
const emailInput = document.getElementById("userEmail");
const nameInput = document.getElementById("userName");

checkIdBtn.addEventListener('click', checkId);
pwInput.addEventListener('change', checkPW);
pwChkInput.addEventListener('change', checkPW);
emailInput.addEventListener('change', checkEmail);
nameInput.addEventListener('change', checkName);

/* ���대�� 以�蹂� 寃���  */
function checkId(){
	const id = document.getElementById("userId").value;
	const originUserLoginId = document.getElementById("originUserLoginId").value;
 	const idMsg = document.getElementById('check_id_m');

	idMsg.style.color = 'red';
	
	//���� 媛��� ����吏� ���� 
	if(id === ""){
		idMsg.innerHTML = '���대��瑜� ���ν���몄��.';
    	return false;
	}

	if(id == originUserLoginId){
		checkedId = true;
		checkIdBtn.style.backgroundColor = 'green';
		idMsg.style.color = 'green';
		idMsg.innerHTML = '湲곗〈�� ���대���� �쇱��⑸����.';
		return;
	}

	const xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function () {
		if (xhttp.readyState == 4 && xhttp.status == 200) {
	    	result = xhttp.responseText;
	    	if (result === 'ok') {
	        	checkedId = true;
	        	checkIdBtn.style.backgroundColor = 'green';
	        	idMsg.style.color = 'green';
				idMsg.innerHTML = '�ъ�� 媛��ν�� ���대��������.';
			} else {
				checkedId = false;
				idInput.value = ''; // input李쎌�� ���λ�� 媛� ����
				idMsg.style.color = 'red';
	        	idMsg.innerHTML = '�대�� 議댁�ы���� ���대��������.';
	      	}
		}
	};

	xhttp.open('Post', './CheckId', true);
	xhttp.setRequestHeader('Content-Type', 'text/plain; charset=UTF-8');
	xhttp.send(id);
}


// 以�蹂듯���몄�� ��猷���怨� ���대��瑜� ������硫� 以�蹂듯���� 痍⑥��
idInput.addEventListener('change', function (event) {
  if (checkedId === true) {
    checkedId = false;
    checkIdBtn.style.backgroundColor = '#51459E';
    document.getElementById('check_id_m').innerHTML = '';
  }
});

/* �대��� ���� 寃���  */
function checkEmailForm(str) {
  const emailForm = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;

  if (!emailForm.test(str)) {
    return false;
  } else {
    return true;
  }
}
function checkEmail(){
	const email = document.getElementById('userEmail').value;
	const emailMsg = document.getElementById('check_email_m');
	emailMsg.style.color = 'red';
	
	// ���κ��� ���� 吏� ����
	if (email === '') {
		emailMsg.innerHTML = '�대��쇱�� ���ν���몄��.';
		checkedEmail = false;
	    return false;
	}else if (!checkEmailForm(email)) {
		emailMsg.innerHTML = '���⑦�� �대��쇱＜��媛� ��������.';
		checkedEmail = false;
		return false;
	}else{
		emailMsg.innerHTML = '';
		checkedEmail = true;
		return true;
	}
}

/* 鍮�諛�踰��� ���� */
function checkPW() {
  const pw1 = document.getElementById('userPw').value; // 鍮�諛�踰���
  const pw2 = document.getElementById('userPwChk').value; // 鍮�諛�踰��� ����
  const checkMsg = document.getElementById('check_pw_m'); // 鍮�諛�踰��� ���� 寃곌낵 硫��몄�
  checkMsg.style.color = 'red';

  // 鍮�諛�踰��멸� ���λ��吏� ���� 寃쎌��
  if (pw1 == '') {
    checkMsg.innerHTML = '鍮�諛�踰��몃�� ���ν���몄��.';
    checkedPW = false;
  } else if (pw2 == '') {
    checkMsg.innerHTML = '鍮�諛�踰��� ���몄�� ���ν���몄��.';
    checkedPW = false;
  } else if (pw1 == pw2) {
    // 鍮�諛�踰��멸� ��濡� 媛��� 寃쎌��
    checkMsg.style.color = 'green';
    checkMsg.innerHTML = '鍮�諛�踰��멸� ���몃�����듬����. ';
    checkedPW = true;
  } else {
    checkMsg.innerHTML = '鍮�諛�踰��멸� ��濡� �ㅻ�����. �ㅼ�� ���명�� 二쇱�몄��.';
    checkedPW = false;
  }
}

function checkName(){
	const name = document.getElementById("userName").value;
 	const nameMsg = document.getElementById('check_name_m');

	nameMsg.style.color = 'red';
	
	//���� 媛��� ����吏� ���� 
	if(name === ""){
		nameMsg.innerHTML = '�대��� ���ν���몄��.';
    	return false;
	}else{
		nameMsg.innerHTML = '';
	}
	return true;
}

/* 鍮�移� 寃��� */
function checkValue(){
	/*
	 - ���대�� 鍮�移� & 以�蹂� 寃��� : checkedId
	 - �대��� : checkedEmail
	 - 鍮�諛�踰��� : checkedPw
	 - �대� : checkedName
	*/
	if(!checkedId) {
		alert('���대��瑜� ���명�댁＜�몄��!');
	    return false;
	}else if (!checkedPW) {
	    alert('鍮�諛�踰��� ���몄�� �댁＜�몄��!');
	    return false;
	}else if(!checkedEmail){
		alert('�대��쇱�� ���명�댁＜�몄��!');
		return false;
	}
	if (checkName()) {
    	return true;
  	}else{
		return false;
	}
	return true;
}

