<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/main.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	cateAdult();
	
	$("#cateCode").bind('change',function(){
		if($("#cateCode").val() == '성인')
			cateAdult();
		else
			cateKids();
	});
	
	$("#lectName").keydown(function(key) {
        if (key.keyCode == 13) {
        	goSearch();
        }
    });
});
 
function cateAdult(){
	var html = "<option value = ''>전체</option>";
		html += "<option value = '1'>건강·댄스</option>";
		html +=	"<option value = '2'>아트·플라워</option>";
		html +=	"<option value = '3'>음악·악기</option>";
		html +=	"<option value = '4'>쿠킹·레시피</option>";
		html +=	"<option value = '5'>출산·육아</option>";
		html +=	"<option value = '6'>어학·교양</option>";
	$("#category").html(html);
}

function cateKids(){
	var html = "<option value = ''>전체</option>";
		html += "<option value = '7'>창의·체험</option>";
		html +=	"<option value = '8'>음악·미술·건강</option>";
		html +=	"<option value = '9'>교육·오감발달</option>";
	$("#category").html(html);
}

function goSearch(){
	var cateCode = $("#cateCode").val();
	var category = $("#category").val();
	var month = $("#month").val();
	var registerStatus = $("#registerStatus").val();
	var lectName = $("#lectName").val().trim();
	
	location.href="<%=ctxPath %>/lectureApply.to?" +
								"cate_code="+cateCode+"&" +
								"cate_no="+category+"&" +
								"class_status="+registerStatus+"&" +
								"class_semester="+month+"&" +
								"class_day=&" +
								"searchType=class_title&" +
								"searchLecWord="+lectName+"&" +
								"listfilter=최신등록순&" +
								"currentShowPageNo=";
}
</script>
<div id="main">
	<div id="leftArea"> 
		<div id="leftSubArea1"> 
			<%-- <jsp:include page="mainCarousel.jsp" /> --%>
			<iframe src="mainCarousel.to" width="748px" height="300px" scrolling="no" frameborder=0></iframe>
		</div>
			
		<div id="leftSubArea2"> 
			<div id="searchBox">
				<form id="searchFrm" name="searchFrm">
					<ul>
						<li>
							<label for="cateCode" class="title">수강대상</label>
							<select id="cateCode" name="cateCode">
								<option value="성인">성인</option>
								<option value="아동">유아/아동</option>
							</select>
							
							<label for="category" class="title">카테고리</label>
							<select id="category" name="category">
								<option value="">카테고리</option>
							</select>
						</li>
						<li>
							<label for="tchName" class="title">수강월</label>
							<select id="month">
								<option value="">전체</option>
								<c:forEach var="i" begin="1" end="12">
										<option value="${ i }월">${ i }월</option>
								</c:forEach>
							</select>
							<label for="registerStatus" class="title">접수상태</label>
							<select id="registerStatus" name="registerStatus">
								<option value="">전체</option>
								<option value="1">접수중</option>
								<option value="2">접수마감</option>
								<option value="0">대기등록</option>
							</select>
						</li>
						<li>
							<label for="lectName" class="title">강좌명</label>
							<input type="text" name="lectName" id="lectName"/>
							<input type="text" style="display: none;"/>
						</li>
						
						<li class="center">
							<a onclick="goSearch()" class="searchBtn hm_a" style="cursor: pointer;"><span class="glyphicon" style="color:#ffffff;">&#xe003;</span> 강좌검색</a>
						</li>
					</ul>
				</form>
			</div>
		</div>
		
		<div id="leftSubArea3"> 
			<a href="<%=ctxPath%>/recomLec.to" class="recommend"></a>
		</div>
	</div>
	
	<!-- 오른쪽 배너 -->
	<div id="rightArea"> 
		<a href="#" class="recruit"></a>
	</div>
	
	<!-- 공지사항 롤링 -->
	<div id="bottomArea">
		<jsp:include page="rolling.jsp" />
	</div>
</div>
