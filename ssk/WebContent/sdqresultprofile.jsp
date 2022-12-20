<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="model.dto.User"%>
<%@ page import="model.dto.SdqReply"%>
<%@ page import="java.util.ArrayList"%>

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
	//int totalNumberOfSdqTest = focusUser.getTotalNumberOfSdqTest();
	
	ArrayList<SdqReply> results = (ArrayList<SdqReply>)session.getAttribute("results");
	//System.out.println("results : " + results);
	ArrayList<String> sdqTestDates = (ArrayList<String>)session.getAttribute("sdqTestDates");
	//System.out.println("sdqresultprofile :: sdqTestDates : " + sdqTestDates);
	ArrayList<String> sdqTestTimes = (ArrayList<String>)session.getAttribute("sdqTestTimes");
	//System.out.println("sdqresultprofile :: sdqTestTimes : " + sdqTestTimes);
	
%>
<%
int socialIntervention = (int) session.getAttribute("socialIntervention");
int socialBoundary = (int) session.getAttribute("socialBoundary");
int socialNormal = (int) session.getAttribute("socialNormal");
int excessiveIntervention = (int) session.getAttribute("excessiveIntervention");
int excessiveBoundary = (int) session.getAttribute("excessiveBoundary");
int excessiveNormal = (int) session.getAttribute("excessiveNormal");
int emotionIntervention = (int) session.getAttribute("emotionIntervention");
int emotionBoundary = (int) session.getAttribute("emotionBoundary");
int emotionNormal = (int) session.getAttribute("emotionNormal");
int behaviorIntervention = (int) session.getAttribute("behaviorIntervention");
int behaviorBoundary = (int) session.getAttribute("behaviorBoundary");
int behaviorNormal = (int) session.getAttribute("behaviorNormal");
int peerIntervention = (int) session.getAttribute("peerIntervention");
int peerBoundary = (int) session.getAttribute("peerBoundary");
int peerNormal = (int) session.getAttribute("peerNormal");

int social = (int) request.getAttribute("social");
int excessive = (int) request.getAttribute("excessive");
int emotion = (int) request.getAttribute("emotion");
int behavior = (int) request.getAttribute("behavior");
int peer = (int) request.getAttribute("peer");
  String socialAn = "";
  String excessiveAn = "";
  String emotionAn = "";
  String behaviorAn = "";
  String peerAn = "";
%>
<%
  
  Calendar cal = Calendar.getInstance();
  
  int year = cal.get(Calendar.YEAR);
  int month = cal.get(Calendar.MONTH)+1;
  int day = cal.get(Calendar.DATE);
  

%>

