<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dto.EsmReply" %>

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
%>

<%

   ArrayList<EsmReply> results = (ArrayList<EsmReply>)session.getAttribute("results");
   ArrayList<String> dates = (ArrayList<String>)session.getAttribute("dates");

   int maxIndex = (int)session.getAttribute("maxIndex");
   // dates list 확인
   //System.out.println(dates);
   
   ArrayList<EsmReply> resultsOfDay = (ArrayList<EsmReply>)request.getAttribute("resultsOfDay");
   ArrayList<String> timeOfDay = (ArrayList<String>)request.getAttribute("timeOfDay");

   // times list 확인
   //System.out.println(timeOfDay);
   ArrayList<Integer> positiveOfDay = (ArrayList<Integer>)request.getAttribute("positiveOfDay");
   ArrayList<Integer> negativeOfDay = (ArrayList<Integer>)request.getAttribute("negativeOfDay");
   int indexOfDay = (int)request.getAttribute("indexOfDay");
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
          for(int i = 0; i < timeOfDay.size(); i++){
       %>
       [<%="'" + timeOfDay.get(i).split(":")[0] + "시 " + timeOfDay.get(i).split(":")[1] + "분 " + timeOfDay.get(i).split(":")[2] + "초'"%>,  <%=positiveOfDay.get(i)%>, <%=negativeOfDay.get(i)%>],

      <%   
          }
       %>
     ]);
   
     var options = {
       title: '<%=dates.get(indexOfDay).split("-")[0]%>년 <%=dates.get(indexOfDay).split("-")[1]%>월 <%=dates.get(indexOfDay).split("-")[2]%>일의 정서 반복 기록',

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
   margin-bottom : 40px;
}
#esmProfileChart{
   width : 100%;
}
#getWeekGraph{
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

   <h3>정서 반복 기록 시간별 그래프</h3>
   <div id="contents">
   <%
      if(indexOfDay - 1 >= 0 ){
   %>
   <button id="prevBtn" class="btn" onClick="location.href='../EwhaSSK/GetESMResultsSelectedGraph?indexOfDay=<%=indexOfDay-1%>'"><</button>
   <%
      }
      else{
   %>
   <button id="prevBtnx" class="btn" style="background : #ff9999;" onClick="javascript:alert('이전 결과가 존재하지 않습니다.');"><</button>
   <%      
      }
      if((indexOfDay + 1) <= maxIndex){
   %>
   <button id="prevBtn" class="btn" onClick="location.href='../EwhaSSK/GetESMResultsSelectedGraph?indexOfDay=<%=indexOfDay+1%>'">></button>
   <%
      }
      else{
   %>
   <button id="prevBtnx" class="btn" style="background : #ff9999;" onClick="javascript:alert('다음 결과가 존재하지 않습니다.');">></button>
   <%      
         
      }
   %>
   </div>
   <div id="esmProfileChart" style="width: 80%; height: 500px;"></div>
   <input type="button" class="btn" id="getWeekGraph" value="일별로 보기" onClick="location.href='../EwhaSSK/GetESMResultsAllOfWeekGraph'">


</body>
</html>