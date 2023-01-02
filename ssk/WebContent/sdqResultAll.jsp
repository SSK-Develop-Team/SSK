<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="model.dto.SdqQuestion" %>
<%@ page import="model.dto.SdqResultAnalysis" %>
<%@ page import="model.dto.SdqTestLog" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>정서 행동 발달 검사 결과</title>

<%
	User currUser = (User)session.getAttribute("currUser");
	SdqTestLog sdqTestLog = (SdqTestLog)session.getAttribute("sdqTestLog");
	Date sdqTestDate = sdqTestLog.getSdqTestDate();

	int[] scoreList = (int[])request.getAttribute("sdqScoreList");
	ArrayList<SdqResultAnalysis> sdqResultAnalysisList = (ArrayList<SdqResultAnalysis>)request.getAttribute("sdqResultAnalysisList");
%>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	$(window).resize(function(){
		drawChart();
	    });
      google.charts.load('current', {packages:['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['정서 / 행동 발달 검사', 'Result', {role:"style"}, {role:'annotation'}],
          ['<%=sdqResultAnalysisList.get(0).getSdqType()%>', <%=scoreList[0]%>, '<%=sdqResultAnalysisList.get(0).getColor()%>', '<%=sdqResultAnalysisList.get(0).getSdqAnalysisResult()%>'],
          ['<%=sdqResultAnalysisList.get(1).getSdqType()%>', <%=scoreList[1]%>, '<%=sdqResultAnalysisList.get(1).getColor()%>', '<%=sdqResultAnalysisList.get(1).getSdqAnalysisResult()%>'],
          ['<%=sdqResultAnalysisList.get(2).getSdqType()%>', <%=scoreList[2]%>, '<%=sdqResultAnalysisList.get(2).getColor()%>', '<%=sdqResultAnalysisList.get(2).getSdqAnalysisResult()%>'],
          ['<%=sdqResultAnalysisList.get(3).getSdqType()%>', <%=scoreList[3]%>, '<%=sdqResultAnalysisList.get(3).getColor()%>', '<%=sdqResultAnalysisList.get(3).getSdqAnalysisResult()%>'],
          ['<%=sdqResultAnalysisList.get(4).getSdqType()%>', <%=scoreList[4]%>, '<%=sdqResultAnalysisList.get(4).getColor()%>', '<%=sdqResultAnalysisList.get(4).getSdqAnalysisResult()%>'],
        ]);
        
        var view = new google.visualization.DataView(data);
        view.setColumns([0, 1,
                         { calc: "stringify",
                           sourceColumn: 1,
                           type: "string",
                           role: "annotation" },
                         2]);

        var options = {
        	annotations : {
        		alwaysOutside : true
        	},
          	vAxis : {
          		viewWindow : {
          			max : 6,
          			min : 0
          		}
          	},
        	'legend' : 'none'
          	
        };
        
        var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
        chart.draw(view, options);
      }
    </script>
</head>
<body>
	<%@ include file="sidebar.jsp"%>
	<div style="text-align:center;font-weight:bold;font-size:1.5em;margin-top:0.5em"><%=currUser.getUserName()%>의 SDQ 검사 결과</div>
	<div style="text-align:center;font-size:1.2em;margin-top:0.5em"><%=1900+sdqTestDate.getYear()%>년 <%=sdqTestDate.getMonth()+1%>월 <%=sdqTestDate.getDate()%>일 결과입니다.</div>
	<div class="w3-row">
		<div class="w3-col m1 l2">&nbsp;</div>
		<div class="w3-col s12 m10 l8">
			<div id="columnchart_values" style="width:100%;height: 60vh;"></div>
		</div>
		<div class="w3-col m1 l2">&nbsp;</div>
	</div>
	<div class="w3-row w3-margin-top">
		<div class="w3-col s2 m3 l3">&nbsp;</div>
		<div class="w3-col w3-row s4 m2 l2">
			<button class="w3-button w3-col w3-padding" id="sdqPopUpBtn" style="border:1px solid #ff6666;border-radius:10px;background-color:#ff6666;margin-bottom:10px;height:50px;color:white;font-size:1em;align-items : center;"onclick="document.getElementById('modal').style.display='block';">검사 결과 설명 보기</button>
		</div>
		<div class="w3-col s1 m3 l3">&nbsp;</div>
		<div class="w3-col w3-row s3 m1 l1">
			<button class="w3-button w3-col w3-padding"style="border:1px solid #ff6666;border-radius:10px;background-color:#ff6666;margin-bottom:10px;height:50px;color:white;font-size:1em;align-items : center;"onclick="location.href='../ssk/sdqTestMain.jsp';">메인으로</button>
		</div>
		<div class="w3-col s2 m3 l3">&nbsp;</div>
	</div>
	<div id="modal" class="w3-modal">
    <div class="w3-modal-content">
      <div class="w3-container">
        <span onclick="document.getElementById('modal').style.display='none'" class="w3-button w3-display-topright">&times;</span>
        <p class="dsc">
			<div id="sdqAnalysis" style="text-align:center;">
				<div style="font-size:1.5em;font-weight:bold;"><%=currUser.getUserName()%>의 SDQ 검사 결과 설명</div>
				<%for(int i =0;i<sdqResultAnalysisList.size();i++){ %>
					<p style="font-weight: bold;">[ <%=sdqResultAnalysisList.get(i).getSdqType()%> ]</p>
					<p>
						<span style="color:<%=sdqResultAnalysisList.get(i).getColor()%>;"><%=sdqResultAnalysisList.get(i).getSdqAnalysisResult()%></span><br>
						<%=sdqResultAnalysisList.get(i).getDescription()%>
					</p>
					<br>
				<%} %>

			</div>
		</p>
      </div>
    </div>
  </div>
</body>
</html>