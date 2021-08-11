<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강사 리스트</title>
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
   		margin : 60px 60px 100px 60px;
   }
   
   #admin_divOption {
   		margin: 7px 3px 7px 0;
   }
   
   .a_categorySelect {
   		height: 25px;
   		margin: 3px 3px 3px 0;
   }
   
   #searchName {
   		margin: 7px 5px 0 5px;
   		width: 130px;
   }
   
   #searchText {
   		width: 130px;
   }
   
   #searchNameBtn, #resetNameBtn {
   		background : #f2e5d9;
   		font-size: 9pt;
   		padding: 6px 10px;
   		margin:2px 0 3px 5px;
   		
   }
   
   #teacherListTbl {
   	  border-top: solid 1px #5e4121;
   	  border-bottom: solid 1px #5e4121;
   }
   
   #teacherListTbl th {
   		height : 45px;
   		background-color: #ebd9c6;
   		vertical-align: middle;
   		text-align: center;
   			
   }
   
   #teacherListTbl td { 		
   		vertical-align: middle;
   		text-align: center;
   			
   }
   
    #Area { 	 		
  	 margin:50px 
  }
  
  .adminBtn {
  	font-size: 10pt;
  	background-color: #661a00;
  	color : white;
  	padding: 3px 6px;
  	margin: 3px;
  }
  
  #newBtn {
  	background-color: #661a00;
  	color: white;
   	border : none;
   	font-size: 11pt;
   	margin-left:1150px;
   	padding : 12px 19px;	
   	position: relative;
   	top:-50px;
   	left:-170px;
  }
   
  .pagebar-btn {
  	width: 45px;
  	height: 35px;
  } 
  
  input[type=checkbox] {
  	margin:4px 8px 0 5px;
  }
  
  #searchCheck {
  	border: solid 1px #b3b3b3;
  	width:180px;
  	padding:5px 0 2px 12px;
  }
  
  a {
  	color:black;
  }
  
</style>

<script type="text/javascript">

	$(document).ready(function(){	
		
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
 		});	 
		
		/* ENTER키로 검색 */   
        $("#searchWord").keydown(function(event){
			if(event.keyCode == 13){ 
				goSearch();
			}
		});  
	       
		/* 검색값 유지하기  */
	   if(${paraMap != null}){
			$("#searchCode").val("${paraMap.searchCode}");
			$("#searchName").val("${paraMap.searchName}");
			$("#searchText").val("${paraMap.searchText}");
			$("#searchStatus").val("${paraMap.searchStatus}");
			}  
			
	        
		
	  
		
	});//$(document).ready(function()
	
	

	/* 강사  검색하기 */
	function goSearch(){	
		var frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/teacherListAdmin.to";
		frm.submit();
	}
	
	/* 검색값 초기화하기 */
	function goReset(){		
		if(${paraMap != null}){
			$("#searchCode").val("");
			$("#searchName").val("");
			$("#searchText").val("");
			$("#searchStatus").val("");
	    }    
	}
	
	
	
	
	/* 상세 정보 보기 */
	function geDetail(teacher_seq){
		var frm = document.goDetailFrm;
		frm.teacher_seq.value = teacher_seq;
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/detailTeacherAdmin.to";
		frm.submit();
	}
	
	/* 정보 수정하기 */
	function goEdit(teacher_seq){
		var frm = document.goEditFrm;
		frm.teacher_seq.value = teacher_seq;
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/editTeacherAdmin.to";
		frm.submit();
	}
	


</script>

</head>
<body id="admin_body" >
	<div id="container">
		<div id = "admin_nvar" align="right" style = "margin: 40px 140px 0 0;">   
	         <div style = "border-right: 1px solid #e5e5e5; padding : 0 12px; margin : 0;" ><i class="fa fa-lock" style="font-size:15px; padding:2px 6px 0 0;"></i>관리자 전용 메뉴</div>
	         <div>강사 리스트</div>
      	</div>
      	
		<div align="center" id="admin_h2">
			<h2>강사 리스트</h2>
		</div>

		<div id="main_container">
	
		<div id="admin_div">
			
			<div id="admin_divOption">
			<form name="searchFrm">
				<select class="a_categorySelect" name="searchCode" id="searchCode">
						<option value="">1차 카테고리</option>
						<option value="adult">성인</option>
						<option value="child">아동</option>		
				</select>
				<select class="a_categorySelect" name="searchName" id="searchName" >
						<option value="">2차 카테고리</option>					
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
				<select class="a_categorySelect" name="searchStatus" id="searchStatus">
						<option value="">고용상태</option>
						<option value="1">재직</option>
						<option value="2">휴직</option>	
						<option value="0">퇴사</option>		
				</select>
				<input type="text" name="searchText" id="searchText" placeholder=" 이름을 입력하세요" />
				<button type="button" id="searchNameBtn" class="btn" onclick="goSearch();">검색</button>
				<button type="button" id="resetNameBtn" class="btn" onclick="goReset();">초기화</button>
				
				</form>
				
				
			</div> <!-- admin_divOption -->	
		
		<div id="admin_divTbl">
		 <table class="table table-condensed" id="teacherListTbl">
		 	 <thead>
			      <tr>
			        <th>강사 코드</th>
			        <th>강사명</th>
			        <th>카테고리1</th>
			        <th>카테고리2</th>
			        <th>성별</th>
			        <th>입사일자</th>
			        <th>고용상태</th>
			        <th></th>
			      </tr>
			  </thead>
			  <tbody>
			  	  
			  	<c:forEach var="teachervo" items="${teacherList}" varStatus="status">
			      
			      <tr>
			        <td>${teachervo.teacher_seq}</td>
			        <td>${teachervo.teacher_name}</td>
			        <td>${teachervo.cate_code}</td>
			        <td>${teachervo.cate_name}</td>
			        <td>${teachervo.teacher_gender}</td>
			        <td>${teachervo.teacher_registerday}</td>
			        <td>${teachervo.teacher_status}</td>
			        <td>
			        	<button type="button" class="btn adminBtn" id="editBtn" onclick="goEdit('${teachervo.teacher_seq}');">정보수정</button>
			        	<button type="button" class="btn adminBtn" id="detailBtn" onclick="geDetail('${teachervo.teacher_seq}');">상세</button>
			        </td>
			      </tr>
			      </c:forEach>
			      
			      
			   </tbody>
		 </table> <!-- lectureList -->
		</div><!-- admin_divTbl -->
		
		
		
		<div id="Area">
			<div align="center" id="centerArea">${pageBar}</div>
			<div id="rightArea"><button type="button" class="btn newBtn" id="newBtn" onclick="javascript:location.href='<%= request.getContextPath()%>/registerTeacherAdmin.to'">신규 강사 등록</button></div>
		</div> <!-- admin_div -->
			
		</div>	
		
		<form name="goDetailFrm">
		<input type="hidden" name="teacher_seq" />
		</form>
		
		<form name="goEditFrm">
		<input type="hidden" name="teacher_seq" />
		</form>
	</div> <!-- container -->
</body>
</html>