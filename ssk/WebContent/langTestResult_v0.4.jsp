<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.dto.User" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dto.LangReply" %>

<%
	User currUser = (User)session.getAttribute("currUser");
	User focusUser = (User)request.getAttribute("focusUser");
	String name = focusUser.getUserName();
	
	if(name.length() == 3){
		name = name.substring(1);
	}
	
	else if(name.length() == 4){
		name = name.substring(2);
	}
	
	char lastName = name.charAt(name.length() - 1);
	int index = (lastName - 0xAC00) % 28;
	if(index > 0){
		name = name + "이";
	} 

	ArrayList<LangReply> langResultList = (ArrayList<LangReply>)session.getAttribute("langResultList");
	int selectAge = langResultList.get(0).getAgeGroup();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>언어 발달 평가 결과</title>

<style>

body{
	margin-top: 100px;
	line-height: 1.6
}
.container{
	width: 40%;
	margin: 0 auto;
}



ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
ul.tabs li{
	background: #ededed;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	background: #1a2a3a;
	color: #fff;
}

.tab-content{
	display: none;
	background: #ededed;
	padding: 15px;
}

.tab-content.current{
	display: inherit;
}

.btn{
	border : 1px solid #1a2a3a;
	border-radius : 10px;
	background-color:#1a2a3a;
	color : white;
	width : 30%;
	margin-left : 2%;
	margin-top : 5%;
	padding : 1%;
	align : center;
}

#ageGroupSelect {
	font-size : 100%;
	width : 100%;
	margin-bottom : 5%;
	text-align : center;
}

</style>


</head>
<body>
<%@ include file="sidebar.jsp" %>
	<div style="width:92%;margin:4%;"> 
		<h2 style="text-align:center;"><%=name%>님의 언어 발달 평가 결과</h2>
		<p style="text-align:right;">검사일 : <%=langResultList.get(0).getReplyDate() %></p>
	</div>
  <div class="container">
	<select id = "ageGroupSelect" name="ageGroup">
		    <option value="ageSelected" selected><%=selectAge %>단계 (현재 단계)</option>
		    <optgroup label="다른 단계 선택하기">
			    <option value="ageSelect00">0단계 (3세 0개월 ~ 3세 3개월)</option>
			    <option value="ageSelect01">1단계 (3세 4개월 ~ 3세 5개월)</option>
			    <option value="ageSelect02">2단계 (3세 6개월 ~ 3세 8개월)</option>
			    <option value="ageSelect03">3단계 (3세 9개월 ~ 3세 11개월)</option>
			    <option value="ageSelect04">4단계 (4세 0개월 ~ 4세 3개월)</option>
			    <option value="ageSelect05">5단계 (4세 4개월 ~ 4세 7개월)</option>
			    <option value="ageSelect06">6단계 (4세 8개월 ~ 4세 11개월)</option>
			    <option value="ageSelect07">7단계 (5세 0개월 ~ 5세 5개월)</option>
			    <option value="ageSelect08">8단계 (5세 6개월 ~ 5세 11개월)</option>
			    <option value="ageSelect09">9단계 (6세 0개월 ~ 6세 5개월)</option>
			    <option value="ageSelect10">10단계 (6세 0개월 ~ 6세 11개월)</option>
			    <option value="ageSelect11">11단계 (7세 0개월 ~ 7세 11개월)</option>
			    <option value="ageSelect12">12단계 (8세 0개월 ~ 8세 11개월)</option>
		    	<option value="ageSelect13">13단계 (9세 0개월 ~ 9세 11개월)</option>
		    </optgroup>
	</select>
	<ul class="tabs">
		<li class="tab-link current" data-tab="tab-1">막대그래프로 확인하기</li>
		<li class="tab-link" data-tab="tab-2">오각그래프로 확인하기</li>
	</ul>

	<div id="tab-1" class="tab-content current">
		<canvas id="myChart"></canvas>
	</div>
	<div id="tab-2" class="tab-content">
		<canvas id="myChart2"></canvas>
	</div>
	
	<div class="btnbox">
		<input type="button" class="btn" id="share" value="공유하기">
		<%if(currUser.getUserRole()=''){ %>
		<input type="button" class="btn" id="mainBack" value="돌아가기" onClick="javascript:location.href='childHome.jsp'">
		<%} %>
	</div>


</div>

<script src= "https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		$('ul.tabs li').click(function(){
			var tab_id = $(this).attr('data-tab');
	
			$('ul.tabs li').removeClass('current');
			$('.tab-content').removeClass('current');
	
			$(this).addClass('current');
			$("#"+tab_id).addClass('current');
		})
	
	})
	
	var ctx = document.getElementById('myChart').getContext('2d');
	var ctx2 = document.getElementById('myChart2').getContext('2d');
	
        var chart = new Chart(ctx, {
            type: 'bar', 
            data: {
                labels: ['의미1', '의미2', '조음', '구문', '화용'],
                datasets: [{
                    label: none,
                    backgroundColor: '#FF92A4',
                    borderColor: '#FF92A4',
                    data: [<%= langResultList.get(0).getUserReply()%>, <%= langResultList.get(1).getUserReply()%>, <%= langResultList.get(2).getUserReply()%>, <%= langResultList.get(3).getUserReply()%>, <%= langResultList.get(4).getUserReply()%>]
                }]
            },
            
            options: {
                indexAxis: 'y',
                
    			scales: {
    				yAxes: [{
    					ticks: {
    						beginAtZero: true,
    						min : 0,
    						max : 4,
    						stepSize : 1,
    					}
    				}]
    			},
    			annotations : {
    				'legend':'none'
    			},
    			legend: {
    		        display: false
    		    },
    		    tooltips: {
    		        callbacks: {
    		           label: function(tooltipItem) {
    		                  return tooltipItem.yLabel;
    		           }
    		        }
    		    }
            }

            
        });
        
        var chart2 = new Chart(ctx2, {
            type: 'radar', 
            data: {
                labels: ['의미1', '의미2', '조음', '구문', '화용'],
                datasets: [{
                    label: none,
                    backgroundColor: 'transparent',
                    fill : false,
		            borderColor: 'rgb(255, 99, 132)',
		            pointBackgroundColor: 'rgb(255, 99, 132)',
		            pointBorderColor: '#fff',
		            pointHoverBackgroundColor: '#fff',
		            pointHoverBorderColor: 'rgb(255, 99, 132)',
                    data: [<%= langResultList.get(0).getUserReply()%>, <%= langResultList.get(1).getUserReply()%>, <%= langResultList.get(2).getUserReply()%>, <%= langResultList.get(3).getUserReply()%>, <%= langResultList.get(4).getUserReply()%>]
                }]
            },
            
            options: {
                
    			scales: {
    				angleLines: {
    				      display: false
    				},
    				    
    				vAxis : {
    		              viewWindow : {
    		                 max : 25,
    		                 min : 0,
    		                 stepSize : 1
    		              }
    		           },
    		        'legend' : 'none',
    			},
    			plugins: {
    			    legend: {
    			      display: false
    			    }
    			}
    		}
        });

</script>

</body>
</html>