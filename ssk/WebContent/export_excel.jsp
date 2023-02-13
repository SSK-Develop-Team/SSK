<%@ page language="java" contentType="application/vnd.ms-excel;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String file_name = request.getParameter("fileName");

	response.setHeader("Content-Disposition","attachment;filename="+file_name+";");
	response.setHeader("Content-Description","JSP GeneratedData");
%>


<html>
<head>
<title>엑셀 파일 변환</title>
<meta http-equiv="Content-type" content="application/vns.ms-excel;charset=UTF-8">
</head>
<body>
  <table>
    <tr>
      <th>First Name</th>
      <th>Last Name</th>
      <th>Points</th>
    </tr>
    <tr>
      <td>Jill</td>
      <td>Smith</td>
      <td>50</td>
    </tr>
    <tr>
      <td>Eve</td>
      <td>Jackson</td>
      <td>94</td>
    </tr>
    <tr>
      <td>Adam</td>
      <td>Johnson</td>
      <td>67</td>
    </tr>
  </table>

</body>
</html>