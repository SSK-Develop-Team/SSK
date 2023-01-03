<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>정서 행동 발달 검사</title>
</head>
<body>
<%@ include file = "sidebar.jsp" %>

<div class="w3-row w3-display-container w3-center" style="height:200px;">
<div class="w3-display-middle" style="font-size:1.8em; font-weight:bold;">정서/행동 발달 검사</div>
</div>
<div class="w3-row"style="height:250px;">
  	<div class="w3-col s1 m3 l3">&nbsp;</div>
  	<button class="w3-button w3-round-large w3-col s4 m2 l2" style="background-color:#FF92A4;color:white;height:250px;font-size: 1.3em; " onclick = "getSdqTest('PARENT')">부모용 검사</button>
  	<div class="w3-col s2 m2 l2">&nbsp;</div>
    <button class="w3-button w3-round-large w3-col s4 m2 l2" style="background-color:#FF92A4;color:white;height:250px;font-size: 1.3em; "onclick = "getSdqTest('CHILD')">아동용 검사</button>
    <div class="w3-col s1 m3 l3">&nbsp;</div>
</div>
</body>
<script>
function getSdqTest(target){
	var form = document.createElement("form");
	var element = document.createElement("input");
	
	form.method = "POST";
	form.action = "GetSdqTest";
	
	element.type="hidden";
	element.name="target";
	element.value = target;
	
	form.appendChild(element);
	
	document.body.appendChild(form);
	
	form.submit();
}
</script>
</html>