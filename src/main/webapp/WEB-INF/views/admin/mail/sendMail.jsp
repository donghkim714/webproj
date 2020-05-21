<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form"  uri="http://www.springframework.org/tags/form" %>
<%@include file="../include/bootStrapSetting.jsp"%>
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
 aside#aside li:hover > ul.low li a { background:#eee; border:1px solid #eee; }
 aside#aside li:hover > ul.low li a:hover { background:#fff;}
 aside#aside li > ul.low li { width:180px; }
 
 footer#footer { margin-top:100px; border-radius:50px 50px 0 0; }
 footer#footer div#footer_box { padding:0 20px; }
 
</style>
<style>
 section#content ul li { display:inline-block; margin:10px; }
 section#content div.goodsThumb img { width:200px; height:200px; }
 section#content div.goodsName { padding:10px 0; text-align:center; }
 section#content div.goodsName a { color:#000; }
 
 div.sendingModal { position:fixed; top:20%; left:calc(50% - 250px); width:500px; height:250px; padding:20px 10px; background:#fff; border:2px solid #666; display:none; }
 div.sendingModal h2 { font-size:16px; font-family:'맑은 고딕', verdana; padding:10px; width:500px; height:200px; text-align:center;}
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
				<form action="/admin/mail/mailSending" method="post" role="form" id="form">
						<div class="inputArea">
							<input type="text" name="tomail" size="120"	style="width:100%" placeholder="상대의 이메일" class="form-control">
						</div>
						<div class="inputArea">
							<input type="text" name="title" size="120" style="width:100%" placeholder="제목을 입력해 주세요" class="form-control">
						</div>
						<div class="inputArea">
							<textarea name="content" cols="120" rows="12" style="width:100%; resize:none" placeholder="내용#" class="form-control">
							</textarea>
						</div>
						<div class="inputArea">
							<input type="button" value="메일 보내기" class="btn btn-warning">
							<script>
							$(".btn").on("click",function(){
								$('#root').on('scroll touchmove mousewheel', function(event) {
									  event.preventDefault();
									  event.stopPropagation();
									  return false;
									});
								window.addEventListener("keydown", function(e) {
									if([32, 37, 38, 39, 40].indexOf(e.keyCode) > -1) {
										e.preventDefault();
									}
								}, false);
								console.log("ddd");
								$(".sendingModal").fadeIn(200);	//서서히 나타남
								$("#form").submit();
							});
							
							</script>
						</div>
				</form>
			</section>
			<div class="sendingModal">
				<h2>보내는 중입니다...</h2>
			</div>
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