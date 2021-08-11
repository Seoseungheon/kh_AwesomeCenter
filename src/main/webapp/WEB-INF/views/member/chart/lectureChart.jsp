<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>차트그리기 예제</title>

<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>

<style type="text/css">
	.highcharts-title {
		font-weight: bold;
		font-size: 12pt;
	}
</style>

<script type="text/javascript">
$(document).ready(function(){

		var param = getUrlParameter("class_seq");
		gender_Ajax(param);
		age_Ajax(param);

}); //end of $(document).ready(function(){});

function gender_Ajax(class_seq){
		
		$.ajax({
			url: "/awesomecenter/chart/genderJSON.to?",
			dataType:"JSON",
			data: { 
				"class_seq" : class_seq
				//"class_seq": 
			},
			success: function(json){
				if(json.length != 0){
				$("#chart_container").empty();
				var resultArr = [];
				for(var i=0; i<json.length; i++){
					var obj = {name: json[i].gender,
							      y: Number(json[i].CNT),
							      p: Number(json[i].PERCENTAGE)};
					resultArr.push(obj);
				}
				
				Highcharts.chart('chart_container', {
					colors: ['#99ccff', '#ff6699'],
				    chart: {
				        plotBackgroundColor: null,
				        plotBorderWidth: null,
				        plotShadow: false,
				        type: 'pie'
				    },
				    title: {
				        text: '성별 현황'
				    },
				    tooltip: {
				        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
				    },
				    accessibility: {
				        point: {
				            valueSuffix: '%'
				        }
				    },
				    plotOptions: {
				        pie: {
				            allowPointSelect: true,
				            cursor: 'pointer',
				            dataLabels: {
				                enabled: true,
				                format: '<b>{point.name}</b>: {point.y:f}명'
				            }
				        }
				    },
				    series: [{
				        name: '인원비율',
				        colorByPoint: true,
				        data: resultArr
				    }]
				});
				}
				else{
					$("#chart_container").css({'height':'30px', 'width':'160px'});
					$("#myModal").css({'width':'200px', 'height':'60px'});
					$("#chart_container").html("<span style='position: relative; right: 25px; top: 2px;'>수강생 정보가 없습니다.</span>");
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}	

function age_Ajax(class_seq){
	
	$.ajax({
		url: "/awesomecenter/chart/ageJSON.to?",
		dataType:"JSON",
		data: { 
			"class_seq" : class_seq
			//"class_seq": 
		},
		success: function(json){
			if(json.length != 0) {
			$("#chart_container2").empty();
			var resultArr = [];
			for(var i=0; i<json.length; i++){
				var obj = {name: json[i].age,
						      y: Number(json[i].percentage),
						      c: Number(json[i].cnt)};
				resultArr.push(obj);
			}
			
			Highcharts.chart('chart_container2', {
				colors: ['#99ccff'],
			    chart: {
			        type: 'column'
			    },
			    title: {
			        text: '연령대별 현황'
			    },
			    xAxis: {
			    	type: 'category'
			    },
			    yAxis: {
			    	title: {
			    		text: 'percentage'
			    	}
			    },
			    
			    tooltip: {
			        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
			        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
			    },
			    accessibility: {
			        announceNewData: {
			            enabled: true
			        }
			    },
			    plotOptions: {
			    	series: {
			            borderWidth: 0,
			            dataLabels: {
			                enabled: true,
			                format: '{point.c:f}명'
			            }
			        }
			    },
			    series: [{
			        name: '인원비율',
			        colorByPoint: true,
			        data: resultArr
			    }]
			});
			} else {
				$("#chart_container2").css({'height':'0', 'width':'0'});
			}
		},
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
	});
	
}



var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
        }
    }
};

</script>
</head>
		<div id="chart_container" style="height: 300px; width: 350px; margin: 0 auto;"></div><br><br>
		<div id="chart_container2" style="height: 300px; width: 350px; margin: 0 auto;"></div>
</html>