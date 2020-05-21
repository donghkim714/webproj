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

.paging {
	text-align : center;
	padding :10px;
	width : 800px;
	height : 100px;
}
/*
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
*/
  div#container_box ul li { border:5px solid #eee; padding:10px 20px; margin-bottom:20px; }
 div#container_box .orderList span { font-size:20px; font-weight:bold; display:inline-block; width:90px; margin-right:10px; }
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
				<section id="content">
					<ul class="orderList">
						<c:forEach items="${orderList }" var="orderList">
							<li>
								<div>
									<p><span>주문번호</span><a href="/admin/shop/orderView?n=${orderList.orderId }">${orderList.orderId }</a></p>
									<p><span>수령인</span>${orderList.orderRec }</p>
									<p><span>주문자</span>${orderList.userId }</p>
									<p><span>주소</span>${orderList.userAddr1 }${orderList.userAddr2 }${orderList.userAddr3 }</p>									
									<p><span>가격</span><fmt:formatNumber pattern="###,###,###" value="${orderList.amount }"/>원</p>									
									<p><span>상태</span>${orderList.delivery }</p>									
								
									
								</div>
							</li>
						</c:forEach>
					</ul>
				</section>
				<div class="paging">
					<c:if test="${paging.prev }">
						<span>[ <a href="/admin/shop/orderList?num=${(paging.num) -1 }">이전</a> ]</span>
					</c:if>
					<c:forEach begin="${paging.startPageNum }" end="${paging.endPageNum }" var="num">
							<span> 
								
								<c:if test="${paging.num != num }">
									<a href="/admin/shop/orderList?num=${ num }">${num}</a>
								</c:if>
								<c:if test="${paging.num == num }">
									<b>${num }</b>
								</c:if>
							</span>

					</c:forEach>
					
					<c:if test="${paging.next }">
						<span>[ <a href="/admin/shop/orderList?num=${(paging.endPageNum) +1 }">다음</a> ]</span>
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