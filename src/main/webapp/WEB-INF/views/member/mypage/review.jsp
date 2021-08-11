<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강후기</title>

<style type="text/css">
	
	#boardTbl td {
	    vertical-align: middle;
	    cursor: pointer;
	    height: 80px;
	    border-top: 1px solid #ddd;
	}
	
	.col1 {width: 5%; border-right: solid 1px gray; padding-left: 2%;}
	
	.col2 {width: 30%; border-right: solid 1px gray; padding-left: 5%;}
	
	.col3 {width: 25%; border-right: solid 1px gray; padding-left: 5%;}
	
	.col4 {width: 10%; padding-left: 2%;}
	
	.hm_tbody tr.answer_kdh td {
		padding: 0 80px !important;
		height: 130px !important;
	}
	
	
</style>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/lectureList.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/FAQList.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(function(){
		
		$(".answer_kdh").css('display', 'none');
	
		var now = new Date();
		
		var year = now.getFullYear();
		
		var registerday = "${sessionScope.loginuser.registerday}";
		var registerYear = registerday.substring(0,4);
		
		var cnt = Number(year)-Number(registerYear)+1;
		
		var html="";
		
		for(var i=0; i<cnt; i++){
			html = "<option value='"+(year-i)+"' class='option'>"+(year-i)+"년</option>";
			$("#year").append(html);
		}
		
		if(${year != ""}){
			$("#year").val('${year}');
		}
		
		if(${term != ""}){
			$("#term").val('${term}');
		}	
		
		
 		$(".answer_kdh").each(function(){
 			var html = "";
 			
 			if($(this).children().html().trim()==""){
 				html = "<span>작성하신 후기가 없습니다.</span><a href='#' onclick='goReview()' class='atag' style='position: absolute; right: 10px; top:40px;'><span class='btn_kdh btnWhite_kdh btnType02_kdh'>작성</span></a>";
 				$(this).children().html(html);
 			}
 			
 		}); 
 		
 		showAnswer();
		
	});

	function goSearch(){
		var frm = document.searchFrm;
		frm.method="GET";
		frm.action="<%=ctxPath%>/member/review.to";
		frm.submit();
	}
	
 	function showAnswer(){
		var question = document.getElementsByClassName("question_kdh");

		for (var i = 0; i < question.length; i++) {
		  question[i].addEventListener("click", function() {

		    var answer = this.nextElementSibling;

		    if (answer.style.display === "block") {
		      answer.style.display = "none";
		    } else {
		      answer.style.display = "block";
		    }
		  });
		}
	} 
 	
 	function goDetail(reviewno){
 		location.href = "<%= ctxPath%>/reviewDetail.to?reviewno="+reviewno;
 	}

 	function goReview(){
 		location.href="<%= ctxPath%>/goReview.to";
 	}
</script>

</head>
<body>

	<div id="container_kdh">
        <div id="content_kdh">
            <div class="menu_kdh">
				<a href="#" class="material-icons atag">home</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">My문화센터</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">마이페이지</a>
				<a href="<%= ctxPath%>/member/review.to" class="atag">수강 후기</a>
			</div>
            <div class="main_kdh lectureList_kdh">
                <h2 class="h2">나의 수강후기</h2>
                <form name="searchFrm">
				<div class="search_kdh">
					<span class="select_kdh" style="width:350px;">
						<select name="year" id="year" class="option_kdh select" title="년도 선택">
							<option value="" class="option">년도</option>						
						</select>
					</span>
					<span class="select_kdh" style="width:350px;">
						<select name="term" id="term" class="option_kdh select" title="학기 선택">	
							<option value="" class="option" selected="selected">학기</option>					
							<option value="3" class="option">봄학기</option>
							<option value="6" class="option">여름학기</option>
							<option value="9" class="option">가을학기</option>
							<option value="12" class="option">겨울학기</option>
						</select>
					</span>
					<a href="#" id="dSearch" class="btn_kdh btnBlack_kdh atag" onclick="goSearch();"><span>검색</span></a>
				</div>
				</form>
                
                
				<div id="boardTbl">
						<table class="table" style="border-top: solid 2px gray; border-bottom: solid 1px gray; margin-top: 70px;">	
							
							<tbody class="hm_tbody">
						
						<c:if test="${empty orderList and empty orderListSearch}">
							<tr style="text-align: center; height: 300px;">
								<td>
									<span>수강하신 강좌가 없습니다.</span>
								</td>
							</tr>
						</c:if>
							
						<c:if test="${not empty orderList and (empty orderListSearch or orderListSearch eq null)}">
						<c:forEach var="ordervo" items="${orderList }" varStatus="status">
							<tr class="question_kdh">
								<td>
									<a class="atag">
									<span class="col1">${status.count }</span>
									<span class="col2">${classList[status.index].class_photo }</span>
									<span class="col3">${classList[status.index].class_title }</span>
									<span class="col4">${ordervo.payday}</span>
									</a>
								</td>
							</tr>
							<tr class="answer_kdh">
								<td style="width: 1160px; position: relative;">			
								<c:forEach var="reviewvo" items="${reviewList }" varStatus="status">
								<c:if test="${not empty reviewvo }">						
								<c:if test="${reviewvo.fk_class_seq eq ordervo.class_seq_fk and reviewvo.fk_userno eq sessionScope.loginuser.userno }">
									
									
									<br><span style="margin-right: 10px; font-size:10pt;">${reviewvo.subject }</span><span style="font-size: 6pt;">${reviewvo.wdate }</span><br><br>
									<span style="font-size: 12pt;">${reviewvo.content }</span><br><br><br>
									<a href="#" onclick="goDetail('${reviewvo.reviewno}')" class="atag" style="position: absolute; right: 10px; top:40px;"><span class="btn_kdh btnWhite_kdh btnType02_kdh">수정/삭제</span></a>
									
											
								</c:if>
								</c:if>
								</c:forEach>
								</td>
							</tr>
						</c:forEach>
						</c:if>
						
						<c:if test="${(empty orderList or orderList eq null) and not empty orderListSearch}">
						<c:forEach var="ordervosearch" items="${orderListSearch }" varStatus="status">
							<tr class="question_kdh">
								<td>
									<a class="atag">
									<span class="col1">${status.count }</span>
									<span class="col2">${classListSearch[status.index].class_photo }</span>
									<span class="col3">${classListSearch[status.index].class_title }</span>
									<span class="col4">${ordervosearch.payday}</span>
									</a>
								</td>
							</tr>
							<tr class="answer_kdh">
								<td style="width: 1160px;">			
								<c:forEach var="reviewvo" items="${reviewList }">
								<c:if test="${not empty reviewvo }">						
								<c:if test="${reviewvo.fk_class_seq eq ordervo.class_seq_fk and reviewvo.fk_userno eq sessionScope.loginuser.userno }">					
									<br><span style="margin-right: 10px; font-size:10pt;">${reviewvo.subject }</span><span style="font-size: 6pt;">${reviewvo.wdate }</span><br><br>
									<span style="font-size: 12pt;">${reviewvo.content }</span><br><br><br>
								</c:if>
								</c:if>
								</c:forEach>
								</td>
							</tr>
						</c:forEach>
						</c:if>
																
							</tbody>
							
						</table>
					</div>


                </div>
            </div>
        </div>

</body>
</html>
