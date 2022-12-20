<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="user" scope="page" value="${sessionScope.currUser }" />	
<c:set var="expert" scope="page" value="${sessionScope.selectedExpert }" />	
<c:set var="child" scope="page" value="${sessionScope.selectedChild }" />	
<c:choose>
	<c:when test="${user.userRole eq null}">
		<%@ include file="sidebarChild.jsp"%>
	</c:when>
	<c:when test="${user.userRole eq 'CHILD'}">
		<%@ include file="sidebarChild.jsp"%>
	</c:when>
	<c:when test="${user.userRole eq 'EXPERT' and child eq null }">
		<%@ include file="sidebarExpert.jsp"%>
	</c:when>
	<c:when test="${user.userRole eq'EXPERT' and child ne null }">
		<%@ include file="sidebarChildSelected.jsp"%>
	</c:when>
	<c:when test="${user.userRole eq 'SUPER' }">
		<%@ include file="sidebarSuperExpert.jsp"%>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>