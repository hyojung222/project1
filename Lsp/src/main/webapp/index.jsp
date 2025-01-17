   <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 페이지</title>
    <link rel="stylesheet" href="css/header.css">
    
    
    <style>
         

        a {          
            color: #c5c4c4;
            font-size: 0.9em;
        }
            
        #wrap {
            width: 100%;
            height: 1000px;
        }

        h1 {
            color: #0e2d92;
            font-weight: 400;
             
        }

        .login {
            width: 300px;
            height: 320px;  
            text-align: center;
            padding: 15px;
            
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);       
            background-color: #efeff0;
            border-radius: 20px;
            box-shadow: 2px 1px 10px #c5c5c5;
        }

       
        span {
            display: inline-block;
            width: 80px;
        }

 

        .login input {
            /* 테두리 없앰 */
          
            width: 220px;
            height: 40px;
            border-width: 0;
            border-bottom: 1px solid #ddd;
            border-radius: 20px;
            padding-left: 10%; 
            margin: 15px auto;


        }

         input:focus{
            border-color: #0e2d92;
            outline: none;
        }

        span {
            margin-bottom: 25px;
        }

        #sub {
            background: #0e2d92;
            color: #FFF;
            text-align: center;
            padding-left: 0;  
            border-radius: 23px;
            /* margin-top: 30px; */


        }
    </style>
</head>

<body>
    <div id="wrap">

        <div class="login">
           
            <form method="post" action="login.do">
              
                <h1>로그인</h1>
               
                 <input type="text" name="m_num" autofocus placeholder="사번"><br>
                 <input type="password" name="pw" placeholder="비밀번호 "> <br>
                 <input id="sub" type="submit" value="로그인" >
                
                <c:if test="${result==0 }">
                    <script>
                        let text = document.getElementById("sub");
                        text.style.fontSize = '1.2em';

                        alert("비밀번호가 틀렸습니다");
                    </script>
                </c:if>
                <c:if test="${result==-1 }">
                    <script>
                        alert("회원가입이 되어있지 않습니다");


                    </script>
                </c:if>
            </form>
        </div>
    </div>
</body>

</html>