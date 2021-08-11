<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	    padding-right: 15px;
	    margin-top: -1px;
	    width: 100px;
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
	
	.btnArea_kdh > a {
    	margin-left: 10px;
	}
	
	.btn_kdh {
	    display: inline-block;
	    color: #fff;
	    text-align: center;
	    vertical-align: middle;
	    padding: 0 10px;
	    height: 30px;
	    line-height: 30px;
	    font-size: 13px;
	    min-width: 55px;
	}
	
	
	.btnBlue_kdh {
	    background: #0093c0;
	}
	
	.btnBlack_kdh {
	    background: #000;
	}
	
	.btnRed_kdh {
	    background: #eb2d2f;
	}
	
	.btnWhite_kdh {
	    background: #fff;
	    border: 1px solid #aaa;
	    color: #222;
	}
	
	.btnType01_kdh {
	    padding: 0 10px;
	    height: 30px;
	    line-height: 30px;
	    font-size: 13px;
	    min-width: 55px;
	}
	
	.btnType02_kdh {
	    height: 66px;
	    line-height: 66px;
	    font-size: 20px;
	    min-width: 120px;
	}
	
	.btnType03_kdh {
	    height: 50px;
	    line-height: 50px;
	    font-size: 16px;
	}

	.atag:link, .atag:visited, .atag:hover, .atag:active, .atag:focus {
	    text-decoration: none;
	}
	
	.btnArea_kdh {
	    overflow: hidden;
	    text-align: center;
	    font-size: 0;
	    width: 75%;
	    margin: 0 auto;
	    margin-top: 10px;
	    margin-bottom: 30px;
	}
	
	.btnArea_kdh .leftArea_kdh {
	    float: left;
	}
	
	.btnArea_kdh .rightArea_kdh {
	    float: right;
	}
	
	.btnArea_kdh .leftArea_kdh a:first-child {
	    margin-left: 0;
	}
	
	.btnArea_kdh .rightArea_kdh a {
	    margin-left: 10px;
	}
	
	.rightArea_kdh .btn_kdh {
		color: #fff;
	}
	
	.btnType02_kdh {
		width: 60px;
	}

</style>	

<script type="text/javascript">
$(document).ready(function(){
	$("#dDelete").click(function(){
		 if (confirm("글을 삭제 하시겠습니까?") == true){    
			 location.href = "<%= ctxPath%>/delHopeBoard.to?no=${hvo.no}";
		 }else{   
		     return false;
		 }
	});
});
</script>
<div id="board_body" >
	<div id="board_div">
		 <div id = "board_nvar" align="right" style = "margin: 40px 220px;">
	         <div><i class = "fa fa-home"></i></div>
	         <div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">게시판</div>
	         <div>개설희망 게시판</div>
	      </div>
	      <div align="center" id = "board_h2">
	         <h2>개설희망</h2>
	      </div>
		
		
		<table class="boardTbl">
			<tr>
				<th style="height: 100px; width: 110px;">
					<span id="boardTbl_cat">개설희망&nbsp;&nbsp;<span style="color:#e5e5e5;">|</span></span>
									<%-- 카테고리 분류 --%>
				</th>
				<td>
					<span id="boardTbl_title">${hvo.title}</span>
				</td>
				<td style="width: 150px;">
					<span id="boardTbl_date">${hvo.writeday}</span>
				</td>
			</tr>
			
		</table>
			
		<div class="board_contents">
			<div id="content">
				${hvo.content}
			</div>
		</div>
		
		<div class="btnArea_kdh">
			<div class="leftArea_kdh">
				<a href="<%= ctxPath%>/boardmenu3.to" class="btn_kdh btnType02_kdh btnWhite_kdh atag"><span>목록</span></a>
			</div>
			<c:if test="${sessionScope.loginuser.username == hvo.username}">
				<div class="rightArea_kdh">
					<a href="<%= ctxPath%>/editHopeBoard.to?no=${hvo.no}" id="dUpdate" class="btn_kdh btnType02_kdh btnBlack_kdh atag"><span>수정</span></a>
					<a href="#" id="dDelete" class="btn_kdh btnType02_kdh btnRed_kdh atag"><span>삭제</span></a>
				</div>
			</c:if>
		</div>
	</div>
</div>
