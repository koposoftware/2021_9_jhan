<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="/resources/bootstrap/js/nav.js"></script>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark"
	style="background-color: #1F9688 !important;
	width:100%;position:fixed;top:0;left:0;z-index:1000; margin-bottom:30px; background-size: cover;">
	<a href = '/' class="navbar-brand" style="font-weight: bolder; font-size: 40px;">
	<img src="/resources/assets/img/favicon.ico" height = "40px"> Hana TockTalk</a>
	
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar" style="float:right;">
		<c:if test="${ses ne null}">
		<ul class="navbar-nav"
			style="position:pixed;top:0;left:0;bottom:0;right:0;margin-left:auto !important; color: white; font-weight: bolder; font-size: 1.4em !important; z-index: 2000 !important;">
			<li class="nav-item" style="display:inline-block">
				<a class="nav-link" data-toggle="modal" data-target="#alarmModal" id="alarm" href="#">
				<i class="fas fa-bell" style='font-size: 24px; '></i></a>
				
			</li>
			<li class="nav-item" style="display:inline-block"><a class="nav-link" id="reload" href="#">
			<i class="far fa-bell-exclamation" style='font-size: 24px;'></i>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="/messenger">대화창</a></li>
			
			<li class="nav-item" style="display:inline-block"><a class="nav-link" id="reload" href="/member/main/?email=${ses}">자산현황</a></li>
			<li class="nav-item"><a class="nav-link" href="/stock/list">종목/지수/환율/섹터</a></li>
			<li class="nav-item"><a class="nav-link" href="/stock/detail/?email=${ses}&symbol=AAPL">개별종목상세</a></li>
			<c:if test="${ses eq 'dybe15@naver.com' }">
				<li class="nav-item"><a class="nav-link" id="admin" href="javascript:post_move()">관리자모드</a></li>
			</c:if>
			<li class="nav-item"><a class="nav-link" id="logout" href="/member/logout">로그아웃</a></li>
		</ul>
		</c:if>
		<c:if test="${ses eq null}">
		<ul class="navbar-nav"
			style="margin-left:auto !important;color: white !important; font-weight: bolder; font-size: 1.4em !important; z-index: 2000 !important;">
			<li class="nav-item"><a class="nav-link" id="reload" href="/member/main/?email=${ses}">자산현황</a></li>
			<li class="nav-item"><a class="nav-link" href="/stock/list">종목/지수/환율/섹터</a></li>
			<li class="nav-item"><a class="nav-link" href="/stock/detail/?email=${ses}&symbol=AAPL">개별종목상세</a></li>
			<li class="nav-item"><a class="nav-link" id="loginPage" href="/member/loginPage">로그인</a></li>
		</ul>
		</c:if>
	</div>
</nav>

<div class="modal fade" id="alarmModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-backdrop="static" style="z-index: -1;">
		<div class="modal-dialog" >
		<div class="modal-content" style="background-color:rgb(255,255,255)">
			<div class="modal-header">
				<h5 class="modal-title grayFontBold" id="exampleModalLabel">알림	TockTalk</h5>
				<button type="button" class="close" data-dismiss="modal" id="cancel2"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="input-group">
					<input class="form-control" type="text" id="keyword_buy"
						placeholder="주문가 140.0USD로 APPL 1개가 체결 되었습니다.">
					<!-- <div class="input-group-append">
						<button type="button" class="btn btnBackgroundTrade" id="symbolSearch">종목조회</button>
					</div> -->
				</div>
				
				<input type="hidden" id="deposit_store">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btnBackgroundTrade" id="cancel" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<form id="toAdmin">
      <input type="hidden">
</form>
<script>
	$("#logout").on("click", function(e) {
		e.preventDefault();

		$(function() {
			setCookie('Ck_01', '', -1);
			$('#logout').unbind();
			var logout_t = document.getElementById("logout");
			logout_t.click();
		});
	});
	
	$(document).on("click", "#alarm", function() {
		$("#alarmModal").css("z-index", "2000");
		var symbol = $(this).data("symbol");
		$("#keyword_buy").val(symbol);
	});

</script>

<div class="container" style="margin-top: 30px">