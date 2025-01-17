  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>메인페이지</title>
        <link rel="stylesheet" href="css/header.css">
        <link rel="stylesheet" href="css/footer.css">  
         
        <style>
       .topimg {
  			width: 80%;
  			height: 40%;
  			text-align:center;
  			/* border:1px solid black; */
  			background-size:contain;
  			background-repeat: no-repeat;
  			background-position: center;
  			background-image: url(image/busniess01.png);
		}
		.intro{
			width: 100%;
  			height: 5%;
  			text-align:center;
			line-height: 60px;
			font-size: 30px;
			font-weight: 900;
			margin: 50px 10px;
			color:  rgb(253, 130, 151);
		}
		.team_member{
		  	width: 80%;
  			height: 40%;
  			text-align:center;
  			/* border:1px solid black; */
  			display: grid;			
			grid-template-rows: 1fr 1fr ;
			grid-template-columns: 1fr 1fr 1fr 1fr;
			grid-template-areas: 
			"box1 box2 box3 box4"
			"box5 box6 box7 box8";
		}
		.team_member>div{
			width: 100%;
			height: 100%;
			text-align: center;			
			/* border:1px solid black; */
		}
		 
			 
		}
		.box5, .box6, .box7, .box8{
			text-align:center;
			font-size: 23px;
			line-height: 50px;
		}
		
 
		.imgbox{
			width: 180px;
			height: 180px;
			text-align: center; 		 
			margin-bottom: 10px;	
		}
		
		.imgbox img{
		  width: 100%;
		  height: 100%;
		  border-radius: 50%;
		  
		 
		 }
	 
		
		.textbox{
			width: 90%;
			height: 10%;
			 
		}
        </style>
    </head>
    <body>
        <div id="wrap">
        	<jsp:include page="header.jsp"></jsp:include>
        	
			<div class="contents">
			<div class="title"> <h2>환영합니다</h2> </div>
			<div class="topimg"></div>
			<div class="intro">2024년 LSP(주) 개발팀 신입사원 소개</div>
			<div class="team_member">				
				<div class="contentsbox"><div class="imgbox"><img src="image/member_ley.jpg" alt="leyimg"></div><div class="textbox">Olivia</div></div>
				<div class="contentsbox"><div class="imgbox"><img src="image/member_shj.jpg" alt="leyimg"></div><div class="textbox">Amelia</div></div>
				<div class="contentsbox"><div class="imgbox"><img src="image/member_psm.jpg" alt="leyimg"></div><div class="textbox">Isabella</div></div>
				<div class="contentsbox"><div class="imgbox"><img src="image/member_ljm.jpg" alt="leyimg"></div><div class="textbox">Willam</div></div>
				
				<div class="box5"><b>* 웹디자인 *</b><br>반응형웹 구현<br>UI, UX 디자인<br>헤더, 푸터 제작</div>
				<div class="box6"><b>* 프론트엔드 *</b><br>공지사항 게시판<br>업무일지<br>휴가페이지</div>
				<div class="box7"><b>* 프론트엔드 *</b><br>로그인<br>마이페이지<br>출퇴근페이지</div>
				<div class="box8"><b>* 백엔드 *</b><br>팀프로젝트 총괄<br>전체 DB설계<br>캘린더</div>
			</div>  	
			</div>  
        </div>
		<jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>