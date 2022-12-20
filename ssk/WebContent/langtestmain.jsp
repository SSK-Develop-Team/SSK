<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="model.dto.User" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>

<%
	User currUser = (User)session.getAttribute("currUser");
	String name = currUser.getUserName();
	int age = currUser.getCurrentAge();
	
	int prevAge = 0;
	int prev2Age = 0;
	
	System.out.println("Age Check : " + age);
	
	boolean isTesting = false;
	session.setAttribute("isTesting", isTesting);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>언어 발달 검사</title>
<link rel="stylesheet" href="css/selectAgeModal.css" type='text/css' >
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<script type="text/javascript">

	function modalOpen(){
		if(<%=age%> == 14) { 
			$(".selectExpertModal").css('display', 'block');
			$(".modalLayer").css('display', 'block');
		}
		
		else{
			$(".modal").css('display', 'block');
			$(".modalLayer").css('display', 'block');
		}
	}
	
	function selectModalOpen(){
		$(".modal").css('display', 'none');
		$(".selectModal").css('display', 'block');
		$(".modalLayer").css('display', 'block');
		
		if(<%=prevAge%> == 100){
			$('#ageGroupSelect').children("[value='prevAge']").remove();
		}
		
		if(<%=prev2Age%> == 100){
			$('#ageGroupSelect').children("[value='prev2Age']").remove();
		}
	}

	function modalClose(){
		$(".modal").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}	

	function selectModalClose(){
		$(".selectModal").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}	
	
	function selectExpertModalClose(){
		$(".selectExpertModal").css('display', 'none');
		$(".modalLayer").css('display', 'none');
	}	
	
	function alertTest(){
		alert("언어 평가를 먼저 진행해주세요.");
	}
</script>
<style>
	h3{
		display : flex;
		justify-content : center;
		align-items : center;
		padding : 5%;
		font-size : 25px;
	}
	#part{
		width : 100%;
		height : 50%;
		background : #f1f1f1;
		display : flex;
		justify-content: center;
		align-items : center;
		padding-top : 60px;
		padding-bottom : 60px;
	}
	#testExplanation{
		font-size : 20px;
	}
	#btndiv{
		display : flex;
		flex-direction: column;
		justify-content : center;
		align-items : center;
		margin : 60px;
	}
	.btn{
			border : 1px solid #51459E;
			border-radius : 10px;
			background-color:#51459E;
			padding : 10px;
			margin : 20px;
			color : white;
			height : 50px;
			width : 350px;
			font-size : 20px;
	}
</style>
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	<h3>언어 발달 검사 하기</h3>
	
	<div id="part">
		<div id="testExplanation">
			<%=name%>님, 현재 나이에 적합한 언어 발달 검사가 진행됩니다. <br>
			해당 언어 발달 검사가 아동에게 맞지 않는다면, 다른 나이대의 언어 발달 검사를 선택하여 진행해주세요.<br>
		</div>
	</div>
	
	<div id="btndiv">
		<button class="btn" id="LangTestBtn" onClick="modalOpen()">검사하기</button>
		<button class="btn" id="LangResultBtn" onClick="javascript:location.href='../EwhaSSK/getLangResult'">최근 결과 보기</button>
	</div>
	<% /*사용자가 존재할 경우 모달창 사용 가능*/
		
		prevAge = age - 1;
		prev2Age = age - 2;
		
		//14는 전문가의 평가용 나이이므로 제외, 아예 접근 불가한 숫자인 100으로 지정
		//if(prevAge < 0) prevAge = 100;
		//if(prev2Age < 0) prev2Age = 100;
		
		String[] ageStr = new String[]{"3세 0개월 ~ 3세 3개월", "3세 4개월 ~ 3세 5개월", "3세 6개월 ~ 3세 8개월", "3세 9개월 ~ 3세 11개월", "4세 0개월 ~ 4세 3개월",
				"4세 4개월 ~ 4세 7개월", "4세 8개월 ~ 4세 11개월", "5세 0개월 ~ 5세 5개월", "5세 6개월 ~ 5세 11개월", "6세 0개월 ~ 6세 5개월", "6세 0개월 ~ 6세 11개월", 
				"7세 0개월 ~ 7세 11개월", "8세 0개월 ~ 8세 11개월", "9세 0개월 ~ 9세 11개월", ""};
		
		if(name.length() == 3){
			name = name.substring(1);
		}
		
		else if(name.length() == 4){
			name = name.substring(2);
		}
		
		char lastName = name.charAt(name.length() - 1);
		int index = (lastName - 0xAC00) % 28;
		if(index > 0) name = name + "이";
	%>
	
	<div class="modalLayer"></div>
	
	<!-- 아동용 모달 -->
	<div class = "modal">
		<div class = "modalFunc">
			<div class = "modalContent">
				<button id = "closeBtn" onClick="modalClose()">X</button>
				<p>현재 <%=name%>의 테스트 단계는 <span><%=age%>단계</span>입니다.</p> 
				<p>(<%=ageStr[age] %>)</p>
				<p>해당 단계를 진행하시겠습니까?</p>
				<button id="otherBtn" onClick="selectModalOpen()">다른 단계 진행</button>
				<button id="testBtn" onClick="location.href='../EwhaSSK/GetLangTest'">해당 단계 진행</button>
			</div>
		</div>
	</div>
	
	<form method="get" class = "selectModal" action="GetLangTest">
		<div class = "selectModalFunc">
			<div class = "selectmodalContent">
				<button id = "closeBtn" onClick="selectModalClose()">X</button>
				<p>평가를 진행할 단계를 선택해주세요.</p> 
				
				<select id = "ageGroupSelect" name="ageGroup">
				<%if(prev2Age>=0){ %>
				    <option value="prev2Age"><%=ageStr[prev2Age] %></option>
				    <%}
				if(prevAge>=0){ %>
				    <option value="prevAge"><%=ageStr[prevAge] %></option>
				    <%} %>
				    <option value="curAge" selected="selected"><%=ageStr[age] %> (현재 단계)</option>
				</select>
				
				<button id="okBtn" type="submit">확인</button>
			</div>
		</div>
	</form>
	
	<!-- 전문가용 모달 -->
	<form method="get" class = "selectExpertModal" action="GetLangTest">
		<div class = "selectExpertModalFunc">
			<div class = "selectExpertmodalContent">
				<button id = "closeBtn" onClick="selectExpertModalClose()">X</button>
				<p>평가를 진행할 단계를 선택해주세요.</p> 
				
				<select id = "expertTestSelect" name="ageGroup">
					<%
					int i = 0;
					for(i = 0; i < 14; i++) { %>
					    <option value="<%= i%>"><%=ageStr[i] %></option>
					<% } %>
				</select>
				
				<button id="okBtn" type="submit">확인</button>
			</div>
		</div>
	</form>
</body>
</html>