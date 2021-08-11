<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%-- ======= tile1 의 header 페이지 만들기  ======= --%>
<%
	String cxtpath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<title>회원리스트</title>

<style type="text/css">

@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

   #memberList_body {
      font-family: "Noto Sans Kr", Nanum Gothic, "나눔고딕", sans-serif;
   }
   
   #memberList_h2 h2 {
   
      font-weight: 500;
      font-size: 52px;
      margin-bottom: 20px;
      letter-spacing: -3px;
      font-family: "Noto Sans Kr";
   
   }
   
   #memberList_line {
        border: solid 1px #bfbfbf;
   }
   
   table#mbrTbl {
	
		margin-top: 12px;
		width: 100%;
		border-collapse: collapse;
	
	}

	table#mbrTbl th{
		background: #f4f4f4;
		border-collapse: collapse;
		height: 50px;
	}

	table#mbrTbl th, table#mbrTbl td{
	
		border-collapse: collapse;
		font-size: 11pt;
	}
	table#mbrTbl td{
	    padding: 13px 5px 5px 13px;
	    color: #353535;
	    vertical-align: middle;
	    word-break: break-all;
	    word-wrap: break-word;
	    font-size: 10pt;
	}
	#searchType{
		vertical-align:middle; 
		height: 35px;
		width: 80px;
		font-size: 11pt;
	}
	
	#member_search_box{
	/*    border: solid 1px red; */
	   list-style:none;
	   vertical-align: middle;
	   height: 35px;
	   margin: 35px 35px 0px 0px;
	}
	
	#member_SearchBtn{
	   background-color: #2d2d2d;
	   color:white;
	   outline: none;
	   border: none;
	   height: 35px;
	   width: 70px;
	   font-size: 11pt;
	}
	
	#member_SearchBtn:hover{
	   background-color: #595959;
	   cursor: pointer;
	   
	}
	#Admin_btn_memberclass{
	   background-color: #7a6258;
	   outline: none;
	   border: none;
	   cursor: pointer;
	   height: 30px;
	   width: 80px;
	   color: white;
	}
	#Admin_btn_memberclass:hover{
	   background-color: #604020;
	   transition: all 0.8s;
	}
	
	#Admin_btn_memberinfo{
	   background-color: #7a6258;
	   outline: none;
	   border: none;
	   cursor: pointer;
	   height: 30px;
	   width: 80px;
	   color: white;
	}
	
	#Admin_btn_memberinfo:hover{
	   background-color: #604020;
	   transition: all 0.8s;
	}
	
	
	#Admin_btn_delete{
	   outline: none;
	   border: none;
	   cursor: pointer;
	   height: 30px;
	   width: 80px;
	   font-weight: bold;
	   background-color: #e6e6e6;
	}
	
	#Admin_btn_delete:hover{
	   background-color: #cccccc;
	   transition: all 0.8s;
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

</style>
<script type="text/javascript">

	<%-- $(document).ready(function(){
		
		$(".memberwithdrawalBtn").click(function(){
			
			var userno = $(this).closest("td").children("input").val();
			
			
			alert("정말로 탈퇴변경하시겠습니까?"+userno);
			
			// 폼을 submit
			var frm = document.drawFrm;
			frm.method = "POST";
		//	frm.action = "<%= cxtpath%>/memberwithdrawal.to";
		//	frm.submit();
		});
		
	}); --%>
	
	function goSearch() {
		var frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/adminMemberList.to"; 
		frm.submit();
	}
	
	function goView(userno) {
		
		var frm = document.goViewFrm;
		frm.userno.value = userno;
		
		frm.method = "GET";
		frm.action = "adminMemberInfo.to";
		frm.submit();
	}
	
	function goDetailClass(userno) {
		
		var frm = document.goClassFrm;
		frm.userno.value = userno;
		
		frm.method = "GET";
		frm.action = "adminMemberClass.to";
		frm.submit();
	}		
			
	function goDraw(userno) {
		
		var message = "정말로 탈퇴변경 하시겠습니까??";
	    result = window.confirm(message);
		
		if(result){ 
			var frm = document.drawFrm;
			frm.userno.value = userno;
			frm.method = "POST";
			frm.action = "memberwithdrawal.to";
			frm.submit();
		}
		else{
			alert("취소되었습니다.");
		}
		
		
	}
	
	
	
	

