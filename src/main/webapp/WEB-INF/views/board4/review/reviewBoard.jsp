<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reviewBoard.css" />

<style type="text/css" >

	.reviewList:hover {
	
		background: #f9f9f9;
	 	cursor : pointer;
		
	}
	
	#searchType{
		vertical-align:middle; 
		height: 34px;
		width: 80px;
		font-size: 11pt;
	}
	
	#searchBtn{
	
	   background-color: #2d2d2d;
	   color:white;
	   outline: none;
	   border: none;
	   height: 34px;
	   width: 70px;
	   font-size: 11pt;
	}
	
	#searchBtn:hover{
	   background-color: #595959;
	   cursor: pointer;
	}

</style>

<script type="text/javascript">

	$(function() {
		
		$(".orderby").each(function() {
			
			if("${paramap.orderby}" == "조회순"){
				
				$(this).addClass("action");
				
				$(".orderby").not(this).removeClass("action");
					
			}
			
			
		});
		
		
		
		
		$(".pagination a span").hide();
		
		$(".orderby").click(function() {
			
			var text = $(this).text();
			
			var searchType = "${ paramap.searchType }";
			var searchWord = "${ paramap.rvSearchWord }";
			
			var frm = document.searchFrm;
			
			frm.orderby.value = text;
			
			frm.searchType.value = searchType;
			frm.rvSearchWord.value = searchWord;
			
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/boardmenu4.to";
			
			frm.submit();
			
		});
		
		// Enter ~~~~!!~~
		$("input[name=rvSearchWord]").keydown(function(event) {
			
			if(event.keyCode == 13){
				
				goSearch();
				
			}
			
		});
		
		// 페이징
		$(".pagination a").click(function() {

			var pageNo = $(this).text();
		
			var frm = document.pageFrm;

			frm.currentShowPageNo.value = pageNo;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/boardmenu4.to";
			
			frm.submit();
			
		});
		
		
		
	});


	//글 상세보기
 	function goDetail(seq){
	   
 		location.href="<%= request.getContextPath()%>/reviewDetail.to?reviewno="+seq;
	}
	
	// 게시글 등록
	function goRegister() {
		
		location.href="<%= request.getContextPath()%>/goReview.to";
		
	}
	
	// 리뷰 검색
	function goSearch() {
		
		if($("input[name=rvSearchWord]").val().trim() != "" && $("select[name=searchType]").val() == "" ){
			
			alert("검색어를 설정해주세요!");
			$("input[name=rvSearchWord]").val("");
			return false;
			
		}
		else if($("input[name=rvSearchWord]").val().trim() == ""){
			
			alert("검색어를 입력하세요.");
			return false;
			
		}
		
		var frm = document.searchFrm;
		
		frm.orderby.value = "${ paramap.orderby }";
		
		frm.method = "POST";
		frm.action = "<%=ctxPath%>/boardmenu4.to";
		
		frm.submit();
		
	}
 
 

</script>

<div id="reviewTbl">
		<form name = "searchFrm">
		<div style="display : inline-block; font-weight: bold; margin-top: 40px; margin-bottom: 5px; width : 49.5%;" align="left">
			<span style="border-right: 1px solid #e5e5e5; padding-right: 10px; margin-right: 5px;" class = "orderby action">최신순</span>
			<span style="" class = "orderby">조회순</span>
			<input type="hidden" name = "orderby" /> 
		</div>
		<div style="display : inline-block; margin-top: 40px; margin-bottom: 7.5px; width : 49.5%;" align="right">
			
				<select id="searchType" name = "searchType" title="검색어">
					<option value = "">검색어</option>
					<option value = "teacher_name">강사명</option>
					<option value = "class_title">강좌명</option>
				</select>
				<input type="text" name = "rvSearchWord" style="height: 34px; vertical-align:middle;"/>
				<button type="button" id = "searchBtn" style="vertical-align:middle;" onclick = "goSearch()">검색</button> 
			
		</div>
	</form>
		<%-- 게시판 상단 내용 --%>
	<table class="table" style="border-top: solid 2px gray; border-bottom: solid 1px gray;">
		
		<thead class="hm_thead">
			<tr>
				<th width="8%">NO.</th>
				<th width="20%">강좌명</th>
				<th width="10%">강사명</th>
				<th width="30%">제목</th>
				<th width="10%">작성자명</th>
				<th width="12%">작성일자</th>
				<th width="8%">조회수</th>
			</tr>
		</thead>
		
		<tbody class="hm_tbody">
		
		<c:if test="${ not empty requestScope.reviewList}">
			<c:forEach var="review" items="${ reviewList }" varStatus="status">
				<tr onclick="goDetail(${review.reviewno})" class = "reviewList">
					<td>${ review.reviewno }</td>
					<td><span>[ ${ review.class_semester }] ${ review.class_title }</span>&nbsp;<span style = "color :#e12a29;">(${ review.commentCount })</span></td>
					<td>${ review.teacher_name }</td>
					<td align="left" ><span>${ review.subject } </span>
						<c:if test="${ review.imgfilename != null }"> 
							<img src="<%= ctxPath %>/resources/shimages/img.png" style = "margin-left : 2px; width : 10px; height : 10px;">
						</c:if> 
					</td>
					<td>${ review.username }</td>
					<td>${ review.wdate }</td>
					<td>${ review.readcount }</td>
				</tr>
			</c:forEach>
		</c:if>
		
		
		<c:if test="${empty requestScope.reviewList}">
				<tr>
					<td colspan="7">수강후기 리뷰가 없습니다.</td>
				</tr>
		</c:if>
		
		
		</tbody>
	</table>
	
	<div id="btnArea">   	
      	<button type="button" class="btns" id="registerBtn" onclick="goRegister();">게시글 등록</button> 
     </div>
	
	<div class="pagination">
			${pageBar}
		
		<form name = "pageFrm">
			<input type="hidden" name = "currentShowPageNo" value="" />
			<input type="hidden" name = "orderby" value="${ paramap.orderby }" />
		</form>
			
	</div>
	
</div>