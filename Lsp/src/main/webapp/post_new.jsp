<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
 
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.ckeditor.com/ckeditor5/38.1.1/classic/ckeditor.js"></script>
        <title>게시판 글쓰기 페이지</title>
        <link rel="stylesheet" href="css/header.css">
        <style>
        
       	form{
			width:100%;
			height:100%;			
        }                
        #boardwrap{
            width: 60%;
            height: 60%;
            text-align: center;
            border: 1px solid black;            
        }        
        #table{
            width: 90%;
            height: 90%;
            table-layout: fixed;            
        }
        tr{border: 1px solid black;}
        .area1{height: 10%;}
        .area2{height: 10%;}
        .area3{height: 80%;}
        input[type=text]{width:100%; height:100%;}
        textarea{width:100%; height:100%; resize: none;}
        </style>    
    </head>
    <body>
        <div id="wrap">
        <jsp:include page="header.jsp"></jsp:include>
            <div class="contents">
            <form method="post" action="board.do">
                <div id="boardwrap">                                      
                        <table id="table">
                            <tr class="area1"><td><h3><게시판 글쓰기 양식></h3></td></tr>
                            <tr class="area2">
                            	<td>
                            		<input type="text" name="title" placeholder="글 제목을 입력하세요">
                            		<input type="hidden" name="date">
                            	</td>
                            </tr>
                            <tr class="area3"><td><textarea id="editor" name="content" placeholder="글 내용을 입력하세요"></textarea></td></tr>                      
                            <tr>
                                <td>
                                    <button type="submit">저장하기</button>
                                    <button type="button" onclick="location.href='board.do?currentPage=1&recordsPerPage=5'">목록으로</button>
                                    <button type="reset">초기화</button>
                                </td>
                            </tr>
                        </table>                                           
                	</div>
                </form>
            </div>
        </div>
        <script>
	        ClassicEditor
	        .create( document.querySelector( '#editor' ) )
	        .catch( error => {
	            console.error( error );
	        } );
        </script>
    </body>
</html>