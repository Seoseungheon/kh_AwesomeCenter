<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/mypage.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<style>
	#characterMember{
	
		color:#666666;
	}
	
	#memberdetailback{
		padding: 10px 25px 10px 25px;
		font-size: 11pt;
		margin-top: 10px;
		border: none;
		outline: none;
		cursor: pointer;
	}

</style>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
	
</script>

	<div id="container_kdh">
		<div id="content_kdh">
		
			<div class="menu_kdh">
				<a href="#" class="material-icons atag">home</a>
				<a href="<%= ctxPath%>/adminMemberList.to" class="atag">관리자 전용 메뉴</a>
				<a class="atag">회원 상세정보</a>
			</div>
			
			<div class="main_kdh memberModify_kdh">
				<h2 class="name_kdh h2"><span id="characterMember">${membervo.username}</span><span>&nbsp;님의 상세정보</span></h2>
				<div style="float: right;">
					최근수정일자 : ${membervo.editday }&nbsp;&nbsp;
					최근로그인일자 : ${membervo.lastloginday}
				</div>
				<!-- 회원정보 :s -->
				<h3 class="subtitle_kdh">회원정보</h3>
				<div class="infoTable_kdh aLeft_kdh mb15_kdh">
					<table class="table">
						<tbody>
							<tr>
							<th scope="row">회원아이디</th>
							<td>${membervo.userid}</td>
							<th scope="row">가입날짜</th>
							<td>${membervo.registerday}</td>
							</tr>
						
							<tr>
							<th scope="row">성명</th>
							<td>${membervo.username}</td>
							<th scope="row">생년월일</th>
							<td>${membervo.birthday}</td>
							</tr>
							
							<tr>
							<th scope="row">성별</th>
								<c:if test="${membervo.gender == 'F'}">
									<td>여성</td>
								</c:if>
								<c:if test="${membervo.gender == 'M'}">
									<td>남성</td>
								</c:if>
							<th scope="row">활동상태</th>
								<c:if test="${membervo.status == '1'}">
									<td>활동중</td>
								</c:if>
								<c:if test="${membervo.status == '0'}">
									<td>탈퇴회원</td>
								</c:if>
							</tr>
							
							<tr>
							<th scope="row">휴대전화</th>
							<td>${membervo.hp1 }-${membervo.hp2 }-${membervo.hp3 }</td>
							<th scope="row">E-mail</th>
							<td>${membervo.email }</td>
							</tr>
							
							
							<tr>
							<tr>
							<th scope="row">주소</th>
							<td colspan="3">${membervo.addr1 } ${membervo.addr2 }</td>
							</tr>
							<tr>
							<th scope="row">마케팅 수신동의</th>
							<td>
								
								<span class="check_kdh">
									<c:if test="${membervo.marketing_email == 'Y'}">
										<input type="checkbox" id="dEmail_kdh" class="input" checked disabled>
										<label for="dEmail_kdh" class="label">E-mail</label>
									</c:if>
									<c:if test="${membervo.marketing_email == 'N'}">
										<input type="checkbox" id="dEmail_kdh" class="input" disabled>
										<label for="dEmail_kdh" class="label">E-mail</label>
									</c:if>
								</span>
								<span class="check_kdh">
									<c:if test="${membervo.marketing_sms == 'Y'}">
										<input type="checkbox" id="dSms_kdh" class="input" checked disabled>
										<label for="dSms_kdh" class="label">SMS</label>
									</c:if>
									<c:if test="${membervo.marketing_sms == 'N'}">
										<input type="checkbox" id="dSms_kdh" class="input" disabled>
										<label for="dSms_kdh" class="label">SMS</label>
									</c:if>
								</span>
							</td>
							<td colspan="2"></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<!-- 회원정보 :e -->
				<div style="text-align: center;">
					<button id="memberdetailback" onclick="javascript:history.back();">목록으로</button>	
				</div>
			</div>
		</div>
	</div>
