<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<style type="text/css">
	
	@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
    @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
	
	 #board_body {
      font-family: "Noto Sans Kr", Nanum Gothic, "나눔고딕", sans-serif;
   }

   #board_div {
      width : 85%;
      margin : 0 auto;
   }
   
   #board_nvar div {
      display: inline-block;
      font-size: 14px;
      margin: 2px 12px 0;
      color : #666;
      font-weight: 400;
   }

   #board_h2 h2 {
      font-weight: 500;
      font-size: 52px;
      margin-bottom: 70px;
      letter-spacing: -3px;
      font-family: "Noto Sans Kr";
   }
   
	.boardTbl {
		margin: 0 auto;
		margin-top: 70px;
	    padding: 0;
	    border-top: solid 1.5px black;
	    width: 75%;
	    font-family: 'Nanum Gothic', '나눔고딕', '돋움', Dotum, sans-serif;
	    font-size: 12px;
	    line-height: normal;
	    vertical-align: baseline;
	}
	
	.boardTbl tr th {
	    width: 120px;
	    padding: 10px 0 10px 30px;
	    border-bottom: 1px solid #d7d7d7;
	    color: #181818;
	    font-weight: normal;
	    text-align: left;
	    vertical-align: middle;
	}
	
	.boardTbl tr td {
	    padding: 10px 0 10px 10px;
	    border-bottom: 1px solid #d7d7d7;
	    color: #837d81;
	    text-align: left;
	    vertical-align: middle;
	}
	
	#boardTbl_cat {	
	    display: inline-block;
	    font-size: 16px;
	    color: #222;
	    font-weight: 400;
	    vertical-align: middle;
	    margin-top: -1px;
	}
	
	#boardTbl_title {
		font-size: 28px;
	    color: #222;
	    font-weight: bold;
	    vertical-align: middle;
	}
	
	#boardTbl_date {
		color:#999999;
		font-size: 12pt;
		font-weight: bold;
	}
	
	.board_contents {
		margin: 0px auto;
		min-height: 500px;
		width: 75%;
		border-bottom: 1px solid #d7d7d7; 
	}
	
	#content {
		float: left;
		width: 70%;
		margin: 30px 40px;
	}
    
   
    #noticeBoardDetailListBack{
    	text-decoration: none;
    	margin: 10px 20px 10px 20px; 
		text-decoration: none;
		outline: none; 
    }
    
    #noticeBoardDetailListBack:hover{
    	cursor: pointer;
    
    }
    
    .btns {
    	height: 66px;
    	line-height: 66px;
   	 	font-size: 20px;
   	 	min-width: 120px;
   	 	display: inline-block;
   		cursor: pointer; 	
    }
    
    
    
    
 /*             목록, 수정, 삭제 버튼                        */   
 
    #listBtn {
    	background: white;
    	border : 1px solid #aaa;
    	cursor: pointer;
    }
    
    
    #NoticeCorrect {   
    	background: black;
    	color: white;
    	border : none;
    	margin-right: 15px;
    	float: right;
    }
    
     #NoticeDelete {
    	background: #eb2d2f;
    	color: white;
    	border : none;
    	float: right;
    }
    
    #leftArea{
    	width: 70%; 
    	margin: 0 auto;
    	padding: 40px 0px 40px 0px;
    }
 /*             목록, 수정, 삭제 버튼           end    */   
 
 	#quickView{
 		width: 70%;
 		margin: 0 auto;
 		padding-top: 20px;
 	}
 	
 	.move:hover{
	 	cursor: pointer;
	 	text-decoration: underline;
 	}
</style>	

<script type="text/javascript">
	$(document).ready(function(){
		
		$("#NoticeDelete").click(function(){
			
			var message = "정말로 삭제하시겠습니까??";
		    result = window.confirm(message);
		    
		    if(result){
		    	var frm = document.delFrm;
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/noticedel.to";
				frm.submit();
		    }
		    else{
		    	alert("취소되었습니다.");
		    }
			
		});
		
	});
</script>

<div id="board_body">
	
	 <div id = "board_nvar" align="right" style = "margin: 40px 220px;">
         <div><i class = "fa fa-home"></i></div>
         <div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">게시판</div>
         <div>공지사항</div>
      </div>
      <div align="center" id = "board_h2">
         <h2>공지사항</h2>
      </div>
	
<form name="delFrm" enctype="multipart/form-data">	
<input type="hidden" name="not_seq" value="${boardvo.not_seq}"/>
	<table class="boardTbl">
		<tr>
			<th style="height: 100px; width: 110px;">
				<span id="boardTbl_cat">공지사항&nbsp;<span style="color:#e5e5e5;">|</span></span>
								<%-- 카테고리 분류 --%>
			</th>
			<td>
				<span id="boardTbl_title">${boardvo.not_title}</span>
			</td>
			<td style="width: 150px;">
				<span id="boardTbl_date">${boardvo.not_regDate}</span>
			</td>
		</tr>
		
	</table>
		
	<div class="board_contents">
		<div id="content">
			${boardvo.not_content}
		</div>
	</div>
</form>
	
	<div id="quickView">
	<div style="margin-bottom: 1%;">이전글    :&nbsp;&nbsp;
					<c:if test="${boardvo.nonextsubject == null}">
						<span>이전글이 없습니다.</span>
					</c:if>
	<span class="move" onClick="javascript:location.href='noticeBoardDetail.to?not_seq=${boardvo.nonextseq}'">${boardvo.nonextsubject}</span></div>
	<div style="margin-bottom: 1%;">다음글    :&nbsp;&nbsp;
					<c:if test="${boardvo.noprevioussubject == null}">
						<span>다음글이 없습니다.</span>
					</c:if>
	<span class="move" onClick="javascript:location.href='noticeBoardDetail.to?not_seq=${boardvo.nopreviousseq}'">${boardvo.noprevioussubject}</span></div>
	</div>
	
   	<div id="leftArea">
   		<button type="button" class="btns" id="listBtn" onClick="javascript:location.href='<%= request.getContextPath() %>/boardmenu.to'">목록</button>
   		<c:if test="${sessionScope.loginuser.userid == 'admin'}">
	   		<button type="button" class="btns" id="NoticeDelete">삭제</button>
	   		<button type="button" class="btns" id="NoticeCorrect" onclick="javascript:location.href='<%= request.getContextPath() %>/noticeedit.to?not_seq=${boardvo.not_seq}'">수정</button>
   		</c:if>
   	</div>

		
</div>
