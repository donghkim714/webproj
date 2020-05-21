<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
 section#container {float:right; }
  section#content { float:right; width:700px; }
  section#content2{float:right; width : 700px; margin-top : 15px; border-top: 2px solid #bbb; padding-top : 10px;}
  section#sidebar{width : 500px;}
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
 
 section#container {clear : both; }
 
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
 
 footer#footer { margin-top:15px; border-radius:50px 50px 0 0; }
 footer#footer div#footer_box { padding:0 20px; }
 
</style>
<style>
 div.goods div.goodsThumnailImg { float:left; width:350px; }
 div.goods div.goodsThumnailImg img { width:350px; height:auto; padding-top : 10px; }
 
 div.goodsImg { text-align : center; }
 div.goods div.goodsImg p.gdsImg{ padding:10px; margin-top :10px; display : block; }
 
 div.goods div.goodsInfo { float:right; width:330px; font-size:22px; }
 div.goods div.goodsInfo p { margin:0 0 20px 0; }
 div.goods div.goodsInfo p span { display:inline-block; width:100px; margin-right:15px; }
 
 div.goods div.goodsInfo p.cartStock input { font-size:22px; width:50px; padding:5px; margin:0; border:1px solid #eee; }
 div.goods div.goodsInfo p.cartStock button { font-size:26px; border:none; background:none; }
 div.goods div.goodsInfo p.addToCart { text-align:right; }
 div.gdsDes { font-size:18px; clear:both; padding-top:30px; padding-left:200px}
 
 
</style>
<style>
 section.replyForm { padding:30px 0; }
 section.replyForm div.input_area { margin:10px 0; }
 section.replyForm textarea { font-size:16px; font-family:'맑은 고딕', verdana; padding:10px; width:500px;; height:150px; }
 section.replyForm button { font-size:20px; padding:5px 10px; margin:10px 0; background:#fff; border:1px solid #ccc; }
 
 section.replyList { padding:30px 0; display:block; }
 section.replyList ol { padding:0; margin:0; }
 section.replyList ol li { padding:10px 0; border-bottom:2px solid #eee; }
 section.replyList div.userInfo { }
 section.replyList div.userInfo .userName { font-size:24px; font-weight:bold; }
 section.replyList div.userInfo .date { color:#999; display:inline-block; margin-left:10px; }
 section.replyList div.replyContent { padding:10px; margin:20px 0; }
 section.replyList div.replyFooter button { font-size:14px; border: 1px solid #999; background:none; margin-right:10px; }
</style>
<style>
 div.replyModal { position:relative; z-index:1; display:none; }
 div.modalBackground { position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0, 0, 0, 0.8); z-index:-1; }
 div.modalContent { position:fixed; top:20%; left:calc(50% - 250px); width:500px; height:250px; padding:20px 10px; background:#fff; border:2px solid #666; }
 div.modalContent textarea { font-size:16px; font-family:'맑은 고딕', verdana; padding:10px; width:500px; height:200px; }
 div.modalContent button { font-size:20px; padding:5px 10px; margin:10px 0; background:#fff; border:1px solid #ccc; }
 div.modalContent button.modal_cancel { margin-left:20px; }
</style>
<script src="/resources/jquery/jquery-3.3.1.min.js"></script>
<head>
<script>

	function replyList(){
	var gdsNum = ${vo.gdsNum};
	$.getJSON("/shop/view/replyList" + "?n=" + gdsNum, function(data){
//비동기식으로 json 데이터를 가져옴       url을 통해 컨트롤러에 접속하여 데이터를 가져와 function(data) 에 집어넣음.
		var str="";
		$(data).each(function(){
			console.log(data);

			var repDate = new Date(this.repDate);
			repDate = repDate.toLocaleDateString("ko-US");
								//컨트롤러에서 view로 보낼때의 날짜 데이터 형식이 달라서 1차로 데이터 가공.
			str+= "<li data-repNum='" + this.repNum + "'>"
				+ "<div class='userInfo'>"
				+ "<span class='userName'>" + this.userName + "</span>"
				+ "<span class='data'>" + repDate + "</span>"
				+ "</div>"
				+ "<div class='replyContent'>" + this.repCon + "</div>"

				+"<c:if test='${member!=null}'>"
				+ "<div class='replyFooter'>"
				+ "<button type='button' class='modify' data-repNum='" + this.repNum + "'>수정</button>"
				+ "<button type='button' class='delete' data-repNum='" + this.repNum + "'>삭제</button>"
				+ "</div>"
				+"</c:if>"
				+ "</li>";
		});

		$("section.replyList ol").html(str);
	});
	}
</script>
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
			
			<form id="form" method="post">

				<div class="goods">
					<div class="goodsThumnailImg">
						<img src="/shop/display?fileName=${vo.gdsThumnailImg}"/>
						
					</div>
				
					<div class="goodsInfo">
						<p class = "gdsName">
							<span>
								상품명 
							</span>
								${vo.gdsName}
						</p>
						<p class = "cateName">
							<span>
								카테고리명 
							</span>
								${vo.cateName}
						</p>
						<p class="gdsPrice">
							<span>
								상품 가격
							</span>
							 	<fmt:formatNumber value="${vo.gdsPrice }" pattern="###,###,###"/> 원
						</p>
						<p class="gdsStock">
							<span>
								재고
							</span>
							 	<fmt:formatNumber value="${vo.gdsStock }" pattern="###,###,###"/> 개 남음
						</p>
						<c:if test="${vo.gdsStock != 0 }">
						
						<p class="cartStock">
							<span>
								구입 수량
							</span>
								<button type="button" class="minus">-</button>
								<input type="number" class="numBox" min="1" max="${vo.gdsStock }" value="1" readonly="readonly"/>
								<button type="button" class="plus">+</button>
						
								<script>
									$(".plus").on("click", function(e){
										e.preventDefault();
										var num = $(".numBox").val();
										var plusNum = Number(num) +1;
										
										if(plusNum >= ${vo.gdsStock} ){
											$(".numBox").val(num);
										}
										else{
											$(".numBox").val(plusNum);
										}
									});
										
										$(".minus").on("click",function(e){
											e.preventDefault();
											var num = $(".numBox").val();
											
											var minusNum = Number(num) -1;
											
											if(minusNum <= 0 ){
												$(".numBox").val(num);
											}
											else{
												$(".numBox").val(minusNum);
											}
										});
								</script>
						</p>
						
						<p class="addToCart">
							<button type="button" class="addCart_btn">카트에 담기</button>
							<script>
								$(".addCart_btn").on("click", function(){
									var gdsNum = $("#gdsNum").val();
									var cartStock = $(".numBox").val();
									
									var data = {
											gdsNum : gdsNum,
											cartStock : cartStock
									};
									
									$.ajax({
										url : "/shop/view/addCart",
										type : "post",
										data : data,
										success : function(result){
											if(result == 1){
												alert("카트에 담았습니다.");
												$(".numBox").val(1);
											}
											else{
												alert("로그인 하세요");
												$(".numBox").val(1);
											}
										},
										error : function(){
											alert("카트에 담지 못했습니다.");
										}
									});
								});
							</script>
						</p>
					</c:if>
					
					<c:if test="${vo.gdsStock == 0 }">
						<p>상품 수량이 부족합니다.</p>
					</c:if>	
					</div>
				</div>
				
			</form>
			</section>
			
		</div>
			<section id="content2">
					<div class="goodsImg">
						<p class="gdsImg">
							<img src="/shop/display?fileName=${vo.gdsImg}"/>
						</p>
					</div>
					
					<div class="gdsDes">${vo.gdsDes }</div>
			</section>
			<div id="reply">
				<c:if test="${member == null }">
					<p>소감을 남기시려면<a href="/member/signin">로그인</a> 해주세요</p>
				</c:if>
				
				<c:if test="${member != null }">
							<section class="replyForm">
								<form role="form" method="post"	autocomplete="off" id="form2">
									<input type="hidden" name="gdsNum" id="gdsNum" value="${vo.gdsNum }"> 
								
									<div class="input_area">
										<textarea name="repCon" id="repCon"></textarea>
									</div>
									
									<div class="input_area">
										<button type="button" id="reply_btn">댓글 남기기</button>
										
									<script>
										$("#reply_btn").on("click", function(e){
											
											e.preventDefault();
											
											var userWarn = ${userWarn};
											if(userWarn == 2){
												alert("댓글을 작성할 수 없습니다.(사유 : 경고 누적)");
											}
											else{
												var formObj = $("#form2");
												var gdsNum = $("#gdsNum").val();
												var repCon = $("#repCon").val();
												
												var data = {
														gdsNum : gdsNum,
														repCon : repCon
												};
												
												$.ajax({
													url : "/shop/view/registReply",
													type:"post",
													data : data,
													success : function(){
														replyList();
														$("#repCon").val("");
													}
												});
											}
											
										});
									</script>
									</div>
									
								</form>
							</section>
				</c:if>
							<section class="replyList">
								<ol>
								<%-- 
								<c:forEach items="${reply }" var="reply">
									<li>
										<div class="userInfo">
											<span class="userName">${reply.userName }</span>
											<span class="date"><fmt:formatDate value="${reply.repDate }" pattern="yyyy-MM-dd"/></span>
										</div>
										<div class="replyContent">${reply.repCon }</div>
									</li>
								</c:forEach>
								--%>
								</ol>
								<script>
									replyList();
								</script>
								<script>
									$(document).on("click", ".delete", function(){
										var deleteConfirm = confirm("정말로 삭제하시겠습니까?");
										if(deleteConfirm){
											var data ={
													repNum : $(this).attr("data-repNum")
											};
											
											$.ajax({
												url : "/shop/view/deleteReply",
												type : "post",
												data : data,
												success : function(){
													if(result == 1){
													replyList();
													}
													else{
														alert("작성자 본인만 할 수 있습니다.");
													}
												},
												error : function(){
													alert("로그인 하셔야 합니다.");
												}
											});
										}
									});
								</script>
								
							</section>
						</div>
			<footer id="footer">
				<div id="footer_box">
					<%@ include file="../include/footer.jsp" %>
				</div>		
			</footer>
	</section>
	<section class="sidebar">
	<aside id="aside">
				<%@ include file="../include/aside.jsp" %>
	</aside>
	</section>
	<div>
	
	
	</div>

</div>
<div class="replyModal">
	<div class="modalContent">
		<div>
			<textarea class="modal_repCon" name="modal_repCon"></textarea>
		</div>
		
		<div>
			<button type="button" class="modal_modify_btn">수정</button>
			<button type="button" class="modal_cancel_btn">취소</button>
		</div>
		
		<div class="modalBackground"></div>
		<script>
			$(document).on("click",".modify" ,function(){
				$(".replymodal").fadeIn(200);	//서서히 나타남
				
				var repNum = $(this).attr("data-repNum");
				var repCon = $(this).attr("data-repCon");
				
				$(".modal_repCon").val(repCon);
				$(".modal_modify_btn").attr("data-repNum", repNum);
			});
			$(".modal_cancel_btn").click(function(){
				$(".replyModal").fadeOut(200);	//서서히 사라짐.
			});
		</script>
		<script>
			$(".modal_modify_btn").on("click", function(){
				var modifyConfirm = confirm("정말 수정하시겠습니까?");
				
				if(modifyConfirm){
					var data = {
						repNum : $(this).attr("data-repNum"),
						repCon : $(".modal_repCon").val()
					};
					$.ajax({
						url : "/shop/view/modifyReply",
						type : "post",
						data : data,
						success : function(result){
							if(result){
								replyList();
								$(".replyModal").fadeOut(200);
							}
							else{
								alert("작성자 본인만 가능합니다.");
							}
						},
						error : function(){
							alert("로그인 하세요");
						}
					});
				}
			});
		</script>
	</div>
</div>
</body>
</html>
