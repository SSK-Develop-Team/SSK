<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="org.json.simple.JSONObject" %>
<%@page import="org.json.simple.JSONArray" %>
<%@page import="model.dto.EsmRecord" %>
<!DOCTYPE html>
<html>
<% 
	String currDateStr = (String)request.getAttribute("currDateStr");
	ArrayList<EsmRecord> currEsmRecordList = (ArrayList<EsmRecord>)request.getAttribute("currEsmRecordList");
	JSONObject eventsJsonObject = (JSONObject)session.getAttribute("eventsJsonObject");
	JSONArray eventsJsonArray = (JSONArray)eventsJsonObject.get("events");	
%>
	<head>
	<title>정서 다이어리</title>
	<link href='fullcalendar/main.css' rel='stylesheet' />
	<link href="css/esmRecord.css" rel="stylesheet" type='text/css' >
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	
	<script src='fullcalendar/main.js'></script>
	<script src='fullcalendar/locales-all.js'></script>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			headerToolbar: {
	        	left: 'prev,next',
	        	center: 'title',
	        	right: 'dayGridMonth'
	        
	    	},
	    	height: 500,
	    	locale: "ko",
	    	selectable: true,
	    	displayEventTime:false,
			timeZone: "local",
	  		dateClick: function(info) {//날짜 클릭 시 이벤트
		    	getDayEsmRecord('GetDayEsmRecord',info.dateStr);//해당 날짜 문자열 반환 -> 해당하는 텍스트 데이터 받아오기
			},
			events: <%=eventsJsonArray%>
		});
		calendar.render();
		calendar.gotoDate('<%=currDateStr%>');
	});
	 function getDayEsmRecord(url, date){/*해당 날짜의 ESM 기록을 가져오는 함수*/
		var form = document.createElement('form');
	  	form.setAttribute('method','post');
	  	form.setAttribute('action',url);
	  	document.charset = "utf-8";
	  	var dateInput = document.createElement('input');
	  	dateInput.setAttribute('type','hidden');
	  	dateInput.setAttribute('name','selectedDateStr');
	  	dateInput.setAttribute('value',date);
	  	form.appendChild(dateInput);
	  	document.body.appendChild(form);
	  	form.submit();
	  }
	 function getPreDayEsmRecord(url, date){
		 const preDate = new Date(date);
		 preDate.setDate(preDate.getDate()-1);
		 var preDateStr = preDate.toISOString().slice(0, 10);
		 getDayEsmRecord(url, preDateStr);
	 }
	 function getNextDayEsmRecord(url, date){
		 const nextDate = new Date(date);
		 nextDate.setDate(nextDate.getDate()+1);
		 var nextDateStr = nextDate.toISOString().slice(0, 10);
		 getDayEsmRecord(url, nextDateStr);
	 }
	 
	</script>
</head>
<body>
<%@ include file="sidebar.jsp"%>
	<div class="w3-row">
		<div class="w3-col s1 m1 l1">&nbsp;</div>
		<div class="w3-col s10 m10 l10">
			<div class="w3-hide-medium w3-hide-large">&nbsp;</div>
			<div style="font-size:1.3em;"><b>정서 다이어리 조회하기</b></div>
			<div>&nbsp;</div>
		 	<div class="w3-row">
				<div id='calendar-view' class="w3-hide-small w3-half w3-container ">
					<div id='calendar'></div>
				</div>
				<div id='record-view' class="w3-half w3-container">
				<div class="records-date w3-panel w3-row ">
						<div class="w3-col s3 w3-center" >
							<button class="w3-button w3-circle w3-white w3-left" id="pre_btn" onclick="getPreDayEsmRecord('GetDayEsmRecord','<%=currDateStr%>');"><img src="./image/previous_w.png" alt="pre_btn" style="width:1em;height:auto;filter: brightness(0.3);"></button>
						</div>
						<div class="w3-col s6 w3-center" style="font: 1.5em sans-serif;font-weight:bold;" ><%=currDateStr%></div>
						<div class="w3-col s3 w3-center">
							<button class="w3-button w3-circle w3-white w3-right" id="next_btn"onclick="getNextDayEsmRecord('GetDayEsmRecord','<%=currDateStr%>');"><img src="./image/next_w.png" alt="next_btn" style="width:1em;height:auto;filter: brightness(0.3);"></button>
						</div>
						
					</div>
					<hr>
					
					<%if(currEsmRecordList.size()>0){%>
					<div class="record-container" style="height:80%;">
						<%
						for(int i=0;i<currEsmRecordList.size();i++){ %>
						<div class="record-box w3-panel w3-border w3-round-large">
							<%
								if(currEsmRecordList.get(i).getEsmRecordTime() == null) {%>
								<div class="record-time"style="text-align:right;font-size:1em;">&nbsp;</div>
							<%}else{ %>
								<div class="record-time"style="text-align:right;font-size:1em;margin-top:0.5em;"><%=currEsmRecordList.get(i).getEsmRecordTime()%></div>
							<%} %>
							<div class="record-text"style="font-size:1em;min-height:7vh;width:100%;word-break:break-all;margin-bottom:1em;"><%=currEsmRecordList.get(i).getEsmRecordText()%></div>
						</div>
						<%}%>
						</div>
					<%}else{ %>
					<div class="w3-center">
						<div>해당 일자의 기록이 없습니다.</div>
					</div>
				<%} %>
				<div>&nbsp;</div>
				<button class="w3-button w3-col w3-padding"style="border:1px solid #1A2A3A;border-radius:10px;background-color:#1A2A3A;margin-bottom:10px;height:50px;color:white;font-size:1em;align-items : center;" onclick="location.href='../ssk/GetEsmRecordMain'">돌아가기</button>
				</div>
		 	</div>
		 	<div>&nbsp;</div>
		 	
		</div>
		<div class="w3-col s1 m1 l1">&nbsp;</div>
	</div>
	
 	
 	<script type="text/javascript" src="./js/esmRecord.js"></script>
</body>
</html>