<%
  String years = "";
  String months = "";
  String days = "";
  years = Integer.toString(year);
  if(month < 10){
     months = "0" + Integer.toString(month);
  }
  else{
     months = Integer.toString(day);
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
  
  String msg = "결과를 등록하였습니다.";
  String location="esmresultprofile.jsp";
  
  String interventionColor = "#ff6666";
  String boundaryLineColor = "#ffcc33";
  String normalColor = "#339999";
  
  // 그래프 색상 기본 설정
  String socialColor = "'#1a2a3a'";
  String excessiveColor = "'#1a2a3a'";
  String emotionColor = "'#1a2a3a'";
  String behaviorColor = "'#1a2a3a'";
  String peerColor = "'#1a2a3a'";
  
  String socialAnalysis = "'정상'";
  String excessiveAnalysis = "'정상'";
  String emotionAnalysis = "'정상'";
  String behaviorAnalysis = "'정상'";
  String peerAnalysis = "'정상'";
  
  if(social <= socialIntervention){
     socialColor = "'" + interventionColor + "'"; 
     socialAnalysis = "'개입 필요'";
     socialAn = "친구를 배려하며 상대를 도와주는 행동을 하기 위해 도움이 필요합니다.";
  }
  else if(social <= socialBoundary){
     socialColor = "'" + boundaryLineColor + "'";
     socialAnalysis = "'경계선'";
     socialAn = "친구를 배려하며 상대를 도와주는 행동이 더욱 필요합니다.";
  }
  else if(social <= socialNormal){
     socialColor = "'" + normalColor + "'";
     socialAn = "친구를 배려하며 상대를 도와주는 행동이 좋습니다.";
  }
  
  if(excessive <= excessiveNormal){
     excessiveColor = "'" + normalColor + "'";
     excessiveAn = "행동이 차분하며 집중을 잘합니다.";
  }
  else if(excessive <= excessiveBoundary){
     excessiveColor = "'" + boundaryLineColor + "'";
     excessiveAnalysis = "'경계선'";
     excessiveAn = "집중하는 면과 차분하게 행동하는 것이 더욱 필요합니다.";
  }
  else if(excessive <= excessiveIntervention){
     excessiveColor = "'" + interventionColor + "'";
     excessiveAnalysis = "'개입 필요'";
     excessiveAn = "차분하게 행동하고 집중을 잘하기 위해서 도움이 필요합니다.";
  }
  
  if(emotion <= emotionNormal){
     emotionColor = "'" + normalColor + "'";
     emotionAn = "낯선 상황에서 불안해하지 않으며 자신감이 높습니다.";
  }
  else if(emotion <= emotionBoundary){
     emotionColor = "'" + boundaryLineColor + "'";
     emotionAnalysis = "'경계선'";
     emotionAn = "낯선 상황에서 불안해하지 않고 자신감을 더욱 높이는 것이 필요합니다.";
  }
  else if(emotion <= emotionIntervention) {
     emotionColor = "'" + interventionColor + "'";
     emotionAnalysis = "'개입 필요'";
     emotionAn = "낯선 상황에서 불안해하지 않고 자신감을 높이기 위해 도움이 필요합니다.";
  }
  
  if(behavior <= behaviorNormal){
     behaviorColor = "'" + normalColor + "'";
     behaviorAn = "친구를 괴롭히거나 싸우지 않고 솔직합니다.";
  }
  else if(behavior <= behaviorBoundary){
     behaviorColor = "'" + boundaryLineColor + "'";
     behaviorAnalysis = "'경계선'";
     behaviorAn = "친구를 괴롭히거나 싸우지 않고 보다 솔직한 것이 필요합니다.";
  }
  else if(behavior <= behaviorIntervention) {
     behaviorColor = "'" + interventionColor +"'";
     behaviorAnalysis = "'개입 필요'";
     behaviorAn = "친구를 괴롭히거나 싸우지 않고 솔직해 지기 위해 도움이 필요합니다.";
  }
  
  if(peer <= peerNormal){
     peerColor = "'" + normalColor + "'";
     peerAn = "친구들과 사이가 좋으며 친구들이 좋아합니다.";
  }
  else if(peer <= peerBoundary){
     peerColor = "'" + boundaryLineColor + "'";
     peerAnalysis = "'경계선'";
     peerAn = "친구들과 더 좋은 관계를 갖는 것이 필요합니다.";
  }
  else if(peer <= peerIntervention){
     peerColor = "'" + interventionColor + "'";
     peerAnalysis = "'개입 필요'";
     peerAn = "친구들과 좋은 관계를 갖기 위해 도움이 필요합니다.";
  }
  
  
  
  String colorStr = "#258595";
%>
<!DOCTYPE html>
<html>
<head>
<style>
body {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

h3 {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 1%;
	font-size: 25px;
}

.dates {
	border: 1px solid #ff6666;
	border-radius: 10px;
	background-color: #ff6666;
	padding: 10px;
	margin: 20px;
	color: white;
	height: 50px;
	width: 180px;
}

#btndiv {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	margin: 60px;
}

.btn {
	border: 1px solid #ff6666;
	border-radius: 10px;
	background-color: #ff6666;
	padding: 10px;
	margin: 20px;
	color: white;
	height: 50px;
	width: 350px;
	font-size: 20px;
}

#profile {
	border: dotted #ff6666;
}

* {
	margin: 0;
	padding: 0;
}

a {
	text-decoration: none;
}

.wrap {
	padding: 10px;
	justify-content: center;
	align-items: center;
	margin: 60px;
}

.openBtn {
	border: 1px solid #ff6666;
	border-radius: 10px;
	background-color: #ff6666;
	padding: 10px;
	margin: 20px;
	color: white;
	height: 50px;
	width: 350px;
	font-size: 20px;
	text-align: center;
}

.closeBtn {
	border: 1px solid #ff6666;
	border-radius: 10px;
	background-color: #ff6666;
	padding: 10px;
	margin: 20px;
	color: white;
	height: 50px;
	width: 350px;
	font-size: 20px;
	text-align: center;
}

.pop_wrap {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, .5);
	font-size: 0;
	text-align: center;
}

.pop_wrap:after {
	display: inline-block;
	height: 100%;
	vertical-align: middle;
	content: '';
}

