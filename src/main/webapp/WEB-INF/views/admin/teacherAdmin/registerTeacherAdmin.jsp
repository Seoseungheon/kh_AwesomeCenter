<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 등록하기</title>
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
    .tblTop {
   		margin: 40px 0 0 5px;
	 	text-align: left;
   }

   .tblTop > h5 {
   		font-weight: bold;
   }
   
  #line {
   	  border: dashed  1px #bfbfbf;
   	  width : 70%;
   	  margin-top: 30px;
   }
   
   .radioText {
   		font-weight: normal;
   		margin-right: 20px; 
   }
   
   .radioInput {
   		position: relative;
   		top: 3px;
   		left : -15px;
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
  
  .addrInput {
  	margin-right:7px;
  	border: hidden;
  	border-bottom: solid 1px #d9d9d9 !important;
  }
   
   .t_categorySelect {
    	padding : 4px;
   		margin: 2px 8px 2px 2px;
   }
   
   .regBtn {
   		width : 140px;
   		height : 50px;
   		background-color: #5e4122;
   		color: white;
   		font-size: 19px;
   		margin: 60px 10px;
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
	       	$('#fk_cate_no').find('[value=7]').hide();
	       	$('#fk_cate_no').find('[value=8]').hide();
	       	$('#fk_cate_no').find('[value=9]').hide();
	       }
	       else if ($('#searchCode option:selected').val() !='adult'){
	       	$('#fk_cate_no').find('[value=7]').show();
	       	$('#fk_cate_no').find('[value=8]').show();
	       	$('#fk_cate_no').find('[value=9]').show();
	       }
	       
	      if ($('#searchCode option:selected').val() =='child'){
	       	$('#fk_cate_no').find('[value=1]').hide();
	       	$('#fk_cate_no').find('[value=2]').hide();
	       	$('#fk_cate_no').find('[value=3]').hide();
	       	$('#fk_cate_no').find('[value=4]').hide();
	       	$('#fk_cate_no').find('[value=5]').hide();
	       	$('#fk_cate_no').find('[value=6]').hide();  	        	
	       }
	       else if ($('#searchCode option:selected').val() !='child'){
	       	$('#fk_cate_no').find('[value=1]').show();
	       	$('#fk_cate_no').find('[value=2]').show();
	       	$('#fk_cate_no').find('[value=3]').show();
	       	$('#fk_cate_no').find('[value=4]').show();
	       	$('#fk_cate_no').find('[value=5]').show();
	       	$('#fk_cate_no').find('[value=6]').show();  
	       }
	      });//searchCode---
	      
	      
	      /* 유효성 검사 */	  
	      $("input:text[name=teacher_name]").blur(function(){
			 var regExp = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; 	
			 var regExp2 = /[a-zA-Z]/; 	
			 var bool = regExp.test($(this).val());
			 var bool2 = regExp2.test($(this).val());
			 
			 if(!bool && !bool2){
				 $(".error_name").css('display', '');
				 $(this).val("");
				 $(this).focus();
			 }
			 else {
				 $(".error_name").css('display', 'none');				
			 }
		 });
	      
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
	      
			 
		 $("input:text[name=teacher_jubun]").blur(function(){
			 var regExp = /[0-9]/;
			 var bool = regExp.test($(this).val());
			 
			 if(!bool){
				 $(".error_jubun").css('display', '');
				 $(this).val("");
				 $(this).focus();
			 }
			 else {
				 $(".error_jubun").css('display', 'none');				
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
	 
	 
	});//$(document).ready(function(){	}---

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
	
	function goRegister(){	
		
		var require = $(".require").val().trim();
		if(require == "" || require == null) {
			alert("강사 정보를 모두 입력해야 등록이 가능합니다.");
			return;
		} 
		
		var frm = document.registerTeacherFrm;
		frm.method = "POST";
		frm.action = "<%= request.getContextPath()%>/registerEndTeacherAdmin.to";
		frm.submit();
	}

</script>
</head>
<body id="admin_body">
	<div id="container">
		<div id = "admin_nvar" align="right" style = "margin: 40px 250px 0 0;">   
	         <div style = "border-right: 1px solid #e5e5e5; padding : 0 12px; margin : 0;" ><i class="fa fa-lock" style="font-size:15px; padding:2px 6px 0 0;"></i>관리자 전용 메뉴</div>
	         <div>신규 강사 등록</div>
      	</div>
      	
		<div align="center" id="admin_h2">
			<h2>신규 강사 등록</h2>
		</div>

		<hr id="line" />

		<div id="main_container">
		<form name="registerTeacherFrm" action="" method="POST" enctype="multipart/form-data">
			<div id="infoDiv1" class="infoDivClass" style="margin-top: 30px;">
				<div id="infoDiv1_tbl">
					<div class="tblTop" style="margin-top: 0;">
						<h5>기본 정보</h5>
					</div>
				
					<table class="table table-bordered teacherInfo" id="teacherInfo1">
						<tr>
							<th>성명</th>
							<td><input type="text" name="teacher_name" class="require"/><span class="error error_name" >※문자만 입력 가능</span></td>
							<th>이메일</th>
							<td><input type="text" name="teacher_email" class="require"/><span class="error error_email">※이메일 형식에 맞게 입력</span></td>
						</tr>
						<tr>
							<th>주민등록번호</th>
							<td><input type="text" name="teacher_jubun" class="require"/><span class="error error_jubun">※주민번호 형식에 맞게 숫자 입력</span></td>
							<th>연락처1</th>
							<td><input type="text" name="teacher_phone1" class="require"/><span class="error error_phone1">※전화번호 형식에 맞게 입력</span></td>
						</tr>
						<tr>
							<th>성별</th>
							<td>					
								<label for="man" class="radioText">남자</label><input type="radio" name="teacher_gender" value="1" id="man" class="radioInput" required/>
								<label for="woman" class="radioText">여자</label><input type="radio" name="teacher_gender" value="2" id="woman" class="radioInput"/>
							</td>
							<th>연락처2</th>
							<td><input type="text" name="teacher_phone2"/></td>
						</tr>
						<tr>
							<th>우편번호</th>
							<td colspan="3">
								<input type="text" class="addrInput require" name="teacher_postcode" id="teacher_postcode"/>
								<button type="button" onclick="goSearchPostCode();" id="postCodeBtn"><span id="postCodeSpan">검색</span></button>
							</td>
						</tr>
						<tr>
							<th>자택주소</th>
							<td colspan="3"><input type="text" name="teacher_addr1" id="teacher_addr1" class="addrInput require"/><input type="text" name="teacher_addr2" id="teacher_addr2" class="addrInput"/></td>
						</tr>
						<tr>
							<th>사진첨부</th>
							<td colspan="3"><input type="file" name="attach"/></td>
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
							<select class="t_categorySelect" name="searchCode" id="searchCode" required>
									<option value="">1차 분류 선택</option>
									<option value="adult">성인</option>
									<option value="child">아동</option>			
							</select>
							
							<select class="t_categorySelect" name="fk_cate_no" id="fk_cate_no" required>
									<option value="">2차 분류 선택</option>
									<option value="1">건강/댄스</option>
									<option value="2">아트/플라워</option>
									<option value="3">음악/아트</option>
									<option value="4">쿠킹/레시피</option>
									<option value="5">출산/육아</option>
									<option value="6">어학/교양</option>
															
									<option value="7">창의/체험</option>
									<option value="8">음악/미술/건강</option>	
									<option value="9">교육/오감발달</option>		
							</select>
					 </td>
					</tr>
					<!-- <tr>
						<th>입사일자</th>
						<td><input type="text" name="teachere_registerday"/></td>
					</tr> -->
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
						<td><input type="text" name="teacher_shcool" class="require"/></td>
					</tr>
					<tr>
						<th style="text-align: center;">전공</th>
						<td><input type="text" name="teacher_major" class="require"/></td>
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
						<td style="vertical-align: middle;"><input type="text" name="teacher_career1" class="require"/></td>
					</tr>
					<tr>
						<th style="text-align: center; height:60px;">근무처</th>
						<td style="vertical-align: middle;"><input type="text" name="teacher_career2"/></td>
					</tr>
				</table>
			</div>
			<!-- infoDiv4 -->

			<!-- <div>
				<iframe src="//www.career.go.kr/cnet/iframe/School.do?apiKey=20015e80de6e27e43a7a456aaa9851b8&gubun=univ_list" scrolling="no" name="ce" width="1000" height="1080" frameborder="0" style="border-width:0px;border-color:white; border-style:solid;"> </iframe>
			</div>  -->

			<div align="center">
				<button type="button" class="btn regBtn" id="registerBtn" onclick="goRegister();">등록</button>
				<button type="button" class="btn regBtn" id="resetBtn" onclick="javascript:location.href='<%= request.getContextPath() %>/teacherListAdmin.to'">취소</button>
			</div>
			
		<!-- 	<input type="hidden" name="T_fileName"/>
			<input type="hidden" name="T_fileSize"/> -->
		</form>
		</div> <!-- main_container -->
	</div> <!-- container -->
</body>
</html>