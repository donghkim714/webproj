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
.select_img{
	width:500px;
	margin:20px 0;
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

				<h2>상품 등록</h2>

				<form id="form" role="form" method="post" autocomplete="off" enctype="multipart/form-data">
						<div class="inputArea"> 
							 <label>1차 분류</label>
 									<span class="category1"></span>
							 <label>2차 분류</label>
 									<span class="category2"></span>
 									 
							 <label id="third">3차 분류</label>
 									<span class="category3"></span> 
						</div>
						<div class="inputArea">
 								<input type="hidden" id="gdsNum" name="gdsNum" value = "${goods.gdsNum }"/>
						</div>
						<div class="inputArea">
 							<label for="gdsName">상품명</label>
 									<input type="text" id="gdsName" name="gdsName" value = "${goods.gdsName }"/>
						</div>

						<div class="inputArea">
 							<label for="gdsPrice">상품가격</label>
 									<input type="text" id="gdsPrice" name="gdsPrice" value="${goods.gdsPrice }"/>
						</div>

						<div class="inputArea">
 							<label for="gdsStock">상품수량</label>
 									<input type="text" id="gdsStock" name="gdsStock" value="${goods.gdsStock }"/>
						</div>

						<div class="inputArea">
							 <label for="gdsDes">상품소개</label>
									 <textarea rows="5" cols="50" id="gdsDes" name="gdsDes">${goods.gdsDes }</textarea>
						</div>
						<div class="inputArea">
							 <label for="gdsPreDes">배너 소개</label>
									 <textarea rows="2" cols="50" id="gdsPreDes" name="gdsPreDes">${goods.gdsPreDes}</textarea>
						</div>
						<div class="inputArea">
							 <label for="gdsDate">수정 일자</label>
							 <fmt:formatDate value="${goods.gdsDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
						</div>
						<div class="inputArea">
 							<label for="gdsImg">상품수량</label>
 									<input type="file" id="gdsImg" name="file"/>
 									<div class="select_img">
 										<img src="/admin/goods/display?fileName=${goods.gdsImg }"/>
 										<input type="hidden" name="gdsImg" value="${goods.gdsImg }"/>
 										<input type="hidden" name="gdsThumnailImg" value="${goods.gdsThumnailImg }"/>
 									</div>
 									<script>
 										$("#gdsImg").change(function(){
 											if(this.files && this.files[0]){
 												var reader = new FileReader;
 												reader.onload = function(data){
 													$(".select_img img").attr("src", data.target.result).width(500);
 												}
 												reader.readAsDataURL(this.files[0]);
 											}
 										});
 									</script>
						</div>
						<div class="inputArea">
								 <button type="submit" id="update_Btn" class="btn btn-primary">완료</button>
								 <button type="button" id="cancel_Btn" class="btn btn-warning">취소</button>
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
		
		if(cateCode / 1000 >= 1){
			thirdCateCode = cateCode;
			secondCateCode = cateCodeRef;
			firstCateCode = cateCodeRef - (cateCodeRef % 100);
			console.log("val : " + $("#firstCateCode").val());
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
		$("#cancel_Btn").on("click", function(e){
			e.preventDefault;
			history.back();
		});	
		
	var regExp = /[^0-9]/gi;
	
	$("#gdsPrice").keyup(function(){ numCheck($(this));});
	$("#gdsStock").keyup(function(){numCheck($(this)); });
	
	function numCheck(selector){
		var tempVal = selector.val();
		selector.val(tempVal.replace(regExp, ""));
	}
		
	</script>
</body>
</html>