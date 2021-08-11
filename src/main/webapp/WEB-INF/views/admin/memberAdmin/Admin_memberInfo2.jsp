<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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


<title>회원정보</title>

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
    
    #Admin_list_backBtnDiv{
     /*  border: solid 1px red;  */
      text-align: center;
      margin: 150px 100px 30px 100px;
    }
    
    #Admin_list_back{
      border: solid 0.5px #bfbfbf;
    }
    
    #Admin_list_backBtn{
      font-size: 11pt;
      padding: 15px 35px 15px 35px;
      margin-top: 15px;
      outline: none;
      border: none;
      
    }
    
    #Admin_list_backBtn:hover{
      background-color: #ffeccc;
      cursor: pointer;
      transition: all 0.5s;
    }
    
    .Admin_memberinfo_th{
      width: 220px;
    }
    
    #Admin_member_box{
      text-align: center;
      margin-top: 50px;
      border: solid 1px yellow;
      width: 60%;
      margin:0 auto;
    }
    

</style>
<script type="text/javascript">

	function goDetailMember(idx){

		location.href=""+idx;

	}

</script>

</head>
<body id="memberList_body">
     <div align="center" id = "memberList_h2">
         <h2>${mbrlist.name}님 상세 정보</h2>
      </div>
      
     <!--  <hr id="memberList_line"/> -->
      
<div style="width:80%; margin:0 auto; border: solid 1px red;"> 	
   
   <div id = "admin_nvar" align="right" style = "margin: 40px 180px 0 0;">   
            <div style = "border-right: 1px solid #e5e5e5; padding : 0 12px; margin : 0;" ><i class="fa fa-lock" style="font-size:15px; padding:2px 6px 0 0;"></i>관리자 전용 메뉴</div>
            <div>회원 상세 정보</div>
   </div>
   
   <div id="Admin_member_box">
 	  <table id = "mbrTbl" >
					<tr>
						<th scope = "row" class="Admin_memberinfo_th">아이디</th>
						<td>YunaID</td>
					</tr>
					<tr>
						<th scope = "row" class="Admin_memberinfo_th">성명</th>
						<td>김유나</td>
					</tr>
					<tr>
						<th scope = "row" class="Admin_memberinfo_th">생년월일</th>
						<td>970101</td>
					</tr>
					<tr>
						<th scope = "row" class="Admin_memberinfo_th">주소</th>
						<td>경기도 의정부시</td>
					</tr>
					<tr>
						<th scope = "row" class="Admin_memberinfo_th">휴대폰</th>
						<%-- <td>${ user.hp1 } - ${ user.hp2 } - ${ user.hp3 }</td> --%>
						<td>010-1234-5678</td>
					</tr>
					<tr>
						<th scope = "row" class="Admin_memberinfo_th">이메일</th>
						<td>kimyuna@gmail.com</td>
					</tr>
					<tr>
						<th scope = "row" class="Admin_memberinfo_th">마케팅 수신동의(SMS)</th>
						<td>동의</td>
					</tr>
					<tr>
						<th scope = "row" class="Admin_memberinfo_th">마케팅 수신동의(EMAIL)</th>
						<td>비동의</td>
					</tr>
					<tr>
						<th scope = "row" class="Admin_memberinfo_th">가입일자</th>
						<td>2019-08-02</td>
					</tr>
					<tr>
						<th scope = "row" class="Admin_memberinfo_th">가입상태</th>
						<td>활동중</td>
					</tr>
					<%-- <c:if test = "${ memberList != null }">
						<c:forEach var = "mbrlist" items="${ memberList }" varStatus="status" > 
							<tr>
								<td>${ status.count }</td>
								<td>${ mbrlist.idx }</td>
								<td>${ mbrlist.userid }</td>
								<td>${ mbrlist.name }</td>
								<td>${ mbrlist.email }</td>
								<td>${ mbrlist.registerday }</td>
								<td>${ mbrlist.registerday }</td>
								<td>${ mbrlist.registerday }</td>
								<td>${ mbrlist.registerday }</td>
								<td>${ mbrlist.registerday }</td>
							</tr>	
						</c:forEach>
					</c:if>
					
					<c:if test="${ memberList == null }">
					<tr>
						<td colspan = "11">
							<span>가입된 회원이 없습니다.</span>
						</td>
					</tr>
					</c:if> --%>
					
				</tbody>
			</table>
</div> 	  
 	  <div id="Admin_list_backBtnDiv">
 	    <hr id="Admin_list_back"/>
 	  	<button id="Admin_list_backBtn">목록으로</button>
 	  </div>
 	  
 	  
</div> 	  
</body>
</html>