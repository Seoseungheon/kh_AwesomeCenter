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
	.row {
		margin-top: 20px;
	}
	
	.btns {
		margin-bottom: 20px !important;
	}
	.btn100 {
		background-color: black;
		color: white;
		padding: 20px 40px;
		margin-right: 40px;
	}
	
	#authCodeCheckBtn {
		margin-left: 20px;
	}
	
	#authCode {
		text-align: center;
	}
	
</style>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/findid.css" />
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/register.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.0.min.js" ></script>
<script type="text/javascript">
var authSms = false;
var authTime = false; //false로 바꿔야됨
var idCheck = false;

$(document).ready(function(){
	/* 수정 */
	$(".authCodeDiv").hide();
	
	$("#celphone_no1").val('${hp1}');
	$("#celphone_no2").val('${hp2}');
	$("#celphone_no3").val('${hp3}');
	
	$("#pw").click(function(){
		$(this).css('opacity', '1');
	});
	
	$("#pw").blur(function(){
		$(this).css('opacity', '0');
	});
	
});

	function sendSms(phone) { 
		$.ajax({ 
			url: "<%=request.getContextPath()%>/sendSms.to", 
			data: { receiver: phone }, 
			type: "post", 
			success: function(result) {
				if (result != "fail") {
					var AuthTimer = new $ComTimer()
				    AuthTimer.comSecond = 180;
				    AuthTimer.fnCallback = function(){alert("다시인증을 시도해주세요.")}
				    AuthTimer.timer =  setInterval(function(){AuthTimer.fnTimer()},1000);
				    AuthTimer.domId = document.getElementById("timer");
				    authTime = true;
					$("#authCodeSend").prop('disabled','true');
					$(".authCodeDiv").show();
					$("#authCodehidden").val(result);
				} 
				else { 
					alert("인증번호 전송에 실패했습니다. 고객센터에 문의해주세요."); 
				} 
			} 
		});
	}
	
	function sendAuthCode(){
		var phone = $("#celphone_no1").val()+$("#celphone_no2").val()+$("#celphone_no3").val();
		sendSms(phone);
	}
	
	function $ComTimer(){
	    //prototype extend
	}

	$ComTimer.prototype = {
	    comSecond : ""
	    , fnCallback : function(){}
	    , timer : ""
	    , domId : ""
	    , fnTimer : function(){
	        var m = Math.floor(this.comSecond / 60) + "분 " + (this.comSecond % 60) + "초";	// 남은 시간 계산
	        this.comSecond--;					// 1초씩 감소
	        this.domId.innerText = m;
	        if(authSms)
	        	clearInterval(this.timer);
	        if (this.comSecond < 0) {			// 시간이 종료 되었으면..
	            clearInterval(this.timer);		// 타이머 해제
	           	alert("인증시간이 초과하였습니다. 다시 인증해주시기 바랍니다.");
	           	$("#authCodeResend").removeAttr("disabled");
	            authTime = false;
	        }
	    }
	    ,fnStop : function(){
	        clearInterval(this.timer);
	    }
	}
	
	function authCodeCheck(){
		if(!authTime){
			alert("시간초과로 인해 인증에 실패했습니다. 재전송 바랍니다.")
		}
		else if( $("#authCodehidden").val() == $("#authCode").val() ){
			alert("인증이 완료되었습니다.");
			$("#authCode").prop('readonly','true');
			$("#celphone_no1").prop('readonly','true');
			$("#celphone_no2").prop('readonly','true');
			$("#celphone_no3").prop('readonly','true');
			$("#authCodeResend").prop('disabled','true');
			authSms = true;
		}
		else{
			alert("인증번호가 일치하지 않습니다.");
		}
	}

	function goSubmit() {
		var pw = $("#pw").val().trim();
		
		if(!authSms){
			alert('휴대폰 인증을 진행해주세요.');
			$("#celphone_no3").focus();
			return;
		}
		
		if(pw == ""){
			alert("패스워드를 입력하세요.");
			$("#userpwd").focus();
			return;
		}
		
		var frm = document.cancelFrm;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/member/payCancelEnd.to";
		frm.submit();
	}

	function goCancel() {
		self.close();
	}

