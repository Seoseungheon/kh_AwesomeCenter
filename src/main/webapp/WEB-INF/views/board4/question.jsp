<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style type="text/css">

   @import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
   @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

   #question_body {
      font-family: "Noto Sans Kr", Nanum Gothic, "나눔고딕", sans-serif;
   }

   #question_container {
      width : 70%;
      margin : 0 auto;
   }
   
   #question_nvar div {    
      display: inline-block;
      font-size: 14px;
      margin: 2px 12px 0;
      color : #666;
      font-weight: 400;
   }

   #question_h2 h2 {
      font-weight: 500;
      font-size: 52px;
      margin-bottom: 70px;
      letter-spacing: -3px;
      font-family: "Noto Sans Kr";
   }
   
   #notice_div {
   		padding: 20px;
    	position: relative;
    	background: #f4f4f4;
    	margin: 0 67px 20px 65px;
    	
   }
   
   #goA {
	   	position: absolute;
	    right: 30px;
	    top: 45px;
	    padding: 10px 6px;
	    background: black; 
	    color:white; 
	    font-size: 11pt; "
   }
   
   #question_div {
   	  margin: 50px 0;
   }
   
   #question_table {
      width : 90%;
      margin: 0 auto;
      border-top: 1px solid black;
      border-bottom: 1px solid #cccccc;
   }
   
   #question_table th {
  	 background-color: #f4f4f4; 
  	 width : 200px;
  	 height: 66px;
  	 vertical-align: middle !important;
  	 text-align: center !important;  
	 font-weight: bold;
	 padding: 15px 30px;
   } 
   
    #question_table td {
  	 width : 400px;  
  	 padding : 11px 5px 10px 5px;	
  	
   } 
   
    #question_table td input[type="text"] {
    	border: solid 1px #ccc;
    	font-size: 15px;
    	width:95%; 
    	height: 44px; 
    	margin:7px;" 
    	padding: 0 30px;
    }
    
    #questionCategory {
    	padding: 8px;
    	margin: 7px;
    	border: solid 1px #ccc;
    	width: 90%;
    	height: 48px;
    }
    
    #contentArea {
    	width: 95%;
    	height: 300px;
    	padding: 8px;
    	margin: 7px;
    	border: solid 1px #ccc;
    }
    
    #btnArea {
    	margin: 30px 5px 270px 61px;
    }
    
    .btns {
    	height: 66px;
    	line-height: 66px;
   	 	font-size: 20px;
   	 	min-width: 120px;
    }
    
    #listBtn {
    	background: white;
    	border : 1px solid #aaa
    }
    
    #registerBtn {
    	background: #eb2d2f;
    	color: white;
    	border : none;
    	
    }
    
    #resetBtn {
    	background: black;
    	color: white;
    	border : none;
    	margin-right: 8px;
    }
    
    #leftArea {	
    	float: left;
    }
    
    #rightArea {
    	 padding-right : 60px;
   		 float : right;
   		 
    }
      
	 
  
   

</style>

</head>
<body id = "question_body">
   
   <div id = "question_container" >
      
      <div id = "question_nvar" align="right" style = "margin: 40px 50px;">
         <div><i class = "fa fa-home"></i></div>
         <div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 4px 10px 0 0; float:right;">문의하기</div>
         <div>1:1 문의</div>
      </div>
      <div align="center" id = "question_h2">
         <h2>1 : 1 문의</h2>
      </div>
      
      <div id="notice_div">
        <div style="width: 70%;">
      	<ul>
      		<li>고객서비스의 [Q&A게시판]에서 자주 질문하는 답변을 보실 수 있습니다.</li>
      		<li>1:1문의를 해주시면 빠른 시일 안에 답변을 드리겠습니다.</li>
      		<li>답변 내용은 마이페이지의 [1:1 문의]에서 확인하실 수 있습니다.</li>
      	</ul>
      	</div>
      	
      	<div style="width: 30%; float:right;">
      	<a href="#"><span id="goA">Q&A게시판 보기</span></a>
      	</div>
      </div>
      
      <div id = "question_div">
      	<form name="questionFrm" action="" method="POST" enctype="multipart/form-data"> 
         <table class="table" id="question_table">
               <tr>
                  <th>제목</th>    
                  <td colspan="3"><input type="text"/></td>     
               </tr>
               <tr>      
                  <th>유형</th>
                  <td>
                  	<select class="questionCategory" name="questionCategory" id="questionCategory" >  
						<option value="question01">회원가입</option>
						<option value="question02">수강신청</option>
						<option value="question03">강좌/강사</option>
						<option value="question04">환불/취소</option>
						<option value="question05">홈페이지</option>
						<option value="question06">기타</option>	
					</select>   
                  </td>
                  <th>지점</th>
                  <td style="padding-left:15px; vertical-align: middle;">본점</td>
               </tr>
                <tr >       
                  <th>내용</th>
                  <td colspan="3">
                  	<textarea maxlength="1000" name="content" id="contentArea" placeholder="*적절한 유형에 맞춰 문의하셔야 원활하게 답변을 받으실 수 있습니다."></textarea>
                  </td>
               </tr>
                <tr>      
                  <th>첨부파일</th>
                  <td colspan="3">
					 <input type="file" name="addFile" id="addFile" style="vertical-align: middle; margin:9px 0 1px 15px;"/>
				 </td>
               </tr>     
         </table>
         </form>
      </div>
      
      <div id="btnArea">
      	<div id="leftArea">
      		<button type="button" class="btns" id="listBtn" onclick="">목록</button>
      	</div>
      	<div id="rightArea">
      		<button type="button" class="btns" id="resetBtn" onclick="">취소</button>
      		<button type="button" class="btns" id="registerBtn" onclick="">등록</button>
      	</div>
      </div>
      
   </div>
   
</body>
</html>