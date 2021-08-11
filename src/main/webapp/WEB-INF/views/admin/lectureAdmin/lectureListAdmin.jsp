<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 강좌 리스트</title>
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
      margin-bottom: 20px;
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
   		width : 90%;
   		margin: 0 auto;
   }
   

   #admin_div {
   		margin : 60px 60px 60px 60px;
   }
   
   #admin_divOption {
   		margin: 7px 3px 7px 0;
   }
   
   .a_categorySelect {
   		height: 25px;
   		margin: 3px 3px 3px 0;
   }
   
   #cate_name {
   		width: 180px;
   		margin: -3px 5px 3px 3px;
   }
   
    #searchNameBtn, #resetNameBtn, #adminBtn {
   		background : #666666;
   		color:white;
   		font-size: 9pt;
   		padding: 6px 10px;
   		margin:2px 0 3px 5px;
   }
   
   #lectureListTbl {
   	  border-top: solid 1px #404040;
   	  border-bottom: solid 1px #404040;
   }
   
   #lectureListTbl th {
   		height : 45px;
   	    background-color: #e6e6e6;
   	    color : #404040;
   		vertical-align: middle;
   		text-align: center;
   			
   }
   
   #lectureListTbl td { 		
   		vertical-align: middle;
   		text-align: center;
   			
   }
   
  #Area { 	 		
  	 margin:50px 0 120px 0; 
  }
  
  #rightArea {
  	float:right;
  	position: relative;
  	top:-60px;
  	left:-40px;
  }
  
  .regBtn {
  	background-color: #4d4d4d;
  	color: white;
   	border : none;
   	font-size: 12pt;   	
   	padding : 11px 25px;	
   	position: relative;
   	top:5px;
   	right:60px;	
  }
  
  .adminBtn {
  	font-size: 10pt;
  	background-color: #262626;
  	color : white;
  	padding: 3px 6px;
  	margin: 3px;
  }
  
   .pagebar-btn {
  	width: 45px;
  	height: 35px;
  } 
  
  .pagebar-number {
		color: red;
		font-size: 13pt;
	}
	
	.pagebar-number:hover {
		text-decoration: none;
		color: rgb(62,62,62);		
	}
	
	a {
		color:black;
	}
   
</style>
<script type="text/javascript">

		$(document).ready(function(){
			
			/* 성인/아동별 옵션 show,hide */
			$('#cate_code').change(function(){
			
			   if( $('#cate_code option:selected').val() =='adult' ){
			   	$('#fk_cate_no').find('[value=7]').hide();
			   	$('#fk_cate_no').find('[value=8]').hide();
			   	$('#fk_cate_no').find('[value=9]').hide();
			   }
			   else if ($('#cate_code option:selected').val() !='adult'){
			   	$('#fk_cate_no').find('[value=7]').show();
			   	$('#fk_cate_no').find('[value=8]').show();
			   	$('#fk_cate_no').find('[value=9]').show();
			   }
			   
			  if ($('#cate_code option:selected').val() =='child'){
			   	$('#fk_cate_no').find('[value=1]').hide();
			   	$('#fk_cate_no').find('[value=2]').hide();
			   	$('#fk_cate_no').find('[value=3]').hide();
			   	$('#fk_cate_no').find('[value=4]').hide();
			   	$('#fk_cate_no').find('[value=5]').hide();
			   	$('#fk_cate_no').find('[value=6]').hide();  	        	
			   }
			   else if ($('#cate_code option:selected').val() !='child'){
			   	$('#fk_cate_no').find('[value=1]').show();
			   	$('#fk_cate_no').find('[value=2]').show();
			   	$('#fk_cate_no').find('[value=3]').show();
			   	$('#fk_cate_no').find('[value=4]').show();
			   	$('#fk_cate_no').find('[value=5]').show();
			   	$('#fk_cate_no').find('[value=6]').show();  
			   }
	  		});//searchCode---
  		
	  		
			/* 검색값 유지하기  */
			   if(${paraMap != null}){
					$("#cate_code").val("${paraMap.cate_code}");
					$("#fk_cate_no").val("${paraMap.fk_cate_no}");
					$("#class_status").val("${paraMap.class_status}");
					$("#class_title").val("${paraMap.class_title}");
			   }    
	  		
		});//$(document).ready(function(){

			
	/* 강좌  검색하기 */
	function goSearch(){	
		var frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/lectureListAdmin.to";
		frm.submit();
	}
	
	/* 검색값 초기화하기 */
	function goReset(){		
		if(${paraMap != null}){
			$("#cate_code").val("");
			$("#fk_cate_no").val("");
			$("#class_status").val("");
			$("#class_title").val("");
	    }    
	}		
		
	/* 강좌  상세정보 */	
	function geDetail(class_seq){
		var frm = document.goDetailFrm;
		frm.class_seq.value = class_seq;
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/detailLectureAdmin.to";
		frm.submit();
	}
	
