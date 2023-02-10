/**
 * @author Jiwon Lee - Copyright 2023 Hong Lab
 * 회원가입 유효성 검사 
 *  - 아이디 중복 검사
 *  - 이메일 형식 검사
 *  - 비밀번호 일치 검사
 *  - 빈칸 검사
 */

let checkedId = false;//아이디 확인
let checkedEmail = false;//이메일 확인
let checkedPW = false;//비밀번호 확인

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

/* 아이디 중복 검사  */
function checkId(){
	const id = document.getElementById("userId").value;
 	const idMsg = document.getElementById('check_id_m');

	idMsg.style.color = 'red';
	
	//입력 값이 있는지 확인 
	if(id === ""){
		idMsg.innerHTML = '아이디를 입력하세요.';
    	return false;
	}
	
	const xhttp = new XMLHttpRequest();

	xhttp.onreadystatechange = function () {
		if (xhttp.readyState == 4 && xhttp.status == 200) {
	    	result = xhttp.responseText;
	    	if (result === 'ok') {
	        	checkedId = true;
	        	checkIdBtn.style.backgroundColor = 'green';
	        	idMsg.style.color = 'green';
				idMsg.innerHTML = '사용 가능한 아이디입니다.';
			} else {
				checkedId = false;
				idInput.value = ''; // input창에 입력된 값 삭제
				idMsg.style.color = 'red';
	        	idMsg.innerHTML = '이미 존재하는 아이디입니다.';
	      	}
		}
	};

	xhttp.open('Post', './CheckId', true);
	xhttp.setRequestHeader('Content-Type', 'text/plain; charset=UTF-8');
	xhttp.send(id);
}

// 중복확인을 완료하고 아이디를 수정하면 중복확인 취소
idInput.addEventListener('change', function (event) {
  if (checkedId === true) {
    checkedId = false;
    checkIdBtn.style.backgroundColor = '#51459E';
    document.getElementById('check_id_m').innerHTML = '';
  }
});

/* 이메일 형식 검사  */
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
	
	// 입력값이 있는 지 확인
	if (email === '') {
		emailMsg.innerHTML = '이메일을 입력하세요.';
		checkedEmail = false;
	    return false;
	}else if (!checkEmailForm(email)) {
		emailMsg.innerHTML = '유효한 이메일주소가 아닙니다.';
		checkedEmail = false;
		return false;
	}else{
		emailMsg.innerHTML = '';
		checkedEmail = true;
		return true;
	}
}

/* 비밀번호 확인 */
function checkPW() {
  const pw1 = document.getElementById('userPw').value; // 비밀번호
  const pw2 = document.getElementById('userPwChk').value; // 비밀번호 확인
  const checkMsg = document.getElementById('check_pw_m'); // 비밀번호 확인 결과 메세지
  checkMsg.style.color = 'red';

  // 비밀번호가 입력되지 않은 경우
  if (pw1 == '') {
    checkMsg.innerHTML = '비밀번호를 입력하세요.';
    checkedPW = false;
  } else if (pw2 == '') {
    checkMsg.innerHTML = '비밀번호 확인을 입력하세요.';
    checkedPW = false;
  } else if (pw1 == pw2) {
    // 비밀번호가 서로 같은 경우
    checkMsg.style.color = 'green';
    checkMsg.innerHTML = '비밀번호가 확인되었습니다. ';
    checkedPW = true;
  } else {
    checkMsg.innerHTML = '비밀번호가 서로 다릅니다. 다시 확인해 주세요.';
    checkedPW = false;
  }
}

function checkName(){
	const name = document.getElementById("userName").value;
 	const nameMsg = document.getElementById('check_name_m');

	nameMsg.style.color = 'red';
	
	//입력 값이 있는지 확인 
	if(name === ""){
		nameMsg.innerHTML = '이름을 입력하세요.';
    	return false;
	}else{
		nameMsg.innerHTML = '';
	}
	return true;
}

/* 빈칸 검사 */
function checkValue(){
	/*
	 - 아이디 빈칸 & 중복 검사 : checkedId
	 - 이메일 : checkedEmail
	 - 비밀번호 : checkedPw
	 - 이름 : checkedName
	*/
	if(!checkedId) {
		alert('아이디를 확인해주세요!');
	    return false;
	}else if (!checkedPW) {
	    alert('비밀번호 확인을 해주세요!');
	    return false;
	}else if(!checkedEmail){
		alert('이메일을 확인해주세요!');
		return false;
	}
	if (checkName()) {
    	return true;
  	}else{
		return false;
	}
	return true;
}

