<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">

  #btnArea {
		float : right;
		margin-top:-40px;
		
	}

  #registerBtn {
  		border : none;
    	background: white;
    	font-size: 12pt;
    	font-weight: bold;
    	padding: 6px 10px;
    	background: black;
    	color: white;
    }
    
    #SearchBtn{
	   background-color: #2d2d2d;
	   color:white;
	   outline: none;
	   border: none;
	   height: 34px;
	   width: 70px;
	   font-size: 11pt;
	}
	
	#SearchBtn:hover{
	   background-color: #595959;
	   cursor: pointer;
	}
	
	#searchType{
		vertical-align:middle; 
		height: 34px;
		width: 80px;
		font-size: 11pt;
	}
		
	#eventStyle:hover{
	   background-color: #f9f9f9;
	   cursor: pointer;
	   font-weight: bold;
	}
	
	.pagebar-btn {
	  	width: 43px;
	  	height: 32px;
 	 } 
	
	a {
		color:black;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		/* 엔터키로 검색 */
		$("#searchWord").keydown(function(event){
			if(event.keyCode == 13){ 
				goSearch();
			}
		});
		
		/* 검색값 유지시키기 */
	 	if(${paraMapE != null}){
			$("#searchType").val("${paraMapE.searchType}"); 
			$("#searchWord").val("${paraMapE.searchWord}");
		} 
		
		
	});

	/* 글 상세보기 */
 	function goEventDetail(event_seq){
	   var frm = document.goEventDetailFrm;
	   frm.event_seq.value = event_seq;
	   frm.method = "GET";
	   frm.action = "<%= request.getContextPath()%>/eventBoardDetail.to";
	   frm.submit(); 
	}
 
	/* 검색 */
 	function goSearch() {
		var frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%= request.getContextPath()%>/boardmenu2.to"; 
		frm.submit();
	}
</script>

<div id="boardTbl">
	<table class="table" style="border-top: solid 2px gray; border-bottom: solid 1px gray;">

		<div style="float: right; margin: 30px 5px 10px 0px;">
			<form name="searchFrm">
				<select id="searchType" name="searchType">
					<option value="event_title">제목</option>
					<option value="event_content">내용</option>
				</select> 
				<input type="text" name="searchWord" id="searchWord" style="height: 34px; vertical-align: middle;" />
				<button id="SearchBtn" style="vertical-align: middle;" onclick="goSearch()">검색</button>
			</form>
		</div>

		<%-- 게시판 상단 내용 --%>
		<thead class="hm_thead">
			<tr>
				<th width="10%">NO.</th>
				<th width="10%">지점</th>
				<th width="50%">제목</th>
				<th width="20%">작성일자</th>
				<th width="10%">조회수</th>
			</tr>
		</thead>
		
		<tbody class="hm_tbody">
		
		<c:if test="${empty eventList}">
				<tr>
					<td colspan="5" style="height:120px;"><span style="font-size: 14pt;">진행중인 이벤트가 없습니다.</span></td>
				</tr>
		</c:if>
		
		<c:if test="${not empty eventList}">
		<c:set var="num" value="${totalCountE - ((currentShowPageNoE-1) * sizePerPageE) }"/>
			<c:forEach var="event" items="${eventList}" varStatus="status" >	
					
			<tr id="eventStyle" onclick="goEventDetail('${event.event_seq}');">
				<td>${num}<input type="hidden" name= "event_seq" value="${event.event_seq}"/></td>
				<td >본점</td>
				<td style="text-align: left;"><span >${event.event_title}</span></td>
				<td>${event.event_date}</td>
				<td>${event.event_view}</td>
			</tr>			
			<c:set var="num" value="${num-1 }"></c:set>
			</c:forEach>
			
		</c:if>
		
		
		</tbody>
	</table>
	
	<div align="center" style="margin:50px;">${pageBarE}
		<c:if test="${sessionScope.loginuser.userno == '8'}">
			<div id="btnArea">   	
		      	<button type="button" class="btns" id="registerBtn" onclick="javascript:location.href='<%= request.getContextPath()%>/eventBoardRegister.to'">게시글 등록</button> 
		     </div>
		</c:if>
	</div>
	
	
	
	<form name="goEventDetailFrm">
		<input type="hidden" name="event_seq"/>
	</form>
	
	
</div>