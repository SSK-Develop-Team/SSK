<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
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
%>

<%
ArrayList<EsmResult> results = (ArrayList<EsmResult>)session.getAttribute("results");
   ArrayList<String> daysOfWeek = (ArrayList<String>)request.getAttribute("daysOfWeek");
   ArrayList<Integer> positive = (ArrayList<Integer>)request.getAttribute("positive");
   ArrayList<Integer> negative = (ArrayList<Integer>)request.getAttribute("negative");
   int indexOfWeek = (int)request.getAttribute("indexOfWeek");

   System.out.println("=============");
   
   int minIndex = 1;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정서 반복 기록</title>

<script type="text/javascript" src="http://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
   google.charts.load('current', {'packages':['corechart']});
   google.charts.setOnLoadCallback(drawChart);
   
   function drawChart() {
     var data = google.visualization.arrayToDataTable([
       ['Time', '긍정 감정', '부정 감정'],
       <% 
          for(int i = 0; i < daysOfWeek.size(); i++){
       %>
       [<%="'" + daysOfWeek.get(i).split("-")[0] + "년 " + daysOfWeek.get(i).split("-")[1] + "월 " + daysOfWeek.get(i).split("-")[2] + "일'"%>,  <%=positive.get(i)%>, <%=negative.get(i)%>],
      <%   
          }
       %>
     ]);
   
     var options = {
       title: '<%=daysOfWeek.get(0).split("-")[0]%>년 <%=daysOfWeek.get(0).split("-")[1]%>월 <%=daysOfWeek.get(0).split("-")[2]%>일 ~ ' + 
             '<%=daysOfWeek.get(6).split("-")[0]%>년 <%=daysOfWeek.get(6).split("-")[1]%>월 <%=daysOfWeek.get(6).split("-")[2]%>일의 정서 반복 기록',
       annotations : {
            alwaysOutside : true
           },
           vAxis : {
              viewWindow : {
                 max : 25,
                 min : 0
              }
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
   
   function gotoPrev(){
      indexOfDay--;
      request.setAttribute("indexOfDay", indexOfDay);
      location.href='../EwhaSSK/GetESMResultsSelectedGraph';
   }
   
   function gotoNext(){
      indexOfDay++;
      request.setAttribute("indexOfDay", indexOfDay);
      location.href='../EwhaSSK/GetESMResultsSelectedGraph';
   }
</script>
<style>
html{
   height : 100%;
   width : 100%;
}
h3 {
   display: flex;
   justify-content: center;
   align-items: center;
   font-size: 25px;
}
body {
   height : 100%;
   width : 100%;
   display: flex;
   flex-direction: column;
   justify-content: center;
   align-items: center;
}
.btn{
         border : 1px solid #ff6666;
         border-radius : 10px;
         background-color:#ff6666;
         padding : 10px;
         margin : 5px;
         color : white;
         height : 50px;
         width : 350px;
         font-size : 20px;
   }      
   
.prevNextBtn{
   border : 1px solid #ff6666;
   border-radius : 10px;
   background-color:#ff6666;
   padding : 10px;
   margin : 20px;
   color : white;
   height : 50px;
   width : 70px;
   font-size : 20px;
}
#sdqProfileChart{
   width : 100%;
}
#getDayGraph{
   position : absolute;
   bottom : 2%;
   right : 2%;
}
#contents{
   padding : 1%;
}
</style>
</head>
<body>
	<%@ include file="sidebar.jsp"%>
   <h3>정서 반복 기록 일별 그래프</h3>
   
   <div id="contents">
   <button id="prevBtn" class="btn" onClick="location.href='../EwhaSSK/GetESMResultsSelectedWeekGraph?indexOfWeek=<%=indexOfWeek+1%>'"><</button>
   <%
      if(!(indexOfWeek - 1 < minIndex)){
   %>
   <button id="prevBtn" class="btn" onClick="location.href='../EwhaSSK/GetESMResultsSelectedWeekGraph?indexOfWeek=<%=indexOfWeek-1%>'">></button>
   <%
      }
      else{
   %>
   <button id="prevBtn" class="btn" style="background : #ff9999;" onClick="javascript:alert('다음 결과가 존재하지 않습니다.');">></button>
   <%      
      }
   %>
   </div>
   <div id="esmProfileChart" style="width: 80%; height: 500px;"></div>
   <input type="button" class="btn" id="getDayGraph" value="시간별로 보기" onClick="location.href='../EwhaSSK/GetESMResultsAllOfGraph'">

</body>
</html>