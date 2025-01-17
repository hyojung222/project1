	
	<%@ page language="java" contentType="text/html; charset=utf-8"
		pageEncoding="utf-8"%>
	
	<!DOCTYPE html>
	<html lang="ko">
	<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>업무일지 페이지</title>
	<link rel="stylesheet" href="css/header.css">
	<link rel="stylesheet" href="css/footer.css">
	<style>
	#middle-1 {
		flex: 2;
		margin-right: 30px;
		text-align: center;
	}
	/*border-radius: 30px; border: 1px solid black;  */
	#side {
		width: 80%;
		height: 50%;
		text-align: center;
	}
	
	#middle-2 {
		width: 80%;
		flex: 8;
		display: flex;
		flex-direction: column;
	}
	
	#content-1 {
		border: 1px solid #ddd;
		width: 100%;
		flex: 1;
		display: grid;
		margin-bottom: 30px;
		grid-template-columns: repeat(4, 1fr);
		grid-template-rows: repeat(2, 1fr);
		grid-template-areas: "box6 box6 box6 box6" "box7 box8 box9 box10";
		padding: 10px;
	}
	
	.box6 {
		grid-area: box6;
	}
	
	#content-2 {
		border: 1px solid #ddd;
		width: 100%;
		flex: 9;
		display: grid;
		grid-template-columns: 8fr 2fr;
		grid-template-rows: 1fr 1fr 8fr;
		grid-template-areas: "box1 box1" "box2 box3" "box4 box5";
	}
	
	#content-2>div, #content-1>div {
		width: 100%;
		height: 100%;
		text-align: center;
		line-height: 43px;
	}
	
	.box1 {
		grid-area: box1;
	}
	
	.box2, .box3, .box7, .box9 {
		background-color: #ccc;
	}
	
	textarea {
		width: 100%;
		height: 100%;
		resize: none;
		border: 1px solid #ddd;
		font-size :25px;
	}
	
	#form1 {
		width: 100%;
		height: 100%;
		display: inline;
		margin: 0;
		padding: 0;
	}
	
	#form2 {
		width: 100%;
		height: 100%;
		display: inline;
		margin: 0;
		padding: 0;
		flex: 8;
		display: flex;
		flex-direction: column;
	}
	
	input[type="button"] {
		margin-top: 30px;
	}
	
	#getdate {
		width: 25%;
		height: 50px;
		font-size: 1.2em;
		text-align: center;
	}
	
	#btn {
		width: 15%;
		height: 35px; 
		text-align: center;
		margin: 30px;
	}
	</style>
	</head>
	
	<body>
		<div id="wrap">
			<jsp:include page="header.jsp"></jsp:include>
			<div class="contents">
				<div class="title">
					<h2>업무일지</h2>
				</div>
				<div id="middle-1">
					<form id="form1" action="#">
						<div id="side">
	
							<span>작성일자: </span> <input type="date" id="getdate"> 
							<input type="button" value="검색!" onclick="request_doPost()"
								id="btn">
						</div>
					</form>
				</div>
	
				<div id="middle-2">
					<form id="form2" method=get action="sheet.do">
						<div id="content-1">
							<div class="box6">
								<h1></h1>
							</div>
							<div class="box7">작성자</div>
							<div class="box8">${m_num }</div>
							<input type="hidden" name="m_num" value="${m_num }" id="hidName">
							<div class="box9">작성일자</div>
							<div class="box10">
								<input type="date" name="date">&nbsp;&nbsp;&nbsp;<input
									type="submit" value="제출">
							</div>
						</div>
						<div id="content-2">
							<div class="box1">
								<금일 업무 내용>
							</div>
							<div class="box2">업무내용</div>
							<div class="box3">비고</div>
							<div class="box4">
								<textarea name="text_area1" id="text_area1"></textarea>
							</div>
							<div class="box5">
								<textarea name="text_area2" id="text_area2"></textarea>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		<script>
			var XHR;
			var type = "";
			function createXMLHttpRequest() {
				if (window.ActiveXObject) {
					XHR = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					XHR = new XMLHttpRequest();
				}
			}
			function createString() {
				var getdate = document.getElementById("getdate").value;
				var getM_num = document.getElementById("hidName").value;
				var dataString = "getdate=" + getdate;
				var dataM_num = "m_num="+ getM_num;
				return dataString+"&"+dataM_num;
			}
	
			function request_doPost() {
				createXMLHttpRequest();
				var url = "sheet.do";
				dataString = createString();
				XHR.onreadystatechange = handleStateChange;
				XHR.open("POST", url, true);
				XHR.setRequestHeader("content-Type",
						"application/x-www-form-urlencoded");
				XHR.send(dataString);
	
			}
			function handleStateChange() {
				console.log(XHR.readyState);
				if (XHR.readyState == 4) {
					if (XHR.status == 200) {
						parseResult();
					}
				}
			}
			function parseResult() {
				var div = document.getElementById("text_area1");
				if (div.hasChildNodes()) {
					div.removeChild(div.childNodes[0]);
				}
				var text = document.createTextNode(XHR.responseText);
				div.appendChild(text);
	
			}
		</script>
		<jsp:include page="footer.jsp"></jsp:include>
	</body>
	</html>