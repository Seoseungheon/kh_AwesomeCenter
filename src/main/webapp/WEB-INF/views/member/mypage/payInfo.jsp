<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/payInfo.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.0.min.js" ></script>
<script type="text/javascript">
	
	$(function(){
		
		$("#cancel").click(function(){
			
			var frm = document.cancelFrm;
			frm.method = "POST",
			frm.action = "<%=ctxPath%>/member/payCancelCheck.to";
			frm.submit();
			
		});
		
	});

</script>

</head>
<body>

	<div id="topArea" style="margin-bottom: 10px;">
	<div style="float: left;">
		<span style="font-weight: bold; font-size: 16pt;">결제정보</span>
	</div>
		<div style="text-align: right; padding-top: 10px;">
		<span style="font-size: 9pt;"><strong id="name">[${sessionScope.loginuser.username}]</strong>님께서 결제하신 내역입니다</span>
	</div>
	</div>

	<div id="tab_menu">
		<table class="orderTabTbl">
		<tr>
			<td class="tab active" >결제 정보</td>
		</tr>
		</table>
	</div>
	
	<div class="tabContent" id="menu1" >
	
		<span class="tblText">결제자</span>
			<table class="orderTbl" style="text-align: left;">
				<tr>
					<th>결제번호</th>
					<td style="width: 170px">${payInfo.no}</td>
					<th style="width:94px;">결제일자</th>
					<td>${payInfo.payday}</td>
				</tr>
				<tr>
					<th>결제자</th>
					<td style="width: 170px">${sessionScope.loginuser.username}</td>
					<th style="width:94px;">결제상태</th>
					<td>
						<c:if test="${payInfo.status eq '4'}">
						<span style="float: left;">접수 완료</span>
						<c:if test="${day > 7 }">
						<form name="cancelFrm">
						<span style="float: right; margin-right: 20px; color:white; background-color:black; padding: 2px 5px; border-radius: 5px; cursor: pointer;" id="cancel">취소</span>
						<input type="hidden" value="${payInfo.no }" name="no" />
						</form>
						</c:if>
						</c:if>
						<c:if test="${payInfo.status eq '1'}">
						취소 완료
						</c:if>
						<c:if test="${payInfo.status eq '2'}">
						수강 대기중
						</c:if>
						<c:if test="${payInfo.status eq '3'}">
						수강중
						</c:if>
						<c:if test="${payInfo.status eq '0'}">
						수강 완료
						</c:if>
					</td>
				</tr>
				<tr>
					<th>결제금액</th>
					<td colspan="4"><fmt:formatNumber maxFractionDigits="3" value="${payInfo.price}" />원</td>
				</tr>
			</table>
			<br/><br/>
			
			<span class="tblText">강좌 정보</span>
			
			<table class="orderTbl tdCenter">
			
			<thead>
				<tr>
					<th colspan="2" style="width:40%">결제 강좌 정보</th>
					<th style="width:10%">강사명</th>
					<th style="width:7%">학기</th>
					<th style="width:9%">강의실</th>
					<th style="width:10%">수강료</th>
					<th style="width:8%">요일</th>
					<th style="width:16%">수강일</th>
				</tr>
			</thead>
			<tbody style="text-align: center;">
				<tr>
					<td><img alt="img" src="../images/${payInfo.class_photo }" width="50px" height="50px"></td>
					<td width="290px">${payInfo.class_title}</td>
					<td>${teacher.teacher_name }</td>
					<td>
						<c:if test="${(payInfo.class_semester == '3월') || (payInfo.class_semester == '4월') || (payInfo.class_semester == '5월')}">
							봄
						</c:if>
						<c:if test="${payInfo.class_semester eq '6월' or payInfo.class_semester eq '7월' or payInfo.class_semester eq '8월'}">
							여름
						</c:if>
						<c:if test="${payInfo.class_semester eq '9월' or payInfo.class_semester eq '10월' or payInfo.class_semester eq '11월'}">
							가을
						</c:if>
						<c:if test="${payInfo.class_semester eq '12월' or payInfo.class_semester eq '1월' or payInfo.class_semester eq '2월'}">
							겨울
						</c:if>
					</td>
					<td>${payInfo.class_place }</td>
					<td><fmt:formatNumber maxFractionDigits="3" value="${payInfo.class_fee }" />원</td>
					<td>${payInfo.class_day }</td>
					<td>${payInfo.class_startdate } ~ ${payInfo.class_enddate }</td>
				</tr>
			</tbody>
			</table>
			<br/><br/>
	</div>
	
	<div style="text-align: center; margin-top: 30px;">
		<span id="closeBtn" onclick="self.close()">닫기</span>
	</div>
	
</body>
</html>