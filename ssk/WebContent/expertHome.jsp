<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>EXPERT HOME - 아동별 결과 조회</title>
</head>
<body>
<%@ include file = "sidebar.jsp" %>
<div class="w3-margin" style="font-weight:bold;font-size:20px;padding-left:25px;"><img src="./image/research.png" style="width:35px;">     아동별 결과 조회</div>
<div style="width:100%;">
<div class="search w3-right" style="width: 300px;">
  <input class="w3-border" type="text" placeholder="전문가 이름 검색" style="width: 85%;border: 1px solid #bbb;border-radius: 8px;padding: 10px 12px;font-size: 14px;">
  <button style="height:42px;"><img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" style="width:17px;"></button>
</div>
</div>
<div class="buttons" style="width:100%;">
	<button class="w3-button w3-right" onclick="location.href='register.jsp?role=child';">아동 계정 생성</button>
	<button class="w3-button w3-right">선택 계정 수정</button>
	<button class="w3-button w3-right">선택 계정 삭제</button>
</div>
<%
	UserPaging userPaging = (UserPaging)request.getAttribute("userPaging");
	ArrayList<User> currUserList = (ArrayList<User>)request.getAttribute("currUserList");
	int blockStartNum = userPaging.getBlockStartNum();
	int blockEndNum = userPaging.getBlockEndNum();
	int lastPageNum = userPaging.getLastPageNum();
	int currPageNum = (int)request.getAttribute("currPageNum");
	int blockRange = UserPaging.getBlockRange();
	
%>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* 정렬 기준 : 등록일 순</div>
<div class="w3-container">
  <table class="w3-table-all w3-hoverable">
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
	<tr onclick = "location.href='GoToChildHome?childId=<%=currUserList.get(i).getUserId()%>';">
	  <td><input type="checkbox" id="check"/></td>
      <td><%=(currPageNum-1)*UserPaging.getListRange()+i+1%></td>
      <td><%=currUserList.get(i).getUserName() %></td>
      <td><%=currUserList.get(i).getUserLoginId() %></td>
      <td><%=currUserList.get(i).getUserBirth() %></td>
      <td><%=currUserList.get(i).getRegistrationDate() %></td>
      <td><%=currUserList.get(i).getUserEmail() %></td>
    </tr>
	<% }%>
  </table>
</div>
<div class="w3-center">
<div class="w3-bar">
	<c:set var="uPaging" scope="page" value="${requestScope.userPaging}" />
	<c:set var="curPageNum" scope="page" value="${requestScope.currPageNum}" />
	<c:if test="${curPageNum > blockRange}">
	 <a href="GetExpertHome?curPage=${uPaging.blockStartNum - 1}" class="w3-bar-item w3-button">&laquo;</a>
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
	 <a href="GetExpertHome?curPage=${uPaging.blockEndNum + 1}" class="w3-bar-item w3-button">&raquo;</a>
	</c:if>
  	<c:remove var="uPaging" scope="page"/>
  	<c:remove var="curPageNum" scope="page"/>
</div>
</div>
</body>
</html>