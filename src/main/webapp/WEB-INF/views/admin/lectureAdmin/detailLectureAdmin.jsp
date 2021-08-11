<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 상세보기</title>
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
   	  border: dashed  1px #e6e6e6;
   	  width : 100%;
   	  margin-top: 70px;
   }
   
   .lectureInfo th {
   	  text-align: center;
   	  background-color: #e6e6e6;
   	  color : #404040;
   	  width : 150px;
   	  vertical-align: middle !important;
   }
   
   .lectureInfo td {
   	  text-align: left;
 		vertical-align: middle !important;
   }
   
    .tblTop {
   		margin: 80px 0 0 5px;
	 	text-align: left;
   }

   .tblTop > h5 {
   		font-weight: bold;
   }
   
   .listTbl {
   	  border-top: solid 1px #404040;
   	  border-bottom: solid 1px #404040;
   }
   
   .listTbl th {
   		height : 45px;
   		width : 130px;
   		background-color: #e6e6e6;
   	    color : #404040;
   		vertical-align: middle !important;
   		text-align: center;
   			
   }
   
   .listTbl td { 		
   		vertical-align: middle !important;
   		text-align: center;			
   }
   
   input[name=radioCheck] {
		margin: 8px 5px 4px 0;
	}
  
  #editBtn {
  	margin: 7px 0 5px 30px;
  }
  
  
   
   #registerBtn, #resetBtn, #deleteBtn {
   		width : 140px;
   		height : 50px;
   		background-color: #262626;
   		color: white;
   		font-size: 19px;
   		margin: 10px;
   }
   
   #btnDiv {
   		margin: 50px 0 80px 0;
   }
   
   #lectureDetailPicture {
		margin: 0 auto;
		min-width:300px;
		min-height:300px;
		max-width: 500px;
		max-height: 700px;
	}
	
	#cautionLectureDetail {
		width : 700px;
		margin: 25px 80px 25px 170px;
		padding: 25px 50px;
		background-color: rgb(244, 244, 244);
		line-height: 200%;
		color: rgb(70,70,70);
		font-size: 9pt;
	}
   
   
</style>

<script type="text/javascript">


	$(document).ready(function(){	
		
		
		$(".adminBtn").click(function(){
			
			var bool = confirm("해당 회원을 삭제하시겠습니까?"); 
		    if(!bool) {
		    	alert("삭제가 취소되었습니다.");
		    }    
		    else {		
		 		var str = "";
	            var tdArr = new Array();   
	            var adminBtn = $(this);
		            
	            var tr = adminBtn.parent().parent();
	            var td = tr.children();
	   
	            var deleteVal = td.eq(1).text();
				$("input[name=fk_userno]").val(deleteVal);
	                  
	            var frm = document.deleteFrm;
	   			frm.method = "POST"
	   			frm.action = "<%= request.getContextPath()%>/studentDelEnd.to";
	   			frm.submit();
		    }
		});
		
		
		
		$("#deleteBtn").click(function(){
			
			var bool = confirm("해당 강좌를 삭제하시겠습니까?"); 
		    if(!bool) {
		    	alert("삭제가 취소되었습니다.");
		    }    
		    else {		 	
	            var frm = document.deleteLectureFrm;
	   			frm.method = "POST";
	   			frm.action = "<%= request.getContextPath() %>/delLectureEnd.to";
	   			frm.submit();
		    }			
		});
		
		
		
		
	});//$(document).ready(function
		
	
		
	function goEdit(class_seq){
		
		var frm = document.editLectureFrm;
		frm.class_seq.value = class_seq;
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/editLectureAdmin.to";
		frm.submit();
	}	
		
	
	
</script>

