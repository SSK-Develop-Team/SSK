<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>전문가 HOME - 아동별 결과 조회</title>
</head>
<body>
<%@ include file = "sidebar.jsp" %>

<div class="w3-row">
	<div class="w3-col w3-hide-small w3-hide-middle l1">&nbsp;</div>
	<div class="w3-col s12 m12 l10" style="font-weight:bold;font-size:1.5em;padding-left:1em;"><img src="./image/research.png" style="width:35px;">     아동별 결과 조회</div>
	<div class="w3-col w3-hide-small w3-hide-middle l1">&nbsp;</div>
</div>

<div class="w3-row">
	<div class="w3-col w3-hide-small m3 l5">&nbsp;</div>
	<div class="select-box w3-col s12 m9 l6"style="margin-bottom:0.5em;padding-right:1em;">
		<div style="font-weight:bold;font-size:0.8em;margin-left:0.3em; margin-bottom:0.3em;">카테고리<span class="w3-right" style="font-weight:100;font-size:0.5em;">아동과 카테고리를 선택하고 excel export 버튼을 누르세요. 아동 별로 엑셀 파일(.xlsx)이 생성됩니다.</span></div>
		<div class="w3-cell-row w3-container" style="background-color:#D9D9D9;font-size:0.8em; line-height:7vh;">
			<div class="w3-cell" style="vertical-align:middle;"><input type="checkbox" style="transform:translateY(0.1em);">&nbsp;<label>언어 발달 검사</label></div>
			<div class="w3-cell" style="vertical-align:middle;"><input type="checkbox" style="transform:translateY(0.1em);">&nbsp;<label>정서 행동 발달 검사</label></div>
			<div class="w3-cell" style="vertical-align:middle;"><input type="checkbox" style="transform:translateY(0.1em);">&nbsp;<label>정서 반복 기록</label></div>
			<div class="w3-cell" style="vertical-align:middle;"><input type="checkbox" style="transform:translateY(0.1em);">&nbsp;<label>정서 다이어리</label></div>
			<div class="w3-cell" style="vertical-align:middle;line-height:2vh; text-align:right;"><button class="w3-button" style="background-color:#51459E; color:white;vertical-align:middle;" onclick="location.href='exportChildResultExcel';"> excel export </button></div>
		</div>
	</div>
	<div class="w3-col w3-hide-small w3-hide-middle l1">&nbsp;</div>
</div>

<div class="w3-row">
	<div class="w3-col w3-hide-small w3-hide-middle l1">&nbsp;</div>
	<div class="w3-col s12 m12 l10">
		<div style="width:100%;margin-bottom:50px;">
		<div class="search w3-right" style="width: 300px;">
		  <input class="w3-border" type="text" placeholder="아동 이름 검색" style="width: 85%;border: 1px solid #bbb;border-radius: 8px;padding: 10px 12px;font-size:0.8em;">
		  <button style="height:42px;"><img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" style="width:17px;"></button>
		</div>
		</div>
		
		<%
			ArrayList<User> currUserList = (ArrayList<User>)request.getAttribute("currUserList");
			int currPageNum = (int)request.getAttribute("currPageNum");
			int blockRange = UserPaging.getBlockRange();
			
		%>
		<div style="font-size:0.5em;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* 정렬 기준 : 등록일 순</div>
		<div class="w3-container">
		  <table class="w3-table-all w3-hoverable" style="font-size:0.8em;">
		    <thead>
		      <tr class="w3-light-grey">
		      	<th>&nbsp;</th>
		        <th>NO.</th>
		        <th>이름</th>
		        <th>아이디</th>
		        <th>생년월일</th>
		        <th>등록일</th>
		        <th>이메일</th>
		      </tr>
		    </thead>
		    <%for (int i =0;i<currUserList.size();i++){
			%>
			<tr>
			  <td><input type="checkbox" id="check"/></td>
		      <td onclick = "location.href='GoToChildHome?childId=<%=currUserList.get(i).getUserId()%>';"><%=(currPageNum-1)*UserPaging.getListRange()+i+1%></td>
		      <td onclick = "location.href='GoToChildHome?childId=<%=currUserList.get(i).getUserId()%>';"><%=currUserList.get(i).getUserName() %></td>
		      <td onclick = "location.href='GoToChildHome?childId=<%=currUserList.get(i).getUserId()%>';"><%=currUserList.get(i).getUserLoginId() %></td>
		      <td onclick = "location.href='GoToChildHome?childId=<%=currUserList.get(i).getUserId()%>';"><%=currUserList.get(i).getUserBirth() %></td>
		      <td onclick = "location.href='GoToChildHome?childId=<%=currUserList.get(i).getUserId()%>';"><%=currUserList.get(i).getRegistrationDate() %></td>
		      <td onclick = "location.href='GoToChildHome?childId=<%=currUserList.get(i).getUserId()%>';"><%=currUserList.get(i).getUserEmail() %></td>
		    </tr>
			<% }%>
		  </table>
		</div>
		<div class="w3-center">
		<div class="w3-bar">
			<c:set var="uPaging" scope="page" value="${requestScope.userPaging}" />
			<c:set var="curPageNum" scope="page" value="${requestScope.currPageNum}" />
			<c:set var="blockRange" scope="page" value="<%=blockRange%>" />
			<c:if test="${curPageNum > blockRange}">
			 <a href="GetExpertHome?curPage=${uPaging.blockStartNum - 1}" class="w3-button">&laquo;</a>
			</c:if>
		 	<c:forEach var="i" begin="${uPaging.blockStartNum}" end="${uPaging.blockEndNum}">
		 		<c:choose>
		 			<c:when test="${i>uPaging.lastPageNum}"></c:when>
		 			<c:when test="${i==curPageNum}">
		 				<a href="#" class="w3-button w3-gray">${i}</a>
		 			</c:when>
		 			<c:otherwise>
		 				<a href="GetExpertHome?curPage=${i}" class="w3-button">${i}</a>
		 			</c:otherwise>
		 		</c:choose>
		 	</c:forEach>
		  	<c:if test="${uPaging.lastPageNum > uPaging.blockEndNum}">
			 <a href="GetExpertHome?curPage=${uPaging.blockEndNum + 1}" class="w3-button">&raquo;</a>
			</c:if>
		  	<c:remove var="uPaging" scope="page"/>
		  	<c:remove var="curPageNum" scope="page"/>
		</div>
		</div>
	</div>
	<div class="w3-col w3-hide-small w3-hide-middle l1">&nbsp;</div>
</div>
</body>
</html>