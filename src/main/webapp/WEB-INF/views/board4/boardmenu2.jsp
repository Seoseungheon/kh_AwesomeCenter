<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
	
	.boardContainer {
		width: 80%;
		margin: 0 auto;
		margin-bottom: 90px;
		padding-top: 40px;
		font-family: 'Nanum Gothic', '나눔고딕', '돋움', Dotum, sans-serif;
	}
	
	#board_h2{
		text-align: center;
		margin: 0 auto;
		margin-top: 40px;
		margin-bottom: 60px;
		font-weight: bold;
		font-family: 'Notokr', sans-serif;
	}
 
   #board_h2 h2 {
   
      font-weight: 500;
      font-size: 52px;
      margin-top: 50px;
      margin-bottom: 20px;
      letter-spacing: -3px;
      font-family: "Noto Sans Kr";
      
   
   }
   
    #board_nvar div {    
      display: inline-block;
      font-size: 14px;
      margin: 2px 12px 0;
      color : #666;
      font-weight: bold;
   }
 
	
	#board .boardTabli span{
		text-align: center;
		font-size: 13pt;
		list-style-type: none;
		cursor: pointer;
		color: black;
		font-weight: bold;
	}
	
	#board .tabon{
		color: #9d6849 !important;
	}
	
	#board .boardTabli{
		text-align: center;
		font-size: 15pt;
		list-style-type: none;
		cursor: pointer;
	}
	
	#board .col-md-3{
		border-bottom: solid 2px #7a6258;
		border-top: solid 1px #c8c8c8;
		border-left: solid 1px #c8c8c8;
		border-right: solid 1px #c8c8c8;
		margin-left: -1px;
	}
	
	#board .tabClick{
		border-bottom: solid 2px #ffffff;
		border-top: solid 2px #7a6258;
		border-left: solid 2px #7a6258;
		border-right: solid 2px #7a6258;
		background: #ffffff !important;
	}
	
	#board .tabMenu{
		height: 40px;
		line-height: 40px;
		background-color: #f9f9f9;
		
		
	}
	
	#board .tabClick span{
		color: #9d6849;
	}
	
	#board ul.hm{
		display: inline;
		padding: 3px;	
	}
	
	#board #top_comment {
		color: gray;
		float: right;
		font-size: 9pt;
	}
	
	<%-- 게시판 내용 CSS 시작 --%>
	#board .hm_thead > tr > th{ 
		font-size: 10pt; 
		text-align: center;
	}
	
	#board .hm_tbody { 
		font-size: 9pt;  
		text-align: center;
	}
	
	#boardTbl td {
		vertical-align: middle;
	}
	<%-- 게시판 내용 CSS 끝 --%>
	
</style>
<script type="text/javascript">

/*************************************************************/
/*	페이지 새로고침 없이 게시판 변경을 위해 show, hide 사용  */
/*************************************************************/

$(document).ready(function(){
	
	/* 우상단 경로 앞에 들어올 문자열 */
	var top_commentPrev = "Home>Mypage>";
	
 	/* 페이지 로딩 시 첫번째 게시판 출력 */ 
	$(".board").hide();
	$("#board2").show();
	$("#tab2").addClass("tabClick");
	
	
	/* 우상단 텍스트 표시 */
	var top_comment = $(".tabClick").text();
	$("#top_comment").text(top_commentPrev + top_comment);
	
	$(".tabMenu").click(function(){
		var rel = $(this).attr("rel");
		location.href= rel + ".to";
	});
	
	<%-- 
	/* 탭 클릭시 이벤트: 탭 1개면 클릭이벤트 삭제 */
	$(".tabMenu").click(function(){
		$(".board").hide();
		$(".tabMenu").removeClass("tabClick");
		
		var rel = $(this).attr("rel");
        $("#" + rel).show()
        
		$(this).addClass("tabClick");
        
        /* 우상단 텍스트 현재 게시판 이름으로 변경 */
        var top_comment = $(".tabClick").text();
		$("#top_comment").text(top_commentPrev + top_comment);
	});
	
	$(".tabMenu").hover(function(){
		$(this).find('span').addClass("tabon");
	},function(){
		$(this).find('span').removeClass("tabon");
	}); 
	--%>
	
});//end of $(document).ready(function(){}

</script>

<div id="board" class="boardContainer">
	<!-- <span id="top_comment"></span><br> -->
	
	<div id = "board_nvar" align="right" style = "margin: 1px -1px;">
         <div><i class = "fa fa-home"></i></div>
         <div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">커뮤니티</div>
         <div>게시판</div>
      </div>
	<div id="board_h2">
		<h2>게시판</h2>
	</div>
	
	<div class="row" style="margin: 0 auto; ">
		<ul class="hm">
			<li class="boardTabli"><div id="tab1" class="col-md-3 tabMenu" rel="boardmenu"><span>공지사항</span></div></li>
		    <li class="boardTabli"><div id="tab2" class="col-md-3 tabMenu" rel="boardmenu2"><span>이벤트</span></div></li>
		    <li class="boardTabli"><div id="tab3" class="col-md-3 tabMenu" rel="boardmenu3"><span>개설 희망</span></div></li>
		    <li class="boardTabli"><div id="tab4" class="col-md-3 tabMenu" rel="boardmenu4"><span>수강 후기</span></div></li>
	    </ul>
	</div>
	
	
	<div id="board2" class="board">
		<jsp:include page="eventBoard.jsp"/>
	</div>
	
</div>
	