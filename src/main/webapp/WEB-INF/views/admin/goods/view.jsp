<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<html>
<head>
<title>DH Admin</title>

<%@ include file ="../include/bootStrapSetting.jsp" %>

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
.oriImg{
	width:500px;
	height : auto;	
}

</style>
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

				<h2>상품 정보</h2>

				<form id="form" role="form" method="post" autocomplete="off">
						<input type="hidden" name="n" value="${goods.gdsNum }"/>
						<div class="inputArea"> 
							 <label>1차 분류</label>
 									<span class="category1" id="firstCateCode" name="firstCateCode"></span>

							 <label>2차 분류</label>
 									<span class="category2"></span>
									 
							 <label id="third">3차 분류</label>
 									<span class="category3"></span>
						</div>

						<div class="inputArea">
 							<label for="gdsName">상품명</label>
 									<span>${goods.gdsName }</span>
						</div>
						
						<div class="inputArea">
 							<label for="gdsPrice">상품가격</label>
 								<span>
 									<fmt:formatNumber value="${goods.gdsPrice }" pattern="###,###,###"/>
								</span>
						</div>

						<div class="inputArea">
 							<label for="gdsStock">상품수량</label>
 							<span>
 								${goods.gdsStock }
 							</span>
						</div>

						<div class="inputArea">
							 <label for="gdsDes">상품소개</label>
							 <span>${goods.gdsDes }</span>
						</div>
						
						
						<div class="inputArea">
							 <label for="gdsPreDes" style="display: block;">배너소개</label>
							 	<span >${goods.gdsPreDes }</span>
						</div>
						<div class="inputArea">
							 <label for="gdsImg" style="display: block;">이미지</label>
							 	<p>원본 이미지</p>
							 	<img src="/admin/goods/display?fileName=${goods.gdsImg }" class="oriImg"/>
							 	
							 	<p>썸네일</p>
							 	<img src="/admin/goods/display?fileName=${goods.gdsThumnailImg }" class="thumbImg"/>
						</div>
						<div class="inputArea">
								 <button type="button" id="modify_Btn" class="btn btn-warning">수정</button>
								 <button type="button" id="delete_Btn" class="btn btn-danger">삭제</button>
								
								
								
								 <script>
								 	var formObj = $("#form");
								 	
								 	$("#modify_Btn").on("click", function(e){
								 		e.preventDefault;
								 		formObj.attr("action", "/admin/goods/modify");
								 		formObj.attr("method", "get");
								 		formObj.submit();
								 	});
								 	
								 	$("#delete_Btn").on("click", function(e){
								 		var con =confirm("정말 삭제하시겠습니까?");
								 		e.preventDefault;
								 		if(con){
								 			formObj.attr("action","/admin/goods/delete");
								 			formObj.submit();
								 		}
								 	});
								 </script>
						
						</div>

				</form>
			</div>
		</section>

		<footer id="footer">
			<div id="footer_box">
				<%@ include file="../include/footer.jsp"%>
			</div>
		</footer>
	</div>
	<script>
	var jsonData = JSON.parse('${category}');
	console.log(jsonData);
	var firstCateCode = null;
	var secondCateCode= null;
	var thirdCateCode= null;
	var cateCode = '${goods.cateCode}';
	var cateCodeRef = '${goods.cateCodeRef}';
	console.log("cateCode/1000 : " + cateCode/1000);
	if(cateCode / 1000 >= 1 ){
		thirdCateCode = cateCode;
		secondCateCode = cateCodeRef;
		firstCateCode = cateCodeRef - (cateCodeRef % 100);
		$(".category1").val(firstCateCode);
		$(".category2").val(secondCateCode);
		$(".category3").val(thirdCateCode);
		for(var i =0; i<jsonData.length; i++){
			if(jsonData[i].level == "1" && jsonData[i].cateCode == firstCateCode){
				$(".category1").append("<span value='" + firstCateCode + "'>" + jsonData[i].cateName + "</span>");		
			}
			else if(jsonData[i].level == "2" && jsonData[i].cateCode == secondCateCode){
				$(".category2").append("<span value='" + secondCateCode + "'>" + jsonData[i].cateName + "</span>");
			}
			else if(jsonData[i].level == "3" && jsonData[i].cateCode == thirdCateCode){
				$(".category3").append("<span value='" + thirdCateCode + "'>" + jsonData[i].cateName + "</span>");
			}
		}
	}
	else {
		$('#third').remove();
		secondCateCode = cateCode;
		firstCateCode = cateCodeRef;
		$(".category1").val(firstCateCode);
		$(".category2").val(secondCateCode);
		
		for(var i =0; i<jsonData.length; i++){
			if(jsonData[i].level == "1" && jsonData[i].cateCode == firstCateCode){
				$(".category1").append("<span value='" + firstCateCode + "'>" + jsonData[i].cateName + "</span>");		
			}
			else if(jsonData[i].level == "2" && jsonData[i].cateCode == secondCateCode){
				$(".category2").append("<span value='" + secondCateCode + "'>" + jsonData[i].cateName + "</span>");
			}
		}
	}
	</script>
</body>
</html>