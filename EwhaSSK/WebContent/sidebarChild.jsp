<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<!-- 
user role이 0(child)인 사용자의 메뉴 바
* home - 메인 페이지
* lang - 언어발달 검사 및 결과
* sdq - 정서/행동 발달 검사 및 결과
* esm - 정서 반복 기록 기록 및 조회/프로파일
* esm record - 정서 반복 기록 텍스트 기록 및 조회
* mypage - 아동 개인 정보 관리
 -->
 
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" charset="UTF-8">
    <link href="css/sidebar.css" rel="stylesheet" type='text/css' >

    <title>SUPER EXPERT SIDEBAR</title>
</head>
<body id="body-pd">
    <div class="l-navbar" id="navbar">
        <nav class="nav">
            <div>
                <div class="nav__brand">
                    <ion-icon name="menu-outline" class="nav__toggle" id="nav-toggle"></ion-icon>
                </div>
				<div class="nav__list">
                    <a href="childHome.jsp" class="nav__link">
                        <ion-icon name="home-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;&nbsp;메인페이지</span>
                    </a>
	                
                    <a href="langtestmain.jsp" class="nav__link collapse">
                        <ion-icon onclick="javascript:location.href='langtestmain.jsp'" name="chatbox-ellipses-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;&nbsp;언어 발달 검사</span>
                    </a>

                    <div href="sdqtestmain.jsp" class="nav__link collapse">
		                <span class="nav__icon" style="font-size:9px;font-weight:700;" onclick="javascript:location.href='sdqtestmain.jsp'">SDQ</span>
	                    <span class="nav_name" onclick="javascript:location.href='sdqtestmain.jsp'" >&nbsp;&nbsp;정서/행동 발달</span>

                    </div>
	                    
                    <div href="esmtestmain.jsp" class="nav__link collapse">
	                    <span class="nav__icon" style="font-size:9px;font-weight:700;" onclick="javascript:location.href='esmtestmain.jsp'">ESM</span>
                        <span onclick="javascript:location.href='esmtestmain.jsp'" class="nav_name">&nbsp;&nbsp;정서 반복 기록</span>

                    </div>
                    
                     <a onclick="submitForm('GetEsmRecord')" class="nav__link">
                       <ion-icon name="document-text-outline" class="nav__icon"></ion-icon>
                       <span class="nav_name">&nbsp;&nbsp;정서 다이어리</span>
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
    <script type="text/javascript" src="js/logout.js" charset="UTF-8"></script>
</body>


</html>