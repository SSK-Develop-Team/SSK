<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.dto.User" %>
<!-- 
user role이 2(super expert)인 사용자의 메뉴 바
* home - 전문가 및 관리 아동 전체 조회
* expert - 선택한 전문가의 관리 아동 조회
* child - 선택한 아동의 기본 정보
* lang - 선택 아동의 언어발달 검사 결과
* sdq - 선택 아동의 정서/행동 발달 검사 결과
* esm - 선택 아동의 정서 반복 기록 기록 / 프로파일
* esm record - 선택 아동의 정서 반복 기록 텍스트 기록 조회
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
                    <a onclick="submitForm('GetSuperExpertHome')" class="nav__link">
                        <ion-icon name="home-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;&nbsp;전체 회원 관리</span>
                    </a>
					<c:if test="${expert ne null}">
                    <a onclick="submitForm('GetExpertSelected')" class="nav__link collapse">
                        <ion-icon name="person-circle-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;&nbsp;전문가 관리 아동 정보</span>
                    </a>
                    </c:if>
                    <c:if test="${child ne null}">
                    <a href="../EwhaSSK/childInfo.jsp" class="nav__link collapse">
                        <ion-icon name="people-circle-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;&nbsp;아동 기본 정보</span>
                    </a>
                    
                    <a onclick="submitForm('getLangResult')" class="nav__link collapse">
                        <ion-icon name="chatbox-ellipses-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;&nbsp;아동 언어 발달 검사 결과</span>
                    </a>
                    
                    <a onclick="submitForm('GetSDQAnalysisSelected')" class="nav__link collapse">
                        <span class="nav__icon" style="font-size:9px;font-weight:700;">SDQ</span>
                        <span class="nav_name">&nbsp;&nbsp;정서/행동 발달 검사</span>
                    </a>
                    
                    <a href="../EwhaSSK/esmresultmain.jsp" class="nav__link collapse">
                        <span class="nav__icon" style="font-size:9px;font-weight:700;">ESM</span>
                        <span class="nav_name">&nbsp;&nbsp;정서 반복 기록</span>

                    </a>
                    
                    <a onclick="submitForm('GetEsmRecord')" class="nav__link">
                        <ion-icon name="document-text-outline" class="nav__icon"></ion-icon>
                        <span class="nav_name">&nbsp;&nbsp;아동 정서 다이어리</span>
                    </a>
					</c:if>
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