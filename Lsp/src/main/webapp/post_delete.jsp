<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>게시글 삭제</title>
	</head>
	<body>
		<%
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			String db_address="jdbc:mysql://localhost:3306/team";
			String db_username="root";
			String db_pwd="12345678";
			Connection connection=DriverManager.getConnection(db_address, db_username, db_pwd);
			request.setCharacterEncoding("utf-8");
			String[] num=request.getParameterValues("deleteBoard");
			
			for(int i = 0 ; i<num.length; i++){
				String insertQuery="delete from board where num=?;";
				PreparedStatement psmt=connection.prepareStatement(insertQuery);
				psmt.setString(1, num[i]);
				psmt.executeUpdate();	
			}
			
			response.sendRedirect("board.do?currentPage=1&recordsPerPage=5");
		}catch(Exception ex){
			out.println("오류 발생: "+ex.getMessage());
		}		
		%>
	</body>
</html>