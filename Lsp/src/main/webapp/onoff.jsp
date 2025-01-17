
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="DTO.OnoffDTO"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>출퇴근관리</title>
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/footer.css">
<style>

/* 오늘 날짜 표시 */
#today {
	width: 300px;
	height: 70px;
	text-align: center;
	line-height: 70px;
	/* background-color: lightgray;*/
	border-radius: 10px;
}
/* 출퇴근 후 시간 보여주는 부분 감싸고 있음*/
.time {
	width: 420px;
	/* background-color: red; */
}
/* 클리어픽스 : float사용시 부모요소의 면적소실문제를 제거하는 기법 */
.time:after {
	content: "";
	display: block;
	clear: both;
}

.ontime, .offtime {
	width: 200px;
	height: 80px;
	/*background-color: lightgray;*/
	text-align: center;
	line-height: 80px;
	float: left;
	margin: 5px;
	border-radius: 10px;
}
/* 출퇴근 버튼 감싸고 있음 */
.onoff_btn {
	clear: both;
	width: 100%;
	padding: 0 32%;

	/* background-color: red; */
}

.onoff_btn input {
	margin: 10px;
}
/* 클리어픽스 : float사용시 부모요소의 면적소실문제를 제거하는 기법 */
.onoff_btn:after {
	content: "";
	display: block;
	clear: both;
}

.on_btn, .off_btn {
	width: 200px;
	height: 60px;
	line-height: 70px;
	color: white;
	text-align: center;
	float: left;
	border-radius: 10px;
	font-size: 1.3em;
	border: none;
}

.on_btn {
	background-color: #1537a7;
}

.off_btn {
	background-color: orange;
}

/* 클리어픽스 : float사용시 부모요소의 면적소실문제를 제거하는 기법 */
.contents:after {
	content: "";
	display: block;
	clear: both;
}

table {
	width: 85%;
	border-collapse: collapse;
	margin-top: 50px;
}

th:nth-child(1) {
	color: red;
}

tr>td:nth-child(1) {
	color: red;
}

th:nth-child(7n) {
	color: blue;
}

tr>td:nth-child(7n) {
	color: blue;
}

th, td {
	border: 1px solid #ddd;
	/* border-left: 0;     
			    border-right: 0; */
	text-align: center;
	table-layout: fixed;
}

th {
	width: 30px;
	height: 50px;
}

td {
	width: 30px;
	height: 130px;
	position: relative;
	overflow: hidden;
}

td span {
	position: absolute;
	top: 0;
	left: 0;
	padding: 5px;
}

caption {
	font-size: 25px;
	margin-bottom: 30px;
}

caption a {
	color: #aaa;
}

caption a:nth-child(2n) {
	color: #000;
}

th {
	border-bottom: none;
}

