
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사원 등록</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">
<style>

/* 사원등록 */
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

.picture_btn {
	 
}

.data input {
	width: 350px;
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

input[type="file"] {
	 margin-left: 300px;
	
}



</style>
</head>
<body>
	<div id="wrap">
		<jsp:include page="header.jsp"></jsp:include>
		<!-- 사원등록 -->
		<div class="contents">
			<div class="title">
				<h2>사원 등록</h2>
			</div>

			<form method="post" enctype="multipart/form-data"
				action="register.do">
				<!-- 사진과 이름, 사번 등을 감싸고 있음 -->
				<div class="change">
					<!-- 사진, 변경 버튼 감싸고 있음 -->
					<div class="picture_btn">
						<!-- 사진은 관리자가 등록하고, 변경만 직원이 가능 -->
						<div class="picture">
							<img src="">
						</div>
						<input type="file" name="photo">
					</div>
					<!-- 개인정보 내용 감싸고 있음 -->
					<div class="data">
						<span>사&nbsp;&nbsp;&nbsp;&nbsp;번</span>
						<input type="text" name="m_num"><br> 
						<span>이&nbsp;&nbsp;&nbsp;&nbsp;름</span>
						<input type="text" name="name"><br> 
						<span>비밀번호</span>
						<input type="text" name="pw"><br> 
						<span>입&nbsp;사&nbsp;일</span>
						<input type="text" name="join_date"><br> 
						<span>주&nbsp;&nbsp;&nbsp;&nbsp;소</span>
						<input type="text" name="address"><br> 
						<span>연&nbsp;락&nbsp;처</span>
						<input type="text" name="phone"><br> 
						<span>이&nbsp;메&nbsp;일</span>
						<input type="email" name="email"><br> 
						<span>관&nbsp;리&nbsp;자</span>
						<input type="text" name="admin"><br>
						<span>연&nbsp;&nbsp;&nbsp;&nbsp;차</span>
						<input type="text" name="annual_number">
					</div>
					<!-- 버튼을 감싸고 있음 -->
					<div class="btn">
						<input type="reset" value="초기화"> 
						<input type="submit"
							value="등록">
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>