</script>

</head>
<body id="memberList_body">

 <div id = "admin_nvar" align="right" style = "margin: 40px 180px 0 0;">   
            <div style = "border-right: 1px solid #e5e5e5; padding : 0 12px; margin : 0;" ><i class="fa fa-lock" style="font-size:15px; padding:2px 6px 0 0;"></i>관리자 전용 메뉴</div>
            <div>회원 리스트</div>
   </div>

     <div align="center" id = "memberList_h2">
         <h2>회원 리스트</h2>
      </div>
      
      <!-- <hr id="memberList_line"/> -->
      
<div style="width:80%; margin:0 auto;"> 	
   
  
   
	   
 	  <div style="float:right;">
 	    <ul>
 	  	  <li id="member_search_box">
 	  	  <form name="searchFrm">
 	  		<select id="searchType" name="searchType">
				<option value="username">이름</option>
				<option value="email">이메일</option>
				<option value="userid">아이디</option>
			</select>
			<input type="text" name="searchWord" id="searchWord" style="height: 29px;"/>
			<button id="member_SearchBtn" style="vertical-align:middle;" onclick="goSearch()">검색</button>
 	  	  </form>
 	  	  </li>
 	  	</ul>
 	  </div>

 	  <table id = "mbrTbl">
				<thead>
					<tr>
						<th>회원번호</th>
						<th>아이디</th>
						<th>성명</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>주소</th>
						<th>가입일자</th>
						<th>가입상태</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
				
					
				
					<c:forEach var="membervo" items="${memberList}" varStatus="status">
							<tr style="text-align: center; border-top: solid 0.5px #e0ebeb;">
								
								<td>${membervo.userno}</td>
								<td>${membervo.userid}</td>
								<td>${membervo.username}</td>
								<td>${membervo.email}</td>
								<td>${membervo.hp}</td>
								<td style="width: 250px;">${membervo.addr}</td>
								<td>${membervo.registerday}</td>
									<c:if test="${membervo.status == '1'}">
										<td>활동중</td>
									</c:if> 
									<c:if test="${membervo.status == '0'}">
										<td>탈퇴</td>
									</c:if> 
							<td>
							  <c:if test="${membervo.status == '1'}">
								  <button id="Admin_btn_memberinfo" onclick="goView('${membervo.userno}');">상세정보</button>
								  <button id="Admin_btn_memberclass" onclick="goDetailClass('${membervo.userno}');">수강정보</button>
								  <button id="Admin_btn_delete" onclick="goDraw(${membervo.userno});">탈퇴변경</button>
							  </c:if> 
							  <c:if test="${membervo.status == '0'}">
								  <span style="color:#666666;">탈퇴날짜</span>&nbsp;&nbsp;${membervo.withdrawalday}		
							  </c:if> 
								</td>
							</tr>	
					</c:forEach>	
					
					
					
				</tbody>
			</table>
	  
 	  <c:if test="${empty memberList}">
 	    <div style="text-align: center; margin: 150px 0px 150px 0px;">
						<span style="font-size: 13pt; font-weight: bold;">검색결과가 없습니다.</span>
	  	</div>
	  </c:if>	
 	  
 	<form name="goViewFrm">
		<input type="hidden" name="userno" />
	</form>  
 	  
 	<form name="drawFrm" enctype="multipart/form-data">
 		<input type="hidden" name="userno" />
 	</form>  
 	
 	<form name="goClassFrm" enctype="multipart/form-data">
 		<input type="hidden" name="userno" />
 	</form> 
 	  
 	<div align="center" style="padding: 40px 0px 10px 0px;">
		${pageBar}
	</div>
 	  
 	  
</div> 	  
</body>
</html>