</head>
<body id="admin_body">
	<div id="container">
		<div id = "admin_nvar" align="right" style = "margin: 40px 250px 0 0;">   
	         <div style = "border-right: 1px solid #e5e5e5; padding : 0 12px; margin : 0;" ><i class="fa fa-lock" style="font-size:15px; padding:2px 6px 0 0;"></i>관리자 전용 메뉴</div>
	         <div>강좌 상세 정보</div>
      	</div>
	
	  <div align="center" id = "admin_h2">
         <h2>강좌 상세 정보</h2>
      </div>
      
      <div id="main_container">
      	<table class="table table-bordered lectureInfo" id="lectureInfo1">
      		<tr>
      			<th style="width:330px;">지점</th>
      			<th style="width:330px;">학기</th>
      			<th style="width:330px;">수강기간</th>  		
      		</tr>
      		
      		<tr>
      			<td style="text-align: center;">본점</td>
      			<td style="text-align: center;">${lectureInfo.class_semester}</td>
      			<td style="text-align: center;">${lectureInfo.class_startDate} ~ ${lectureInfo.class_endDate}</td>	
      		</tr>    		
      	</table>
      	
      	<table class="table table-bordered lectureInfo" id="lectureInfo2">
      		<tr>
      			<th>강좌명</th>
      			<td>${lectureInfo.class_title}</td>
      			<th>강좌코드</th>
      			<td style="width:450px;">${lectureInfo.class_seq}</td>
      		</tr>
      		<tr>
      			<th>수업일</th>
      			<td>${lectureInfo.class_day}요일</td>
      			<th>수업시간</th>
      			<td>${lectureInfo.class_time}</td>
      		</tr>
      		<tr>
      			<th>강의실</th>
      			<td>${lectureInfo.class_place}&nbsp;강의실</td>
      			<th>수강정원</th>
      			<td>${lectureInfo.class_personnel}명</td>
      		</tr>
      		<tr>
      			<th>담당강사(코드)</th>
      			<td>${lectureInfo.teacher_name}&nbsp;(${lectureInfo.fk_teacher_seq})</td>
      			<th>수강료</th>
      			<td><fmt:formatNumber value="${lectureInfo.class_fee}" pattern="###,###,###"/>원
      				<span style="float:right; margin-right:15px;">(재료비 : 회당 <fmt:formatNumber value="${lectureInfo.class_subFee}" pattern="###,###"/>원)</span></td>
      		</tr>	
      	</table>
      	
      	<table class="table table-bordered lectureInfo" id="lectureInfo3">
      		<tr>
      			<th>접수 상태</th>
      			<td>${lectureInfo.class_status}</td>     	
      		</tr>
      		<tr>
      			<th>강좌 카테고리</th>
      			<td>
	      			<span style="padding-top: 50px;">1차 분류 : ${lectureInfo.cate_code}</span><br/>
	      			<span>2차 분류 : ${lectureInfo.cate_name}</span>
      			</td>     	
      		</tr>
      		<tr>
      			<th>좋아요</th>
      			<td>
      				<c:if test="${not empty lectureInfo.class_heart}">${lectureInfo.class_heart}♥</c:if>
      				<c:if test="${empty lectureInfo.class_heart}">0</c:if>
      			</td>     	
      		</tr>
      		
      	</table>
      	
      	<table class="table table-bordered lectureInfo" id="lectureInfo4">
      		<tr>
      			<th>강좌 제목</th>
      			<td>${lectureInfo.class_title}</td>     	
      		</tr>
      		<tr>
      			<th>첨부 사진</th>
      			<td>${lectureInfo.class_photo}</td>     	
      		</tr>
      	</table>
      	
      	<table class="table table-bordered lectureInfo" id="lectureInfo5">
      		<tr><th style="height: 60px;">강좌 상세 내역</th></tr>
      		<tr><td style="padding:30px; text-align:center; border-bottom:none;">
      			<img id="lectureDetailPicture" src="resources/images_lecture/${lectureInfo.class_photo}" />
      		</td></tr>
      		<tr><td style="padding:30px; border-top:none; border-bottom:none;">
      			
      				<div align="center">${lectureInfo.class_content}</div>
 
      		</td></tr>
      		<tr><td style="padding:30px; border-top:none;">
      			<div id="cautionLectureDetail" align="center">
					<span style="font-size: 12pt;">수강 접수시 유의사항</span><br/>
					<br/>
					1. 회원정보에서 핸드폰 번호를 꼭 다시 한 번 확인 해 주세요.<br/>
					
					2. 환불요청시 10일 전(前)까지이며, 개강 이후에는 수업 참여여부와 상관없이<br/>
					   &nbsp;&nbsp;&nbsp; [평생교육시설 운영법]에 의거해 처리됩니다.<br/>
					   &nbsp;&nbsp;&nbsp;*대기접수시 접수신청은 신청가능 여부 연락 후 1일 내에 결제해주셔야 신청가능합니다.<br/>
					
					3. 본인이 아닌 자녀 및 가족 등록 시 가족등록 시에도 회원가입 수강자명으로 등록됩니다.<br/>
					
					4. 대기접수 신청시 수강취소가 불가합니다.<br/>
					
					5. 수강신청 인원이 미달될 경우 강좌가 폐강 될수 있으며, 폐강시 수강료는 전액 환불해 드립니다.<br/>
					
					6. 공예/요리 등 재료 준비가 필요한 강좌는 재료비가 강사님께 현금납부됩니다.<br/>
					
					7. 영유아 강좌는 아이와 보호자 1인만 참여 가능합니다.<br/>
					
					8. 수강자 외 형제, 자매나 보호자 1인 이상의 참여는 불가하오니, 이 점 양해부탁드립니다.<br/>
				</div>
      		</td></tr>
      	</table>
    
    <hr id="line"/> 
     
     <div id="studentListDiv">
	     <div class="tblTop">
			<h5>수강생 명단</h5>
		</div>
		
		<div id="studentTbl">	
			<table class='table table-condensed listTbl' id='studentListTbl'>
				<thead>
					<tr>
						<th style="width:70px;">순번</th>
						<th style="width:100px;">수강생 코드</th>
						<th style="width:140px;">수강생 이름</th>
						<th style="width:90px;">성별</th>
						<th style="width:170px;">연락처</th>
						<th style="width:170px;">이메일</th>
						<th style="width:250px;">수강 상태</th>
					</tr>
				</thead>
				<tbody>
				
				<c:if test="${empty studentList}">
					<tr>
					 <td colspan="7" style="height:100px;">수강 중인 회원이 없습니다.</td>
					</tr>
				</c:if>
				
				
				<c:if test="${not empty studentList}">
					<form name="deleteFrm">
					<c:forEach var="slist" items="${studentList}" varStatus="status" begin="0" step="1">
						<tr>		
							<td>${status.count}</td>			
							<td>${slist.fk_userno}</td>
							<td>${slist.username}</td>
							<td>${slist.gender}</td>
							<td>${slist.hp1}-${slist.hp2}-${slist.hp3}</td>
							<td>${slist.email}</td>
							<td><input type="hidden" name="fk_userno" value=""/> 
								<input type="hidden" name="fk_class_seq" value="${slist.fk_class_seq}"/>
								<label class='checkbox-inline'><input type='radio' class='radioCheck' name="radio${status.index}" <c:if test="${not empty studentList}">checked</c:if>/>수강중</label>
								<label class='checkbox-inline'><input type='radio' class='radioCheck' name='radio${status.index}'/>수강 취소</label>			
								<input type="button" class="btn adminBtn" id='editBtn' value="변경"/>
							</td>
						</tr>
					</c:forEach>
					
					</form>	
				</c:if>			
				</tbody>
				</table>
				
				
					
				
		 </div>	<!-- studentTbl -->
		</div><!-- studentListDiv -->
		
		
		 <div id="waitingListDiv">
	     <div class="tblTop">
			<h5>대기자 명단</h5>
		</div>
				
		 <table class="table table-condensed listTbl" id="waitingListTbl">
		 	 <thead>
			      <tr>
			      	<th style="width:80px;">순번</th>
			        <th>수강생 코드</th>
			        <th>수강생 이름</th>
			        <th>성별</th>
			        <th>연락처</th>
			        <th>대기 접수 날짜</th>		  
			      </tr>
			  </thead>
			  <tbody>
					  <c:if test="${empty waitingtList}">
						 <tr>
						   <td colspan="6" style="height:100px;">대기 중인 회원이 없습니다.</td>
						 </tr>
					  </c:if>	
					  		
					  <c:if test="${not empty waitingtList}">				
						<c:forEach var="wlist" items="${waitingtList}" varStatus="status" begin="0" step="1">
					      <tr>
					      	<td>${status.count}</td>
					        <td>${wlist.userno_fk}</td>
					        <td>${wlist.username}</td>
					        <td>${wlist.gender}</td>
					        <td>${wlist.hp1}-${wlist.hp2}-${wlist.hp3}</td>
					        <td>${wlist.reciptday}</td>       
					      </tr>
					    </c:forEach>		
					</c:if>							      
			   </tbody>
		 </table> <!-- waitingList -->
		</div><!-- waitingListDiv -->
     
     <form name="editLectureFrm">
     	<input type="hidden" name="class_seq"/>   
     </form>
     
     <form name="deleteLectureFrm">
     	<input type="hidden" name="class_seq" value="${lectureInfo.class_seq}"/>   
     </form>
     
      <div align="center" id="btnDiv">
      	<button type="button" class="btn" id="registerBtn" onclick="javascript:location.href='<%= request.getContextPath()%>/lectureListAdmin.to'">목록</button>
      	<button type="button" class="btn" id="resetBtn" onclick="goEdit('${lectureInfo.class_seq}');">수정</button>
      	<button type="button" class="btn" id="deleteBtn" >삭제</button>
      </div>
      
	
      </div> <!--main_container  -->
   </div>   
</body>
</html>