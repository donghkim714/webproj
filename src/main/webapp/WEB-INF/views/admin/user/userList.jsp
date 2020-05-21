<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>DH Admin</title>


<%@ include file="../include/bootStrapSetting.jsp" %>
<style>
a {
	text-decoration: none;
}

a:visited {
	color: #50bcdf;
}

a:link {
	color: #50bcdf;
}

body {
	font-family: '맑은 고딕', verdana;
	padding: 0;
	margin: 0;
}

ul {
	padding: 0;
	margin: 0;
	list-style: none;
}

div#root {
	width: 90%;
	margin: 0 auto;
}

header#header {
	font-size: 30px;
	padding: 20px 0;
}

header#header h1 a {
	color: #000;
	font-weight: bold;
	text-decoration: underline;
}

nav#nav {
	padding: 10px;
	text-align: right;
}

nav#nav ul li {
	display: inline-block;
	margin-left: 10px;
}

section#container {
	padding: 20px 0;
	border-top: 2px solid #eee;
	border-bottom: 2px solid #eee;
}

section#container::after {
	content: "";
	display: block;
	clear: both;
}

aside {
	float: left;
	width: 200px;
}

div#container_box {
	float: right;
	width: calc(100% - 200px - 20px);
}

aside ul li {
	text-align: center;
	margin-bottom: 10px;
	margin-left: 40px;
}

aside ul li a {
	display: block;
	width: 150px;
	padding: 10px 0;
	text-decoration: none;
}

aside ul li a:hover {
	background: #eee;
	text-decoration: underline;
}

footer#footer {
	background: #f9f9f9;
	padding: 20px;
}

footer#footer ul li {
	display: inline-block;
	margin-right: 10px;
}
.inputArea {
	 margin:10px 0;
}

select {
	 width:100px;
}

label {
	 display:inline-block; 
	 width:70px; 
	 padding:5px;
}

label[for='gdsDes'] { 
	display:block;
}

input {
	 width:150px; 
}

textarea#gdsDes {
	 width:400px;
	 height:180px; 
}

#container_box table{ width : 900px; }
#container_box table th{
	 font-size :20px; font-weight:bold;
	text-align :center; padding : 10px; border-bottom : 2px solid #666;
	padding-left : 10px;
	
}
#container_box table tr:hover{
	background : #eee;
}
#container_box table td {
	padding : 10px;
	text-align : center;
}
#container_box table img{
	width : 150px;
	height : auto;
}
.paging {
	text-align : center;
	padding :10px;
	width : 800px;
	height : 100px;
}
</style>
<!-- 
<style>
	#container_box table td {
		width:120px;
		padding : 10px;
		padding-left : 4px;
	}
	#container_box table th{
		text-align:left;
	}
</style>
-->
</head>
<body>
	<div id="root">
		<header id="header">
			<div id="header_box">
				<%@ include file="../include/header.jsp"%>
			</div>
		</header>

		<nav id="nav">
			<div id="nav_box">
				<%@ include file="../include/nav.jsp"%>
			</div>
		</nav>

		<section id="container">
			<aside>
				<%@ include file="../include/aside.jsp"%>
			</aside>
			<div id="container_box">

				<!--  <h2>상품 목록</h2> -->
				
				<table>
					<thread>
						<tr>
							<th>아이디</th>
							<th>이름</th>
							<th>연락처</th>
							<th>권한</th>
							<th>경고횟수</th>
							<th>등록날짜</th>
						
						</tr>
					</thread>
					
					<tbody>
						<c:forEach items="${list }" var="list">
							<tr>
								<td>
									<a href="/admin/user/userView?userId=${list.userId }">${list.userId }</a>
								</td>
								<td>${list.userName }</td>
								<td>									
								<fmt:formatNumber value="${list.userPhon }" pattern="###-####-####"/></td>
								<td>
									<c:if test="${list.verify == '9'}"><b>관리자</b></c:if>
									<c:if test="${list.verify == '0'}">일반</c:if>
									
								</td>
								<td>
									<c:choose>
										<c:when test="${list.userWarn == '1' }">
											<p style='color : #f7e600'><b>${list.userWarn}</b></p>
										</c:when>
										<c:when test="${list.userWarn == '2' }">
											<p style='color : red'><b>${list.userWarn }</b></p>
										</c:when>
										<c:otherwise>
											${list.userWarn }
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<fmt:formatDate value="${list.regiDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
						
								</td>
					
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="paging">
					<c:if test="${paging.prev }">
						<span>[ <a href="/admin/user/userList?num=${(paging.num) -1 }">이전</a> ]</span>
					</c:if>
					<c:forEach begin="${paging.startPageNum }" end="${paging.endPageNum }" var="num">
							<span> 
								
								<c:if test="${paging.num != num }">
									<a href="/admin/user/userList?num=${ num }">${num}</a>
								</c:if>
								<c:if test="${paging.num == num }">
									<b>${num }</b>
								</c:if>
							</span>

					</c:forEach>
					
					<c:if test="${paging.next }">
						<span>[ <a href="/admin/user/userList?num=${(paging.endPageNum) +1 }">다음</a> ]</span>
					</c:if>
					</div>
				
			</div>
		</section>

		<footer id="footer">
			<div id="footer_box">
				<%@ include file="../include/footer.jsp"%>
			</div>
		</footer>
	</div>
</body>
</html>