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
<title>QnA 목록</title>

<style type="text/css">
	.table tr td {
		height: 60px;
	}
	
	.table tr:hover {
		color: black;
		font-weight: bold;
		cursor: pointer;
	}
	
	a {
		text-decoration: none;
		color: black;
	}
	
	a:visited {
		text-decoration: none;
	}
	
	a:link {
		text-decoration: none;
	}
	
	a:active {
		text-decoration: none;
	}

	
</style>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/QnAList.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	function goView(no) {
		var frm = document.goViewFrm;
		frm.no.value = no;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath %>/QnA/QnAView.to";
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
				<a href="<%= ctxPath%>/QnA/QnAList.to" class="atag">QnA</a>
			</div>
			<div class="main_kdh">
				<h2 class="h2">Q & A</h2>
				<div class="noticeArea_kdh">
					<ul class="olulli">
						<li class="olulli">고객서비스의 [자주하는 문의]에서 자주 질문하는 답변을 보실 수 있습니다.</li>
						<li class="olulli">자주하는 문의에 없는 질문은 문의를 해주시면 빠른 시일 안에 답변을 보내드리겠습니다.</li>
						<li class="olulli">답변 내용은 마이페이지의 [Q&A]에서 확인하실 수 있습니다.</li>
					</ul>
					<a href="<%= ctxPath%>/QnA/FAQList.to" class="btn_kdh btnBlack_kdh btnType01_kdh atag"><span>자주하는 문의보기</span></a>
				</div>
				<div class="infoTable_kdh mb30_kdh">
					<table class="table">
						<colgroup>
							<col style="width: 62px;">
							<col style="width: 140px;">
							<col style="width: 160px;">
							<col style="width: auto;">
							<col style="width: 160px;">
							<col style="width: 120px;">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">No.</th>
								<th scope="col">카테고리</th>
								<th scope="col">지점명</th>
								<th scope="col">제목</th>
								<th scope="col">접수일</th>
								<th scope="col">상태</th>
							</tr>
						</thead>
						<c:if test="${sessionScope.loginuser.userid != 'admin' }">
						<tbody>	
						<c:if test="${empty QnAList }">
								<tr>
									<td colspan="6" class="noData_kdh">등록된 문의가 없습니다.</td>
								</tr>
						</c:if>
						<c:if test="${not empty QnAList }">
						<c:forEach var="qnavo" items="${QnAList }" varStatus="status">
								<tr onclick="goView('${qnavo.no}')" class="qnalist">
									<td>${qnavo.rrno }</td>
									<td>
									<c:if test="${qnavo.categoryno_fk eq 1}">
										회원가입
									</c:if>
									<c:if test="${qnavo.categoryno_fk eq 2}">
										수강신청
									</c:if>
									<c:if test="${qnavo.categoryno_fk eq 3}">
										강좌/강사
									</c:if>
									<c:if test="${qnavo.categoryno_fk eq 4}">
										환불/취소
									</c:if>
									<c:if test="${qnavo.categoryno_fk eq 5}">
										홈페이지
									</c:if>
									<c:if test="${qnavo.categoryno_fk eq 6}">
										기타
									</c:if>
									</td>
									<td>본점</td>
									<td>${qnavo.title }</td>
									<td>${qnavo.writeday }</td>
									<td>
										<c:if test="${qnavo.status eq 0 }">
											<span style="color:red;">접수중</span>
										</c:if>
										<c:if test="${qnavo.status eq 1 }">
											<span style="font-weight: bold;">답변 완료</span>
										</c:if>
									</td>
								</tr>
						</c:forEach>
						</c:if>
						</tbody>
						</c:if>
						<!-- ============================================================================ -->
						<!-- ============================================================================ -->
						<!-- ============================================================================ -->
						<c:if test="${sessionScope.loginuser.userid == 'admin' }">
						<c:if test="${empty QnAList }">
								<tr>
									<td colspan="6" class="noData_kdh">등록된 문의가 없습니다.</td>
								</tr>
						</c:if>
						<c:if test="${not empty QnAList }">
						<c:forEach var="qnavo" items="${QnAList }" varStatus="status">
								<tr onclick="goView('${qnavo.no}')" class="qnalist">
									<td>${qnavo.rrno }</td>
									<td>
									<c:if test="${qnavo.categoryno_fk eq 1}">
										회원가입
									</c:if>
									<c:if test="${qnavo.categoryno_fk eq 2}">
										수강신청
									</c:if>
									<c:if test="${qnavo.categoryno_fk eq 3}">
										강좌/강사
									</c:if>
									<c:if test="${qnavo.categoryno_fk eq 4}">
										환불/취소
									</c:if>
									<c:if test="${qnavo.categoryno_fk eq 5}">
										홈페이지
									</c:if>
									<c:if test="${qnavo.categoryno_fk eq 6}">
										기타
									</c:if>
									</td>
									<td>본점</td>
									<td>${qnavo.title }</td>
									<td>${qnavo.writeday }</td>
									<td>
										<c:if test="${qnavo.status eq 0 }">
											<span style="color:red;">접수중</span>
										</c:if>
										<c:if test="${qnavo.status eq 1 }">
											<span style="font-weight: bold;">답변 완료</span>
										</c:if>
									</td>
								</tr>
						</c:forEach>
						</c:if>
						</c:if>
					</table>
				</div>		
				
				<form name="goViewFrm">
				<input type="hidden" name="no" /> 
				</form>
				
				<c:if test="${not empty QnAList }">
					<div align="center" style="">
						${pageBar}
					</div>		
				</c:if>
				
<c:if test="${sessionScope.loginuser.userid != 'admin' }">
				<div class="btnArea_kdh">
					<div class="rightArea_kdh">
						<a href="<%= ctxPath %>/QnA/QnAWrite.to" class="btn_kdh btnType02_kdh btnWhite_kdh atag"><span>문의하기</span></a>
					</div>
				</div>
</c:if>
			</div>
		</div>
	</div>

</body>
</html>