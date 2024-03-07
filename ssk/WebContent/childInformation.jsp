<%@ page import="model.dto.User" %>	
<%@ page import="model.dto.EsmAlarm" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.Time" %>

<!DOCTYPE html>
<html>
<head>
	<!--user (O):계정 수정, (X):계정 생성-->
	<c:set var="user" scope="page" value="${requestScope.user}"/>
	<c:set var="esmTime" scope="page" value="${requestScope.esmTime}"/>

	<title>계정 조회</title>

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
		<c:when test="${role eq 'expert'&& user ne null}">
			<h2><b>전문가 계정 정보</b></h2>
		</c:when>
		<c:when test="${role eq 'child' && user ne null}">
			<h2><b>아동 계정 정보</b></h2>
		</c:when>
	</c:choose>
 	</div>
 	<hr>
 	<br>
	<div class="w3-row" style="height:100%;, width:100%;">
		<div class="w3-col s1 m2 l4">&nbsp;</div>
		<div class="w3-col s10 m8 l4 w3-padding-large">

	<form name="regFrm" method="post" id="frm"class="w3-container">



			<div class="w3-margin-top">
				<div class="w3-row" style="margin-bottom:2.5em;">
					<label style="margin-right: 2.5em;font-weight: bold;">아이디:</label>
					${user.userLoginId}
				</div>
			</div>
			
			<div class="w3-margin-top">
				<c:choose>
				    <c:when test="${role eq 'expert'}">
						<label><span style="color:red; margin-left:-5px;">*</span>전문가 이름</label>
						<input type="hidden" id="userRole" name="userRole" value="EXPERT" required>
				    </c:when>
				    <c:when test="${role eq 'child'}">
				    	<div class="w3-row" style="margin-bottom: 2.5em;">
							<label style="margin-right: 2.5em;font-weight: bold;">아동 이름:</label>
						    ${user.userName}
						</div>
				    </c:when>
				</c:choose>

			</div>
			<c:choose>
			    <c:when test="${role eq 'child'}">
					<div class="w3-margin-top">
						<div class="w3-row"style="margin-bottom:2.5em;">
							<label style="margin-right: 2.5em;font-weight: bold;">생년월일:</label>
						    ${user.userBirth}
						</div>
					</div>
			    </c:when>
			    </c:choose>

			<div class="w3-margin-top">
			<div class="w3-row"style="margin-bottom:2.5em;">
				<label style="margin-right: 2.5em;font-weight: bold;">이메일:</label>
				${user.userEmail}
			</div>
			</div>
			
			<c:choose>
			<c:when test="${role eq 'child'}">
				<div class="w3-margin-top">
						<c:choose>
							<c:when test="${user.userGender eq 'male'}">
								<div class="w3-row"style="margin-bottom:2.5em;">
									<label style="margin-right: 2.5em;font-weight: bold;">성별:</label>
						    		남자
								</div>	
							</c:when>
							<c:when test="${user.userGender eq 'female'}">
								<div class="w3-row"style="margin-bottom:2.5em;">
									<label style="margin-right: 2.5em;font-weight: bold;">성별:</label>
						    		여자
								</div>
							</c:when>
						</c:choose>
					</div>
			</c:when>
			</c:choose>
			
			<div class="w3-margin-top"style="margin-bottom:2.5em;">
				<label style="font-weight: bold;">정서 반복 기록 설정</label>
				
 <!-- esmTime이라는 이름으로 전달된 ArrayList를 받음 -->

 <% ArrayList<EsmAlarm> esmTime = (ArrayList<EsmAlarm>) request.getAttribute("esmTime"); %>
