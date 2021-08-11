<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>



<!DOCTYPE html>
<html lang="ko">
<head>
    
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    
    <title>으뜸문화센터</title>
    
    <meta name="keywords" content="롯데문화센터">
    <meta name="description" content="">
    <meta name="format-detection" content="telephone=no">
    
        <meta charset="euc-kr" />
        <meta property="fb:app_id" content=""/>
        <meta property="og:url" content="">
        <meta property="og:type" content="website">
        <meta property="og:title" content="">
        <meta property="og:description" content="">
        <meta name="twitter:card" content="summary">
        <meta name="twitter:url" content="">
        <meta name="twitter:title" content="">
        <meta name="twitter:description" content="">
        
           <meta property="og:image" content="">
           <meta name="twitter:image" content="">
        
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/RegGuide.css">



    
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.0.2/TweenMax.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/malihu-custom-scrollbar-plugin/3.1.5/jquery.mCustomScrollbar.concat.min.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
    <script type="text/javascript">
    var LOGIN_MEMBER = false;    
    //console.log('LOGIN_MEMBER=['+LOGIN_MEMBER+']');
    </script>
	
    
    <script type="text/javascript">
        $(function(){   
            $('.onlineGuide .applyStep a').click(function(){
                var src = $(this).attr('href');
                var top = $(src).offset().top;
                $("html,body").animate({'scrollTop':top});
                return false;
            })
            $(window).scroll(function(){
                var win = $(window);
                    winT = win.scrollTop();
                    winH = win.height();
                    obj = $('.applyStep').offset().top;
                    console.log(obj)

                if(winT > 307){
                    $('.applyStep').addClass('fixed');
                    $('.stepBox').css({'padding-top':'190px'});
                }
                else{   
                    $('.applyStep').removeClass('fixed');
                    $('.stepBox').css({'padding-top':'0px'});
                }

                $('.onlineGuide .stepBox').each(function(idx){
                    var top = $(this).offset().top; 
                    if(winT + winH - winH/2 > top){
                        $('.applyStep li').eq(idx).addClass('on').siblings().removeClass('on');
                    }else{
                        //$('.applyStep li').eq(idx).removeClass('on');
                    }           
                });
            });
        });
    </script>    
</head>
<body>
<!-- wrap : s -->
<div class="wrap">
    <!-- header : s -->
    <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-149792241-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-149792241-1');
  
</script>

	
		<script type='text/javascript' src='https://members.lpoint.com/api/js/serialize.object.js'></script>
		<script type='text/javascript' src='https://members.lpoint.com/api/js/json2.js'></script>
		<script type='text/javascript' src='/LDCS/resources/lotte.sso.api.js'></script>  
	
		
    <!-- container : s -->
    <div id="container">
        <div id="content" class="onlineGuide">
            <!-- location : s -->
            <div id = "guide_nvar" align="right" style = "margin: 40px 0;">
	            <div>
					<a href = "<%=ctxPath%>/main.to"><img src = "<%=ctxPath%>/resources/images/Home.png" ></a>
				</div>
				<div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">
					<a href = "<%= ctxPath %>/lectureApply.to">수강신청</a>
				</div>
				<div>
					<a href = "javascript:history.go(0);">온라인 신청 가이드</a>
				</div>
			</div>
            <!-- location : e -->
            <div class="inner">
                <h2>온라인 신청가이드</h2>

                <ul class="applyStep">
                    <li class="step01 on">
                        <div><a href="#step01"><span>01</span> 강좌찾기</a></div>                       
                    </li>
                    <li class="step02">
                        <div><a href="#step02"><span>02</span> 강좌정보 확인</a></div>
                    </li>
                    <li class="step03">
                        <div><a href="#step03"><span>03</span> 수강 결제/장바구니 담기</a></div>
                    </li>
                    <li class="step04">
                        <div><a href="#step04"><span>04</span> 수강 결제</a></div>
                    </li>
                </ul>

                <div class="stepBox" id="step01">
                    <h3 class="stit">01. 강좌찾기</h3>
                    <p class="stxt">수강 신청하고자 하는 강좌를 [수강신청>강좌검색] 또는 [수강신청>강좌스케줄]에서 찾으시기 바랍니다. </p>
                    <div>
                        <strong>수강신청 > 강좌검색에서 찾기</strong>
                        <img src="<%= ctxPath %>/resources/shimages/guide_step01_2.jpg" alt="" />
                    </div>
                </div>
                <div class="stepBox" id="step02">
                    <h3 class="stit">02. 강좌정보 확인하기</h3>
                    <p class="stxt">검색화면에서 신청하고자 하는 강좌명을 클릭 후 해당 강좌 정보를 확인하시기 바랍니다.</p>
                    <div><img src="<%= ctxPath %>/resources/shimages/guide_step02.jpg" alt="" /></div>
                </div>
                <div class="stepBox" id="step03">
                    <h3 class="stit">03. 수강 결제/장바구니 담기</h3>
                    <p class="stxt">신청할 강좌정보 화면의 하단에 있는 장바구니 버튼이나 결제하기 버튼을 클릭해 주시기 바랍니다.</p>
                    <div><img src="<%= ctxPath %>/resources/shimages/guide_step03.jpg" alt="" /></div>
                </div>
                <div class="stepBox" id="step04">
                    <h3 class="stit">04. 개인정보확인 및 수강 결제</h3>
                        <p class="stxt">강좌를 수강하기 위해 개인정보 확인 후 결제를 진행해 주시기 바랍니다.</p>
                    <div><img src="<%= ctxPath %>/resources/shimages/guide_step04.jpg" alt="" style="border-top:1px solid #eee;"/></div>
                </div>

            </div>
            
            
  
 			<button id = "sidebanner" type="button" onclick="$('html').animate({scrollTop : 0})"><span class="glyphicon">&#xe260;</span></button>
            
        </div>
    </div>
    <!-- container : e -->
    <!-- footer : s -->
    

</div>
<!-- wrap : e -->
</body>
</html>