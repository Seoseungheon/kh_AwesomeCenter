<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
	//	/startspring
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>차트그리기 예제</title>

<style type="text/css">

	.ch_tb{
		border: solid 1px black;
		margin: 0 auto; 
	}
	
	#memberList_h2 h2 {
   
      font-weight: 500;
      font-size: 52px;
      margin-bottom: 20px;
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
   



</style>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("#searchType").bind("change",function(){
			func_Ajax($(this).val()); //select 태그의 value 값
		});
		
		$("#chart_container").empty();
	}); // end of document ------------------

	function func_Ajax(searchTypeVal){
		
		switch(searchTypeVal){ // 넘어온 값 
			case "class":
				$.ajax({
					url:"/awesomecenter/adminTotalClass.to",
//					data: {"YEAR":item.YEAR},
					dataType:"JSON",
					success: function(json){
						$("#chart_container").empty();
						
						var classArr = [];
						
						$.each(json,function(index, item){
							classArr.push( {
			                    name: item.CATENAME,
			                    y: Number(item.CATETOTAL), /* String 타입인 percentage 꼭 number로 바꿔준다★ */
			                    drilldown: item.CATENAME
			                    
			                });
							
						});   // end of $.each(json,function(index, item) --- 여기까지가 클릭 전 처음 차트 화면 
						
						var monthArr = [];		
						     // ↓ 
						$.each(json, function(index2, item2){
							
							$.ajax({
								url:"/awesomecenter/DetailMonthclass.to",
								type: "GET",
								data: {"catename":item2.CATENAME},  // 연도 보내기 
								dataType:"JSON",
								success: function(json2){
									// 배열 속에 배열이 들어오고 있음 
									var subArr = []; 
									
									$.each(json2, function(index3, item3){
										subArr.push([
													item3.CLASSMONTH,
													Number(item3.CLASSMONTHSUM)
													]); 
									}); // end of $.each(json2, function(index3, item3) --------------
									
									monthArr.push({
										name: item2.CATENAME,
										id: item2.CATENAME,
										data: subArr
									});
								
								},
								error: function(request, status, error){
									alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
								}
							});
						});  // end of $.each(json, function(index2, item2) ----------------
							
						// 반복문 빠져나온 후 차트 보이기 //////////////////////////////////
						// Create the chart 
						Highcharts.chart('chart_container', {
						    chart: {
						        type: 'column'
						    },
						    title: {
						        text: '2020년 강좌별 매출 통계'
						    },
						    subtitle: {
						        text: '카테고리를 클릭하시면  월별 통계가 보입니다.'
						    },
						    accessibility: {
						        announceNewData: {
						            enabled: true
						        }
						    },
						    xAxis: {
						        type: 'category'
						    },
						    yAxis: { // y축 
						        title: {
						            text: '매출액(원)'
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
						                format: '{point.y}'
						            }
						        }
						    },
						
						    tooltip: {
						        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
						        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b>원<br/>'
						    },
						
						    series: [
						        {
						            name: "매출액",
						            colorByPoint: true,
						            data: classArr // *** 위에서 구한 값을 대입시킴 ***
						        }
						    ],
						    drilldown: {
						        series: monthArr // *** 위에서 구한 값을 대입시킴 ***
						    }
						});
						/////////////////////////////////////////////////////////		
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
				
				break;
				
				case "teacher":
					$.ajax({
						url:"/awesomecenter/teacherClass.to",
//						data: {"YEAR":item.YEAR},
						dataType:"JSON",
						success: function(json){
							$("#chart_container").empty();
							
							var classArr = [];
							
							$.each(json,function(index, item){
								classArr.push( {
				                    name: item.CATENAME,
				                    y: Number(item.COUNT), /* String 타입인 percentage 꼭 number로 바꿔준다★ */
				                    drilldown: item.CATENAME
				                    
				                });
								
							});   // end of $.each(json,function(index, item) --- 여기까지가 클릭 전 처음 차트 화면 
							
							var monthArr = [];		
							     // ↓ 
							$.each(json, function(index2, item2){
								
								$.ajax({
									url:"/awesomecenter/teacherGender.to",
									type: "GET",
									data: {"catename":item2.CATENAME},  
									dataType:"JSON",
									success: function(json2){
										// 배열 속에 배열이 들어오고 있음 
										var subArr = []; 
										
										$.each(json2, function(index3, item3){
											subArr.push([
														item3.GENDER,
														Number(item3.PERCENTAGE)
														]); 
										}); // end of $.each(json2, function(index3, item3) --------------
										
										monthArr.push({
											name: item2.CATENAME,
											id: item2.CATENAME,
											data: subArr
										});
									
									},
									error: function(request, status, error){
										alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
									}
								});
							});  // end of $.each(json, function(index2, item2) ----------------
								
							// 반복문 빠져나온 후 차트 보이기 //////////////////////////////////
							// Create the chart 
							Highcharts.chart('chart_container', {
							    chart: {
							        type: 'column'
							    },
							    title: {
							        text: '2020년 강좌별 강사 통계'
							    },
							    subtitle: {
							        text: '카테고리를 클릭하시면 성별(백분율)이 나타납니다.'
							    },
							    accessibility: {
							        announceNewData: {
							            enabled: true
							        }
							    },
							    xAxis: {
							        type: 'category'
							    },
							    yAxis: { // y축 
							        title: {
							            text: '강사수(명)'
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
							                format: '{point.y}'
							            }
							        }
							    },
							
							    tooltip: {
							    	 headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
								     pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
							    },
							
							    series: [
							        {
							            name: "강사수",
							            colorByPoint: true,
							            data: classArr // *** 위에서 구한 값을 대입시킴 ***
							        }
							    ],
							    drilldown: {
							        series: monthArr // *** 위에서 구한 값을 대입시킴 ***
							    }
							});
							/////////////////////////////////////////////////////////		
						},
						error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
					});
					
					break;	
				
			case "year":
				$.ajax({
					url:"/awesomecenter/adminMemberChart.to",
//					data: {"YEAR":item.YEAR},
					dataType:"JSON",
					success: function(json){
						$("#chart_container").empty();
						
						var yearArr = [];
						
						$.each(json,function(index, item){
							yearArr.push( {
			                    name: item.YEAR,
			                    y: Number(item.YEARSUM), /* String 타입인 percentage 꼭 number로 바꿔준다★ */
			                    drilldown: item.YEAR
			                    
			                });
							
						});   // end of $.each(json,function(index, item) --- 여기까지가 클릭 전 처음 차트 화면 
						
						var monthArr = [];		
						     // ↓ 
						$.each(json, function(index2, item2){
							
							$.ajax({
								url:"/awesomecenter/ChartDetailMonth.to",
								type: "GET",
								data: {"year":item2.YEAR},  // 연도 보내기 
								dataType:"JSON",
								success: function(json2){
									// 배열 속에 배열이 들어오고 있음 
									var subArr = []; 
									
									$.each(json2, function(index3, item3){
										subArr.push([
													item3.MONTH,
													Number(item3.MONTHSUM)
													]); 
									}); // end of $.each(json2, function(index3, item3) --------------
									
									monthArr.push({
										name: item2.YEAR,
										id: item2.YEAR,
										data: subArr
									});
								
								},
								error: function(request, status, error){
									alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
								}
							});
						});  // end of $.each(json, function(index2, item2) ----------------
							
						// 반복문 빠져나온 후 차트 보이기 //////////////////////////////////
						// Create the chart 
						Highcharts.chart('chart_container', {
						    chart: {
						        type: 'column'
						    },
						    title: {
						        text: '연도별 매출 통계'
						    },
						    subtitle: {
						        text: '연도를 클릭하시면 해당 연도의 월별 통계가 보입니다.'
						    },
						    accessibility: {
						        announceNewData: {
						            enabled: true
						        }
						    },
						    xAxis: {
						        type: 'category'
						    },
						    yAxis: { // y축 
						        title: {
						            text: '매출액(원)'
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
						                format: '{point.y}'
						            }
						        }
						    },
						
						    tooltip: {
						        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
						        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b>원<br/>'
						    },
						
						    series: [
						        {
						            name: "매출액",
						            colorByPoint: true,
						            data: yearArr // *** 위에서 구한 값을 대입시킴 ***
						        }
						    ],
						    drilldown: {
						        series: monthArr // *** 위에서 구한 값을 대입시킴 ***
						    }
						});
						/////////////////////////////////////////////////////////		
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
				
				break;	
		}
		
	} // end of function func_Ajax(searchTypeVal)
	

</script>

</head>
<body>
	<div align="center">
		 <div id = "admin_nvar" align="right" style = "margin: 40px 180px 0 0;">   
            <div style = "border-right: 1px solid #e5e5e5; padding : 0 12px; margin : 0;" ><i class="fa fa-lock" style="font-size:15px; padding:2px 6px 0 0;"></i>관리자 전용 메뉴</div>
            <div>매출·수입 통계</div>
  		 </div>

	     <div align="center" id = "memberList_h2">
	         <h2>매출 · 수입 통계</h2>
	     </div>
		
		<form name="searchFrm" style="margin-bottom: 80px;">
			<select name="searchType" id="searchType" style="height:35px; width: 150px;">
				<option value="">통계선택</option>
				<option value="year">연도별 매출 통계</option>
				<option value="class">강좌별 매출 통계</option>
				<option value="teacher">강좌별 강사 통계</option>
			</select>
		</form>
	
		<div id="chart_container" style="min-width: 300px; height:400px; max-width:600px; margin:0 auto; padding-bottom: 100px;"></div>
	
	</div>
	
	
</body>
</html>