</script>

</head>
<body>
<div id="findid">
<div class="container">

<div class="toparea">
	<h2 class="title">결제 취소</h2>
	<div class="headline">
		등록된 회원정보로 <br> 인증해 주십시오.
	</div>
</div>

	<form name="cancelFrm">
	<div class="content">
	<div class="subject __underline"></div>
	
		<div class="row">
		<div class="col-md">
		<div id="section-find-emailid" class="inner-content active">
		
		<div class="row">
		<div class="col-md">
		<label>비밀번호 확인</label>
		</div>
		<div class="col-md">
		<div class="form-wrap __normal">
		<div class="ui-input">
		<input type="password" name="pw" id="pw" maxlength="20" style="padding-left : 5px;"/>
		<span class="placeholder">비밀번호를 입력해주세요.</span>
		<input type="hidden" value="${no }" name="no" />
		</div>
		</div>
		</div>
		</div>
		
		<div class="row __depth" id="div-mblNo">
			<div class="col-md">
				<label>휴대폰 번호</label>
				<!-- 휴대폰 번호 -->
			</div>
			<div class="col-md">
				<div class="form-wrap __mobile __telecom type1" id="celPhoneView"
					type="1">
					<div class="inner">
						<input id="celphone_no1" name="celphone_no1" size="10" class="ui-select" type="tel" maxlength="3" style="ime-mode: disabled; text-align: center; padding: 0; margin-right: 5px;" readonly/>
						
						<div class="ui-input active">
							<input id="celphone_no2" name="celphone_no2" type="tel"
								maxlength="4" size="10"
								onkeyup="this.value=this.value.replace(/[^0-9]/g,'')"
								style="ime-mode: disabled; text-align: center; margin-right: 10px;" readonly>
							<!-- 휴대폰 번호 중간자리 -->
						</div>
						<div class="ui-input active">
							<input id="celphone_no3" size="10" name="celphone_no3" type="tel"
								maxlength="4"
								onkeyup="this.value=this.value.replace(/[^0-9]/g,'')"
								style="ime-mode: disabled; text-align: center; margin-right: 10px;" readonly>
							<!-- 휴대폰 번호 뒷자리 -->
						</div>

						<button type="button" class="ui-button __square-small __black"
							id="authCodeSend" name="authCodeSend" onclick="sendAuthCode()" style="margin-left: 40px;">
							인증번호 전송</button>
					</div>
					<%-- 수정 --%>
					<div class="inner authCodeDiv" style="margin-top: 10px;">
						<span style="color: #000; font-size: 10pt;">인증번호가 전송되었습니다.</span>
						<span id="timer" style="color: #000; font-size: 10pt;"></span><br />
						<div class="ui-input active authCodetxtDiv" style="width: 150px;">
							<input style="width: 150px; padding: 0;" class="inputPwd"
								type="text" id="authCode" placeholder="인증번호"> <input
								style="width: 150px; padding: 0;" class="inputPwd" type="hidden"
								id="authCodehidden">
						</div>

						<button type="button" class="ui-button __square-small __black"
							id="authCodeCheckBtn" onclick="authCodeCheck()">확인</button>

						<button type="button" class="ui-button __square-small __black"
							id="authCodeResend" name="authCodeResend"
							onclick="sendAuthCode()">재전송</button>

					</div>
					<%-- 수정 끝--%>
				</div>
			</div>
		</div>
		</div>
		</div>
		</div>
		
		<div class="btns">
		<button type="button" onclick="goSubmit();" class="btn100">확인</button>
		<button type="button" onclick="goCancel();" class="btn100">취소</button>
		</div>
		
		</div>
	</form>

</div>
</div>
</body>
</html>