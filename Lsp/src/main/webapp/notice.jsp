<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="controller.boardServlet" %>
<%@ page import="DAO.BoardDAO" %>
<%@ page import="DTO.BoardDTO" %>

 
 
<!DOCTYPE html>
<html lang="ko">

<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>공지사항</title>
   <link rel="stylesheet" href="css/header.css">
   <link rel="stylesheet" href="css/footer.css">

   <style>
      #boardwrap {
         width: 100%;
         flex: 7;
         text-align: center;
      font-weight: 300;
      }

     tbody tr th:nth-child(2){
      color: #f07878;
     }
 

     tbody tr th:nth-child(2)::before{
       
      content: "공지" ;
      background-color: red;
      color:#fff;
      font-size: 0.9em;
      margin-right: 5px;
 

      

 
       
       
      
     }
      table,
      tr,
      th,
      td {
         border: 1px solid #ddd;
         border-collapse: collapse;
         padding: 10px;
      }

      #table {
         width: 90%;
         table-layout: fixed;
         margin-top: 50px;
         font-size: 0.9em;
         
      
          
      }

 

       th, td{
         width: 19%; 
      }



      #title {
         width: 55%; 
         table-layout: fixed;
      }

      #button {
         width: 100px;
         height: 45px;
       position: relative;
         top: 35px;    
         background-color: #0e2d92;
         color: #fff;
      }

      #button:hover {
         background-color: #1a39a0;
      }


      .btnbox {
         margin-top: 30px;
         width: 25%;
         display: flex;
         justify-content: space-around;
         align-items: center;
      }

     .btnbox2{
      width:100%; 
      height:100px;    
     }
 

      .leftbtn,
      .rightbtn {
         margin-top: 10PX;
         width: 45px;     
      }

   </style>
</head>

<body>
   <div id="wrap">
      <jsp:include page="header.jsp"></jsp:include>
      <div class="contents">
         <div class="title">
            <h2>공지사항</h2>
         </div>


         <div id="boardwrap">
            <form method="post" action="post_delete.jsp">
            <table id="table">
               <thead>
                  <tr>
                     <th>번호</th>
                     <th id="title">제목</th>
                     <th>작성자</th>
                     <th>작성날짜</th>
                     <th>수정</th>
                     <th>삭제</th>
                  </tr>
               </thead>
               <tbody>
                  <c:forEach var="i" items="${adminList }">
                     <tr>
                        <th>${i.num }</th>
                        <th>${i.title }</th>
                        <th>${i.writer }</th>
                        <th>${i.reg_date }</th>
                        <th>관리자전용</th>
                        <th>관리자전용</th>
                        
                     </tr>
                  </c:forEach>
                  <c:forEach var="data" items="${data}">
                     <tr>
                        <td>${data.num}</td>
                        <td><a href="post_read.jsp?num=${data.num}">${data.title}</a></td>
                        <td>${data.writer}</td>
                        <td>${data.reg_date}</td>
                        <td>
                           <button type="button" value="수정"
                              onclick="location.href='post_modify.jsp?num=${data.num}'">수정</button>
                        </td>
                        <td>      
                           <input type="checkbox" name="deleteBoard" value="${data.num }">
                           <!-- <button type="button" value="삭제"
                              onclick="location.href='post_delete.jsp?num=${data.num}'">삭제</button>
                            -->
                        </td>
                     </tr>
                  </c:forEach>

               </tbody>
            </table>
            <!-- <%--페이징처리--%>  -->
            

            <div class="btnbox">

               <c:if test="${currentPage !=1 }">
                  <div class="subbox">
                     <a href="board.do?currentPage=${currentPage-1 }&recordsPerPage=${recordsPerPage }">

                        <!--  -->
                        <img src="image/leftbtn.png" class="leftbtn">
                     </a>
                  </div>
               </c:if>

               <c:forEach begin="1" end="${npage }" var="i">
                  <c:choose>
                     <c:when test="${currentPage eq i }">
                        <b><a>[${i }]</a></b>
                     </c:when>
                     <c:otherwise>
                        <a href="board.do?currentPage=${i }&recordsPerPage=${recordsPerPage }">[${i }]</a>
                     </c:otherwise>
                  </c:choose>
               </c:forEach>
               <c:if test="${currentPage !=npage }">
                  <a href="board.do?currentPage=${currentPage+1 }&recordsPerPage=${recordsPerPage }">

                     <img src="image/rightbtn.png" class="rightbtn"></a>
               </c:if>
            </div>


            <div class="btnbox2">
               <button type="button" id="button" value="글쓰기" onclick="location.href='post_new.jsp'">글쓰기</button>
               <button type="submit" id="button" value="삭제">삭제</button>
            </div>
            
            </form>

         </div>
      </div>



<jsp:include page="footer.jsp"></jsp:include>
</body>

</html>