<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<button class="w3-button w3-right" onclick="location.href='../ssk/register.jsp?role=child';">아동 계정 생성</button>
	<button class="w3-button w3-right">선택 계정 수정</button>
	<button class="w3-button w3-right">선택 계정 삭제</button>
</div>
</body>
</html>