.pop_wrap .pop_inner {
	display: inline-block;
	padding: 20px 30px;
	background: #fff;
	width: 70%;
	vertical-align: middle;
	font-size: 15px;
}
</style>
<meta charset="UTF-8">
<title>sdq result profile</title>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    
      google.charts.load('current', {packages:['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['정서 반복 기록', 'Result', {role:"style"}, {role:'annotation'}],
          ['사회지향행동', <%=social%>, <%=socialColor%>, <%=socialAnalysis%>],
          ['과잉행동', <%=excessive%>, <%=excessiveColor%>, <%=excessiveAnalysis%>],
          ['정서증상', <%=emotion%>, <%=emotionColor%>, <%=emotionAnalysis%>],
          ['품행문제', <%=behavior%>, <%=behaviorColor%>, <%=behaviorAnalysis%>],
          ['또래문제', <%=peer%>, <%=peerColor%>, <%=peerAnalysis%>]
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
            subtitle: '<%=years %>년 <%=months %>월 <%=days %>일 결과입니다',
             },
           //colors:['#457515','#1a2a3a','red','yellow','black'],
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
	<h3><%=focusUser.getUserName()%>님의 SDQ 결과 프로파일</h3>
	<div style="overflow-y: scroll; width: 100%; height: 300px;" id="profile">
		<div id="sdqDates">
			<% 
			String dateStr = "";				
			for(int i = 0; i < sdqTestTimes.size(); i++){ 
				if(i == 0){
					dateStr = sdqTestDates.get(i);
					%>
					<br><p style="margin-left:10px;"><%= dateStr %></p>
					<%
				}
				if(!dateStr.equals(sdqTestDates.get(i))){
					dateStr = sdqTestDates.get(i);
					//System.out.println("sdqresultprofile.jsp : dateStr : " + dateStr);
					%>
					<br><p style="margin-left:10px;"><%= dateStr %></p>
					<%
				}
			%>
				<button class="dates"
					onclick="javascript:location.href='../EwhaSSK/GetSDQResultSelected?time=<%=sdqTestDates.get(i) + " " + sdqTestTimes.get(i)%>'">
					<%=sdqTestTimes.get(i).split(":")[0] %>시
					<%=sdqTestTimes.get(i).split(":")[1] %>분
					<%=sdqTestTimes.get(i).split(":")[2] %>초
				</button>
			<%
				System.out.println("sdqresultprofile :: sdqTestTimes : " + sdqTestTimes.get(i));
			} %>
		</div>
	</div>
	<div id="columnchart_values" style="width: 80%; height: 500px;"></div>
	<div id="btndiv">
		<!-- <button class="btn" id="helpBtn" onClick="openPop();">도움말</button>
		<button class="btn" id="analysisBtn" onClick="javascript:location.href='GetSDQDates';">결과 해석 확인하기</button> -->
		<a href="#pop_info_1" class="openBtn">결과 해석 확인하기</a> 
		<!-- <a href="#pop_info_2"
			class="openBtn">결과 해석 확인하기</a>-->
		
	</div>


	<div class="wrap">


		<div id="pop_info_1" class="pop_wrap" style="display: none;">
			<div class="pop_inner">
				<p class="dsc">
				<div id="sdqAnalysis">
					<h3><%=name%>의 SDQ 검사 결과 설명
					</h3>
					<p style="font-weight: bold;">[ 사회지향행동 ]</p>
					<p>
						<span
							style="font-weight: bold; color:<%=socialColor.split("'")[1]%>"><%=socialAnalysis%></span><br>
						<%=socialAn%></p>
					<br>
					<p style="font-weight: bold;">[ 과잉행동 ]</p>
					<p>
						<span
							style="font-weight: bold; color:<%=excessiveColor.split("'")[1]%>"><%=excessiveAnalysis%></span><br>
						<%=excessiveAn%></p>
					<br>
					<p style="font-weight: bold;">[ 정서증상 ]</p>
					<p>
						<span
							style="font-weight: bold; color:<%=emotionColor.split("'")[1]%>"><%=emotionAnalysis%></span><br>
						<%=emotionAn%></p>
					<br>
					<p style="font-weight: bold;">[ 품행문제 ]</p>
					<p>
						<span
							style="font-weight: bold; color:<%=behaviorColor.split("'")[1]%>"><%=behaviorAnalysis%></span><br>
						<%=behaviorAn%></p>
					<br>
					<p style="font-weight: bold;">[ 또래문제 ]</p>
					<p>
						<span
							style="font-weight: bold; color:<%=peerColor.split("'")[1]%>"><%=peerAnalysis%></span><br>
						<%=peerAn%></p>
					<br>

				</div>
				</p>
				<button type="button" class="closeBtn">닫기</button>
			</div>
		</div>

		<div id="pop_info_2" class="pop_wrap" style="display: none;">
			<div class="pop_inner">
				<p class="dsc">팝업 안내문구 입니다222.</p>
				<button type="button" class="closeBtn">닫기</button>
			</div>
		</div>
	</div>

</body>
<script>
	var target = document.querySelectorAll('.openBtn');
	var btnPopClose = document.querySelectorAll('.pop_wrap .closeBtn');
	var targetID;

	// 팝업 열기
	for (var i = 0; i < target.length; i++) {
		target[i].addEventListener('click', function() {
			targetID = this.getAttribute('href');
			document.querySelector(targetID).style.display = 'block';
		});
	}

	// 팝업 닫기
	for (var j = 0; j < target.length; j++) {
		btnPopClose[j].addEventListener('click', function() {
			this.parentNode.parentNode.style.display = 'none';
		});
	}
</script>
</html>