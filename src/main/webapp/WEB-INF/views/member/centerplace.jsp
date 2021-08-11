<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/centerplace.css" />

<style type="text/css">
.mySlides {display: none}
img {vertical-align: middle;}

/* Slideshow container */
.slideshow-container {
  max-width: 1000px;
  position: relative;
  margin: auto;
}

/* Next & previous buttons */
.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  padding: 16px;
  margin-top: -22px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
  user-select: none;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
}

/* Caption text */
.text {
  color: #f2f2f2;
  font-size: 15px;
  padding: 8px 12px;
  position: absolute;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* The dots/bullets/indicators */
.dot {
  cursor: pointer;
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active, .dot:hover {
  background-color: #717171;
}

/* Fading animation */
.fade {
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 1.5s;
}

@-webkit-keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

#map > div:nth-child(4) {
	top: 190px !important;
}

#map > div:nth-child(2) > div > div:nth-child(1) > div:nth-child(3) > div:nth-child(3) > div > div {
	border: 2px solid gray !important;
}

#map > div:nth-child(2) > div > div:nth-child(1) > div:nth-child(3) > div:nth-child(3) > div > div > div:nth-child(2) {
	border-color: gray transparent transparent !important;
	bottom: -50px !important;
}

</style>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=1wjoj2tr7k"></script>
<script type="text/javascript">

$(function(){
	showSlides(1);		
});

var slideIndex = 1;

// Next/previous controls
function plusSlides(n) {
  showSlides(slideIndex += n);
}

// Thumbnail image controls
function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  
  if (n > slides.length) {
	  slideIndex = 1
	 }
  if (n < 1) {
	  slideIndex = slides.length
	 }
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " active";
}

</script>



</head>

	<div id="container_kdh">
		<div id="content_kdh">
		
			<div class="menu_kdh">
				<a href="#" class="material-icons atag">home</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">이용안내</a>
				<a href="<%= ctxPath%>/centerplace.to" class="atag">센터찾기</a>
			</div>
			
			<div class="main_kdh">
				<h2 class="h2">센터 안내</h2>
				<br><hr>
			</div>
			
			<div class="placeArea" style="width:1160px; margin: 0 auto;">
			
			<div class="placeImg" style="position:relative;">
			<div>
			<!-- Slideshow container -->
			<div class="slideshow-container">
			  <!-- Full-width images with number and caption text -->
			  <div class="mySlides fade">
			    <div class="numbertext">1 / 3</div>
			    <img src="/awesomecenter/resources/dhimages/centerimages/314.jpg" width=100%; height=100%; style="width:800px height:507px;">
			  </div>
			  <div class="mySlides fade">
			    <div class="numbertext">2 / 3</div>
			    <img src="/awesomecenter/resources/dhimages/centerimages/305.jpg" width=100%; height=100%; style="width:800px height:507px;">
			  </div>
			  <div class="mySlides fade">
			    <div class="numbertext">3 / 3</div>
			    <img src="/awesomecenter/resources/dhimages/centerimages/316.jpg" width=100%; height=100%; style="width:800px height:507px;">
			  </div>
			  
			  <!-- Next and previous buttons -->
			  <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
			  <a class="next" onclick="plusSlides(1)">&#10095;</a>
			</div>
			<br>
			<!-- The dots/circles -->
			<div style="text-align:center">
			  <span class="dot" onclick="currentSlide(1)"></span>
			  <span class="dot" onclick="currentSlide(2)"></span>
			  <span class="dot" onclick="currentSlide(3)"></span>
			</div>
			</div>
			
			</div>
			
			<div class="placeInfo" style="position:relative;">
				<div>
					<span class="stxt">으뜸 문화센터</span>
					<strong class="placeName">본점</strong>
				</div>
				
				<ul>
					<li class="ico01">
						서울특별시 중구 남대문로 120 <br />대일빌딩 2F, 3F
					</li>
					<li class="ico02">
						1544-9970
					</li>
					<li class="ico03">
						강의실 6실
					</li>
				</ul>
			</div>
			
			</div>
			
				<div class="main_kdh" style="height: 80px;">
					<h2 class="h2">오시는 길</h2>
				</div>
				
			<div class="trafficArea">
				<div class="cont" style="width: 1160px; margin: 0 auto;">
					<div class="mapArea">
						<div id="map" style="width:1160px; height:470px; position:relative; overflow:hidden;">
							<script>
							var HOME_PATH = window.HOME_PATH || '.';
							var center = new naver.maps.LatLng(37.567908, 126.983069),
							    map = new naver.maps.Map('map', {
							        center: center,
							        scaleControl: false,
							        logoControl: false,
							        mapDataControl: false,
							        zoomControl:true,
							        minZoom: 1
							    }),
							    marker = new naver.maps.Marker({
							        map: map,
							        position: center
							    });
						    
							var contentString = [
							        '<div class="iw_inner" style="width: 270px; height: 200px;" align="center">',
							        '   <h3>으뜸 문화센터</h3>',
							        '   서울특별시 중구 남대문로 120 <br />대일빌딩 2F, 3F<br/>',
							        '       <img src="/awesomecenter/resources/hmimages/logo2.png" width="250" height="55" alt="으뜸 문화센터" class="thumb" /><br />',
							        '       | T: 1544-9970 / F: 02-722-0858 |',
							        '       <br /><a id="link" href="http://localhost:9090/awesomecenter/main.to" target="_blank" style="padding-left: 10px;">www.awesomecenter.com</a>',
							        '   </p>',
							        '</div>'
							    ].join('');

							var infowindow = new naver.maps.InfoWindow({
							    content: contentString,
							    width: 270,
							    height: 222,
							    backgroundColor: "#eee",
							    borderColor: "#2db400",
							    borderWidth: 5,
							    anchorSize: new naver.maps.Size(30, 30),
							    anchorSkew: true,
							    anchorColor: "#eee",
							    pixelOffset: new naver.maps.Point(20, -20)
							});

							naver.maps.Event.addListener(marker, "click", function(e) {
							    if (infowindow.getMap()) {
							        infowindow.close();
							    } else {
							        infowindow.open(map, marker);
							    }
							});
							
							
							
							</script>
						</div>
					</div>
					
					<div class="trafficInfo">
						<dl class="bus">
							<dt>버스 이용 시  <span>BUS</span></dt>
							<dd id="dBusContent">
								<ul>
									<li class="clfix">
									<div class="busIcoWrap"><span class="bus01">간선버스</span></div><p>103, 143, 151, 162, 172, 173, 201, 262, 401, 406, 701, 704, N15, N62</p>
									</li><br><br>
									<li class="clfix">
									<div class="busIcoWrap"><span class="bus02">지선버스</span></div><p>7017, 7021, 7022</p>
									</li><br><br>
									<li class="clfix">
									<div class="busIcoWrap"><span class="bus03">광역버스</span></div><p>5500-2, 9000, 9000-1, 9200, G8110, 9401</p>
									</li>
								</ul>
							</dd>
						</dl><br><br>
						<dl class="subway">
						<hr><br>
							<dt>지하철 이용 시  <span>SUBWAY</span></dt>
							<dd id="dSubwayContent">
								<ul>
									<li class="clfix">
									<div class="subwayIcoWrap"><span class="line01">1호선</span></div><p>종각역 (도보 10분)</p>
									</li><br><br>
									<li class="clfix">
									<div class="subwayIcoWrap"><span class="line02">2호선</span></div><p>을지로입구역 (도보 10분)</p>
									</li>
								</ul>
							</dd>
						</dl>
					</div>
				</div>
			</div>
						
		</div>
	</div>	

</html>