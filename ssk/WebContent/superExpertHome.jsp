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
	<%@ include file="sidebar.jsp"%>
	<%
		ArrayList<User> expertList = (ArrayList<User>)request.getAttribute("expertList");
		ArrayList<User>[] childList = new ArrayList[expertList.size()];
		childList = (ArrayList<User>[])request.getAttribute("childList");
		%>
	<div class="header w3-row w3-container">
		<div class="w3-col" style="width:30%;border-bottom: 1.5px solid;">
		  <div style="display:inline-block;padding-right:5px;"><h2>전체 회원 관리</h2></div>
		</div>
		<div class="w3-rest"></div>
	</div>
	<div class="w3-container" style="margin-right:10%; margin-left:10%;">
		<div class="w3-container w3-margin-top select-btn w3-row"style="width:100%;">
			<button class="w3-button w3-panel w3-right" style="min-height:30px;color:white;background-color:#51459E;" onclick="selectExpert()">선택 조회</button>
			<button class="w3-button w3-panel w3-right" style="min-height:30px;color:white;background-color:#51459E;" onclick="deleteExpert()">선택 삭제</button>
		</div>
		<div class="w3-row w3-container w3-margin-top w3-center">
		<form method="post" action="DeleteUserList" id = "deleteUserListForm">
			<table class="w3-striped w3-center w3-border" style="width:100%;">
			    <tr class="w3-khaki">
			      <th></th>
			      <th>전문가 이름</th>
			      <th>관리 아동 수</th>
			      <th>관리 아동</th>
			    </tr>
			    <%for(int i = 0 ; i<expertList.size();i++){%>
			    <tr>
			      <td><input type="checkbox" name="expertSelect" value="<%=expertList.get(i).getUserId()%>"></td>
			      <td><%=expertList.get(i).getUserName()%></td>
			      <td><%=childList[i].size() %></td>
			      <td>
			      	<%for(int j = 0 ; j<childList[i].size();j++){ %>
			      		<div><%=childList[i].get(j).getUserName()%></div>
			      	<%}%>
			      </td>
			    </tr>
			    <%} %>
			</table>
		</form>
		</div>
	</div>

<script>
function selectExpert(){
	const query = 'input[name="expertSelect"]:checked';
	const selectedElements = document.querySelectorAll(query);
	const selectedElementsCnt = selectedElements.length;
	if(selectedElementsCnt>1){ alert("다중 선택 시 가장 먼저 선택된 전문가를 조회합니다.");}
	
	var form = document.createElement("form");
	form.action = "SelectExpert";
	form.method = "POST";
	const expertIdField = document.createElement('input');
	expertIdField.type="hidden";
	expertIdField.name="selectedExpertId";
	expertIdField.value=selectedElements[0].value;
	form.appendChild(expertIdField);
	document.body.appendChild(form);
	form.submit();
}

function deleteExpert(){
	 if (!confirm("선택한 전문가 계정을 삭제하시겠습니까?")) {
     } else {
    	var form = document.getElementById("deleteUserListForm");
    	form.submit();
     }
	
}
</script>
</body>
</html>