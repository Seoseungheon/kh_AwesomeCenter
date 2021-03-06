<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/recomLec.css" />

<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  
  <script src='https://kit.fontawesome.com/a076d05399.js'></script>

<script type="text/javascript">

	$(function() {
		
		$("#myPopup").toggleClass("show");
		
		var nnn = "${wishList}"
		
		if(nnn != ""){
			
			$.ajax({
						
					url:"<%= ctxPath %>/bestTeacherChart.to",
					dataType:"JSON",
					success:function(json) {
						
						
						/* let data = [];
						
						$.each(json, function(index, item) {
							
							data.push({
					                    name: item.department_name,
					                    y: Number(item.percentage),
					                 });
							
							console.log(item.TEACHER_NAME);
					
						}); // end of $.each()----------------- */
						
						if(json.length >0) {
							
							let name = [];
							let rate = [];
							$.each(json, function(index, item) {
								
								name.push(item.TEACHER_NAME+"<br/>"+item.cate_name);
								rate.push(parseInt(item.rate));
						
							});
							
							var chart = Highcharts.chart('bestTeacherChart', {
			
							    title: {
							        text: '??????????????????'
							    },
			
							    subtitle: {
							        text: ''
							    },
			
							    xAxis: {
							        categories: name
							    
							    },
			
							    series: [{
							        type: 'column',
							        colorByPoint: true,
							        data: rate,
							        showInLegend: false
							    }]
			
							});
						}
						
		
		
					},
					
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
					
				});
			
	//	});
		}
		
		$("#lecture_menu ul li a").click(function() {
			
			$(this).addClass("action");
			
			$("#lecture_menu ul li a").not(this).removeClass("action");
			
		});
		
		$(".pagebar-btn").hover(function () {
			
			$(this).css("opacity", "100%");
			
			
			}, function() {
				
			$(this).css("opacity", "60%");
				
		});
		
	});// end of $(function() { });
	
	function myFunction() {
		
		
		$("#myPopup").toggleClass("show");
	
	}
</script>

<div id = "lecture_body">
	<div id = "lectureList" >
		
		<div id = "lecture_nvar" align="right" style = "margin: 40px 0;">
		<!-- 	<div><img src = ""></div>
			<div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">????????????</div>
			<div>????????????</div> -->
			
			<div>
				<a href = "<%=ctxPath%>/main.to"><img src = "<%=ctxPath%>/resources/images/Home.png" ></a>
			</div>
			<div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">
				<a href = "<%= ctxPath %>/lectureApply.to">????????????</a>
			</div>
			<div>
				<a href = "javascript:history.go(0);">????????????</a>
			</div>
			
		</div>
		<div align="center" id = "lecture_h2">
			<h2>????????????</h2>
		</div>
		
		<div id = "lecture_menu">
			<ul>
				<li><a href = "<%= ctxPath %>/lectureApply.to">????????????</a></li>
				<li><a href = "<%= ctxPath %>/recomLec.to" class = "action">????????????</a></li> <!-- recomLec.to  -->
				<li><a href = "<%= ctxPath %>/populLec.to">????????????</a></li>	<!-- populLec.to  -->
				<li><a href = "<%= ctxPath %>/lectureSchedule.to">???????????????</a></li>
			</ul>
		</div>
	
	</div>
	
	<div id = "realList">
	
		<div id="listLec">
		<c:if test="${ not empty wishList }"> <!-- not empty wishList -->
			<div id="listFilter">
				<div class="popup" onclick="myFunction()">
				   <span data-toggle="modal" data-target="#myModal"><span style = "color : #605752; font-size: 16pt;">${sessionScope.loginuser.username}</span>?????? ?????? ?????? ???????????????</span>
				   <span class="popuptext" id="myPopup">Click Me&nbsp;<span class="far">&#xf59c;</span></span>
				</div>
			</div>
			
			<div id="pictureList">
				<ul>
					<c:forEach var="lecturevo" items="${lectureList}">
						<li>
							<a href='lectureDetail.to?class_seq=${lecturevo.class_seq}'>
							<div class="prodItem">
								<div class="thum">
									<img class="lecListPic" src="resources/images_lecture/${lecturevo.class_photo}" />
								</div>
								<div class="lecInfo">
									<div>
										<%-- ?????? css ?????? ????????? ??? ????????? ??????????????? ?????? ??????????????? ?????? --%>
										<c:if test="${lecturevo.class_status==1 }"><span class="onApply">?????????</span></c:if><c:if test="${lecturevo.class_status==0 }"><span class="onWait">????????????</span></c:if><c:if test="${lecturevo.class_status==2 }"><span class="closeApply">????????????</span></c:if><span class="detailAge">${lecturevo.cate_code}??????</span><span class="detailCat">${lecturevo.cate_name}</span>
									</div>								
									<div class="lecTitleDIV">
										<span id="lecTitle">${lecturevo.class_title}</span>
									</div>
									<div id="lecDetailInfo">
										<span class="detailInfoSpan">${lecturevo.teacher_name}</span>&nbsp;&nbsp;
										<span class="detailInfoSpan">${lecturevo.class_semester}</span>&nbsp;&nbsp;
										<span class="detailInfoSpan">(${lecturevo.class_day})&nbsp;&nbsp;${lecturevo.class_time}</span><br/>
										<span style="color: black; font-size: 11pt;"><fmt:formatNumber value="${lecturevo.class_fee}" pattern="###,###" />&nbsp;???</span>&nbsp;&nbsp;<span class="detailInfoSpan">(??? 4???)</span>
									</div>
								</div>
							</div>		
							</a>				
						</li>
					</c:forEach>			
				</ul>

			</div>
			
		</c:if>
		
		<c:if test="${ empty wishList }"> <!-- empty wishList -->
			<div id = "noLogin" align="center">
				<h2>???????????? ?????? ????????? ?????????????????????</h2>
				<c:if test="${ sessionScope.loginuser == null }">	<!-- sesseion.loginuser == null -->
					<button type="button" id = "goLoginBtn" onclick = "location.href = '<%= ctxPath %>/login.to'">?????????</button>
					<button type="button" id = "goRegisBtn" onclick = "location.href = '<%= ctxPath %>/member/Register.to'">????????????</button>
				</c:if>
				<c:if test="${ sessionScope.loginuser != null }">	<!-- sesseion.loginuser != null -->
					<button type="button" id = "goLoginBtn" onclick = "location.href = '<%= ctxPath %>/member/mypage.to'">???????????? ??????</button>
				</c:if>
			</div>
		</c:if>
		
		</div>
	
		<!-- The Modal -->
	  <div class="modal fade" id="myModal">
	    <div class="modal-dialog modal-lg">
	      <div class="modal-content">
	        
	        <!-- Modal body -->
	        <div class="modal-body">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
					<div id="bestTeacherChart"></div>
	        </div>
	      </div>
	    </div>
	  </div>
	
	</div>
</div>