<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/payment.css" />

<script type="text/javascript">

	$(function() {
		
		$("input").hide();
		
		$("#payBtn").click(function() {
			
			var bool = confirm("결제를 시작합니다.");
			
			if(bool){
				
				goPay();	
				
			}
			
			
		});
		
	});
	
	// == 코인 충전하기 (실제로 카드 결제) == //
	function goPay() {
		
	//	alert("확인용 idx : " + idx + ", coinmoney : " + coinmoney);
	
		var payArr = new Array();
		
		$("input[name=class_seq]").each(function() {
			
			var class_seq = $(this).val();
			
			payArr.push(class_seq);
		});
	
		// 아임포트 결제 팝업창 띄우기
		var url="<%= ctxPath %>/paying.to?payArr="+payArr;
		
		window.open(url, "PaymentLec",
				    "left=350px, top=100px, width=820px, height=600px");	
	
		
	}
	
	function RealPay() {
		
		var payArr = new Array();
		var cartArr = new Array();
		var feeArr = new Array();
		
		$("input[name=class_seq]").each(function() {
			
			var class_seq = $(this).val();
			var cart_seq = $(this).siblings("input[name=cart_seq]").val();	
			var class_fee = $(this).siblings("input[name=class_fee]").val();
			
			payArr.push(class_seq);
			cartArr.push(cart_seq);
			feeArr.push(class_fee);
/* 
			console.log(class_seq);
			console.log(class_fee); */
		});
		
		console.log(payArr);
		
		$("input[name=payArr]").val(payArr);
		$("input[name=cartArr]").val(cartArr);
		$("input[name=priceArr]").val(feeArr);
		
		var frm = document.payFrm;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath %>/paymentEnd.to";
		
		frm.submit();
		
	}

</script>

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
		
		<div>
		<form name = "payFrm">
			<input name = "payArr" value = ""/>
			<input name = "cartArr" value = ""/>
			<input name = "priceArr" value = ""/>
			<table id = "pay_tbl">
					<tr style= " background-color: #f4f4f4">
						<th>강좌구분</th>
						<th>강좌정보</th>
						<th>수강자명</th>
						<th>수강료</th>
						<th>할인선택</th>
						<th>할인</th>
						<th>결제금액</th>
					</tr>
			<c:if test="${ orderDueList != null }">
				<c:forEach var="order" items="${ orderDueList }" >
					<tr id = "orderDueList">
						<td>상반기</td>
						<td style = "text-align: left;  padding-left: 40px;">
							<div>
								<input type="hidden" name = "class_seq" value = "${ order.fk_class_seq }" />
								<input type="hidden" name = "cart_seq" value = "${ order.cart_seq }" />
								<input type="hidden" name = "class_fee" value = "${ order.class_fee }" />
								<span class = "lectureName">${ order.class_title }</span> <br>
								<span class = "lectureEtc">${ order.class_semester }</span>
								<span class = "lectureEtc" style = "border-left: 1px solid #e5e5e5; border-right: 1px solid #e5e5e5; padding: 0 10px;">${ order.teacher_name }</span><span class = "lectureEtc">${ order.class_term }</span>	<br>
								<span class = "lectureEtc">(${ order.class_day })</span><span class = "lectureEtc">${ order.class_time }</span>
							</div>
						</td>
						<td>${ sessionScope.loginuser.username }</td>
						<td><fmt:formatNumber pattern="###,###" value="${ order.class_fee }" />원</td>
						<td></td>
						<td>-</td>
						<td><fmt:formatNumber pattern="###,###" value="${ order.class_fee }" />원</td>
					</tr>
				</c:forEach>	
			</c:if>		
			</table>
			
			<table id = "totalTbl">
				<tr>
					<th>수강료합계</th>
					<td><span style = "font-size: 18px; color: #000; font-weight: 700;"><fmt:formatNumber pattern="###,###" value="${ totalCount }" /></span>원</td>
					<th style = "padding : 0 24px; ">할인</th>
					<td style = "padding : 0 25px; "><span style = "font-size: 18px; color: #000; font-weight: 700;">0</span>원</td>
					<th>총 수강료</th>
					<td  style = "border-right: 1px solid #ccc;">
						<span id = "totalPrice"><fmt:formatNumber pattern="###,###" value="${ totalCount }" /></span><span style = "margin-left: 5px; vertical-align: text-top;">원</span>
						<input type="hidden" name = "totalCount" value = "${ totalCount }" />
					</td>
					
				</tr>
				
			</table>
		
			<div align="left" id = "tbl_caption">
				<p>_인터넷 신청 강좌의 카드결제 취소는 카드사에 따라 처리 기간이 차이가 있으며 최종 취소 승인은 인터넷 취소 시점에서 10일 경과 후 확인이 가능합니다.</p>
			</div>
		</form>	
		</div>
		
		<div align="center" style = "margin: 90px 0;">
			<div id = "payBtn" >결제하기</div>
		</div>
		
	</div>
	
</div>