td .numbox {
	width: 100%;
	height: 84%;
	padding: 10px;
}
</style>
</head>
<body>

	<div id="wrap">
		<jsp:include page="header.jsp"></jsp:include>

		<div class="contents">
			<div class="title">
				<h2>출퇴근 관리</h2>
			</div>

			<div id="today">
				<!-- 현재 날짜와 시간 표시될 곳 -->
			</div>

			<!-- 출퇴근 버튼 누르면 시간 표시됨 -->
			<!-- 
				<div class="time">
					<div class="ontime">00:00:00</div>
					<div class="offtime">00:00:00</div>
				</div>
				 -->
			<div class="onoff_btn">
				<form method="post" action="on.one">
					<input type="hidden" name="m_num" value="${m_num }"> <input
						type="submit" value="출근" class="on_btn">
				</form>

				<form method="post" action="off.one">
					<input type="submit" value="퇴근" class="off_btn">
				</form>
			</div>


			<!-- 캘린더 영역 -->
			<%
			String m_num = (String) session.getAttribute("m_num");
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<OnoffDTO> list = new ArrayList<OnoffDTO>();

			String msg = "";
			String check_date = "";

			String url = "jdbc:mysql://127.0.0.1:3306/team";
			String db_id = "root";
			String db_pw = "iotiot";

			String sql = "select * from onoff where m_num=?;";

			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection(url, db_id, db_pw);
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, m_num);

				rs = pstmt.executeQuery();
				while (rs.next()) {
					OnoffDTO oDTO = new OnoffDTO();
					oDTO.setM_num(rs.getString("m_num"));
					oDTO.setClicktime(rs.getString("clicktime"));
					oDTO.setClicktype(rs.getInt("clicktype"));
					oDTO.setCheck_date(rs.getString("check_date"));
					list.add(oDTO);
				}

			} catch (Exception e) {
				System.out.println("ing error" + e);
			} finally {
				try {
					if (rs != null)
				rs.close();
					if (pstmt != null)
				pstmt.close();
					if (conn != null)
				conn.close();

				} catch (Exception ex) {
					System.out.println("end error" + ex);
				}
			}
			session.setAttribute("list", list);
			%>
			<%
			int listSize = list.size();
			String[] aTime = new String[listSize];
			int[] aType = new int[listSize];
			String[] realTime = new String[listSize];

			for (int i = 0; i < list.size(); i++) {
				aTime[i] = list.get(i).getCheck_date();
				aType[i] = list.get(i).getClicktype();
				realTime[i] = list.get(i).getClicktime();
				//out.print(list.get(i).getCheck_date());
			%>
			<%
			}
			%>
			<%
			Calendar cal = Calendar.getInstance();
			int y = cal.get(Calendar.YEAR);
			int m = cal.get(Calendar.MONTH);
			if (request.getParameter("m") != null) {
				y = Integer.parseInt(request.getParameter("y"));
				m = Integer.parseInt(request.getParameter("m"));
			}
			if (m > 11) {
				y++;
				m = 0;
			}
			if (m < 0) {
				y--;
				m = 11;
			}

			cal.set(y, m, 1);

			int firstDate = cal.get(Calendar.DAY_OF_WEEK); //첫날의 요일
			int lastDate = cal.getActualMaximum(Calendar.DATE); //그달의 마지막날
			%>

			<table>




				<caption>
					<a href="onoff.jsp?y=<%=y%>&m=<%=m - 1%>" class="month">◀&nbsp;</a>
					<%=y%>년
					<%=m + 1%>월 <a href="onoff.jsp?y=<%=y%>&m=<%=m + 1%>" class="month">&nbsp;▶</a>
				</caption>

				<tr>
					<th>일</th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
				</tr>

				<tr>
					<%
					String today = "";

					int count = 0;
					for (int e = 1; e < firstDate; e++) {
						out.print("<td></td>");
						count++;
					}

					for (int i = 1; i <= lastDate; i++) {
						count++;
					%>

					<td><span><%=i%></span><br>


						<div class="numbox">

							<p id="number">
								<%
								if ((m + 1) < 10) {
									if (i < 10) {
										//out.print(y+"-0"+(m+1)+"-0"+i);
										today = y + "-0" + (m + 1) + "-0" + i;
									} else {
										//out.print(y+"-0"+(m+1)+"-"+i);
										today = y + "-0" + (m + 1) + "-" + i;
									}

								} else {
									if (i < 10) {
										//out.print(y+"-"+(m+1)+"-0"+i);
										today = y + "-" + (m + 1) + "-0" + i;
									} else {
										//out.print(y+"-"+(m+1)+"-"+i);
										today = y + "-" + (m + 1) + "-" + i;
									}

								}
								%>



								<%
								for (int k = 0; k < listSize; k++) {
									if (today.equals(aTime[k])) {
										if (aType[k] == 1) {
									out.print("출근 ");
									for (int o = 11; o < 19; o++) {
										out.print(realTime[k].charAt(o));
									}
									out.print("<br>");

										} else {
									out.print("퇴근 ");
									for (int o = 11; o < 19; o++) {
										out.print(realTime[k].charAt(o));
									}
									out.print("<br>");
										}
									}
								}
								%>

							</p>
						</div></td>




					<%
					if (count % 7 == 0) {
						out.print("</tr><tr>");
					}
					}
					%>
				</tr>


			</table>





			<script>
				//날짜 가져오기
				let newDate = new Date();
				let year = newDate.getFullYear(); //연
				let month = newDate.getMonth(); //월
				let date = newDate.getDate(); //일
				let day = newDate.getDay(); //요일
				let dayList = [ '일', '월', '화', '수', '목', '금', '토' ];
				let day2 = dayList[day];
				//시간 가져오기
				//시, 분, 초를 항상 두자리씩 표현하기 위해 문자로 바꾸고 padStart 사용함.
				let hours = newDate.getHours().toString().padStart(2, "0");
				let minutes = newDate.getMinutes().toString().padStart(2, "0");
				let seconds = newDate.getSeconds().toString().padStart(2, "0");

				//현재 날짜와 시간 가져와서 표시하기
				function currentTime() {
					//함수 안에서 날짜와 시간을 가져와야 setInterval 사용시 1초에 한번씩 바뀜.
					//날짜 가져오기
					let newDate = new Date();
					let year = newDate.getFullYear(); //연
					let month = newDate.getMonth(); //월
					let date = newDate.getDate(); //일
					let day = newDate.getDay(); //요일
					let dayList = [ '일', '월', '화', '수', '목', '금', '토' ];
					let day2 = dayList[day];
					//시간 가져오기
					//시, 분, 초를 항상 두자리씩 표현하기 위해 문자로 바꾸고 padStart 사용함.
					let hours = newDate.getHours().toString().padStart(2, "0");
					let minutes = newDate.getMinutes().toString().padStart(2,
							"0");
					let seconds = newDate.getSeconds().toString().padStart(2,
							"0");

					//날짜와 시간 표시하기
					let today = document.getElementById("today");
					today.innerHTML = year + "년 " + (month + 1) + "월 " + date
							+ "일 " + day2 + "요일 " + hours + ":" + minutes + ":"
							+ seconds;
				}

				//출근버튼 누르면 alert
				document.getElementsByClassName("on_btn")[0].addEventListener(
						"click", function() {
							let newDate = new Date();
							let hours = newDate.getHours().toString().padStart(
									2, "0");
							let minutes = newDate.getMinutes().toString()
									.padStart(2, "0");
							let seconds = newDate.getSeconds().toString()
									.padStart(2, "0");
							let time = hours + ":" + minutes + ":" + seconds;
							//document.querySelector(".ontime").innerText=time;
							alert(time + " 출근!");
						});
				//퇴근버튼 누르면 alert
				document.getElementsByClassName("off_btn")[0].addEventListener(
						"click", function() {
							let newDate = new Date();
							let hours = newDate.getHours().toString().padStart(
									2, "0");
							let minutes = newDate.getMinutes().toString()
									.padStart(2, "0");
							let seconds = newDate.getSeconds().toString()
									.padStart(2, "0");
							let time = hours + ":" + minutes + ":" + seconds;
							//document.querySelector(".offtime").innerText=time;
							alert(time + " 퇴근!");
						});

				document.addEventListener('DOMContentLoaded', function() {
					currentTime();
					setInterval(currentTime, 1000); //시간 1초에 한번씩 바뀌게 함.
				});
			</script>





		</div>
		<!-- contents  -->
	</div>
	<!-- wrap end -->


<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>