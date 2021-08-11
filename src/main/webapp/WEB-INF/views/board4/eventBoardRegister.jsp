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
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<style type="text/css">

   @import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
   @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

   #event_body {
      font-family: "Noto Sans Kr", Nanum Gothic, "나눔고딕", sans-serif;
   }

   #event_container {
      width : 70%;
      margin : 0 auto;
   }
   
   #event_nvar div {    
      display: inline-block;
      font-size: 14px;
      margin: 2px 12px 0;
      color : #666;
      font-weight: 400;
   }

   #event_h2 h2 {
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
   
   #event_div {
   	  margin: 50px 0;
   }
   
   #event_table {
      width : 90%;
      margin: 0 auto;
      border-top: 1px solid black;
      border-bottom: 1px solid #cccccc;
   }
   
   #event_table th {
  	 background-color: #f4f4f4; 
  	 width : 200px;
  	 height: 66px;
  	 vertical-align: middle !important;
  	 text-align: center !important;  
	 font-weight: bold;
	 padding: 15px 30px;
   } 
   
    #event_table td {
  	 width : 400px;  
  	 padding : 11px 5px 10px 5px;	
  	
   } 
   
    #event_table td input[type="text"] {
    	border: solid 1px #ccc;
    	font-size: 15px;
    	width:95%; 
    	height: 44px; 
    	margin:7px;" 
    	padding: 0 30px;
    }
    
    #eventCategory {
    	padding: 8px;
    	margin: 7px;
    	border: solid 1px #ccc;
    	width: 90%;
    	height: 48px;
    }
    
    #content {
    	width: 95%;
    	height: 500px;
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

<script type="text/javascript">

	$(document).ready(function(){
		
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
		
		$("#registerBtn").click(function(){
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
			 
			 func_register();
		});
		
		
		
	});

	function goCancel(){
	    var bool = confirm("게시글 작성을 취소하시겠습니까?"); 
	    if(bool) {
	    	alert("게시글 작성이 취소 되었습니다.");
	    	location.href='<%= request.getContextPath() %>/boardmenu.to';
	    }   
	    else {
	    	return;
	    }
	} 
	
	function func_register(){
	    var bool = confirm("게시글을 등록하시겠습니까?"); 
	    if(!bool) {
	    	alert("게시글이 등록이 취소되었습니다.");
	    }    
	    else {
	    		
	    	var frm = document.eventFrm;
	    	frm.method = "POST";
	    	frm.action = "<%= request.getContextPath()%>/eventBoardRegisterEnd.to";
	    	frm.submit();
	    }
	} 


</script>

</head>
<body id = "event_body">
   
   <div id = "event_container" >
      
      <div id = "event_nvar" align="right" style = "margin: 40px 70px 0 0;">   
	         <div style = "border-right: 1px solid #e5e5e5; padding : 0 12px; margin : 0;" ><i class="fa fa-lock" style="font-size:15px; padding:2px 6px 0 0;"></i>관리자 전용 메뉴</div>
	         <div>관리자 전용 메뉴</div>
      	</div>
      	
		<div align="center" id="event_h2">
			<h2>이벤트 등록</h2>
		</div>
     
      <div id = "event_div">
      	<form name="eventFrm"  enctype="multipart/form-data"> 
         <table class="table" id="event_table">
               <tr>
                  <th>제목</th>    
                  <td colspan="3"><input type="text" name="event_title"/></td>     
               </tr>
               <tr>      
                  <th>유형</th>
                  <td style="vertical-align: middle; padding-left:15px;">이벤트</td>
                  <th>지점</th>
                  <td style="padding-left:15px; vertical-align: middle;">본점</td>
               </tr>
               <tr>      
                  <th>첨부파일</th>
                  <td colspan="3">
					  <input type="file" name="attach" id="addFile" style="vertical-align: middle; margin:9px 0 1px 10px;"/> 
				 </td>
               </tr>   
                <tr >       
                  <th>내용</th>
                  <td colspan="3">
                  	<textarea maxlength="1000" name="event_content" id="content" ></textarea>
                  </td>
               </tr>        
         </table>
         <input type="hidden" name="fk_userno" value="${eventvo.fk_userno}"/>
       
         </form>
      </div>
      
      <div id="btnArea">
      	<div id="leftArea">
      		<button type="button" class="btns" id="listBtn" onclick="javascript:location.href='<%= request.getContextPath() %>/boardmenu.to'">목록</button>
      	</div>
      	<div id="rightArea">
      		<button type="button" class="btns" id="resetBtn" onclick="goCancel();">취소</button>
      		<button type="button" class="btns" id="registerBtn">등록</button>
      	</div>
      </div>
      
   </div>
   
</body>
</html>