<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="model.dto.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아동 관리 페이지</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<%@ include file="header.jsp" %>
<body>
	<%@ include file="sidebar.jsp" %>
	<%
		ArrayList<User> userChildList = (ArrayList<User>)session.getAttribute("userChildList");
		%>
	<div class="header w3-row w3-container">
		<div class="w3-col" style="width:30%;border-bottom: 1.5px solid;">
		  <div style="display:inline-block;padding-right:5px;"><h2>아동 관리</h2></div>
		  <div style="display:inline-block;transform:translateY(-8px);">
		  	<button  class="w3-button w3-xlarge w3-circle w3-black w3-card-4" onclick="location.href='registerChild.jsp'">+</button>
		  </div>
		</div>
		<div class="w3-rest"></div>
	</div>
	<div class="w3-container">
		<div class="sort-select-view">
		</div>
		<div class="children-view w3-row w3-container w3-margin-top">
		<form id="selectMyChild" action="SelectMyChild" method="post"></form>
			<%
			if(userChildList.size()!=0){
				for(int i=0;i<userChildList.size();i++){ %>
					<div class="w3-card-2 w3-light-gray w3-col m2 w3-panel w3-margin w3-center"style="padding:0;min-height:100px;">
						<div class="w3-padding w3-right"><button class="w3-button w3-light-gray" onClick="deleteChild('<%= userChildList.get(i).getUserId() %>','<%= userChildList.get(i).getUserName() %>');">X</button></div>
						<div class="w3-padding" onclick="selectChild('<%=userChildList.get(i).getUserId()%>')"><img src="<%=userChildList.get(i).getUserIcon()%>" alt="user icon" style="width: 100%;max-height:250px;overflow:hidden;object-fit:cover;"></div>
						<h5 class="w3-padding w3-margin-bottom" style="font-weight:500;"><%=userChildList.get(i).getUserName()%></h5>
						<div class="w3-padding w3-panel"><button class="w3-button w3-gray" onclick="selectChild('<%=userChildList.get(i).getUserId()%>')">아동 상세 보기</button></div>
					</div>
			<%}}%>
		</div>
	</div>

<script>
function selectChild(childIdStr){
	var form = document.getElementById("selectMyChild");
	const childIdField = document.createElement('input');
	childIdField.type="hidden";
	childIdField.name="selectedChildId";
	childIdField.value=childIdStr;
	form.appendChild(childIdField);
	form.submit();
}
function deleteChild(childIdStr, childNameStr){
	 if (!confirm("아동 \""+childNameStr+"\"의 계정을 삭제하시겠습니까?")) {
     } else {
    	 var form = document.createElement("form");
    		form.action = "DeleteUser";
    		form.method = "POST";
    		
    		const childIdField = document.createElement('input');
    		childIdField.type="hidden";
    		childIdField.name="deleteUserId";
    		childIdField.value=childIdStr;
    		
    		form.appendChild(childIdField);
    		document.body.appendChild(form);
    		
    		form.submit();
     }
	
}
</script>
</body>
</html>