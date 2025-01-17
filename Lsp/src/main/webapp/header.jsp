
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="css/header.css">

</head>

<body>
	<div id="wrap">

		<div id="header">

			<div class="top">
				<div class="top1">
					<a href="main.jsp">LSP주식회사</a>
				</div>
				<div class="top2">${m_num }님환영합니다</div>

				<c:if test="${result==1 || result==2}">
					<div class="logout">
						<a href="logout.jsp">로그아웃</a>
					</div>
				</c:if>



			</div>

			<div class="mainmenu">

				<ul class="menu">
					<li><a href="board.do?currentPage=1&recordsPerPage=5">공지사항</a></li>
					<li><a href="onoff.one">출퇴근관리</a></li>
					<li><a href="vacation.leave">휴가관리</a></li>
					<li><a href="jobsheet.jsp">업무일지</a></li>
					<li><a href="mypage.do">마이페이지</a></li>

					<!-- 관리자 권한이 있는 자가 로그인 했을 경우 관리자페이지 메뉴 보이기 -->
					<c:if test="${result==1}">
						<li class="admin"><a href="#">관리자페이지</a>
							<ul class="submenu">
								<li><a href="staff.jsp">신입사원 등록</a></li>
								<li><a href="all.jsp">전체사원 조회</a></li>
							</ul>
						</li>
					</c:if>


					<!-- 하단에 쫓아다니는 바 -->
					<div class="bar"></div>

				</ul>

			</div>


		</div>
		<!-- header end -->



	</div>
	<!-- wrap end -->



	<script>
		//서브메뉴 하단 슬라이드

		$(document).ready(function() {
			$('.menu>li').mouseover(function() {

				$(this).find('.submenu').stop().slideDown();
			});

			$('.menu>li ').mouseleave(function() {
				$(this).find('.submenu').stop().slideUp();
			});

		})

		//메뉴 하단 따라다니는 바
		$(document).ready(function() {
			$('.menu>li').mouseenter(function() {
				//1. barwidth 변수에 $(this).width() 정의
				var barwidth = $(this).width();
				//2. barpos 변수에 $(this).position().left 정의
				var barpos = $(this).position().left;

				// .bar 를 animate()시킵니다. width는 barwidth까지,
				$('.bar').stop().animate({
					left : barpos,
					width : barwidth
				}, 300)
			})//mouseenter

		})//end ready
	</script>






</body>

</html>