<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file ="../include/bootStrapSetting.jsp" %>

<html>
<head>
	<title>DH</title>
	<style>

 body { margin:0; padding:0; font-family:'맑은 고딕', verdana; }
 a { color:#05f; text-decoration:none; }
 a:hover { text-decoration:underline; }
 
 h1, h2, h3, h4, h5, h6 { margin:0; padding:0; }
 ul, lo, li { margin:0; padding:0; list-style:none; }

 /* ---------- */
 
 div#root { width:900px; margin:0 auto; }
 header#header { }
 nav#nav { }
 section#container { }
  section#content { float:right; width:700px; }
  aside#aside { float:left; width:180px; }
  section#container::after { content:""; display:block; clear:both; } 
 footer#footer { background:#eee; padding:20px; }
 
 /* ---------- */
 
 header#header div#header_box { text-align:center; padding:30px 0; }
 header#header div#header_box h1 { font-size:50px; }
 header#header div#header_box h1 a { color:#000; }
 
 nav#nav div#nav_box { font-size:14px; padding:10px; text-align:right; }
 nav#nav div#nav_box li { display:inline-block; margin:0 10px; }
 nav#nav div#nav_box li a { color:#333; }
 
 section#container { }
 
 aside#aside h3 { font-size:22px; margin-bottom:20px; text-align:center; }
 aside#aside li { font-size:16px; text-align:center; }
 aside#aside li a { color:#000; display:block; padding:10px 0; }
 aside#aside li a:hover { text-decoration:none; background:#eee; }
 
 aside#aside li { position:relative; }
 aside#aside li:hover { background:#eee; } 		
 aside#aside li > ul.low { display:none; position:absolute; top:0; left:180px;  }
 aside#aside li:hover > ul.low { display:block; }
 aside#aside li:hover > ul.low li a { background:#eee; buser:1px solid #eee; }
 aside#aside li:hover > ul.low li a:hover { background:#fff;}
 aside#aside li > ul.low li { width:180px; }
 
 footer#footer { margin-top:100px; buser-radius:50px 50px 0 0; }
 footer#footer div#footer_box { padding:0 20px; }
 
</style>
<style>
/*
 section#content ul li { display:inline-block; margin:10px; }
 section#content div.goodsThumb img { width:200px; height:200px; }
 section#content div.goodsName { padding:10px 0; text-align:center; }
 section#content div.goodsName a { color:#000; }
 */
  .userInfo { border:5px solid #eee; padding:10px 20px; margin:20px 0;}
 .userInfo span { font-size:20px; font-weight:bold; display:inline-block; width:150px; }
 
</style>
</head>
<body>
<div id="root">
	<header id="header">
		<div id="header_box">
			<%@ include file="../include/header.jsp" %>
		</div>
	</header>

	<nav id="nav">
		<div id="nav_box">
			<%@ include file="../include/nav.jsp" %>
		</div>
	</nav>
	
	<section id="container">
		<div id="container_box">
			<section id="content">
			<form id="form1" method="post">
			<div class="userInfo">
						<p><span name='userId' value="${uv.userId }">아이디</span>${uv.userId }</p>
						<p><span>총 주문 수량</span><fmt:formatNumber value="${uv.totalStock }" pattern="###,###,###"/>개</p>
						<p><span>총 소비 금액</span><fmt:formatNumber value="${uv.totalAmount }" pattern="###,###,###"/>원</p>
						<p><span>경고 횟수</span>
						<button type="button" class="minus">-</button>
								<input type="number" class="numBox" min="0" max="2" value="${uv.userWarn }" readonly="readonly"/>
								<button type="button" class="plus">+</button>
						
								<script>
									$(".plus").on("click", function(e){
										e.preventDefault();
										var num = $(".numBox").val();
										var plusNum = Number(num) +1;
										
										if(plusNum > 2 ){
											$(".numBox").val(num);
										}
										else{
											$(".numBox").val(plusNum);
										}
										
										var userWarn = $(".numBox").val();
										var userId = "${uv.userId}";
										var data = {
												userWarn : userWarn,
												userId : userId
										};
										
										$.ajax({
											url:"/admin/user/userModi",
											type : "post",
											data : data,
											error : function(){
												alert("error");
											}						
												
										});
										
				
									});
										
										$(".minus").on("click",function(e){
											e.preventDefault();
											var num = $(".numBox").val();
											
											var minusNum = Number(num) -1;
											
											if(minusNum < 0 ){
												$(".numBox").val(num);
											}
											else{
												$(".numBox").val(minusNum);
											}
											
											var userWarn = $(".numBox").val();
											var userId = "${uv.userId}";

											var data = {
													userWarn : userWarn,
													userId : userId
											};
											
											$.ajax({
												url:"/admin/user/userModi",
												type : "post",
												data : data,
												error : function(){
													alert("error");
												}						
													
											});
										});
										
								</script>
						</p>
			</div>
			
			<button id="deleteUser" class="btn btn-danger">유저 삭제</button>
			<script>
			$("#deleteUser").on("click", function(e){
				e.preventDefault();
				var deleteConfirm = confirm("정말로 유저를 탈퇴시킬까요?");
				if(deleteConfirm){
					$("#form1").submit();
				}
				
			});
			
			
			</script>
			</form>
			</section>
			
			<aside id="aside">
				<%@ include file="../include/aside.jsp" %>
			</aside>
		</div>
	</section>

	<footer id="footer">
		<div id="footer_box">
			<%@ include file="../include/footer.jsp" %>
		</div>		
	</footer>

</div>
</body>
</html>