<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="java.util.*" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="model.dto.User" %>
<%@ page import="model.dto.EsmResult" %>
<%
	User focusUser = new User();
	if((User)session.getAttribute("selectedChild")!=null) {
		focusUser = (User)session.getAttribute("selectedChild");
	}else {
		focusUser = (User)session.getAttribute("currUser");
	}
	String id = focusUser.getUserLoginId();
	String name = focusUser.getUserName();
	int userid = focusUser.getUserId();
	int totalNumberOfEsmTest = focusUser.getTotalNumberOfEsmTest();

	int positive = (int) request.getAttribute("positive");
	int negative = (int) request.getAttribute("negative");
	
	Calendar cal = Calendar.getInstance();
	Date date = new Date();
	
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH)+1;
	int day = cal.get(Calendar.DATE);
	
	int hour = date.getHours();
	int min = date.getMinutes();
	int sec = date.getSeconds();
%>
<%
	String months = "";
	String days = "";
	if(month < 10){
		months = "0" + Integer.toString(month);
	}
	if(day < 10){
		days = "0" + Integer.toString(day);
	}
	else{
		days = Integer.toString(day);
	}
	
	String hours = "";
	String mins = "";
	String secs = "";
	if(hour < 10){
		hours = "0" + Integer.toString(hour);
	}
	else{
		hours = Integer.toString(hour);
	}
	if(min < 10){
		mins = "0" + Integer.toString(min);
	}
	else{
		mins = Integer.toString(min);
	}
	if(sec < 10){
		secs = "0" + Integer.toString(sec);
	}
	else{
		secs = Integer.toString(sec);
	}
	
	String msg = "결과를 등록하였습니다.";
	String location="esmresultprofile.jsp";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>esm result</title>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    
      google.charts.load('current', {packages:['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['정서 반복 기록', 'Result', {role:"style"}],
          ['긍정', <%=positive%>, "color : #66cc66"],
          ['부정', <%=negative%>, "color : #ff6666"]
        ]);
        
        var view = new google.visualization.DataView(data);
        view.setColumns([0, 1,
                         { calc: "stringify",
                           sourceColumn: 1,
                           type: "string",
                           role: "annotation" },
                         2]);

        var options = {
          chart: {
            title: '정서 반복 기록 결과',
            subtitle: '<%=year %>년 <%=months %>월 <%=days %>일 결과입니다',
          }
        };

        //var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

        //chart.draw(data, google.charts.Bar.convertOptions(options));
        
        var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
        chart.draw(view, options);
      }
      
    </script>
    <style>
    	.btn{
			border : 1px solid #ff6666;
			border-radius : 10px;
			background-color:#ff6666;
			padding : 10px;
			margin : 20px;
			color : white;
			height : 50px;
			width : 150px;
		}
    </style>
</head>
<body>
	<%@ include file="sidebar.jsp"%>

	<div id="columnchart_values" style="width: 800px; height: 500px;"></div>
	<!-- <input type="button" class="btn" id="goToTimesOfDateBtn" value="다른 시간대 결과 확인하기" onClick="location.href='esmtimesofdate.jsp'">
	<input type="button" class="btn" id="goToProfileBtn" value="다른  날짜 결과 확인하기" onClick="location.href='esmresultprofile.jsp'"> -->
	<input type="button" class="btn" id="goToMainBtn" value="메인으로 돌아가기" onClick="location.href='esmtestmain.jsp';">
</body>
</html>