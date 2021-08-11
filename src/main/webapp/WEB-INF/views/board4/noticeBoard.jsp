<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
%>

<style type="text/css">

    #btnArea {
		float : right;
	}

    #registerBtn {
  		border : none;
    	background: white;
    	font-size: 12pt;
    	font-weight: bold;
    	padding: 6px 10px;
    	background: black;
    	color: white;
    	text-decoration: none;
    }
    
    .NoticeStyle{
		cursor: pointer;
		text-decoration: underline;
	}
	
	#noticeHovertitle:hover{
		background-color: #f9f9f9;
		
	}
	
	#notice_SearchBtn{
	   background-color: #2d2d2d;
	   color:white;
	   outline: none;
	   border: none;
	   height: 34px;
	   width: 70px;
	   font-size: 11pt;
	}
	
	#notice_SearchBtn:hover{
	   background-color: #595959;
	   cursor: pointer;
	
	}
	
	#searchType{
		vertical-align:middle; 
		height: 34px;
		width: 80px;
		font-size: 11pt;
	}
	.pagination {
		
		display : block !important;
    	width: 75%;	
		margin: 0 auto;
		margin-top : 25px;
		padding-bottom: 20px;
		text-align: center;
	}
	
	.pagebar-btn {
		margin-bottom: -11px;
		width: 47px;
		height: 38px;
		opacity: 60%;
	}
	
	.pagebar-btn:hover {
		cursor : pointer;
	}
	
	.pagebar-number {
		color: rgb(62,62,62);
		font-size: 12pt;
	    position: relative;
	    top: 6px;
	    left: 2px;
	}
	
	.pagebar-number:hover {
		text-decoration: none;
		color: rgb(62,62,62);		
		
		cursor : pointer;
	}
	
	
	.action2 {
	
		font-weight: bold !important;
		text-decoration: underline !important;
	}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$(".not_title").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("NoticeStyle");
		});
		
		$(".not_title").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("NoticeStyle");
		});
	});
 
		function goView(not_seq) {
				
				var frm = document.goViewFrm;
				frm.not_seq.value = not_seq;
				
				frm.method = "GET";
				frm.action = "noticeBoardDetail.to";
				frm.submit();
			}
		
		function goSearch() {
			var frm = document.searchFrm;
			frm.method = "GET";
			frm.action = "<%= request.getContextPath()%>/boardmenu.to"; 
			frm.submit();
		}
</script>

<div id="boardTbl">
	<table class="table" style="border-top: solid 2px gray; border-bottom: solid 1px gray;">
	
	
	 <div style="float: right; margin: 30px 5px 10px 0px;">	 
 	  	  <form name="searchFrm">
 	  		<select id="searchType" name="searchType">
				<option value="not_title">제목</option>
			</select>
			<input type="text" name="searchWord" id="searchWord" style="height: 34px; vertical-align:middle;"/>
			<button id="notice_SearchBtn" style="vertical-align:middle;" onclick="goSearch()">검색</button>
 	  	  </form>
	 </div>
	 
	 
		<%-- 게시판 상단 내용 --%>
		<thead class="hm_thead">
			<tr>
			    <th width="10%">NO.</th>
				<th width="20%">지점</th>
				<th width="40%">제목</th>
				<th width="30%">작성일자</th>
			</tr>
		</thead>
		
		<tbody class="hm_tbody">
		
		<c:forEach var="boardvo" items="${boardList}" varStatus="status">
			<tr id="noticeHovertitle">
				<td align="center">${boardvo.sunbun}</td>
				<td align="center">본점</td>
				<td align="center">
				
				<span class="not_title" onclick="goView('${boardvo.not_seq}');">${boardvo.not_title}</span>
				
				</td>
				<td align="center">${boardvo.not_regDate}</td>
				
		    </tr>
		</c:forEach>
		
		</tbody>
	</table>

	<form name="goViewFrm">
		<input type="hidden" name="not_seq" />
		<input type="hidden" name="gobackURL" value="${gobackURL}" /> 
	</form>

<c:if test="${not empty boardList}">	
	<div class="pagination">
		${pageBar}
	</div>	
</c:if>
	
<c:if test="${sessionScope.loginuser.userid == 'admin'}">
	<div id="btnArea">   	
      	<a id="registerBtn" href="<%=ctxPath%>/NoticeWrite.to">게시글 등록</a>  
     </div>
</c:if>

<c:if test="${empty boardList}">
	    <div style="text-align: center; margin: 150px 0px 150px 0px;">
					<span style="font-size: 13pt; font-weight: bold;">검색결과가 없습니다.</span>
  	</div>
 </c:if>

	<form name="goDetailFrm">
		<input type="hidden" name=""/>
	</form>
</div>