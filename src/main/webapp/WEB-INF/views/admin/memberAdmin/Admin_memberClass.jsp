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
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<title>수강 정보</title>

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
        border: solid 0.5px #bfbfbf;
        margin-top: 40px;
        width: 70%;
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
	
	}
	table#mbrTbl td{
	    
	    padding: 11px 10px 10px;
	    /* border-top: 1px solid blue; */
	    color: #353535;
	    vertical-align: middle;
	    word-break: break-all;
	    word-wrap: break-word;
	}
	#member_search{
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
	#Admin_btn_classdelete{ 
	   background-color: #7a6258;
	   outline: none;
	   border: none;
	   cursor: pointer;
	   height: 30px;
	   width: 100px;
	   color: white;
	}
	#Admin_btn_classdelete:hover{
	   background-color: #604020;
	   transition: all 0.8s;
	}
	
	
	#Admin_btn_delete{
	   outline: none;
	   border: none;
	   cursor: pointer;
	   height: 30px;
	   width: 50px;
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
   
    #Admin_excelBtn{
   	  border-radius: 8px;
   	  height: 26px;
   	  width: 130px;
   	  background-color: #f2f2f2;
   	  border: none; 
   	  outline: none;
   
   }
    #Admin_excelBtn:hover{
      cursor: pointer;
      background-color: #d9d9d9;
      transition: all 0.8s;
    }
    
    #AdminClassListBackBtn{
      height: 40px; 
      width: 100px;
      outline: none; 
      border: none; 
      background-color: #fff7e6;
     
      
    }
    #AdminClassListBackBtn:hover{
      cursor: pointer;
      transition: all 0.8s;
      background-color: #ffeecc;
    }
   
   #memberdetailback{
		padding: 10px 25px 10px 25px;
		margin-bottom: 30px;
		font-size: 11pt;
		margin-top: 10px;
		border: none;
		outline: none;
		cursor: pointer;
	}

</style>
<script type="text/javascript">

function godeleteClass(orderlistno) {
	
	var message = "정말로 수강취소 하시겠습니까??";
    result = window.confirm(message);
	
	if(result){ 
		var frm = document.drawFrm;
		frm.orderlistno.value = orderlistno;
		frm.method = "POST";
		frm.action = "admindeleteClass.to";
		frm.submit();
	}
	else{
		alert("취소되었습니다.")	
	}
	}

function printclass(){
	
	 window.print();
	 
}

	
</script>

</head>
<body id="memberList_body">
  
      <div id = "admin_nvar" align="right" style = "margin: 40px 180px 0 0;">   
            <div style = "border-right: 1px solid #e5e5e5; padding : 0 12px; margin : 0;" ><i class="fa fa-lock" style="font-size:15px; padding:2px 6px 0 0;"></i>관리자 전용 메뉴</div>
            <div>수강 정보</div>
     </div>
      
     
     <div align="center" id = "memberList_h2">
         <h2><span style="color:#666666;">${membervo.username}</span> 님 수강 정보</h2>
      </div>
     
     <!--  <hr id="memberList_line"/> -->
      
<div style="width:80%; margin:0 auto;"> 	
   
   
  
    <div style="float: right; margin: 18px 10px 8px 0px;">
 	    <button id="Admin_excelBtn" onclick="printclass();"><i class='far fa-arrow-alt-circle-down'></i>&nbsp;&nbsp;수강정보 출력</button>
 	</div>
 	  
 	  <table id = "mbrTbl">
				<thead>
					<tr>
						<th></th>
						<th>접수번호</th>
						<th>강좌명</th>
						<th>수강료</th>
						<th>접수일</th>
						<th>접수 상태</th>
						<th>취소 및 환불</th>
					</tr>
				</thead>
				
				<tbody>
			
				 <c:forEach var="orderlistvo" items="${orderlistvo}" varStatus="status">	  
							<tr style="text-align: center;">
								<td></td>
								<td>${orderlistvo.orderlistno}</td>
								<td>${orderlistvo.class_title}</td>
								<td>${orderlistvo.price}</td>
								<td>${orderlistvo.payday}</td>
									<c:if test="${orderlistvo.status == '0'}">
										<td>접수완료</td>
									</c:if>
									<c:if test="${orderlistvo.status == '1'}">
										<td>취소완료</td>
									</c:if>
									
									<c:if test="${orderlistvo.status == '0'}">
									<td>
								  		<button id="Admin_btn_classdelete" onclick="godeleteClass(${orderlistvo.orderlistno});">수강취소</button>
									</td>
									</c:if>
									<c:if test="${orderlistvo.status == '1'}">
									<td>
								  		<span>${orderlistvo.deleteday}</span>
									</td>
									</c:if>
							</tr>	
				 </c:forEach>
				
				
				</tbody>
			</table>
 	  
 	<!--   <hr id="memberList_line"/> -->
 	  
 	  <c:if test="${empty orderlistvo}">
	 	    <div style="text-align: center; margin: 150px 0px 150px 0px;">
				<span style="font-size: 13pt; font-weight: bold;">접수내역이 없습니다.</span>
		  	</div>
	  </c:if>	
 	  
 	  <div style="text-align: center; margin-top: 30px;">
			<button id="memberdetailback" onclick="javascript:history.back();">목록으로</button>	
	  </div>
	  
	  <form name="drawFrm" enctype="multipart/form-data">
 		<input type="hidden" name="orderlistno" />
 		<input type="hidden" name="userno" value="${ userno }" />
 		<input type="hidden" name="username" value="${username}" />
 	  </form> 
</div>
	  
</body>
</html>