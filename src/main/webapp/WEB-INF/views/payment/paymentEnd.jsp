<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/paymentEnd.css" />

<div id = "payment_body">
	
	<div id = "payment_div" >
		
		<div id = "pay_nvar" align="right" style = "margin: 40px 0;">
			<div>
				<a href = "<%=ctxPath%>/main.to"><img src = "<%=ctxPath%>/resources/images/Home.png" ></a>
			</div>
			<div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">
				<a href = "<%= ctxPath %>/lectureApply.to">수강신청</a>
			</div>
			<div>
				<a href = "javascript:history.go(0);">수강결제</a>
			</div>
		</div>
		<div align="center" id = "pay_h2">
			<h2>수강결제</h2>
		</div>
		
		<div style = "width : 63%; margin: 0 auto; padding-bottom: 30px;">
			<div id = "logoDiv" style = "">
			</div>
			<div id = "msgDiv"> 
				<p id = "firstMsg">신청하신 강좌가 정상적으로 등록 및 결제 되었습니다.</p>
				<p id = "secondMsg">
					<span style = "text-decoration: underline;">MY 문화센터 > 마이페이지 > 수강내역조회</span>에서 수강내역 조회 및 취소, 수강증을 확인하실 수 있습니다.
				</p>
			</div>
		</div>
		
		
	<c:if test="${  not empty payList }">	
		<div id = "pay_div" style= "margin-top: 200px;">
			<table id = "pay_Tbl">
					<tr style= " background-color: #f4f4f4">
						<th>강좌구분</th>
						<th>강좌정보</th>
						<th>수강자명</th>
						<th>수강료</th>
						<th>할인선택</th>
						<th>할인</th>
						<th>결제금액</th>
					</tr>
				<c:forEach var="payment" items="${ payList }">
					<tr>
						<td>상반기</td>
						<td style = "text-align: left;  padding-left: 40px;">
							<span class = "lectureName">${ payment.class_title }</span> <br>
							<span class = "lectureEtc">${ payment.class_semester }</span>
							<span class = "lectureEtc" style = "border-left: 1px solid #e5e5e5; border-right: 1px solid #e5e5e5; padding: 0 10px;">${ payment.teacher_name }</span><span class = "lectureEtc">${ payment.class_term }</span>	<br>
							<span class = "lectureEtc">(${ payment.class_day })</span><span class = "lectureEtc">${ payment.class_time }</span>
						</td>
						<td>${ sessionScope.loginuser.username }</td>
						<td><fmt:formatNumber pattern="###,###" value="${ payment.class_fee }" />원</td>
						<td></td>
						<td>-</td>
						<td><fmt:formatNumber pattern="###,###" value="${ payment.class_fee }" />원</td>
					</tr>
				</c:forEach>	
					
			</table>
			
			<table id = "totalTbl">
				<tr>
					<th>수강료합계</th>
					<td><span style = "font-size: 18px; color: #000; font-weight: 700;"><fmt:formatNumber pattern="###,###" value="${ totalCount }" /></span>원</td>
					<th style = "padding : 0 24px; ">할인</th>
					<td style = "padding : 0 25px; "><span style = "font-size: 18px; color: #000; font-weight: 700;">0</span>원</td>
					<th>총 결제금액</th>
					<td  style = "border-right: 1px solid #ccc;">
						<span style = "margin-right : 70px;">신용카드 결제</span>
						<span id = "totalPrice"><fmt:formatNumber pattern="###,###" value="${ totalCount }" /></span><span style = "margin-left: 5px; vertical-align: text-top;">원</span>
					</td>
					
				</tr>
				
			</table>
			<div align="left" id = "tbl_caption">
				<p>_ 추후 고객정보에 기재된 연락처로 강좌관련 메시지가 발송됩니다. (확인방법 : 상단 마이페이지 > 회원정보수정)</p>
			</div>
			
		</div>
	</c:if>
		
		<div align="center" style = "margin : 90px 0;">
			<div id = "otherLecBtn" onclick = "location.href='<%= ctxPath%>/lectureApply.to'" >다른 강좌보기</div>
			<div id = "myLecListBtn" onclick = "location.href='<%= ctxPath%>/member/lectureList.to'">수강내역 조회</div>
		</div>

  
	</div>
	
</div>

