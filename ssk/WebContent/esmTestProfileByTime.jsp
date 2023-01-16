<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dto.EsmReply" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>정서 반복 기록 시간별 그래프</title>
<%
	ArrayList<Date> esmTestLogList = (ArrayList<Date>)request.getAttribute("esmTestLogList");
	ArrayList<EsmTestLog> selectedDateEsmTestLogList = (ArrayList<EsmTestLog>)request.getAttribute("selectedEsmTestLogList");
	ArrayList<Integer> positiveList = (ArrayList<Integer>)request.getAttribute("positiveList");
	ArrayList<Integer> negativeList = (ArrayList<Integer>)request.getAttribute("negativeList");
%>
<script type="text/javascript" src="http://www.gstatic.com/charts/loader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	$(window).resize(function(){
		drawChart();
    });
   google.charts.load('current', {'packages':['corechart']});
   google.charts.setOnLoadCallback(drawChart);
   
   function drawChart() {
     var data = google.visualization.arrayToDataTable([

       ['Time', '긍정 감정', '부정 감정'],
       <% 
          for(int i = 0; i < selectedDateEsmTestLogList.size(); i++){
       %>
       ['<%=selectedDateEsmTestLogList.get(i).getEsmTestTime().toString()%>',  <%=positiveList.get(i)%>, <%=negativeList.get(i)%>],

      <%   
          }
       %>
     ]);
   
     var options = {
       annotations : {
            alwaysOutside : true
           },
           vAxis : {
              viewWindow : {
                 max : 25,
                 min : 0
              },
           },
           'legend' : 'none',
           series : {
              0 : {color : '#66cc66'},
              1 : {color : '#ff6666'},
           },
           lineWidth : 5,
           pointSize : 10
     };
   
     var chart = new google.visualization.LineChart(document.getElementById('esmProfileChart'));
   
     chart.draw(data, options);
   }
</script>
</head>
<body>
	<%@ include file="sidebar.jsp"%>
   <div style="text-align:center;font-weight:bold;font-size:1.5em;margin-top:0.5em">정서 반복 기록 - 시간별 그래프</div>
   
	<div class="w3-row">
		<div class="w3-col m1 l1">&nbsp;</div>
		<div class="w3-col s12 m10 l10">
			<div id="esmProfileChart" style="width:100%;height: 60vh;"></div>
		</div>
		<div class="w3-col m1 l1">&nbsp;</div>
	</div>
	<div class="w3-row w3-margin-top">
		<div class="w3-col s2 m3 l3">&nbsp;</div>
		<div class="w3-col w3-row s4 m2 l2">
			<button class="w3-button w3-col w3-padding" style="border:1px solid #ff6666;border-radius:10px;background-color:#ff6666;margin-bottom:10px;height:50px;color:white;font-size:1em;align-items : center;"onclick="location.href='../ssk/GetEsmTestProfileByDay';">일별 그래프 보기</button>
		</div>
		<div class="w3-col s1 m3 l3">&nbsp;</div>
		<div class="w3-col w3-row s3 m1 l1">
			<button class="w3-button w3-col w3-padding"style="border:1px solid #ff6666;border-radius:10px;background-color:#ff6666;margin-bottom:10px;height:50px;color:white;font-size:1em;align-items : center;"onclick="location.href='../ssk/esmTestMain.jsp';">메인으로</button>
		</div>
		<div class="w3-col s2 m3 l3">&nbsp;</div>
	</div>

</body>
</html>