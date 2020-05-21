<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>DH Admin</title>

<%@ include file="../include/bootStrapSetting.jsp" %>
<script src="/resources/ckeditor/ckeditor.js"></script>
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
	 display:block;
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
.select_img img{
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
 									<select class="category1">
  											<option value="">전체</option>
 									</select>

							 <label>2차 분류</label>
 									<select class="category2" name="cateCode" id="cateCode2">
  											<option value="">전체</option>
									 </select>
									 `
							 <label>3차 분류</label>
 									<select class="category3" name="cateCode" id="cateCode3">
  											<option value="">전체</option>
									 </select>
						</div>

						<div class="inputArea">
 							<label for="gdsName">상품명</label>
 									<input type="text" id="gdsName" name="gdsName" />
						</div>

						<div class="inputArea">
 							<label for="gdsPrice">상품가격</label>
 									<input type="text" id="gdsPrice" name="gdsPrice" />
						</div>

						<div class="inputArea">
 							<label for="gdsStock">상품수량</label>
 									<input type="text" id="gdsStock" name="gdsStock" />
						</div>

						<div class="inputArea">
							 <label for="gdsDes">상품소개</label>
									 <textarea rows="5" cols="50" id="gdsDes" name="gdsDes"></textarea>
						
							<script>
								var ckeditor_config ={		//json형태
										resize_enaleb : false,
										enterMode : CKEDITOR.ENTER_BR,
										shiftEnterMode : CKEDITOR.ENTER_P,
										filebrowserUploadUrl : "/admin/goods/ckUpload"
								};
								
								CKEDITOR.replace("gdsDes", ckeditor_config);
												//텍스터에리어의 ID, 변수
							</script>
						</div>
						<div class="inputArea">
							 <label for="gdsPreDes">배너 소개</label>
									 <textarea rows="2" cols="50" id="gdsPreDes" name="gdsPreDes"></textarea>
						</div>
						
						<div class="inputArea">
							 <label for="gdsImg">이미지</label>
								<input type="file" id="gdsImg" name="file"/>
								<div class="select_img"><img src=""/></div>
						
						<script>
							
							$("#gdsImg").change(function(){
								if(this.files && this.files[0]){	//파일 체크
									var reader = new FileReader;	//리더 선언
									reader.onload = function(data){	
										$(".select_img img").attr("src", data.target.result).width(500);
																			//미리보기
									}
									reader.readAsDataURL(this.files[0]);
											//데이터 url로 만드는 방법 base64로 인코딩 주소창에 치면 브라우저가 이파일을 표시함.
								}
							});
						</script>
						<!-- request.getRealPath("/") %>
						 현재 프로젝트의 실제 경로 표시 -->
						</div>
						
						<div class="inputArea">
								 <button type="button" id="register_Btn" class="btn btn-primary">등록</button>
						</div>
				</form>
				</div>
		</section>

		<footer id="footer">
			<div id="footer_box">
				<%@ include file="../include/footer.jsp"%>
			</div>
		</footer>
	<script>
		var jsonData = JSON.parse('${category}');
		console.log(jsonData);

		var selectVal = null;
		var cate1Arr = new Array();
		var cate1Obj = new Object();
		var finalcateCode = null;
		for (var i = 0; i < jsonData.length; i++) {
			if (jsonData[i].level == "1") {
				cate1Obj = new Object();
				cate1Obj.cateCode = jsonData[i].cateCode;
				cate1Obj.cateName = jsonData[i].cateName;
				cate1Arr.push(cate1Obj);
			}
		}

		var cate1Select = $("select.category1");

		for (var i = 0; i < cate1Arr.length; i++) {
			cate1Select.append("<option value='" + cate1Arr[i].cateCode + "'>"
					+ cate1Arr[i].cateName + "</option>");
		}

		$(document)
				.on(
						"change",
						"select.category1",
						function() {
							
							//카테고리 1이 변경되었을 시 실행.
							var cate2Arr = new Array();
							var cate2Obj = new Object();

							for (var i = 0; i < jsonData.length; i++) {
								if (jsonData[i].level == "2") {
									cate2Obj = new Object();
									cate2Obj.cateCode = jsonData[i].cateCode;
									cate2Obj.cateName = jsonData[i].cateName;
									cate2Obj.cateCodeRef = jsonData[i].cateCodeRef;

									cate2Arr.push(cate2Obj);
								}
							}
							var cate2Select = $("select.category2");
							/*
							for(var i=0; i<cate2Arr.length; i++){
								cate2Select.append("<option value='" + cate2Arr[i].cateCode +"'>" + cate2Arr[i].cateName + "</option>");
							}
							 */
							 
							 cate2Select.children().remove();	//기존 데이터 삭제
							 
							 var cateCode = $("select[name=cateCode]").val();
							 console.log("cateCode : " + cateCode);
							
							$("option:selected", this)
									.each(
											
											function() {
												
												selectVal = null;
												selectVal = $(this).val();
																//1차 분류값
												cate2Select.append("<option value='"+ selectVal + "'>전체</option>");

												for (var i = 0; i < cate2Arr.length; i++) {
													console.log("selectVal : " + selectVal);
													if (selectVal == cate2Arr[i].cateCodeRef) {
														//1차 분류값	//2차 분류의 레퍼런스값
														cate2Select.append("<option value='" + cate2Arr[i].cateCode + "'>" + cate2Arr[i].cateName + "</option>");

													}

												}
											});
							
						});
		
		$(document)
				.on(
						"change",
						"select.category2",
						function() {
							var target = document.getElementById("cateCode2");
							var cate3Arr = new Array();
							var cate3Obj = new Object();

							for (var i = 0; i < jsonData.length; i++) {
								if (jsonData[i].level == 3) {
									cate3Obj = new Object();
									cate3Obj.cateCode = jsonData[i].cateCode;
									cate3Obj.cateName = jsonData[i].cateName;
									cate3Obj.cateCodeRef = jsonData[i].cateCodeRef;
									cate3Arr.push(cate3Obj);
								}
							}
							var cate3Select = $("select.category3");

							cate3Select.children().remove();
							
							
							$("option:selected", this).each(
									function(){
										selectVal = $(this).val();
										//2차 분류값
										cate3Select.append( "<option value='"+ selectVal +"'>전체</option>");
										
										for(var i = 0; i<cate3Arr.length; i++){
											console.log("cate3Arr[" + i + "] : " + cate3Arr[i].cateCodeRef + " selectVal : " + selectVal );
											if(selectVal == cate3Arr[i].cateCodeRef){
												cate3Select.append( "<option value='" + cate3Arr[i].cateCode + "'>" + cate3Arr[i].cateName + "</option>");
											}
										}
										selectVal = null;
									});
							
							 
							/* var cateCode = $("select[name=cateCode]").val();
							 console.log("cateCode : " + cateCode); */
							 
							
							/*
							for (var i = 0; i < cate3Arr.length; i++) {
								cate3Select
										.append("<option value='" + cate3Arr[i].cateCode + "'>"
												+ cate3Arr[i].cateName
												+ "</option>");
							}
							*/
						});
		
		$("#register_Btn").click(function(){
			var size = $("select[name='cateCode']").length;
			console.log("size : "+ size);
		
			var arr = null;
			for(var i =0; i<size; i++){
				console.log(i + "번째 : " + $("select[name='cateCode']").eq(i).val());
			}
			arr = $("select[name='cateCode']").eq(size-1).val();
			console.log("arr : " + arr);
			
			
			
			$("select[name='cateCode']").eq(0).empty();
			$("select[name='cateCode']").val(arr);
			
			var size = $("select[name='cateCode']").length;
			console.log("size2 :" + size);
			
			for(var i =0; i<size; i++){
				console.log(i + "번째 : " + $("select[name='cateCode']").eq(i).val());
			}
			$("#form").submit();
		});
						
		/*
		$(document).on("change","select.category3",
				function(){
			
			var target = document.getElementById("cateCode3");
			alert("선택된 옵션 value= " + target.options[target.selectedIndex].value);
			var cateCode = $('#cateCode3 option:selected').val();
			$("select[name=cateCode]").val(cateCode);
			console.log("cateCode : " + cateCode);
			
		});
		*/
	
				
		//숫자가 아닌 다른 문자 입력을 막음.
		var regExp = /[^0-9]/gi;
					//정규표현식, 숫자만 허용
		$("#gdsPrice").keyup(function(){ numCheck($(this)); });
				//this : 현재 실행중인 선택자 -> 상품 가격입력시 $("#gdsPrice") 의미
		$("#gdsStock").keyup(function(){ numCheck($(this)); });
				//this : 상품 수량 입력시 $("#gdsStock") 이 된다.
		function numCheck(selector){
			var tempVal = selector.val();
			selector.val(tempVal.replace(regExp, ""));
		}

		</script>
</body>
</html>