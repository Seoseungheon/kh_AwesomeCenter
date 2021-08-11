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
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

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
		min-height: 500px;
		width: 75%;
		border-bottom: 1px solid #d7d7d7; 
	}
	
	#content {
    	width: 98%;
    	height: 300px;
    	padding: 8px;
    	margin: 10px 10px;
    	border: solid 1px #ccc;
    }
	
	
	
	#viewBtn {
		width : 75%;
 		margin: 40px 50px 50px 170px;
 		border : 1px solid #d7d7d7;
 		padding : 10px;
 		overflow: hidden;
 		
	}
	
	#rightArea {
		float : right;	
	}
	
    #listBtn, #cancelBtn {
    	background: #eb2d2f;
    	color: white;
    	border : none;
    	font-size: 18pt;
    	margin: 5px;
    	padding : 12px 20px;
    }
    
    #editBtn {
    	background: black;
    	color: white;
    	border : none;
    	margin: 5px;
    	font-size: 18pt;
    	padding : 12px 20px;
    }

	.move:hover{
	 	cursor: pointer;
	 	font-weight: bold;
	 	color : navy;
 	}
 	
</style>	

<script type="text/javascript"> 

	$(document).ready(function(){
		
		//$("#content").val("${eventBoardInfo.event_content}");
		//$("#attach").val("${eventBoardInfo.event_photo}");
		
		/* 스마트 에디터 */
		var obj = []; //전역변수
		
		//스마트에디터 프레임생성
		   nhn.husky.EZCreator.createInIFrame({
		    oAppRef: obj,
		    elPlaceHolder: "content",
		    sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
		    htParams : {
		        // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		        bUseToolbar : true,            
		        // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		        bUseVerticalResizer : true,    
		        // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		        bUseModeChanger : true,
		    }
		});
		
		$("#editBtn").click(function(){
			
			//textarea에 에디터 대입
			  obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); 
			
			  <%-- === 스마트에디터 구현 시작 ================================================================ --%>
				//스마트에디터 사용시 무의미하게 생기는 p태그 제거
		        var contentval = $("#content").val();
			        
		        // === 확인용 ===
		        // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
		        // "<p>&nbsp;</p>" 이라고 나온다.
		        
		        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
		        // 글내용 유효성 검사 (스마트에디터 버전)
		        /* if(contentval == "" || contentval == "<p>&nbsp;</p>") {
		        	alert("강좌 내용을 입력하세요.");
		        	return;
		        } */
		        
		        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
		        contentval = $("#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
		    /*    
		              대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
		        ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
		                     그리고 뒤의 gi는 다음을 의미합니다.

		        	g : 전체 모든 문자열을 변경 global
		        	i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
		    */    
		        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
		        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
		        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
		    
		        $("#content").val(contentval);
			 <%-- === 스마트에디터 구현 끝 =================================================================== --%> 
			 
			 func_update();
			
		});
	});
	
	function func_update(){
	 
		var frm = document.eventBoardEditFrm;
		frm.method = "POST";
		frm.action = "<%= request.getContextPath()%>/eventBoardEditEnd.to";
		frm.submit();
		
		
	}//goUpdate
	
</script>

<div id="mainDiv" >
	
	 <div id = "board_nvar" align="right" style = "margin: 40px 220px;">
         <div><i class = "fa fa-home"></i></div>
         <div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">게시판</div>
         <div>이벤트 게시판</div>
      </div>
      <div align="center" id = "board_h2">
         <h2>이벤트 수정</h2>
      </div>
	
	<form name="eventBoardEditFrm" action="" method="POST" enctype="multipart/form-data"> 
	<table class="eventTbl">
		<tr>
			<th style="height: 100px; width: 110px;">
				<span id="eventTbl_cat">이벤트&nbsp;&nbsp;<span style="color:#e5e5e5;">|</span></span>
								<%-- 카테고리 분류 --%>
			</th>
			<td>
				<span id="eventTbl_title"><input type="text" name="event_title" value="${eventBoardInfo.event_title}"/></span>
			</td>
			<td style="width: 115px;">
				<span id="eventTbl_date">${eventBoardInfo.event_date}</span>
			</td>
			<td style="width: 90px;">
				<span id="eventTbl_date">(<span class="glyphicon glyphicon-eye-open"></span>&nbsp;:&nbsp;${eventBoardInfo.event_view})</span>
			</td>
		</tr>
		<tr>
			<th style="font-size: 11pt;">기존 파일</th>
			<td style="font-size: 11pt;" colspan="4"><input type="text" value="${eventBoardInfo.event_photo}" style="border:none; width:100%;" readonly/></td>
			</tr>
		<tr>
		<tr>
			<th style="font-size: 11pt;">사진 첨부</th>
			<td style="font-size: 11pt;"><input type="file" name="attach" id="attach"/></td>
			</tr>
		<tr>
			<td colspan="4"><textarea maxlength="10000" name="event_content" id="content" >${eventBoardInfo.event_content}</textarea></td>
		</tr>
		
	</table>
	<input type="hidden" name="fk_userno" value="${eventBoardInfo.fk_userno}"/>
	<input type="hidden" name="event_seq" value="${eventBoardInfo.event_seq}"/>
	</form>
	
	
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
		
		<div id="rightArea">
			<button type="button" class="btns" id="cancelBtn" onclick="javascript:history.back();">취소</button>
   	   		<button type="button" class="btns" id="editBtn">저장</button>
      		<button type="button" class="btns" id="listBtn" onclick="javascript:location.href='<%= request.getContextPath() %>/boardmenu2.to'">목록</button>   		
      	</div>
	</div>
	
	
      	

		
</div><!-- mainDiv -->
