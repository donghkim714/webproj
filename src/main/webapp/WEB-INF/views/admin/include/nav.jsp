<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<ul>
	<c:if test="${member != null }">
		
			<li><a href="/">일반 화면</a></li>
		<li>
		<c:if test="${member.userWarn == 2 }">
			<b style='color : red'>경고 : 2회</b>
		</c:if>
		<c:if test="${member.userWarn == 1 }">
			<b style='color : #f7e600'>경고 : 1회</b>
		</c:if>
		</li>
		<li>${member.userName }님을 환영합니다.</li>
		<li><a href="/member/signout">로그아웃</a></li>
	</c:if>
</ul>

