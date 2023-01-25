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
	User focusUser = (User)request.getAttribute("focusUser");

	ArrayList<SdqTestLog> sdqTestLogList = (ArrayList<SdqTestLog>)request.getAttribute("sdqTestLogList");
	SdqTestLog selectedSdqTestLog = (SdqTestLog)request.getAttribute("selectedSdqTestLog");
	ArrayList<SdqResultOfType> sdqResult = (ArrayList<SdqResultOfType>)request.getAttribute("sdqResult");
	ArrayList<SdqResultAnalysis> sdqResultAnalysisList = (ArrayList<SdqResultAnalysis>)request.getAttribute("sdqResultAnalysisList");

	int selectedIndex = sdqTestLogList.indexOf(selectedSdqTestLog);
%>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
          <%for(int i=0;i<sdqResult.size();i++){%>
	          ['<%=sdqResultAnalysisList.get(i).getSdqType()%>', <%=sdqResult.get(i).getResult()%>, '<%=sdqResultAnalysisList.get(i).getColor()%>', '<%=sdqResultAnalysisList.get(0).getSdqAnalysisResult()%>'],
        <%}%>
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
	<!-- page title -->
   <div style="text-align:center;font-weight:bold;font-size:1.5em;margin-top:0.5em">정서 반복 기록 - 일 별 그래프</div>
   <div>&nbsp;</div>
   <div>&nbsp;</div>
   
   <!-- 날짜 선택 -->
   <div class="w3-row">
		<div class="w3-col s1 m2 l4">&nbsp;</div>
		<c:set var="selectedIndex" scope="page"><%=selectedIndex%></c:set>
		
		<c:choose>
		<c:when test="${selectedIndex eq 0}">
			<div class="w3-col s1 m1 l1 w3-center"onclick="alert('이전 기록이 없습니다.');"><img src="./image/left-arrow.png" style="width:2.5em; opacity: 0.5;"/></div>
		</c:when>
		<c:otherwise>
			<div class="w3-col s1 m1 l1 w3-center" onclick="location.href='../ssk/GetSdqResultAll?sdqTestLogId=<%=sdqTestLogList.get(selectedIndex-1).getSdqTestLogId()%>'"><img src="./image/left-arrow.png" style="width:2.5em;"/></div>
		</c:otherwise>
		</c:choose>
		
		<div class="w3-col s8 m6 l2" >
			<div class="w3-dropdown-hover"style="width:100%;">
			    <button class="w3-button"style="width:100%;background-color:#D9D9D9;"><%=selectedSdqTestLog.getSdqTestDate().toString()%>&nbsp;<%=selectedSdqTestLog.getSdqTestTime().toString()%></button>
			    <div class="w3-dropdown-content w3-bar-block w3-border"style="width:100%;">
			      <%for(int i = sdqTestLogList.size()-1 ; i >= 0 ;i--){ %>
			      <a href="../ssk/GetSdqResultAll?sdqTestLogId=<%=sdqTestLogList.get(i).getSdqTestLogId()%>" class="w3-bar-item w3-button"style="width:100%;"><%=sdqTestLogList.get(i).getSdqTestDate().toString()%>&nbsp;<%=sdqTestLogList.get(i).getSdqTestTime().toString()%></a>
			      <%} %>
			    </div>
		    </div>
		</div>
		
		<c:choose>
		<c:when test="${selectedIndex eq sdqTestLogList.size()-1}">
			<div class="w3-col s1 m1 l1 w3-center"onclick="alert('다음 기록이 없습니다.');"><img src="./image/right-arrow.png" style="width:2.5em; opacity: 0.5;"/></div>
		</c:when>
		<c:otherwise>
			<div class="w3-col s1 m1 l1 w3-center"onclick="location.href='../ssk/GetSdqResultAll?sdqTestLogId=<%=sdqTestLogList.get(selectedIndex+1).getSdqTestLogId()%>'"><img src="./image/right-arrow.png" style="width:2.5em;"/></div>
		</c:otherwise>
		</c:choose>
		
		<c:remove var="selectedIndex" scope="page"/>
		
		<div class="w3-col s1 m2 l4">&nbsp;</div>
   </div>
   
	<!-- 시간별 그래프 뷰 -->
	<div class="w3-row">
		<div class="w3-col m1 l2">&nbsp;</div>
		<div class="w3-col s12 m10 l8">
			<div id="columnchart_values" style="width:100%;height: 60vh;"></div>
		</div>
		<div class="w3-col m1 l2">&nbsp;</div>
	</div>
	<div class="w3-row w3-margin-top">
		<div class="w3-col s2 m3 l3">&nbsp;</div>
		<div class="w3-col w3-row s4 m3 l2">
			<button class="w3-button w3-col w3-padding" id="sdqPopUpBtn" style="border:1px solid #ff6666;border-radius:10px;background-color:#ff6666;margin-bottom:10px;height:50px;color:white;font-size:1em;align-items : center;"onclick="document.getElementById('modal').style.display='block';">검사 결과 설명 보기</button>
		</div>
		<div class="w3-col s1 m1 l3">&nbsp;</div>
		<div class="w3-col w3-row s3 m2 l1">
			<button class="w3-button w3-col w3-padding"style="border:1px solid #ff6666;border-radius:10px;background-color:#ff6666;margin-bottom:10px;height:50px;color:white;font-size:1em;align-items : center;"onclick="location.href='../ssk/sdqTestMain.jsp';">메인으로</button>
		</div>
		<div class="w3-col s2 m2 l3">&nbsp;</div>
	</div>
	
	
	<div id="modal" class="w3-modal">
    <div class="w3-modal-content">
      <div class="w3-container">
        <span onclick="document.getElementById('modal').style.display='none'" class="w3-button w3-display-topright">&times;</span>
        <p class="dsc">
			<div id="sdqAnalysis" style="text-align:center;">
				<div style="font-size:1.5em;font-weight:bold;"><%=focusUser.getUserName()%>의 SDQ 검사 결과 설명</div>
				<%for(int i = 0 ; i<sdqResultAnalysisList.size() ; i++){ %>
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