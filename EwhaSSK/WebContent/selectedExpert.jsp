<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="model.dto.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전문가 아동 조회</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<%@ include file="header.jsp" %>
<body>
	<%@ include file="sidebar.jsp"%>
	<%
		User selectedExpert = (User)session.getAttribute("selectedExpert");
		ArrayList<User> selectedExpertChildList = (ArrayList<User>)request.getAttribute("selectedExpertChildList");
	%>
	<div class="header w3-row w3-container">
		<div class="w3-col" style="width:30%;border-bottom: 1.5px solid;">
		  <div style="display:inline-block;padding-right:5px;"><h2><b><%=selectedExpert.getUserName()%></b>전문가 아동 목록</h2></div>
		</div>
		<div class="w3-rest"></div>
	</div>
	<div class="w3-container" style="margin-right:5%; margin-left:5%;">
		<div class="w3-container w3-margin-top select-btn w3-row" style="width:100%;">
			<button class="w3-button w3-panel w3-right" style="min-height:30px;color:white;background-color:#51459E;" onclick="selectExpertChild()">선택 조회</button>
			<button class="w3-button w3-panel w3-right" style="min-height:30px;color:white;background-color:#51459E;" onclick="deleteExpertChild()">선택 삭제</button>
		</div>
		<div class="w3-row w3-container w3-margin-top w3-center" >
		<form method="post" action="DeleteUserList" id="deleteUserListForm">
			<table class="w3-striped w3-center w3-border" style="width:100%;">
			    <tr class="w3-khaki">
			      <th></th>
			      <th>이름</th>
			      <th>생년월일</th>
			      <th>성별</th>
			      <th>언어 발달 검사 수</th>
			      <th>정서/행동 발달 검사 수</th>
			      <th>정서 반복 기록</th>
			    </tr>
			    <%for(int i = 0 ; i<selectedExpertChildList.size();i++){%>
			    <tr>
			      <td><input type="checkbox" name="childSelect" value="<%=selectedExpertChildList.get(i).getUserId()%>"></td>
			      <td><%=selectedExpertChildList.get(i).getUserName()%></td>
			      <td><%=selectedExpertChildList.get(i).getUserBirth().toString()%></td>
			      <td><%=selectedExpertChildList.get(i).getUserGender()%></td>
			    </tr>
			    <%} %>
			</table>
		</form>
		</div>
	</div>

<script>
function selectExpertChild(){
	const query = 'input[name="childSelect"]:checked';
	const selectedElements = document.querySelectorAll(query);
	const selectedElementsCnt = selectedElements.length;
	if(selectedElementsCnt>1){ alert("다중 선택 시 가장 먼저 선택된 아동을 조회합니다.");}
	
	var form = document.createElement("form");
	form.action = "SelectExpertChild";
	form.method = "POST";
	const childIdField = document.createElement('input');
	childIdField.type="hidden";
	childIdField.name="selectedExpertChildId";
	childIdField.value=selectedElements[0].value;
	form.appendChild(childIdField);
	document.body.appendChild(form);
	form.submit();
}

function deleteExpertChild(){
	 if (!confirm("선택한 아동 계정을 삭제하시겠습니까?")) {
	 } else {
    	var form = document.getElementById("deleteUserListForm");
    	form.submit();
     }
}
</script>
</body>
</html>