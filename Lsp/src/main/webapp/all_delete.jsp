<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원삭제 처리기</title>
	</head>
	<body>
		<%
			request.setCharacterEncoding("utf-8");
			String m_num=request.getParameter("delete");
			System.out.println("m_num: "+m_num);
			String sql="delete from member where m_num='"+m_num+"'";
		
			Connection conn=null;
			Statement stmt=null;
			String url="jdbc:mysql://127.0.0.1:3306/team";
			String db_id="root";
			String db_pw="iotiot";
			
			try{
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn=DriverManager.getConnection(url, db_id, db_pw);
				stmt=conn.createStatement();
				stmt.executeUpdate(sql);
				response.sendRedirect("all.jsp");
			}catch(Exception e){
				System.out.println("all_delete.jsp 에서 접속중 오류발생 : "+e);
			}finally{
				try{
					if(stmt!=null)stmt.close();
					if(conn!=null)conn.close();					
				}catch(Exception ex){
					System.out.println("all_delete.jsp 에서 접속 해제중 오류발생 : "+ex);
				}
			}
		%>
	</body>
</html>