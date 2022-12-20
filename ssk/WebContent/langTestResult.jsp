<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dto.User" %>
<%@ page import="model.dto.LangTestLog" %>
<%@ page import="model.dto.LangReply" %>
<%@ page import="model.dto.LangQuestion" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>언어 발달 평가 결과</title>
<script src= "https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<%
	User focusUser = (User)session.getAttribute("currUser");
	
	LangTestLog langTestLog = (LangTestLog)request.getAttribute("langTestLog");
	ArrayList<LangReply> langReplyList = (ArrayList<LangReply>)request.getAttribute("langReplyList");
	ArrayList<LangQuestion> langQuestionList = (ArrayList<LangQuestion>)request.getAttribute("langQuestionList");
	
%>
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

</style>

</head>
<body>
<%@ include file="sidebar.jsp" %>
<div style="width:92%;margin:4%;"> 
	<h2 style="text-align:center;"><%=focusUser.getUserName()%>님의 언어 발달 평가 결과</h2>
	<p style="text-align:right;"> 검사일 : <%=langTestLog.getLangTestDate() %></p>
</div>
<div class="container">
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
		<%if(focusUser.getUserRole()=="CHILD"){ %>
		<input type="button" class="btn" id="mainBack" value="돌아가기" onClick="javascript:location.href='childHome.jsp'">
		<%} else if(focusUser.getUserRole()=="EXPERT"){%>
		<input type="button" class="btn" id="mainBack" value="돌아가기" onClick="javascript:location.href='expertHome.jsp'">
		<%} %>
	</div>
</div>

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
                labels: ['<%= langQuestionList.get(0).getLangType()%>', '<%= langQuestionList.get(1).getLangType()%>', '<%= langQuestionList.get(2).getLangType()%>', '<%= langQuestionList.get(3).getLangType()%>', '<%= langQuestionList.get(4).getLangType()%>'],
                datasets: [{
                    backgroundColor: '#FF92A4',
                    borderColor: '#FF92A4',
                    data: [<%= langReplyList.get(0).getLangReplyContent()%>, <%= langReplyList.get(1).getLangReplyContent()%>, <%= langReplyList.get(2).getLangReplyContent()%>, <%= langReplyList.get(3).getLangReplyContent()%>, <%= langReplyList.get(4).getLangReplyContent()%>]
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
            	labels: ['<%= langQuestionList.get(0).getLangType()%>', '<%= langQuestionList.get(1).getLangType()%>', '<%= langQuestionList.get(2).getLangType()%>', '<%= langQuestionList.get(3).getLangType()%>', '<%= langQuestionList.get(4).getLangType()%>'],
                datasets: [{
                    backgroundColor: 'transparent',
                    fill : false,
		            borderColor: 'rgb(255, 99, 132)',
		            pointBackgroundColor: 'rgb(255, 99, 132)',
		            pointBorderColor: '#fff',
		            pointHoverBackgroundColor: '#fff',
		            pointHoverBorderColor: 'rgb(255, 99, 132)',
                    data: [<%= langReplyList.get(0).getLangReplyContent()%>, <%= langReplyList.get(1).getLangReplyContent()%>, <%= langReplyList.get(2).getLangReplyContent()%>, <%= langReplyList.get(3).getLangReplyContent()%>, <%= langReplyList.get(4).getLangReplyContent()%>]
                }]
            },
            
            options: {
                
    			scales: {
    				angleLines: {
    				      display: false
    				},
    				r: {
    		            max: 5,
    		            min: 0,
    		            ticks: {
    		                stepSize: 1
    		            }
    		        },
   		           'legend' : 'none',
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

</script>
</body>
</html>