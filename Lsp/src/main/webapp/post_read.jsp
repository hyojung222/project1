<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
 
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>게시글 내용 페이지</title>
        <link rel="stylesheet" href="css/header.css">
        <style>
        
        #boardwrap{
            width: 100%;
            height: 60%;
            
            text-align: center;
            border: 1px solid black;
            text-align:center; 
           	display: grid;
            grid-template-columns: 1fr 9fr;
            grid-template-rows: 1fr 1fr 1fr 7fr;
            grid-template-areas: 
                "box1 box2"
                "box3 box4"
                "box5 box6"
                "box7 box8";
        }
        #boardwrap>div{
        	width:100%;
        	height:100%;
        	border: 1px solid black;        	
        }
    </style>    
    </head>
    <body>
        <div id="wrap">
        <jsp:include page="header.jsp"></jsp:include>
            <div class="contents">
                <div id="boardwrap">
       	<%
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			String db_address="jdbc:mysql://localhost:3306/team";
			String db_username="root";
			String db_pwd="12345678";
			Connection connection=DriverManager.getConnection(db_address, db_username, db_pwd);
			request.setCharacterEncoding("utf-8");
			String num=request.getParameter("num");
			String insertQuery="select*from board where num="+num;
			PreparedStatement psmt=connection.prepareStatement(insertQuery);
			ResultSet result=psmt.executeQuery();
			while(result.next()){
             %>   	             	
                	<div class="box1">글번호</div>
                	<div class="box2"><%=result.getInt("num") %></div>
                	<div class="box3">작성일</div>
                	<div class="box4"><%=result.getString("reg_date") %></div>
                	<div class="box5">제목</div>
                	<div class="box6"><%=result.getString("title") %></div>
                	<div class="box7">내용</div>
                	<div class="box8"><%=result.getString("content") %></div> 
                	                                   
                </div>
                <div>
					<button type=button onclick="location.href='board.do?currentPage=1&recordsPerPage=5'">목록으로</button>
				</div>	
				<% }
			}catch(Exception ex){
			out.println("오류 발생: "+ex.getMessage());
		}%>
				   
            </div>
        </div>
    </body>
</html>