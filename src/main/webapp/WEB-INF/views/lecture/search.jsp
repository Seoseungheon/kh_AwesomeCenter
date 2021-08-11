<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/search.css" />

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.5.0/styles/default.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.5.0/highlight.min.js"></script>


<script type="text/javascript" >
	
	$(function() {
		

		$(".class_title").each(function() {
		
			 var find = "${paramap.searchWord}";
			 var find2 = "${paramap.searchWord2}";
			 
			 
			 var regex = new RegExp(find, "g");
			 var regex2 = new RegExp(find2, "g");
			 
			 var change = $(this).text().replace(regex, "<span class='searchWord'>"+find+"</span>");
			 
			 $(this).html(change);
			 
			 
		}); 
		
	//	$(".class_title:contains('${paramap.searchWord}')").css({color:"red"});
	 

		$(".pagination a span").hide();
		
		$("input:checkbox[name=reSearch]").click(function() {
			
			if( $(this).is(":checked") ){				
				$("input[name=searchWord2]").val('${ paramap.searchWord}');								
			}
			
		});
		
		$(".pagination a").click(function() {

			var pageNo = $(this).text();
		
			var frm = document.pageFrm;

			frm.currentShowPageNo.value = pageNo;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/search.to";
			
			frm.submit();
			
		});
		
		
		
		$(".class_status").each(function(){
			
			if($(this).text() == "1"){
				
				$(this).text("접수중");
				$(this).addClass("onApply");
			}
			else if ($(this).text() == "2"){
				$(this).text("접수완료");
				$(this).addClass("closeApply");
			}
			else if ($(this).text() == "0"){
				$(this).text("대기접수");
				$(this).addClass("onWait");
			}
			
		});
		
		$("#searchWord").keydown(function(event) {
			
			if(event.keyCode == 13){
				
				goSearch();
				
			}
			
		});
		
		
	});
	
	function goSearch() {
		
		if($("#searchWord").val().trim() == ""){
			
			alert("검색어를 입력하세요.");
			return;
		}
		
		var frm = document.searchFrm;

		frm.method = "POST";
		frm.action = "<%=ctxPath%>/search.to";
		
		frm.submit();
	}


</script>

<div id = "search_body">

		<div id = "lecture_nvar" align="right" style = "margin: 40px 0;">
			<div>
				<a href = "<%=ctxPath%>/main.to"><img src = "<%=ctxPath%>/resources/images/Home.png" ></a>
			</div>
			<div style = "border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">
				<a href = "javascript:history.go(0);">통합검색</a>
			</div>
		</div>
		<div align="center" id = "lecture_h2">
			<h2>통합검색</h2>
		</div>
		
		<div id = "searchFrmDiv">
			<form name="searchFrm">
				<div id = "searchZone">
					<input type = "text" name = "searchWord" id = "searchWord" placeholder="검색어를 입력해 주세요"/>
					<input type="checkbox" name = "reSearch" id = "reSearch"/>
					<label for = "reSearch" style = "color: #222; font-size: 13px;">결과 내 재검색</label>
					<div id = "searchIcon" style = "display : inline-block;">
						<img src="<%=ctxPath%>/resources/images/돋보기.jpg" onclick = "goSearch();" />
					</div>
					<input type="text" name = "searchWord2" value = "" style = "display: none;"/>
				</div>
			</form>
		</div>
		
		<c:if test = "${ not empty lecList }">
		<p align="center" style = "font-size: 20px; color: #222; margin-bottom: 70px;">
			<span style = "color: #e12a29">‘${ paramap.searchWord }’</span>에 대한 검색 결과는 총 <span style = "color: #e12a29">${ totalCount }</span>건 입니다.			
		</p>
		
	 	
		<ul id = "listUL" >
				
				<c:forEach var="lecture" items="${ lecList }">
				<li>
					<span class = "class_status">${ lecture.class_status }</span><span class="detailAge">${ lecture.cate_code }강좌</span><span class="detailCat">${ lecture.cate_name }</span>
	               	<a href = "<%= ctxPath %>/lectureDetail.to?class_seq=${ lecture.class_seq }" class = "class_title">${ lecture.class_title }</a>
	               	<div id = "lecDetail">
	               		<span style = "padding-left:0px;">${ lecture.teacher_name }</span>
	               		<span>${ lecture.class_semester }</span>
	               		<span>${ lecture.class_term }</span>
	               		<span style = "border-right: hidden;">(${ lecture.class_day })&nbsp;${ lecture.class_time }</span>
	               	</div>
               	</li>
				</c:forEach>
			
		</ul>
		
		
		<div class="pagination">
			${pageBar}
			
			<form name = "pageFrm">
				<input type="hidden" name = "currentShowPageNo" value="" />
				<input type="hidden" name = "searchWord" value="${ paramap.searchWord }" />
				<input type="hidden" name = "searchWord2" value="${ paramap.searchWord2 }" />
				<input type="hidden" name = "reSearch" value="${ paramap.reSearch }" />
			</form>
			
		</div>
	 </c:if>
	 
	<c:if test = "${ empty lecList }">
		<div class="searchNoResult">
			<div class="inner">
				<p style = "font-size: 20px;"><span style = "color: #e12a29;">‘${ paramap.searchWord }’</span> 에 대한 검색 결과가 없습니다.</p>
				<ul>
					<li>단어의 철자가 정확한지 확인해보세요.</li>
					<li>한글을 영어로 혹은 영어를 한글로 입력했는지 확인해 보세요.</li>
					<li>검색어의 단어 수를 줄이거나, 보다 일반적인 검색어로 다시 검색해 보세요.</li>
					<li>두 단어 이상의 검색어인 경우, 띄어쓰기를 확인해 보세요.</li>
				</ul>
			</div>
		</div>
	</c:if>
	
	
</div>