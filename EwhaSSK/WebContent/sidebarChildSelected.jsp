<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- [전문가->아동 선택 시] 사이드 바 
* 전체 아동 관리
* 언어 발달 평가
* 정서/행동 발달 평가
* 정서 반복 기록 기록/프로파일
* 정서 다이어리
* 내 홈으로 돌아가기
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SIDEBAR - Selected Child</title>
<link href="css/sidebar.css" rel="stylesheet" type='text/css' >
<script src='js/alert.js'></script>
</head>
<body id="body-pd">
    <div class="l-navbar" id="navbar">
        <nav class="nav">
            <div>
                <div class="nav__brand">
                    <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
                </div>
                
				<div class="nav__list">
					<a href="childInfo.jsp" class="nav__link">
                        <ion-icon name="person-circle-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;&nbsp;내 아동 정보</span>
                    </a>
                    <a href="../EwhaSSK/getLangResult" class="nav__link">
                        <ion-icon name="chatbox-ellipses-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;&nbsp;언어 발달 평가</span>
                    </a>
                    <a href="#sdqTest" class="nav__link" onclick="submitForm('GetSDQAnalysisSelected');"><!-- submitForm('GetSDQDates'); -->
                        <span class="nav__icon" style="font-size:9px;font-weight:700;">SDQ</span>
                        <span class="nav_name">&nbsp;&nbsp;정서/행동 발달 평가</span>
                    </a>
                    <a href="#esmDiary" class="nav__link" onclick="javascript:location.href='esmresultmain.jsp';"><!--location.href='esmtestmain.jsp';  -->
                        <span class="nav__icon" style="font-size:9px;font-weight:700;">ESM</span>
                        <span class="nav_name">&nbsp;&nbsp;정서 반복 기록</span>
                    </a>
                    </a>
                    <a href="#esmRecord" class="nav__link" onclick="submitForm('GetEsmRecord');">
                        <ion-icon name="document-text-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;&nbsp;정서 다이어리</span>
                    </a>
                    <a href="#my" class="nav__link" onclick="submitForm('GetExpertHome');">
                        <span class="nav__icon" style="font-size:10px;font-weight:700;">MY</span>
                        <span class="nav_name">&nbsp;&nbsp;내 홈으로</span>
                    </a>
				</div>
				
			</div>
		</nav>
	</div>
	<script>
	 function submitForm(url){
	    	var form = document.createElement('form');
		  	form.setAttribute('method','post');
		  	form.setAttribute('action',url);
		  	document.charset = "utf-8";
		  	document.body.appendChild(form);
		  	form.submit();
	    }

	</script>
	<!-- IONICONS -->
    <script src="https://unpkg.com/ionicons@5.2.3/dist/ionicons.js"></script>
    <script>
    
    const showMenu = (toggleId, navbarId, bodyId) => {
        const toggle = document.getElementById(toggleId),
        navbar = document.getElementById(navbarId),
        bodypadding = document.getElementById(bodyId)

        if( toggle && navbar ) {
            toggle.addEventListener('click', ()=>{
                navbar.classList.toggle('expander');

                bodypadding.classList.toggle('body-pd')
            })
        }
    }

    showMenu('nav-toggle', 'navbar', 'body-pd')

    /* LINK ACTIVE */
    const linkColor = document.querySelectorAll('.nav__link')
    function colorLink() {
        linkColor.forEach(l=> l.classList.remove('active'))
        this.classList.add('active')
    }
    linkColor.forEach(l=> l.addEventListener('click', colorLink))

    /* COLLAPSE MENU */
    const linkCollapse = document.getElementsByClassName('collapse__link')
    var i

    for(i=0;i<linkCollapse.length;i++) {
        linkCollapse[i].addEventListener('click', function(){
            const collapseMenu = this.nextElementSibling
            collapseMenu.classList.toggle('showCollapse')

            const rotate = collapseMenu.previousElementSibling
            rotate.classList.toggle('rotate')
        });
    }
   
    </script>
</body>
</html>