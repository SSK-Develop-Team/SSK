<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import ="java.util.*" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="model.dto.User" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>정서 반복 기록 결과</title>
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
      },
      annotations : {
  		alwaysOutside : true
  		},
    	vAxis : {
    		viewWindow : {
    			max : 25,
    			min : 0
    		}
    	}
    };
    
    var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
    chart.draw(view, options);
  }
  
</script>
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	<div class="w3-row">
		<div class="w3-col m1 l2">&nbsp;</div>
		<div class="w3-col s12 m10 l8">
			<div id="columnchart_values" style="width:100%;height: 60vh;"></div>
		</div>
		<div class="w3-col m1 l2">&nbsp;</div>
	</div>
	<div class="w3-row">
		<div class="w3-col m1 l2">&nbsp;</div>
		<div class="w3-col s12 m10 l8">
			<div id="columnchart_values" style="width:100%;height: 60vh;"></div>
		</div>
		<div class="w3-col m1 l2">&nbsp;</div>
	</div>
	<input type="button"value="메인으로" onClick="location.href='esmTestMain.jsp'">
</body>
</html>