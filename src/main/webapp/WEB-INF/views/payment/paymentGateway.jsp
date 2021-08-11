<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress"%>

<%

	// === 서버 IP 주소 알아오기 ===
	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress();
//	System.out.println("serverIP : "+ serverIP);
	
	// === 서버 포트번호 알아오기 ===
	int portNumber = request.getServerPort();
//	System.out.println("portNumber : "+ portNumber);
	
	// === 서버이름 만들기 ===
	String serverName = "http://"+serverIP+":"+portNumber;
//	System.out.println("serverName : "+ serverName);
	
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	//	여기 링크를 꼭 참고하세용 http://www.iamport.kr/getstarted
   var IMP = window.IMP;     // 생략가능
   IMP.init('');  // 중요!!  아임포트에 가입시 부여받은 "가맹점 식별코드". 
	
   // 결제요청하기
   IMP.request_pay({
       pg : 'html5_inicis', // 결제방식 PG사 구분
       pay_method : 'card',	// 결제 수단	// card, kakao
       merchant_uid : 'merchant_' + new Date().getTime(), // 가맹점에서 생성/관리하는 고유 주문번호
       name : '으뜸문화센터',	 // 코인충전 또는 order 테이블에 들어갈 주문명 혹은 주문 번호. (선택항목)원활한 결제정보 확인을 위해 입력 권장(PG사 마다 차이가 있지만) 16자 이내로 작성하기를 권장
       amount : 10,	  // '${coinmoney}'  결제 금액 number 타입. 필수항목. 
       buyer_email : '',  // 구매자 email
       buyer_name : '${username}',	  // 구매자 이름 
       buyer_tel : '',    // 구매자 전화번호 (필수항목)
       buyer_addr : '',  
       buyer_postcode : ''
   }, function(rsp) {
       /*
		   if ( rsp.success ) {
			   var msg = '결제가 완료되었습니다.';
			   msg += '고유ID : ' + rsp.imp_uid;
			   msg += '상점 거래ID : ' + rsp.merchant_uid;
			   msg += '결제 금액 : ' + rsp.paid_amount;
			   msg += '카드 승인번호 : ' + rsp.apply_num;
		   } else {
			   var msg = '결제에 실패하였습니다.';
			   msg += '에러내용 : ' + rsp.error_msg;
		   }
		   alert(msg);
	   */

		if ( rsp.success ) { // PC 데스크탑용
		/* === 팝업창에서 부모창 함수 호출 방법 3가지 ===
		    1-1. 일반적인 방법
			opener.location.href = "javascript:부모창스크립트 함수명();";
			
			1-2. 일반적인 방법
			window.opener.부모창스크립트 함수명();

			2. jQuery를 이용한 방법
			$(opener.location).attr("href", "javascript:부모창스크립트 함수명();");
		*/
		//	opener.location.href = "javascript:goCoinUpdate('${idx}','${coinmoney}');";
			window.opener.RealPay();
		//  $(opener.location).attr("href", "javascript:goCoinUpdate('${idx}','${coinmoney}');");
			
		    self.close();
			
        } else {
        	
            alert("결제에 실패하였습니다.");
            self.close();
       }

   }); // end of IMP.request_pay()----------------------------

}); // end of $(document).ready()-----------------------------

</script>
</head>	

<body>
</body>
</html>
