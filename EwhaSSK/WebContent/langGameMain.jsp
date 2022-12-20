<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>언어 직접 평가(게임)</title>
</head>
<% 
	User currUser = (User)session.getAttribute("currUser");
	ArrayList<Integer> dontKnowList = (ArrayList<Integer>)session.getAttribute("dontKnowList");
	String dontKnowListStr = "\'잘 모르겠다\'라고 기입한 ";
	for(int i = 0 ; i<dontKnowList.size();i++){
		dontKnowListStr += dontKnowList.get(i).toString();
		if(i<dontKnowList.size()-1) dontKnowListStr += "번, ";
		else dontKnowListStr += "번 문항에 대한 간접 평가(게임)를 진행합니다.";
	}
%>
<body>
	<%@ include file="sidebar.jsp" %>
	<div>
	<p><%=dontKnowListStr%></p>
	</div>
	<div><input type="button" value="언어 게임 시작하기" onclick="location.href='../EwhaSSK/GetLangGame';"></div>
</body>
</html>