<c:choose>
    <c:when test="${empty esmTime}">
        <!-- esmTime이 비어있을 때의 처리 -->
        <div class="w3-container w3-margin-top" style="padding:0;">
        <table class="w3-table" style="font-size:0.8em;">
					<tbody id="table_body">
						<tr>
						<!-- Add a hidden input field for alarmId --> 
            				<input type="hidden" name="alarmId" value="0"/>
						<td style="padding-left: 0px;"><div class="w3-col" style="width:30px"><label>시작</label></div></td>
							<td><input type="text" class="w3-input" id="alarmStart" name="alarmStart" placeholder="Start Time"></td>
							<td><div class="w3-col" style="width:30px"><label>종료</label></div></td>
							<td><input type="text" class="w3-input" id="alarmEnd" name="alarmEnd" placeholder="End Time"></td>
							<td><div class="w3-col" style="width:30px"><label>간격</label></div></td>
							<td><input type="text" class="w3-input" id="alarmInterval" name="alarmInterval" placeholder="Interval"></td>
						</tr>
					</tbody>
        	
					</table>
				</div>
        
    </c:when>
     <c:otherwise>
     <!-- esmTime이 값이 있을 때의 처리 -->
      
        <div class="w3-container w3-margin-top" style="padding:0;">
        
        
        
        <table class="w3-table" style="font-size:0.8em;">
        <tbody id="table_body">
        <%if(esmTime.size()!=0){
						for (int i =0;i<esmTime.size();i++){
					%>
					
						<tr>
						<!-- Add a hidden input field for alarmId -->
						<input type="hidden" name="alarmId" value="<%=esmTime.get(i).getAlarmId() %>" />
						 <td>[<%=(i+1)%>]</td>
            				
						<td style="padding-left: 0px;"><div class="w3-col" style="width:30px"><label>시작</label></div></td>
							<td><%=esmTime.get(i).getAlarmStart().getHours()%>시</td>
							<td><div class="w3-col" style="width:30px"><label>종료</label></div></td>
							<td><%=esmTime.get(i).getAlarmEnd().getHours() %>시</td>
							<td><%=esmTime.get(i).getAlarmInterval() %>시간 간격</td>
						</tr>
						
					<% }
					}%>
        	</tbody>
					</table>
				</div>
        
 </c:otherwise>
</c:choose>

			</div>
<% 
Integer latestChildId = (Integer)request.getAttribute("latestChildId");
if(latestChildId == null) {
%>
Latest Child Id: null입니다
<%
} else {
%>
Latest Child Id: <%= latestChildId %>
<%
}
%>
			
			
			<div class="w3-margin-top w3-left">
				<div class="w3-button" style="color:white;background-color:#51459E;" onclick="history.go(-1);" > 뒤로가기 </div>
			</div>
			
			<div class="w3-margin-top w3-right">
				<button class="w3-button w3-right" style="background-color:#51459E; color:white;" onclick="deleteChild()">삭제하기</button>
				<button class="w3-button w3-right" style="background-color:#51459E; color:white;margin-right:1.5em;" onclick="updateChild()">수정하기</button>
			</div>
			</form>

		</div>
		<div class="w3-col s1 m2 l4">&nbsp;</div>
	</div>
	<script>
	function setLatestChildId(childId){
		const latestChildIdInput = document.getElementById("latestChildId");
		latestChildIdInput.value = childId;
	}
	function deleteChild(){
		const childCnt = document.querySelectorAll('input[name="childId"]:checked').length;
		if(childCnt==0){
			alert("아동을 선택해주세요.");
		}else{
			if(confirm("선택한 모든 아동을 삭제합니다.")){
				const deleteFrm = document.getElementById('manageFrm');
				deleteFrm.setAttribute("action", "DeleteUser");
				deleteFrm.submit();
			}
		}
	}
	function updateChild(){
		const childCnt = document.querySelectorAll('input[name="childId"]:checked').length;
		if(childCnt==0){
			alert("아동을 선택해주세요.");
		}else if(childCnt==1){
			const updateFrm = document.getElementById('frm');
			updateFrm.setAttribute("action", "GetUpdateUser")
			updateFrm.submit();
		}else{
			if(confirm("마지막으로 선택한 아동의 계정을 수정합니다.")){
				const updateFrm = document.getElementById('frm');
				updateFrm.setAttribute("action", "GetUpdateUser")
				updateFrm.submit();


	}
	</script>

</body>
</html>