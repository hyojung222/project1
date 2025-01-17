 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="DTO.OnoffDTO" %>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="css/header.css">
		<style>
			body{
				font-size: 20px;
				color:#555555;
				
			}
			table{
				width: 85%; 			
				border-collapse : collapse;
			}
			th:nth-child(1){
			 				color: red;}
			
			tr>td:nth-child(1){
			 				color: red;} 	
			 							
			
			th:nth-child(7n){
			             color:  blue;
			     } 	
			     
			tr>td:nth-child(7n){
			             color:  blue;
			     } 		     			 		 
			 
			 
			th, td{
				border: 1px solid #ddd;
				border-left: 0;     
			    border-right: 0;
			    width: 30px;
				height: 90px;
				text-align : center;
			}
			caption{
				 
				font-size : 25px;
				margin-bottom:30px;
				
			}
			
			caption a{
						color:#aaa;}
						
			caption a:nth-child(2n){
						color:#000;}
			
			th{border-bottom: none;}
			
			.month
			
		</style>
	</head>
	<body>
		<div id="wrap">
			<jsp:include page="header.jsp"></jsp:include>
			<div class="contents">
				<div class="title">
					<h2>출퇴근 관리</h2>
				</div>
				<%
					String m_num = (String)session.getAttribute("m_num");
					Connection conn = null;
					PreparedStatement pstmt = null;
					ResultSet rs =null;
					List<OnoffDTO> list = new ArrayList<OnoffDTO>();
					
					
					String msg="";
					String check_date="";
					
					String url ="jdbc:mysql://127.0.0.1:3306/team";
					String db_id="root";
					String db_pw = "12345678";
					
					
					String sql = "select * from onoff where m_num=?;";
					
					try{
						Class.forName("com.mysql.cj.jdbc.Driver");
						conn = DriverManager.getConnection(url,db_id,db_pw);
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1 , m_num);
						
						rs= pstmt.executeQuery();
						while(rs.next()){
							OnoffDTO oDTO = new OnoffDTO();
							oDTO.setM_num(rs.getString("m_num"));
							oDTO.setClicktime(rs.getString("clicktime"));
							oDTO.setClicktype(rs.getInt("clicktype"));
							oDTO.setCheck_date(rs.getString("check_date"));
							list.add(oDTO);
							
							
						}
						
						
					}catch(Exception e){
						System.out.println("ing error"+e);
					}finally{
						try{
							if(rs!=null)rs.close();
							if(pstmt!=null)pstmt.close();
							if(conn!=null)conn.close();
							
						}catch(Exception ex){
							System.out.println("end error"+ex);
						}
					}
					session.setAttribute("list",list);
					
				%>	
				<%	
					int listSize = list.size();
					String[] aTime = new String[listSize];
					int[] aType = new int[listSize];
					String[] realTime = new String[listSize];
					
					for(int i = 0 ; i<list.size(); i++){
						aTime[i]= list.get(i).getCheck_date();
						aType[i] = list.get(i).getClicktype();
						realTime[i] = list.get(i).getClicktime();
						//out.print(list.get(i).getCheck_date());%><%
					}
				%>
				<%
					Calendar cal = Calendar.getInstance();
					int y = cal.get(Calendar.YEAR);
					int m = cal.get(Calendar.MONTH);
					if(request.getParameter("m")!=null){
						y =Integer.parseInt(request.getParameter("y"));
						m =Integer.parseInt(request.getParameter("m"));
					}
					if(m>11){
						y++;
						m=0;
					}
					if(m<0){
						y--;
						m=11;
					}
				
					cal.set(y,m,1);
					
					int firstDate = cal.get(Calendar.DAY_OF_WEEK); //첫날의 요일
					int lastDate = cal.getActualMaximum(Calendar.DATE); //그달의 마지막날
					
					
					
					
				%>
				
				<table>
				
				
					
					
					<caption>
						<a href="calendar.jsp?y=<%=y %>&m=<%=m-1 %>" class="month">◀&nbsp;</a>
						<%=y %>년 <%=m+1 %>월
						<a href="calendar.jsp?y=<%=y %>&m=<%=m+1 %>" class="month">&nbsp;▶</a>
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
							for(int e =1; e<firstDate; e++){
								out.print("<td></td>");
								count++;
							}
						
							
							for(int i = 1; i<=lastDate ; i++){
								count++;
								
								
								
								
								%>
								
								<td><%=i %><br>
								<%	
										
									if((m+1)<10){
										if(i<10){
											//out.print(y+"-0"+(m+1)+"-0"+i);
											today = y+"-0"+(m+1)+"-0"+i;
										}else{
											//out.print(y+"-0"+(m+1)+"-"+i);
											today = y+"-0"+(m+1)+"-"+i;
										}
									
									}
									else{
										if(i<10){
											//out.print(y+"-"+(m+1)+"-0"+i);
											today = y+"-"+(m+1)+"-0"+i;
										}else{
											//out.print(y+"-"+(m+1)+"-"+i);
											today= y+"-"+(m+1)+"-"+i;
										}
										
									}
									
								%>
								
								<% for(int k = 0 ; k<listSize; k++){
									if(today.equals(aTime[k])){
										if(aType[k]==1){
											out.print("출근 ");
											for(int o = 11 ; o<19; o++){
												out.print(realTime[k].charAt(o));	
											}
											out.print("<br>");
											
											
											
										}else{
											out.print("퇴근 ");
											for(int o = 11 ; o<19; o++){
												out.print(realTime[k].charAt(o));	
											}
											out.print("<br>");
										}
									}
								}
									
									
								%>
									
									
								
								</td>
								
								
								<%
								if(count%7 ==0){
									out.print("</tr><tr>");
								}
							}
						%>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>