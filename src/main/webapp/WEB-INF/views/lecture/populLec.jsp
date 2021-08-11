<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/populLec.css" />

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
  
  <script src='https://kit.fontawesome.com/a076d05399.js'></script>

<script type="text/javascript">

	$(function() {
		
		$("#myPopup").toggleClass("show");
		
		$.ajax({
			
			url : "cate_heart.to",
			dataType : "JSON",
			success : function(json){
				
				var cate_heartArr = [];
				
				var class_dataArr = [];
				
				$.each(json, function(index, item) {
					
					cate_heartArr.push({ name : item.cate_name,
											y : Number(item.percentage),
								 	drilldown :	item.cate_name });
				
					$.ajax({

						url : "class_heart.to",
						data: {"fk_cate_no" : item.fk_cate_no},
						dataType : "JSON",
						success : function(json2){
							
						//	console.log("~~~~cate_heartArr : "+JSON.stringify(cate_heartArr));
							
							var class_heartArr = [];
							
							$.each(json2, function(index2, item2) {
				   				
								 	class_heartArr.push([
								 		
								 		item2.class_title,
								 		Number(item2.percentage)
								 		
								 	]);
				   				
				   			});
				   			
							
				   			class_dataArr.push({ name : item.cate_name ,
				   								   id : item.cate_name ,
				   								 data :	class_heartArr
				   									 
				   			});
				   		
				   		//	console.log("~~~~class_dataArr : "+JSON.stringify(class_dataArr));
					
				   			Highcharts.chart('container', {
				   			    chart: {
				   			        type: 'column'
				   			    },
				   			    title: {
				   			        text: '3월 인기 강좌 차트, 2020'
				   			    },
				   			    subtitle: {
				   			        text: ''
				   			    },
				   			    accessibility: {
				   			        announceNewData: {
				   			            enabled: true
				   			        }
				   			    },
				   			    xAxis: {
				   			        type: 'category'
				   			    },
				   			    yAxis: {
				   			        title: {
				   			            text: 'Heart by Category'
				   			        }

				   			    },
				   			    legend: {
				   			        enabled: false
				   			    },
				   			    plotOptions: {
				   			        series: {
				   			            borderWidth: 0,
				   			            dataLabels: {
				   			                enabled: true,
				   			                format: '{point.y:.1f}%'
				   			            }
				   			        }
				   			    },

				   			    tooltip: {
				   			        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
				   			        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
				   			    },

				   			    series: [
				   			        {
				   			            name: "Category",
				   			            colorByPoint: true,
				   			            data: cate_heartArr				   			            
				   			        }
				   			    ],
				   			    drilldown: {
				   			        series: class_dataArr
				   			    }
				   			});
				   			

				   			
						},
						error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
						
					});// $.ajax
					
				}); // each
				

	   			console.log(cate_heartArr);
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
				       	
		
		});
		
		
		///////////////////////////////////////////////////////////////////////////
		
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
			<div>
				<a href = "<%=ctxPath%>/main.to"><img src = "<%=ctxPath%>/resources/images/Home.png" ></a>
			</div>
			<div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">
				<a href = "<%= ctxPath %>/lectureApply.to">수강신청</a>
			</div>
			<div>
				<a href = "javascript:history.go(0);">인기강좌</a>
			</div>
			
		</div>
		<div align="center" id = "lecture_h2">
			<h2>인기강좌</h2>
		</div>
		
		<div id = "lecture_menu">
			<ul>
				<li><a href = "<%= ctxPath %>/lectureApply.to" >강좌검색</a></li>
				<li><a href = "<%= ctxPath %>/recomLec.to">추천강좌</a></li> <!-- recomLec.to  -->
				<li><a href = "<%= ctxPath %>/populLec.to" class = "action">인기강좌</a></li>	<!-- populLec.to  -->
				<li><a href = "<%= ctxPath %>/lectureSchedule.to">강좌스케줄</a></li>
			</ul>
		</div>
	
	</div>
	
	<div id = "realList">
	
		<div id="listLec">
		
			<div id="listFilter">
				<div class="popup" onclick="myFunction()">
				   <span style = "color : #605752; font-size: 16pt;" data-toggle="modal" data-target="#myModal">3월 인기강좌</span>
				   <span class="popuptext" id="myPopup">Click Me&nbsp;<span class="far">&#xf59c;</span></span>
				</div>
				
							<!-- 	
					Button to Open the Modal
				  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
				    Open modal
				  </button> -->
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
										<%-- 여기 css 땜에 한줄로 쭉 썼으니 지저분해도 이해 부탁합니다 ㅠㅠ --%>
										<c:if test="${lecturevo.class_status==1 }"><span class="onApply">접수중</span></c:if><c:if test="${lecturevo.class_status==0 }"><span class="onWait">대기접수</span></c:if><c:if test="${lecturevo.class_status==2 }"><span class="closeApply">접수마감</span></c:if><span class="detailAge">${lecturevo.cate_code}강좌</span><span class="detailCat">${lecturevo.cate_name}</span>
									</div>								
									<div class="lecTitleDIV">
										<span id="lecTitle">${lecturevo.class_title}</span>
									</div>
									<div id="lecDetailInfo">
										<span class="detailInfoSpan">${lecturevo.teacher_name}</span>&nbsp;&nbsp;
										<span class="detailInfoSpan">${lecturevo.class_semester}</span>&nbsp;&nbsp;
										<span class="detailInfoSpan">(${lecturevo.class_day})&nbsp;&nbsp;${lecturevo.class_time}</span><br/>
										<span style="color: black; font-size: 11pt;"><fmt:formatNumber value="${lecturevo.class_fee}" pattern="###,###" />&nbsp;원</span>&nbsp;&nbsp;<span class="detailInfoSpan">(총 4회)</span>
									</div>
								</div>
							</div>		
							</a>				
						</li>
					</c:forEach>			
				</ul>

			</div>
			
		
		
		</div>
		
	</div>
	

  <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
      <!-- 
        Modal Header
        <div class="modal-header">
          <h4 class="modal-title"></h4>
          
        </div> -->
        
        <!-- Modal body -->
        <div class="modal-body">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
			<figure class="highcharts-figure">
			    <div id="container"></div>
			</figure>
        </div>
        <!-- 
        Modal footer
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
         -->
      </div>
    </div>
  </div>
	
</div>