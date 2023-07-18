<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	alert('${msg}');
	<c:if test="${empty url}">
	location.href = document.referrer;
	</c:if>
	<c:if test="${!empty url}">
	location.href='${url}'; //새로운 요청 빈페이지가 열려
	</c:if>
</script>