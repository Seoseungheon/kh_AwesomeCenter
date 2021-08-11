<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reviewEdit.css" />

<script type="text/javascript" src="<%= ctxPath %>/resources/smarteditor/js/HuskyEZCreator.js"></script>

<script type="text/javascript">

	$(function() {
		
		//전역변수
	    var obj = [];
		
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
	        sSkinURI: "<%= ctxPath %>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	            
	        	}

	    	
	    });

	    
		$(".hide").hide();
		
	//	var teacher_name = $("#teacher_name").siblings("td").child("select").child("input").val();
		
		$("#class_name").change(function() {
			
			if($(this).val() == ''){
				
				 $("#teacher_name").text("");
				return;
				
			}
			else{

				 var index = $('#class_name option').index($('#class_name option:selected'));
				 var teacher_name =	$("#class_name option:eq("+(index+1)+")").val();
				 
				 
				 $("#teacher_name").text(teacher_name);
				console.log("val : "+teacher_name);
				
			}
			
			
		}); // 카테고리 검사
		
		
		$("#registerBtn").click(function() {
			
			/* 		=== 스마트 에디터 구현 시작 === */
	        //id가 content인 textarea에 에디터에서 대입
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			/* 	        === 스마트 에디터 구현 끝 === */
			
			
			// 글제목 유효성 검사
			var subjectval = $("#subject").val().trim();
			if(subjectval == "") {
				alert("글제목을 입력하세요!!");
				return;
			}
			
		/* 	=== 스마트에디터 구현 시작 === */
			//스마트에디터 사용시 무의미하게 생기는 p태그 제거
	        var contentval = $("#content").val();
		        
	        // === 확인용 ===
	        // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
	        // "<p>&nbsp;</p>" 이라고 나온다.
	        
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
	        // 글내용 유효성 검사 
	        if(contentval == "" || contentval == "<p>&nbsp;</p>") {
	        	alert("글내용을 입력하세요!!");
	        	return;
	        }
	        
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
		     // alert(contentval);
			/*  === 스마트에디터 구현 끝 === */

			
			var frm = document.reviewFrm;
			
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/reviewEditEnd.to";
			frm.submit();
			
			
		});// end of $("#registerBtn").click(function()
				
				
				
	});
	

</script>

</head>
<body id = "question_body">
   
   <div id = "question_container" >
      
      <div id = "question_nvar" align="right" style = "margin: 40px 50px;">
      <!--    <div><i class = "fa fa-home"></i></div>
         <div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 4px 10px 0 0; float:right;">커뮤니티</div>
         <div>수강후기</div>
          -->
         	<div>
				<a href = "<%=ctxPath%>/main.to"><img src = "<%=ctxPath%>/resources/images/Home.png" ></a>
			</div>
			<div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">
				<a href = "javascript:history.go(0);">커뮤니티</a>
			</div>
			<div>
				<a href = "javascript:history.go(0);">수강후기</a>
			</div>
      </div>
      <div align="center" id = "question_h2">
         <h2>수강후기</h2>
      </div>
 
      <div id = "question_div">
      	<form name="reviewFrm" enctype="multipart/form-data"> 
         <input type="hidden" name = "reviewno" value="${ rvo.reviewno }" />
         <table class="table" id="question_table">
               <tr>      
                  <th>수강강좌</th>
                  <td style = "padding: 3.3%;">${ rvo.class_title }</td>
                  <th>강사명</th>
                  <td style="padding-left:15px; vertical-align: middle;" id = "teacher_name">${ rvo.teacher_name }</td>
               </tr>
               
               <tr>
                  <th>제목</th>    
                  <td colspan="3"><input type="text" name = "subject" id = "subject" value = "${ rvo.subject }" style = "padding-left: 8px;"/></td>     
               </tr>
               
                <tr >       
                  <th>내용</th>
                  <td colspan="3"  style = "padding-left: 19px;">
                  	<textarea maxlength="1000" name="content" id="content" placeholder="자유롭게 회원님의 수강후기를 작성해주세요!">${ rvo.content }</textarea>
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
      		<button type="button" class="btns" id="resetBtn" onclick = "location.href='<%= ctxPath %>/reviewDetail.to?reviewno=${ rvo.reviewno }'">취소</button>
      		<button type="button" class="btns" id="registerBtn">등록</button>
      	</div>
      </div>
      
   </div>
   
</body>
</html>