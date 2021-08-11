<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/FAQList.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
	.boardContainer {
		width: 100%;
		margin: 0 auto;
		margin-bottom: 10px;
		font-family: 'Nanum Gothic', '나눔고딕', '돋움', Dotum, sans-serif;
	}
	
	#board .hm_h1{
		text-align: center;
		margin: 0 auto;
		margin-top: 40px;
		margin-bottom: 70px;
		font-weight: bold;
		font-family: 'Notokr', sans-serif;
	}
	
	#board .boardTabli span{
		text-align: center;
		font-size: 13pt;
		list-style-type: none;
		cursor: pointer;
		color: #c8c8c8;
		font-weight: bold;
	}
	
	#board .tabon{
		color: #000 !important;
	}
	
	#board .boardTabli{
		text-align: center;
		font-size: 15pt;
		list-style-type: none;
		cursor: pointer;
	}
	
	#board .col-md-2{
		border-bottom: solid 2px #000;
		border-top: solid 1px #c8c8c8;
		border-left: solid 1px #c8c8c8;
		border-right: solid 1px #c8c8c8;
		margin-left: -1px;
	}
	
	#board .tabClick{
		border-bottom: solid 2px #ffffff;
		border-top: solid 2px #000;
		border-left: solid 2px #000;
		border-right: solid 2px #000;
		background: #ffffff !important;
	}
	
	#board .tabMenu{
		height: 40px;
		line-height: 40px;
		background-color: #f9f9f9;
	}
	
	#board .tabClick span{
		color: #000;
	}
	
	#board ul.hm{
		display: inline;
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
	
	#board .hm_tbody{ 
		font-size: 9pt;  
		text-align: left;
	}
	
	#boardTbl td{
		vertical-align: middle;
		cursor: pointer;
		height: 80px;
	}
	<%-- 게시판 내용 CSS 끝 --%>
	
</style>
<script type="text/javascript">

/*************************************************************/
/*	페이지 새로고침 없이 게시판 변경을 위해 show, hide 사용  */
/*************************************************************/

$(document).ready(function(){
	
	$(".answer_kdh").css('display','none');
	
 	/* 페이지 로딩 시 첫번째 게시판 출력 */ 
	$(".board").hide();
	$("#BEST5").show();
	$("#tab1").addClass("tabClick");
	
	/* 우상단 텍스트 표시 */
	var top_comment = $(".tabClick").text();
	
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
	
	showAnswer();
	
/* 	 $(".question_kdh").bind('click',function(){
		var answer = $(this).next();
		
		if(answer.css('display','none')){
			answer.show();
		} else {
			answer.hide();
		}
	});   */
 	
	}); //end of $(document).ready(function(){}
	
	function showAnswer(){
		var question = document.getElementsByClassName("question_kdh");

		for (var i = 0; i < question.length; i++) {
		  question[i].addEventListener("click", function() {

		    var answer = this.nextElementSibling;

		    if (answer.style.display === "block") {
		      answer.style.display = "none";
		    } else {
		      answer.style.display = "block";
		    }
		  });
		}
	}
	
</script>

	    <div id="container_kdh">
        <div id="content_kdh">
           
            <div class="menu_kdh">
				<a href="#" class="material-icons atag">home</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">My문화센터</a>
				<a href="<%= ctxPath%>/QnA/FAQList.to" class="atag">FAQ</a>
			</div>
           
            <div class="main_kdh">
                <h2 class="h2">FAQ</h2>

                <div class="noticeArea_kdh">
                    <ul class="olulli">
                        <li class="olulli">자주하는 문의에서 찾을 수 없는 답변은 문의를 통해 궁금한점을 보내 주시기 바랍니다.</li>
                        <li class="olulli">답변 내용은 마이페이지의 [문의]에서 확인하실 수 있습니다.</li>
                    </ul>
                    <a id="dGoInquiryList" href="<%= ctxPath %>/QnA/QnAList.to" class="btn_kdh btnBlack_kdh btnType01_kdh atag"><span>문의하기</span></a>
                </div>

<div id="board" class="boardContainer">	

	<div class="row" style="margin: 0 auto;">
		<ul class="hm">
			<li class="boardTabli"><div id="tab1" class="col-md-2 tabMenu" rel="BEST5"><span>질문 BEST 5</span></div></li>
		    <li class="boardTabli"><div id="tab2" class="col-md-2 tabMenu" rel="Register"><span>회원가입</span></div></li>
		    <li class="boardTabli"><div id="tab3" class="col-md-2 tabMenu" rel="Request_cancel"><span>수강신청·취소</span></div></li>
		    <li class="boardTabli"><div id="tab4" class="col-md-2 tabMenu" rel="lecture_teacher"><span>강좌·강사</span></div></li>
		    <li class="boardTabli"><div id="tab4" class="col-md-2 tabMenu" rel="homepage"><span>지점·홈페이지</span></div></li>
		    <li class="boardTabli"><div id="tab4" class="col-md-2 tabMenu" rel="etc"><span>기타</span></div></li>
	    </ul>
	</div>
	
 	<div id="BEST5" class="board">
		<jsp:include page="BEST5.jsp"/>
	</div>
	
	<div id="Register" class="board">
		<jsp:include page="Register.jsp"/>
	</div>
	
	<div id="Request_cancel" class="board">
		<jsp:include page="Request_cancel.jsp"/>
	</div>
	
	<div id="lecture_teacher" class="board">
		<jsp:include page="lecture_teacher.jsp"/>
	</div>
	
	<div id="homepage" class="board">
		<jsp:include page="homepage.jsp"/>
	</div>
	
	<div id="etc" class="board">
		<jsp:include page="etc.jsp"/>
	</div>
</div>
</div>
</div>
</div>
	