<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>DH Admin</title>


<script src="/resources/jquery/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="/resources/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bootstrap/bootstrap-theme.min.css">
<script src="/resources/bootstrap/bootstrap.min.js"></script>

<style>
a {
	text-decoration:none;
}
a:visited{
	color : #50bcdf;
}
a:link{
	color:#50bcdf;
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
	text-decoration:underline;
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
	margin-left : 40px;
}
aside ul li a{
	display:block; width:150px; padding:10px 0;
	text-decoration:none;
}
aside ul li a:hover{
	background:#eee;
	text-decoration:underline;
}
footer#footer {
	background: #f9f9f9;
	padding: 20px;
}

footer#footer ul li {
	display: inline-block;
	margin-right: 10px;
}
 .userInfo { border:5px solid #eee; padding:10px 20px; margin:20px 0;}
 .userInfo span { font-size:20px; font-weight:bold; display:inline-block; width:150px; }
</style>
</head>
<body>
	<div id="root">
		<header id="header">
			<div id="header_box">
				<%@ include file="include/header.jsp"%>
			</div>
		</header>

		<nav id="nav">
			<div id="nav_box">
				<%@ include file="include/nav.jsp"%>
			</div>
		</nav>

		<section id="container">
			<aside>
				<%@ include file="include/aside.jsp"%>
			</aside>
			<div id="container_box">
			<h2>오늘(${list[0].today })의 통계</h2>
				<div class="userInfo">
						<p><span>전체 상품 결제 금액</span><fmt:formatNumber value="${list[0].totalPrice }" pattern="###,###,###"/>원</p>
						<p><span>전체 상품 주문 수량</span><fmt:formatNumber value="${list[0].totalStock }" pattern="###,###,###"/>개</p>
						<br>
				</div>
				<c:forEach items="${list }" var ="list">
				<div class="userInfo">
						
						<b style='color : blue'>제품 별 통계</b>
						<br><br>
						<p><span>${list.cateName }</span></p>
						<p><span>총 결제 금액</span><fmt:formatNumber value="${list.cateTotalAmount }" pattern="###,###,###"/>원</p>
						<p><span>총 주문 수량</span><fmt:formatNumber value="${list.cateTotalStock }" pattern="###,###,###"/>개</p>
				</div>
				</c:forEach>
				
			</div>
		</section>

		<footer id="footer">
			<div id="footer_box">
				<%@ include file="include/footer.jsp"%>
			</div>
		</footer>

	</div>
</body>
</html>