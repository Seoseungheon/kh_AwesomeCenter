<%@page import="org.springframework.web.context.annotation.RequestScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강사 정보 수정하기</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

  
<style type="text/css">

@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

   #admin_body {
      font-family: "Noto Sans Kr", Nanum Gothic, "나눔고딕", sans-serif;
      
   }
   
   #admin_h2 h2 {
     font-weight: 500;
      font-size: 52px;
      margin-top: 50px;
      margin-bottom : 40px;
      letter-spacing: -3px;
      font-family: "Noto Sans Kr";
   }
   
   #admin_nvar div {    
      display: inline-block;
      font-size: 14px;
      margin: 2px 12px 0;
      color : #666;
      font-weight: 400;
   }
   
   #container {
   		width:95%;
   		margin: 0 auto;
   		font-size: 10pt;
   }
   
   #main_container{
   		width : 70%;
   		margin: 0 auto;
   }
   
   #line {
   	  border: dashed 1px #bfbfbf;
   	   width : 70%;
   	  margin-top: 30px;
   }
   
   
   .tblTop {
   		margin: 40px 0 0 5px;
	 	text-align: left;
   }

   .tblTop > h5 {
   		font-weight: bold;
   }

   .infoDivClass {
  		 overflow: hidden;
   }
   
  .teacherInfo th {
  	 background-color: #f9f2eb;
  	 width : 110px;
  	 padding: 4px;
  	 vertical-align: middle !important;
  }
  
   .teacherInfo td { 	
  	 width : 300px; 	
  }
  
  .teacherInfo input{
  	border: none;
  	border-bottom : 1px solid #d9d9d9;
  	width : 250px;
  }
  
  #postCodeBtn{
  	height: 23px;
  	width: 45px;
  	font-size: 8pt;
  	text-align: center;
  	vertical-align: middle;
  }
  
  #postCodeSpan {
  	font-size: 8pt;
  	text-align: center;
  	vertical-align: middle;
  }
  
  #postcode {
  	width:100px;
  }
  
  .addrInput {
  	margin-right:7px;
  	border: hidden;
  	border-bottom: solid 1px #d9d9d9 !important;
  }
   
   .t_categorySelect {
    	padding : 4px;
   		margin: 2px 8px 2px 2px;
   }
   
   .statusCheck {
		margin: 8px 5px 4px -20px;
		width : 20px !important;
	}
   
   #teacherInfo5 th{
   		text-align: center;
   }
   
   #registerBtn, #resetBtn {
   		width : 140px;
   		height : 50px;
   		background-color: #5e4122;
   		color: white;
   		font-size: 19px;
   		margin: 60px 0;
   }
   
    .error {
   		padding-left:5px;
   		color:#990000;
   		font-size:11px;
   		font-weight: bold;
   }
   
   input[type=text] {
   		border:none;
   }
   
  
</style>


<script type="text/javascript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> <!--다음 우편번호 -->

<script type="text/javascript">

	$(document).ready(function(){
		
		$(".error").css('display','none');
		
		 /* 성인/아동별 옵션 show,hide */
		$('#searchCode').change(function(){

	        if( $('#searchCode option:selected').val() =='adult' ){
	        	$('#searchName').find('[value=7]').hide();
	        	$('#searchName').find('[value=8]').hide();
	        	$('#searchName').find('[value=9]').hide();
	        }
	        else if ($('#searchCode option:selected').val() !='adult'){
	        	$('#searchName').find('[value=7]').show();
	        	$('#searchName').find('[value=8]').show();
	        	$('#searchName').find('[value=9]').show();
	        }
	        
	       if ($('#searchCode option:selected').val() =='child'){
	        	$('#searchName').find('[value=1]').hide();
	        	$('#searchName').find('[value=2]').hide();
	        	$('#searchName').find('[value=3]').hide();
	        	$('#searchName').find('[value=4]').hide();
	        	$('#searchName').find('[value=5]').hide();
	        	$('#searchName').find('[value=6]').hide();  	        	
	        }
	        else if ($('#searchCode option:selected').val() !='child'){
	        	$('#searchName').find('[value=1]').show();
	        	$('#searchName').find('[value=2]').show();
	        	$('#searchName').find('[value=3]').show();
	        	$('#searchName').find('[value=4]').show();
	        	$('#searchName').find('[value=5]').show();
	        	$('#searchName').find('[value=6]').show();  
	        }
	       
	    
		var searchCode = $("#searchCode").val();
		
		if(searchCode == ['7','8','9'] ){
			$("#searchName").val('child');
		} else {
			$("#searchName").val('adult');
		}
		
		});
		 
		 
		 /* 유효성 검사 */	  	      
		 $("input:text[name=teacher_email]").blur(function(){
			 var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			 var bool = regExp.test($(this).val());
			 
			 if(!bool){
				 $(".error_email").css('display', '');
				 $(this).val("");
				 $(this).focus();
			 }
			 else {
				 $(".error_email").css('display', 'none');				
			 }
		 });	      
			 
		 
		 $("input:text[name=teacher_phone1]").blur(function(){
			 var regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
			 var bool = regExp.test($(this).val());
			 
			 if(!bool){
				 $(".error_phone1").css('display', '');
				 $(this).val("");
				 $(this).focus();
			 }
			 else {
				 $(".error_phone1").css('display', 'none');				
			 }
		 });		
		 /* 유효성 검사 끝*/	  
	});

	//우편번호 찾기 버튼
	function goSearchPostCode(){
		new daum.Postcode({
		oncomplete: function(data) {
			 // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                } 
            } 
            
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("teacher_postcode").value = data.zonecode;
            document.getElementById("teacher_addr1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("teacher_addr2").focus();
			    
		}
	}).open();
	}//goSearchPostCode------------
	
	
	function goUpdate(){
		
		var require = $(".require").val().trim();
		if(require == "" || require == null) {
			alert("강사 정보를 모두 입력해야 등록이 가능합니다.");
			return;
		} 
		
		var frm = document.editTeacherInfo;
		frm.method = "POST";
		frm.searchName.value = $("#searchName option:selected").val();
		frm.action = "<%= request.getContextPath()%>/editEndTeacherAdmin.to";
		frm.submit();
	}// goUpdate
	

