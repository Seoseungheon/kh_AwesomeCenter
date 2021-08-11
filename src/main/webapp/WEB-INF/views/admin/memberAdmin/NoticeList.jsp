<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%-- ======= tile1 의 header 페이지 만들기  ======= --%>
<%
	String cxtpath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<title>공지게시판 목록</title>

<style type="text/css">

@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

   #memberList_body {
      font-family: "Noto Sans Kr", Nanum Gothic, "나눔고딕", sans-serif;
   }
   
   #memberList_h2 h2 {
   
      font-weight: 500;
      font-size: 52px;
      margin-bottom: 20px;
      letter-spacing: -3px;
      font-family: "Noto Sans Kr";
   
   }
   
   #memberList_line {
        border: solid 1px #bfbfbf;
   }
   
   table#mbrTbl {
	
		margin-top: 12px;
		width: 100%;
		border-collapse: collapse;
	
	}

	table#mbrTbl th{
		background: #f4f4f4;
		border-collapse: collapse;
		height: 50px;
	}

	table#mbrTbl th, table#mbrTbl td{
	
		border-collapse: collapse;
	
	}
	table#mbrTbl td{
	    
	    padding: 11px 10px 10px;
	    /* border-top: 1px solid blue; */
	    color: #353535;
	    vertical-align: middle;
	    word-break: break-all;
	    word-wrap: break-word;
	}
	#member_search{
		vertical-align:middle; 
		height: 35px;
		width: 80px;
		font-size: 11pt;
	}
	
	#member_search_box{
	/*    border: solid 1px red; */
	   list-style:none;
	   vertical-align: middle;
	   height: 35px;
	   margin: 35px 35px 0px 0px;
	}
	
	#member_SearchBtn{
	   background-color: #2d2d2d;
	   color:white;
	   outline: none;
	   border: none;
	   height: 35px;
	   width: 70px;
	   font-size: 11pt;
	}
	
	#member_SearchBtn:hover{
	   background-color: #595959;
	   cursor: pointer;
	   
	}

	 #admin_h2 h2 {
   
      font-weight: 500;
      font-size: 52px;
      margin-top: 50px;
      margin-bottom : 40px;
      letter-spacing: -3px;
      font-family: "Noto Sans Kr";
   
   }
   
    #btnArea {
    	margin: 30px 5px 270px 61px;
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
    
    #rightArea {
   		 float : right;
   		 margin-top: 40px;
   		 
    }
    .btns {
    	height: 66px;
    	line-height: 66px;
   	 	font-size: 20px;
   	 	min-width: 120px;
    }

	.NoticeStyle{
		cursor: pointer;
		text-decoration: underline;
	}
	
	#noticeHovertitle:hover{
		background-color: #f9f9f9;
		
	}
</style>
<script type="text/javascript">

		$(document).ready(function(){
		
			$(".not_title").bind("mouseover", function(event){
				var $target = $(event.target);
				$target.addClass("NoticeStyle");
			});
			
			$(".not_title").bind("mouseout", function(event){
				var $target = $(event.target);
				$target.removeClass("NoticeStyle");
			});
		});
	

</script>

</head>
<body id="memberList_body">


     <div align="center" id = "memberList_h2">
         <h2>공지사항</h2>
      </div>
      
      
	  <div style="width:70%; margin:0 auto;"> 	
   
 	  <div style="float:right;">
 	    <ul>
 	  	  <li id="member_search_box">
 	  		<select id="member_search" name="member_search">
				<option value="">제목</option>
			</select>
			<input type="text" style="height: 29px;"/>
			<button id="member_SearchBtn" style="vertical-align:middle;">검색</button>
 	  	  </li>
 	  	</ul>
 	  </div>
 	  
 	  <table id = "mbrTbl">
			
		<tr>
			<th style="width: 70px;  text-align: center;">번호</th>
			<th style="width: 70px; text-align: center;">점포</th>
			<th style="width: 360px;  text-align: center;">제목</th>
			<th style="width: 180px; text-align: center;">등록일</th>
			
		</tr>	
		
	<c:forEach var="boardvo" items="${boardList}" varStatus="status">
			<tr id="noticeHovertitle">
				<td align="center">${boardvo.not_seq}</td>
				<td align="center">본점</td>
				<td align="center">
				
				<span class="not_title" onclick="goView('${boardvo.not_seq}');">${boardvo.not_title}</span>
				
				</td>
				<td align="center">${boardvo.not_regDate}</td>
				
		    </tr>
		</c:forEach>
		
	</table>	
	
	<div id="btnArea">
      	<div id="rightArea">
      		<button type="button" class="btns" id="registerBtn" onclick="">등록</button>
      	</div>
     </div>
	
	<div align="center" style="">
		${pageBar}
	</div>		
 	  
 	  
 	  
 	  
</div> 
</body>
</html>