</script>

</head>
<body id="admin_body">
	<div id="container">
		<div id = "admin_nvar" align="right" style = "margin: 40px 140px 0 0;">   
	         <div style = "border-right: 1px solid #e5e5e5; padding : 0 12px; margin : 0;" ><i class="fa fa-lock" style="font-size:15px; padding:2px 6px 0 0;"></i>관리자 전용 메뉴</div>
	         <div>강좌 리스트</div>
      	</div>
      	
		<div align="center" id="admin_h2">
			<h2>강좌 리스트</h2>
		</div>

		<div id="main_container">
	
		<div id="admin_div">
			<div id="admin_divOption">
			
				<form name="searchFrm">
					<select class="a_categorySelect" name="cate_code" id="cate_code">
							<option value="">1차 분류 선택</option>
							<option value="adult">성인</option>
							<option value="child">아동</option>				
					</select>
					
					<select class="a_categorySelect" name="fk_cate_no" id="fk_cate_no">
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
					
					<select class="a_categorySelect" name="class_status" id="class_status">
							<option value="">접수 상태</option>
							<option value="1">접수중</option>
							<option value="2">접수완료</option>	
							<option value="0">대기접수</option>				
					</select>
	
					<input type="text" name="class_title" id="class_title" placeholder="(ex.게임)"/>
					
					<button type="button" id="searchNameBtn" class="btn" onclick="goSearch();">검색</button>
					<button type="button" id="resetNameBtn" class="btn" onclick="goReset();">초기화</button>
				</form>
				
			</div> <!-- admin_divOption -->
		
		<div id="admin_divTbl">
		 <table class="table table-condensed" id="lectureListTbl">
		 	 <thead>
			      <tr>
			        <th>강좌 코드</th>
			        <th>강좌명</th>
			        <th>1차 카테고리</th>
			        <th>2차 카테고리</th>
			        <th>담당 강사</th>
			        <th>수강 기간</th>
			        <th>접수상태</th>
			        <th>비고</th>
			      </tr>
			  </thead>
			  <tbody>
			  
			  <c:forEach var="lectureList" items="${lectureAdminList}" varStatus="">			  	
			      <tr>
			        <td>${lectureList.class_seq}</td>
			        <td>${lectureList.class_title}</td>
			        <td>${lectureList.cate_code}</td>
			        <td>${lectureList.cate_name}</td>
			        <td>${lectureList.teacher_name}</td>
			        <td>${lectureList.class_startDate} ~ ${lectureList.class_endDate}</td>
			        <td>${lectureList.class_status}</td>
			        <td>
			        	<button type="button" class="btn adminBtn" id="editBtn" onclick="javascript:location.href='<%= request.getContextPath()%>/editLectureAdmin.to?class_seq=${lectureList.class_seq}'">수정</button>
			        	<button type="button" class="btn adminBtn" id="detailBtn" onclick="geDetail('${lectureList.class_seq}');">상세</button>
			        </td>
			      </tr>	
			   </c:forEach>	
			     
			   </tbody>
		 </table> <!-- lectureList -->
		</div><!-- admin_divTbl -->
			</div> <!-- admin_div -->
			
		
		<div id="Area">
			<div id="centerArea" align="center">${pageBar}</div>
			<div id="rightArea"><button type="button" class="btn regBtn" onclick="javascript:location.href='<%= request.getContextPath()%>/registerLectureAdmin.to'">강좌 등록</button></div>
		</div>
		</div>		
		
		<form name="goDetailFrm" ><input type="hidden" name="class_seq"/></form>
		
		
	</div> <!-- container -->
</body>
</html>