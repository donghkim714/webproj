<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h3>카테고리</h3>

<ul>
	<li><a href="/shop/list?c=100&l=1&num=1">식품</a>
		<ul class="low">
			<li><a href="/shop/list?c=101&l=2&num=1">과일</a></li>
			<li><a href="/shop/list?c=102&l=2&num=1">어패류</a>
				<ul class="low">
					<li><a href="/shop/list?c=1021&l=3&num=1">어류</a></li>
					<li><a href="/shop/list?c=1022&l=3&num=1">조개류</a></li>
				</ul>
			</li>
			<li><a href="/shop/list?c=103&l=2&f=0&num=1">육류</a>
				<ul class="low">
					<li><a href="/shop/list?c=1031&l=3&num=1">닭</a></li>
					<li><a href="/shop/list?c=1032&l=3&num=1">돼지</a></li>
					<li><a href="/shop/list?c=1033&l=3&num=1">소</a></li>
				</ul>
			</li>
			<li><a href="/shop/list?c=104&l=2&num=1">채소</a></li>
		</ul>
	</li>
	<li><a href="/shop/list?c=200&l=1&f=0&num=1">주류</a>
		<ul class="low">
			<li><a href="/shop/list?c=201&l=2&num=1">맥주</a></li>
			<li><a href="/shop/list?c=202&l=2&num=1">소주</a></li>
		</ul>
	</li>
</ul>

