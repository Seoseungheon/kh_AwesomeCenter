<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<style type="text/css">
	
	@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
    @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
	
	 #board_body {
      font-family: "Noto Sans Kr", Nanum Gothic, "나눔고딕", sans-serif;
   }

   #mainDiv {
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
   
	.eventTbl {
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
	
	.eventTbl tr th {
	    width: 120px;
	    padding: 10px 0 10px 30px;
	    border-bottom: 1px solid #d7d7d7;
	    color: #181818;
	    font-weight: normal;
	    text-align: left;
	    vertical-align: middle;
	}
	
	.eventTbl tr td {
	    padding: 10px 0 10px 10px;
	    border-bottom: 1px solid #d7d7d7;
	    color: #837d81;
	    text-align: left;
	    vertical-align: middle;
	}
	
	#eventTbl_cat {	
	    display: inline-block;
	    font-size: 16px;
	    color: #222;
	    font-weight: 400;
	    vertical-align: middle;
	    padding-right: 15px;
	    margin-top: -1px;
	}
	
	#eventTbl_title {
		font-size: 28px;
	    color: #222;
	    font-weight: bold;
	    vertical-align: middle;
	}
	
	#eventTbl_date {
		color:#999999;
		font-size: 12pt;
		font-weight: bold;
	}
	
	.board_contents {
		margin: 0px auto;
		min-height:500px;
		width: 75%;
		border-bottom: 1px solid #d7d7d7; 
		overflow: hidden;
	}
	
	#content {
		float: left;
		width: 70%;
		margin: 30px 40px;
	}
	
	.btn_cover {
		margin: 20px auto;
		width: 75%;
		text-align: right;
	}
	
	.btn {
	    display: inline-block;
	    width: 140px;
	    height: 80px;
	    margin: 10px;
	    padding: 23px 0 35px 0;
	    border: 1px solid #aaa;
	    color: black;
	    font-size: 28px;
	    font-weight: bold;
	    text-align: center;
	    cursor: pointer;
	}
	
	#viewBtn {
		width : 75%;
 		margin: 40px 50px 50px 169px;
 		border : 1px solid #d7d7d7;
 		padding : 10px;
 		overflow: hidden;
 		
	}
	
	#rightArea {
		float : right;	
	}
	
    #listBtn, #deleteBtn {
    	background: #eb2d2f;
    	color: white;
    	border : none;
    	font-size: 16pt;
    	margin: 5px;
    	padding : 12px 28px;
    }
    
    #editBtn {
    	background: black;
    	color: white;
    	border : none;
    	margin: 5px;
    	font-size: 16pt;
    	padding : 12px 28px;
    }

	.move:hover{
	 	cursor: pointer;
	 	font-weight: bold;
	 	color : navy;
 	}
 	
</style>	

<script type="text/javascript">

	$(document).ready(function(){	
			
		$("#deleteBtn").click(function(){
			
			var bool = confirm("해당 게시글을 삭제하시겠습니까?"); 
		    if(!bool) {
		    	alert("삭제가 취소되었습니다.");
		    }    
		    else {
		
		 		var frm = document.deleteFrm;
		 		frm.method = "GET";
		 		frm.action = "<%= request.getContextPath()%>/deleteEvent.to";
		 		frm.submit();
		    }
		});
		
	});	
</script>

<div id="mainDiv" >
	
	 <div id = "board_nvar" align="right" style = "margin: 40px 220px;">
         <div><i class = "fa fa-home"></i></div>
         <div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">게시판</div>
         <div>이벤트 게시판</div>
      </div>
      <div align="center" id = "board_h2">
         <h2>이벤트</h2>
      </div>
	
	
	<table class="eventTbl">
		<tr>
			<th style="height: 100px; width: 110px;">
				<span id="eventTbl_cat">이벤트&nbsp;&nbsp;<span style="color:#e5e5e5;">|</span></span>
								<%-- 카테고리 분류 --%>
			</th>
			<td>
				<span id="eventTbl_title">${eventBoardInfo.event_title}</span>
			</td>
			<td style="width: 120px;">
				<span id="eventTbl_date">${eventBoardInfo.event_date}</span>
			</td>
			<td style="width: 90px;">
				<span id="eventTbl_date">(<span class="glyphicon glyphicon-eye-open"></span>&nbsp;:&nbsp;${eventBoardInfo.event_view})</span>
			</td>
		</tr>
		
	</table>
		
	<div class="board_contents">
		
		<div id="content" align="center">
			<c:if test="${not empty eventBoardInfo.event_photo}">
			<div><img id="eventPhoto" src="resources/syimages/${eventBoardInfo.event_photo}" /></div>
			</c:if>
			<div style="margin-top:30px;">${eventBoardInfo.event_content}</div>
		</div>
		
	</div>
	
	<div id="viewBtn" >
		<div style="float:left;">
		<div style="margin: 10px 0 4% 0;">▲ 이전글   &nbsp;:&nbsp;
			<c:if test="${eventBoardInfo.nextsubjectE == null}">
				<span>이전 글이 없습니다.</span>
			</c:if>
			
			<c:if test="${eventBoardInfo.nextsubjectE != null}">
			<span class="move" onClick="javascript:location.href='eventBoardDetail.to?event_seq=${eventBoardInfo.nextseqE}'">${eventBoardInfo.nextsubjectE} </span>
			</c:if>
		</div>	
		<div style="margin: 10px 0 4% 0;">▼ 다음글   &nbsp;:&nbsp;
			<c:if test="${eventBoardInfo.previoussubjectE == null}">
				<span>다음 글이 없습니다.</span>
			</c:if>
			
			<c:if test="${eventBoardInfo.previoussubjectE != null}">
				<span class="move" onClick="javascript:location.href='eventBoardDetail.to?event_seq=${eventBoardInfo.previousseqE}'">${eventBoardInfo.previoussubjectE} </span>
			</c:if>
		</div>	
		</div>
		
		<form name="deleteFrm">
			<input type="hidden" name="event_seq" value="${eventBoardInfo.event_seq}"/>
			<input type="hidden"/>
		</form>
		
		<div id="rightArea">
			<c:if test="${sessionScope.loginuser.userno == '8'}">
			<button type="button" class="btns" id="deleteBtn">삭제</button>			
   	   		<button type="button" class="btns" id="editBtn" onclick="javascript:location.href='<%= request.getContextPath() %>/eventBoardEdit.to?event_seq=${eventBoardInfo.event_seq}'">수정</button>
      		</c:if>
      		<button type="button" class="btns" id="listBtn" onclick="javascript:location.href='<%= request.getContextPath() %>/boardmenu.to'">목록</button>   		
      	</div>
	</div>
	
	
      	

		
</div><!-- mainDiv -->
