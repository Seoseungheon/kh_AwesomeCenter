<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/QnAWrite.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

</script>

</head>
<body>

	<div id="container_kdh">
		<div id="content_kdh">

            <div class="menu_kdh">
				<a href="#" class="material-icons atag">home</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">My문화센터</a>
				<a href="<%= ctxPath%>/QnA/QnAList.to" class="atag">1:1문의</a>
			</div>

			<div class="main_kdh">
				<h2 class="h2">Q & A</h2>

				<div class="noticeArea_kdh">
					<ul class="olulli">
						<li class="olulli">고객서비스의 [자주하는 문의]에서 자주 질문하는 답변을 보실 수 있습니다.</li>
						<li class="olulli">자주하는 문의에 없는 질문은 1:1 문의를 해주시면 빠른 시일 안에 답변을 보내드리겠습니다.</li>
						<li class="olulli">답변 내용은 마이페이지의 [1:1 문의]에서 확인하실 수 있습니다.</li>
					</ul>
					<a href="<%= ctxPath%>/QnA/FAQList.to" class="btn_kdh btnBlack_kdh btnType01_kdh atag"><span>자주하는 문의보기</span></a>
				</div>
				<!-- notiBoxArea : e -->
				<div class="completeArea_kdh">
					<dl>
						<dt>고객님 문의가 정상적으로 <em>접수완료</em> 되었습니다.</dt>
						<dd>빠른 시일 안에 답변 드리도록 하겠습니다.</dd>
						<dd>수강내역 조회 및 취소, 수강증을 확인하실 수 있습니다.</dd>
					</dl>
				</div>

				<div class="btnArea_kdh">
					<div class="rightArea_kdh">
						<a href="<%= ctxPath%>/QnA/QnAList.to" class="btn_kdh btnType02_kdh btnWhite_kdh atag" style="color:black;"><span>목록</span></a>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>