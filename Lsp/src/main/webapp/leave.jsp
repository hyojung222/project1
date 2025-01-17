  
<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ page import="DAO.VacationDAO"%>

 

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">



<title>휴가 페이지</title>
<link rel="stylesheet" href="css/header.css">
<style>

#middle-1 {
width: 80%;
height: 80px;
line-height: 80px;
display: flex;
flex-direction: row;
border: 1px solid black;
margin-bottom: 30px;
}

.span {
flex: 1;
text-align: center;
}

#middle-2 {
width: 80%;
height: 560px;
display: flex;
flex-direction: row;
justify-content: center;
text-align: center;
align-items: center;
border: 1px solid black;
}
#middle-3{
width: 80%;
height: 800px;
margin-top: 10px;
 }

#form-1 {
width: 20%;
height: 100%;
text-align: center;
position: relative;
/*border: 1px solid black;*/   
}

#form-1-1 {
margin: 0 auto;
display: flex;
flex-direction: column;
position: absolute;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
/*border: 1px solid black;*/

}

#form-1-1 button {        
width: 150px;
height: 60px;
border-radius: 20px;
border: 1px solid #eee;    
}

.form-2 {
 
width: 80%;
height: 100%;
/*border: 1px solid black;*/
}


.text{
    position: relative; 
    width: 100%;
    height: 100%;
    margin-top: 20px;
}

textarea {
position: absolute;
top: 90px;
left: 50px;
width: 90%;
height:  300px;
resize: none;
margin-top: 25px;
font-size: 25px;
padding: 10px;

}

input[type=date], input[type=datetime-local] {
height: 40px;
}

input[type=submit] {
width: 100px;
}

.submitbtn{
width: 150px;
height:50px;
border:none;
border-radius: 10px;
background-color:  #1537a7;
color:#fff;
font-size: 1em;

position: absolute;
bottom: 10%;
left:50%;
 
}

#calender{
   width:500px;
   height:500px;
}

 

#form-1-1 button {
    margin: 10px;
    box-shadow: 2px 3px 10px #e0dfdf;
}

#form-1-1 button:first-child {
    background-color: #bcf068;}
     
#form-1-1 button:nth-child(2){
    background-color: #a1edfa; }

#form-1-1 button:nth-child(3){
    background-color: #f0d068; }
 
#form-1-1 button:last-child {
    background-color: rgb(174, 182, 185);}    

</style>

</head>
<body>

  <%
request.setCharacterEncoding("utf-8");
VacationDAO vDAO = new VacationDAO();
String m_num = (String)session.getAttribute("m_num");
int a=vDAO.vacation_check(m_num); //연차 사용 갯수      
int b=vDAO.bancha_check(m_num); //반차 사용 갯수
int c=vDAO.annaul_number_check(m_num); //전체 연가 갯수
double d=c-(a+(b*0.5));
String d_d = Double.toString(d);
%>  



<div id="wrap">
    <jsp:include page="header.jsp"></jsp:include>

    <div class="contents">
        <div class="title">
            <h2>휴가페이지</h2>
        </div>


        <div id="middle-1">
            <div class="span">사원: ${m_num }</div>
            <div class="span">미사용 연차: <%=d_d %> 일</div>
        </div>

        <div id="middle-2">
            
            <div id="form-1">
                <div id="form-1-1">
                    <button  >연차</button>
                 
                    <button>반차</button>
                    
                    <button>휴가</button>
                     
                    <button>사직</button>
                    
                </div>
            </div>
            

            <!--타입:1, 연차 -->
            
            <form method="post" action="data1.leave" class="form-2">               
               
                <div class="text">
                    
                    <input type="hidden" name="leavetype" value="1"> 
                    <span>날짜를 선택하세요</span>&nbsp;&nbsp; 
                    <input type="date" name="leave_start"><br>
                    
                    <textarea name="reason" id="text_area" cols="80" rows="15"
                        placeholder="사유를 입력해주세요"></textarea>
                    <input type="submit" value="제출!" class="submitbtn">   
                </div>
                        
            </form>

            <!--타입:2, 반차-->
            <form method="post" action="data2.leave" class="form-2">
                <div class="text">
                
                    <input type="hidden" name="leavetype" value="2"> 
                    <span>날짜와 시간을 선택하세요</span>&nbsp;&nbsp; 
                    <input type="date" name="leave_start">
                    
                    <select name="bancha_time">
                        <option value="am">오전반차</option>
                        <option value="pm">오후반차</option>
                    </select>
                    
                    <textarea name="reason" id="text_area" cols="80" rows="15"
                        placeholder="사유를 입력해주세요"></textarea>
                        <input type="submit" value="제출!" class="submitbtn">   
                </div>
                            
            </form>

            <!--타입:3, 휴가 -->
            <form method="post" action="data3.leave" class="form-2">               
                <div class="text">
                    <input type="hidden" name="leavetype" value="3"> 
                    <span>휴가기간을 선택하세요</span>&nbsp;&nbsp; 
                    <input type="date" name="leave_start">&nbsp; ~ &nbsp; 
                    
                    <input type="date" name="leave_end">
                    <textarea name="reason" id="text_area" cols="80" rows="15"
                        placeholder="사유를 입력해주세요"></textarea>
                    <input type="submit" value="제출!" class="submitbtn">      
                </div>
                         
            </form>

            <!--타입:4, 사직-->
            <form method="post" action="data4.leave" class="form-2">               
                <div class="text">
                    <input type="hidden" name="leavetype" value="4"> 
                    <span  >사직서를 작성해서 제출해주세요</span> 
                        
                     
                    <textarea name="reason" id="text_area" cols="80" rows="15"
                        placeholder="사직사유를 입력해주세요"></textarea>
                    <input type="submit" value="제출!" class="submitbtn">   
                </div>
                           
            </form>
        </div>
        
    </div>
</div>

<script>
    let btns = document.querySelectorAll("button");
    let btnDivs = document.querySelectorAll(".form-2");
    for (var i = 0; i < btnDivs.length; i++) {
        if (i == 0)
            btnDivs[i].style.display = 'block';
        else
            btnDivs[i].style.display = 'none';
    }
    for (var i = 0; i < btns.length; i++) {
        //버튼의 번호를 속성으로 저장
        btns[i].no = i;
        btns[i].addEventListener("click", function(e) {
            for (var j = 0; j < btns.length; j++) {
                btnDivs[j].style.display = 'none';
            }
            btnDivs[this.no].style.display = 'block';
        });
    }
    
    
    
</script>

<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>