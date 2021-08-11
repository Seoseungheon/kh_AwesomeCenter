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
<title>Insert title here</title>

<style type="text/css">

	table {
		width: 1160px;
	}
	
</style>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/QnAWrite.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	function delQuestion(no) {
		
		var frm = document.deleditFrm;
		frm.no.value = no;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath %>/QnA/QnADelete.to";
		frm.submit();
		
	}
	
	function editQuestion(no) {
		var frm = document.deleditFrm;
		frm.no.value = no;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath %>/QnA/QnAEdit.to";
		frm.submit();		
	}
	
	function writeAnswer(no) {
		var frm = document.deleditFrm;
		frm.no.value = no;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath %>/QnA/writeAnswer.to";
		frm.submit();		
	}
	
	function editAnswer(no) {
		var frm = document.deleditFrm;
		frm.no.value = no;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath %>/QnA/editAnswer.to";
		frm.submit();		
	}

</script>

</head>
<body>

	<div id="container_kdh">
		<div id="content_kdh">
		
			<div class="menu_kdh">
				<a href="#" class="material-icons atag">home</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">My문화센터</a>
				<a href="<%= ctxPath%>/QnA/QnAList.to" class="atag">Q&A</a>
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

				<form name="detailForm" class="form">
				<div class="infoTable_kdh aLeft_kdh mb30_kdh">
					<table>
						<colgroup>
							<col style="width: 12%;">
							<col style="width: 38%;">
							<col style="width: 12%;">
							<col style="width: 38%">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">제목</th>
								<td colspan="3">${qna.title }</td>
							</tr>
							<tr>
								<th scope="row">카테고리</th>
								<td>
								<c:if test="${qna.categoryno_fk eq 1}">
										회원가입
								</c:if>
								<c:if test="${qna.categoryno_fk eq 2}">
										수강신청
								</c:if>
								<c:if test="${qna.categoryno_fk eq 3}">
										강좌/강사
								</c:if>
								<c:if test="${qna.categoryno_fk eq 4}">
										환불/취소
								</c:if>
								<c:if test="${qna.categoryno_fk eq 5}">
										홈페이지
								</c:if>
								<c:if test="${qna.categoryno_fk eq 6}">
										기타
								</c:if>
								</td>
								<th scope="row">지점</th>
								<td>본점</td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3" class="tdcontent_kdh">
									<div style="margin-top: 20px;">
									${qna.content }
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">답변</th>
								<td colspan="3" class="tdanswer_kdh">
									<div>
										<c:if test="${empty qna.answer}">
											-
										</c:if>
										<c:if test="${not empty qna.answer}">
											${qna.answer }
										</c:if>
									</div>
							</tr>
							
						</tbody>
					</table>
				</div>
				</form>
				
<c:if test="${sessionScope.loginuser.userid != 'admin' }">				
				<div class="btnArea_kdh">
					<div class="leftArea_kdh">
						<a href="<%= ctxPath%>/QnA/QnAList.to" class="btn_kdh btnType02_kdh btnWhite_kdh atag"><span>목록</span></a>
					</div>
					<div class="rightArea_kdh">
					<c:if test="${empty qna.answer}">
						<a href="#" onclick="editQuestion('${qna.no}');" id="dUpdate" class="btn_kdh btnType02_kdh btnBlack_kdh atag"><span>수정</span></a>
						<a href="#" onclick="delQuestion('${qna.no}')" id="dDelete" class="btn_kdh btnType02_kdh btnRed_kdh atag"><span>삭제</span></a>
					</c:if>
					<c:if test="${not empty qna.answer}">
						<a href="#" onclick="delQuestion('${qna.no}')" id="dDelete" class="btn_kdh btnType02_kdh btnRed_kdh atag"><span>삭제</span></a>
					</c:if>
					</div>
				</div>
</c:if>
<c:if test="${sessionScope.loginuser.userid == 'admin' }">
				<div class="btnArea_kdh">
					<div class="leftArea_kdh">
						<a href="<%= ctxPath%>/QnA/QnAList.to" class="btn_kdh btnType02_kdh btnWhite_kdh atag"><span>목록</span></a>
					</div>
					<div class="rightArea_kdh">
					<c:if test="${empty qna.answer}">
						<a href="#" onclick="writeAnswer('${qna.no}');" id="dUpdate" class="btn_kdh btnType02_kdh btnBlack_kdh atag"><span>답하기</span></a>
					</c:if>
					<c:if test="${not empty qna.answer}">
						<a href="#" onclick="editAnswer('${qna.no}')" id="dDelete" class="btn_kdh btnType02_kdh btnRed_kdh atag"><span>수정</span></a>
					</c:if>
					</div>
				</div>
</c:if>				
				<form name="deleditFrm">
					<input type="hidden" name="no"/>
				</form>
			</div>
		</div>
	</div>

</body>
</html>