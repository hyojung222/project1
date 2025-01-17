
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">

<style>

/* 마이페이지 내용 */
.data {
	width: 100%;
}

.change {
	width: 860px;
	height: 860px;
}

.change {
	width: 860px;
	height: 860px;
	border: 1px solid #ddd;
	margin: 0 auto;
	padding: 20px;
	border-radius: 10px;
}


.picture {
	width: 100px;
	height: 120px;
    background-color: #ddd; 
	border:1px solid #ddd;
	
}

 
.data span {
	display: inline-block;
	width: 70px;
}

.picture_btn, .data, .btn {
	text-align: center;
	margin-top: 20px;
}

.data input {
	width: 350px;
}

.btn input {
	width: 200px;
}

img {
	width: 100px;
	height: 100px;
	
}

.btn input{
	width: 120px;
	border:none;
	border-radius: 10px;}
	
.btn input:nth-child(2n){
		background-color:  #1537a7;
		color:#fff;}	

input {
	width: 60%;
	height: 40px;
	margin: 10px;
}

.data span {
	text-align: justify;
}

.changebtn {
	background-color:#ccc;
	color: #fff;
	 
	width: 100px;
	border: none;
}

.changebtn:hover {
	 
}



</style>
</head>
<body>
	<div id="wrap">
		<jsp:include page="header.jsp"></jsp:include>

		<div class="contents">

			<div class="title">
				<h2>마이페이지</h2>
			</div>


			<form method="post" action="mypage.do" enctype="multipart/form-data">
				<!-- 사진과 이름, 사번 등을 감싸고 있음 -->

				<div class="change">
					<!-- 사진, 변경 버튼 감싸고 있음 -->
					<div class="picture_btn">
						<!-- 사진은 관리자가 등록하고, 변경만 직원이 가능 -->
					
						<div class="picture">
							<img src="${mDTO.photo }">
						
						 
						
						<input type="hidden" name="originPhoto" value="${mDTO.photo }">
						
						</div>
						
						<input type="file" value="변경" class="changebtn" name="photo">
					</div>

					<!-- 개인정보 내용 감싸고 있음 -->
					<div class="data">
						<span>이&nbsp;&nbsp;&nbsp;&nbsp;름</span><input type="text"
							value="${mDTO.name }" readonly><br> <span>사&nbsp;&nbsp;&nbsp;&nbsp;번</span><input
							type="text" value="${m_num }" name="m_num" readonly><br>
						
						 
						<span>비밀번호</span><input type="text" name="pw">	 <br>
					    
					    <span>연&nbsp;락&nbsp;처</span><input
							type="text" name="phone" value="${mDTO.phone }"><br>
						<span>이&nbsp;메&nbsp;일</span><input type="email" name="email"
							value="${mDTO.email }"><br> <span>주&nbsp;&nbsp;&nbsp;&nbsp;소</span><input
							type="text" name="address" value="${mDTO.address }"><br>



					</div>
					<!-- 버튼을 감싸고 있음 -->
					<div class="btn">
						<input type="reset" value="초기화"> <input type="submit" value="수정">
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