</script>
</head>
<body id="admin_body">
	<div id="container">
		<div id = "admin_nvar" align="right" style = "margin: 40px 250px 0 0;">   
	         <div style = "border-right: 1px solid #e5e5e5; padding : 0 12px; margin : 0;" ><i class="fa fa-lock" style="font-size:15px; padding:2px 6px 0 0;"></i>관리자 전용 메뉴</div>
	         <div>강사 정보 수정</div>
      	</div>
      	
		<div align="center" id="admin_h2">
			<h2>강사 정보 수정</h2>
		</div>

		<hr id="line" />

		<div id="main_container">
			<form name="editTeacherInfo" action="" method="POST" enctype="multipart/form-data"> 
			<div id="infoDiv1" class="infoDivClass"  style="margin-top: 30px;">
				<div id="infoDiv1_tbl">
					<div class="tblTop" style="margin-top: 0;">
						<h5>기본 정보</h5>
					</div>

					
					<table class="table table-bordered teacherInfo" id="teacherInfo1">
						<tr>
							<th>성명</th>
							<td style="width:400px;">${teacherInfo.teacher_name}</td>
							<th>이메일</th>
							<td><input type="text" class="require" name="teacher_email" value="${teacherInfo.teacher_email}"/><span class="error error_email">※이메일 형식에 맞게 입력</span></td>
						</tr>
						<tr>
							<th>주민등록번호</th>
							<td>${teacherInfo.teacher_jubun}</td>
							<th>연락처1</th>
							<td><input type="text" class="require" name="teacher_phone1" value="${teacherInfo.teacher_phone1}"/><span class="error error_phone1">※전화번호 형식에 맞게 입력</span></td>
						</tr>
						<tr>
							<th>성별</th>
							<td>${teacherInfo.teacher_gender}</td>
							<th>연락처2</th>
							<td><input type="text" name="teacher_phone2" value="${teacherInfo.teacher_phone2}"/><span class="error error_phone2">※전화번호 형식에 맞게 입력</span></td>
						</tr>
						<tr>
							<th>우편번호</th>
							<td colspan="3"><input type="text" class="addrInput require" name="teacher_postcode" id="teacher_postcode" value="${teacherInfo.teacher_postcode}"/>
											<button type="button" onclick="goSearchPostCode();" id="postCodeBtn"><span id="postCodeSpan">검색</span></button>
							</td>
						</tr>
						<tr>
							<th>자택주소</th>
							<td colspan="3">
								<input type="text" name="teacher_addr1" id="teacher_addr1" class="addrInput require" value="${teacherInfo.teacher_addr1}"/><br/>
								<input type="text" name="teacher_addr2" id="teacher_addr2" class="addrInput require" value="${teacherInfo.teacher_addr2}"/>
							</td>
						</tr>
						
						<c:if test="${not empty teacherInfo.teafileName}">
						<tr>
							<th>기존 첨부 사진</th>
							<td colspan="3">			
								${teacherInfo.teaorgFilename}&nbsp;<img src="<%= request.getContextPath() %>/resources/syimages/${teacherInfo.teafileName}" width="30px;"/>
							</td>
						</tr>
						</c:if>

						<tr>
							<th>사진 첨부</th>
							<td colspan="3">			
								<input type="file" name="attach"/>
							</td>
						</tr>
					</table>

				</div>
				<!-- infoDiv1_tbl -->
			</div>
			<!-- infoDiv1 -->

			<div id="infoDiv2" class="infoDivClass">
				<div class="tblTop">
					<h5>구분</h5>
				</div>

				<table class="table table-bordered teacherInfo" id="teacherInfo2">
					<tr>
						<th style="text-align: center;">담당 분야</th>
						<td>
							<select class="a_categorySelect" name="searchCode" id="searchCode">
								<option value="">1차 카테고리</option>
								<option value="adult" <c:if test="${(teacherInfo.fk_cate_no != 7) or (teacherInfo.fk_cate_no != 8) or (teacherInfo.fk_cate_no != 9)}">selected</c:if>>성인</option>
								<option value="child" <c:if test="${(teacherInfo.fk_cate_no eq 7) or (teacherInfo.fk_cate_no eq 8) or (teacherInfo.fk_cate_no eq 9)}">selected</c:if>>아동</option>		
							</select>
							<select class="a_categorySelect" name="fk_cate_no" id="searchName">
									<option value="">2차 카테고리</option>					
									<option value="1" <c:if test="${teacherInfo.fk_cate_no eq 1}">selected</c:if>>건강/댄스</option>
									<option value="2" <c:if test="${teacherInfo.fk_cate_no eq 2}">selected</c:if>>아트/플라워</option>
									<option value="3" <c:if test="${teacherInfo.fk_cate_no eq 3}">selected</c:if>>음악/아트</option>
									<option value="4" <c:if test="${teacherInfo.fk_cate_no eq 4}">selected</c:if>>쿠킹/레시피</option>
									<option value="5" <c:if test="${teacherInfo.fk_cate_no eq 5}">selected</c:if>>출산/육아</option>
									<option value="6" <c:if test="${teacherInfo.fk_cate_no eq 6}">selected</c:if>>어학/교양</option>
															
									<option value="7" <c:if test="${teacherInfo.fk_cate_no eq 7}">selected</c:if>>창의/체험</option>
									<option value="8" <c:if test="${teacherInfo.fk_cate_no eq 8}">selected</c:if>>음악/미술/건강</option>	
									<option value="9" <c:if test="${teacherInfo.fk_cate_no eq 9}">selected</c:if>>교육/오감발달</option>		
							</select>
					 </td>
					</tr>
				</table>
			</div>
			<!-- infoDiv2 -->

			<div id="infoDiv3" class="infoDivClass">
				<div class="tblTop">
					<h5>학력 사항</h5>
				</div>

				<table class="table table-bordered teacherInfo" id="teacherInfo3">
					<tr>
						<th style="text-align: center;">학교명</th>
						<td><input type="text" name="teacher_shcool" class="require" value="${teacherInfo.teacher_shcool}"/></td>
					</tr>
					<tr>
						<th style="text-align: center;">전공</th>
						<td><input type="text" name="teacher_major" class="require" value="${teacherInfo.teacher_major}"/></td>
					</tr>
				</table>
			</div>
			<!-- infoDiv3 -->

			<div id="infoDiv4" class="infoDivClass">
				<div class="tblTop">
					<h5>경력 사항</h5>
				</div>

				<table class="table table-bordered teacherInfo" id="teacherInfo4">
					<tr>
						<th style="text-align: center; height:60px;">근무처</th>
						<td style="vertical-align: middle;"><input type="text" name="teacher_career1" class="require" value="${teacherInfo.teacher_career1}"/></td>
					</tr>
					<tr>
						<th style="text-align: center; height:60px;">근무처</th>
						<td style="vertical-align: middle;"><input type="text" name="teacher_career2" class="require" value="${teacherInfo.teacher_career2}"/></td>
					</tr>
				</table>
			</div>
			<!-- infoDiv4 -->
			
			<div id="infoDiv5" class="infoDivClass">
				<div class="tblTop">
					<h5>고용 상태</h5>
				</div>

				<table class="table table-bordered teacherInfo" id="teacherInfo5">
					<tr>
						<th style="text-align: center;">고용 상태</th>
						<td style="padding:6px 2px; vertical-align: middle;">
							<label class="checkbox-inline"><input type="radio" value="1" class="statusCheck" name="teacher_status" <c:if test="${teacherInfo.teacher_status eq '재직'}">checked</c:if>/>재직</label>
							<label class="checkbox-inline"><input type="radio" value="2" class="statusCheck" name="teacher_status" <c:if test="${teacherInfo.teacher_status eq '휴직'}">checked</c:if>/>휴직</label>
							<label class="checkbox-inline"><input type="radio" value="0" class="statusCheck" name="teacher_status" <c:if test="${teacherInfo.teacher_status eq '퇴사'}">checked</c:if>/>퇴사</label>
						 </td>		 
					</tr>
					<tr id="reason">
						<th>사유</th>
						<td style="padding-left:10px;"><input type="text" name="teacher_reason" value="${teacherInfo.teacher_reason}"/></td>
					</tr>
				</table>
			</div>
			<!-- infoDiv5 -->
			
			
			<div align="center">				
				<button type="button" class="btn" id="resetBtn" onclick="javascript:location.href='<%= request.getContextPath() %>/detailTeacherAdmin.to?teacher_seq=${teacherInfo.teacher_seq}'">취소</button>
				<button type="button" class="btn" id="registerBtn" onclick="goUpdate();">저장</button>
			</div>
			
			<input type="hidden" name="teacher_seq" value="${teacherInfo.teacher_seq}"/>
		</form>
		</div> <!-- main_container -->
	</div> <!-- container -->
</body>
</html>