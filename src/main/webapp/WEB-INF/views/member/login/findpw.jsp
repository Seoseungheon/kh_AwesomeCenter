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
<title>비밀번호 찾기</title>
<link rel="stylesheet" type="text/css"
	href="<%=ctxPath%>/resources/css/findpw.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {	
		var authSms = false;
		var authTime = false; //false로 바꿔야됨
		
		$(".authCodeDiv").hide();
		
		if(${requestScope.status==1}){
			window.resizeTo(610, 620);
		}
		
		if(${requestScope.status==3}){
			alert('${requestScope.msg}');
			window.close();
		}
		
		if(${requestScope.status==0 && requestScope.msg != ""}){
			alert('${requestScope.msg}');
		}
		
		$(".ui-input input").focus(function() {
			$(this).css('opacity', 1);
			$(this).css('background-color', '#fff');
		});

		$(".ui-input input").blur(function() {
			if ($(this).val() == "")
				$(this).css('opacity', 0);
			else
				$(this).css('background-color', '#f2f2f2');
		});
		
		$(".ui-radio input").on('change',function(){
			$(".inner-content").removeClass('active');
			if($(this).is(":checked"))
				$(this).parent().parent().find('.inner-content').addClass('active');
		});
			
	});
	
	function goEdit(){
		var userid = $("#userid").val().trim();
		if(userid == ""){
			alert('아이디를 입력해주세요');
			$("#userid").focus();
			return;
		}
		
		var frm = document.findFrm;
		frm.method = "POST";
		frm.action = "<%=ctxPath%>/findpw.to";
		frm.submit();
	}
	
	function sendAuthCode(){
		var celphone_no1 = $("#celphone_no1").val();
		var celphone_no2 = $("#celphone_no2").val();
		var celphone_no3 = $("#celphone_no3").val();
		
		$("#authCodeResend").prop('disabled','true');
		if($("#celphone_no1").val() == ""){
			alert("앞 세자리를 선택해주세요.");
			$("#celphone_no1").focus();
			return;
		}
		if($("#celphone_no2").val() == ""){
			alert("휴대폰 번호 앞자리 4자리를 입력해주세요.");
			$("#celphone_no2").focus();
			return;
		}
		if($("#celphone_no3").val() == ""){
			alert("휴대폰 번호 뒷자리 4자리를 입력해주세요.");
			$("#celphone_no3").focus();
			return;
		}
		var phone = $("#celphone_no1").val()+$("#celphone_no2").val()+$("#celphone_no3").val();
		
		if(celphone_no1 != "${requestScope.memvo.hp1}" ||
		   celphone_no2 != "${requestScope.memvo.hp2}" ||
		   celphone_no3 != "${requestScope.memvo.hp3}" ){
			alert("아이디와 휴대폰번호가 일치하지 않습니다.");
			return;
		}
		sendSms(phone);
	}
	
	/* SMS인증 FUNCTION:시작 */
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
			var frm = document.findFrm;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/findpw.to";
			frm.submit();
		}
		else{
			alert("인증번호가 일치하지 않습니다.");
		}
	}
	
	function goChangePW(){
		var userpw = $("#userpw").val().trim();
		var userpwChk = $("#userpwChk").val().trim();
		
		if(userpw==""){
			alert("새로운 비밀번호를 입력해주세요.");
			$("#userpw").focus();
			return
		}
		
		if(!/^[a-zA-Z0-9$@$!%*#?&]{8,20}$/.test($("#userpw").val())){
			alert('패스워드는 숫자와 영문자 조합으로 8~20자리를 사용해야 합니다.');
			$("#userpwd").focus();
			return;
		}
		
		if(userpwChk==""){
			alert("비밀번호 확인을 입력해주세요.");
			$("#userpwChk").focus();
			return
		}
		
		if(userpw != userpwChk){
			alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			$("#userpwChk").val("");
			$("#userpwChk").focus();
			return;
		}
		
		var frm = document.findFrm;
		frm.method = "POST";
		frm.action = "<%=ctxPath%>/findpw.to";
		frm.submit();
	}
</script>
</head>
<body>
	<div id="findpw">
	<div id="mast-body">
		<div class="container">
			<!-- toparea -->
			<div class="toparea">
				<h2 class="title">비밀번호 찾기</h2>				
				
				<!-- 아이디 찾기 -->
				<div class="headline">
				<c:if test="${requestScope.status==0}">
					아이디 확인 후<br>비밀번호를 다시 설정하실 수 있습니다.
				</c:if>
				<c:if test="${requestScope.status==1}">
					본인확인 수단을<br>선택해주세요.
				</c:if>
				
				<c:if test="${requestScope.status==2}">
					새로운 비밀번호를<br>입력해주세요.
				</c:if>
				</div>
			</div>
			<!-- //toparea -->

			<!-- contents -->
			<form name="findFrm">
			<div class="contents">
			<input type="hidden" id="useridHidden1" name="useridHidden1" maxlength="20" value="${requestScope.userid}">
			<input type="hidden" id="useridHidden2" name="useridHidden2" maxlength="20" value="${requestScope.useridHidden1}">
			<input type="hidden" id="usernoHidden" name="usernoHidden" maxlength="20" value="${requestScope.memvo.userno}">
			<input type="hidden" id="usernoHidden2" name="usernoHidden2" maxlength="20" value="${requestScope.userno}">
			<!-- 아이디 입력화면 -->
			<c:if test="${requestScope.status==0}">
				<div class="section __half __find ui-radio-accodion __none"
					id="resident">
					<div class="subject __underline"></div>

					<div class="row" style="margin-top: 30px;">
						<div class="col-md">
							<span class="middle">아이디</span>
							<div class="ui-input">
								<input type="text" id="userid" name="userid" maxlength="20">
								<span class="placeholder">아이디를 입력해주세요.</span>
							</div>
							
							<c:if test="${requestScope.userid==null || status==0}">
								<div id="findBtn">
								<button type="button" class="ui-button __square-small __black" name="findBtn" id="findBtn" onclick="goEdit()">
										확인
								</button>
								</div>
							</c:if>
						</div>
					</div>
				</div>
			</c:if>
			<!-- 아이디 입력화면 끝 -->
			
			<!-- 본인인증 수단 -->
			<c:if test="${requestScope.status==1}">
				<div class="row">
				<div class="col-md">
					<!-- 선택 -->
					<div class="ui-radio">
						<input type="radio" id="find-way-hp" name="member-find-way">
						<label for="find-way-hp">휴대폰 인증</label>
						<!-- 휴대폰 번호로 찾기 -->
					</div>
					<!-- 펼침 -->
					<div id="section-find-hp" class="inner-content">
						<!-- 휴대폰 번호 -->
						<div class="row authphone">
							<div class="col-md">
								<label for="find-hp-user-hp-0">휴대폰 번호</label>
								<!-- 휴대폰 번호 -->
							</div>
							<div class="col-md">
								<div class="form-wrap __phone">
									<select title="통신사번호" id="celphone_no1" name="celphone_no1" class="ui-select">
										<option value="">선택
											<!-- 선택 --></option>
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
									</select>
									<div class="ui-input">
										<input type="tel" id="celphone_no2" name="celphone_no2"
											onkeyUp="this.value=this.value.replace(/[^0-9]/g,'')"
											style="ime-mode: disabled;" maxlength="4">
									</div>
									<div class="ui-input">
										<input type="tel" id="celphone_no3" name="celphone_no3"
											onkeyUp="this.value=this.value.replace(/[^0-9]/g,'')"
											style="ime-mode: disabled;" maxlength="4">
									</div>
									<div id="findBtn">
										<button type="button" class="ui-button __square-small __black" name="authCodeSend" id="authCodeSend" onclick="sendAuthCode()">
												인증번호전송
										</button>
									</div>
									<%-- 인증번호 확인 --%>
									<div class="inner authCodeDiv" style="margin-top: 10px;">
										<span style="color:#000; font-size: 10pt;">인증번호가 전송되었습니다.</span>
										<span id="timer" style="color:#000; font-size: 10pt;"></span><br/>
										<div class="ui-input active authCodetxtDiv" style="width: 150px;">
											<input style="width: 150px; padding: 0;" class="inputPwd" type="text" id="authCode">
											<span class="placeholder">인증번호 입력</span>
											<input style="width: 150px; padding: 0;" class="inputPwd" type="hidden" id="authCodehidden" name="authCodehidden">
										</div>
										
										<button type="button" class="ui-button __square-small __black" id="authCodeCheckBtn" onclick="authCodeCheck()">
											확인	
										</button>
										
										<button type="button" class="ui-button __square-small __black" id="authCodeResend" name="authCodeResend" onclick="sendAuthCode()">
											재전송	
										</button>
									</div>
									<%-- 인증번호 확인 끝--%>
								</div>
							</div>
						</div>
					</div> <!-- //펼침 -->
				</div>
				</div> <!-- 휴대폰번호로 찾기 -->
			</c:if>
			<!-- 본인인증 수단 끝 -->
			
			<c:if test="${requestScope.status==2}">
				<div class="section __half __find ui-radio-accodion __none"
					id="resident">
					<div class="subject __underline"></div>
					<div class="row" style="margin-top: 30px;">
						<div class="col-md">
							<span class="middle">새로운 비밀번호</span><br/>
							<div class="ui-input">
								<input type="password" id="userpw" name="userpw" maxlength="20">
								<span class="placeholder">비밀번호 입력해주세요.</span>
							</div>
						</div>
					<div class="row" style="margin-top: 30px;">
						<div class="col-md">
							<span class="middle">비밀번호 확인</span><br/>
							<div class="ui-input">
								<input type="password" id="userpwChk" name="userpwChk" maxlength="20">
								<span class="placeholder">비밀번호 확인을 입력해주세요.</span>
							</div>
						</div>
					</div>
					</div>
				</div>
			</c:if>
			</div> <!-- end of contents -->
			</form>
			
			<div class="btns">
				<c:if test="${requestScope.status==2}">
					<button type="button" class="ui-button __square-small __black " name="cancleBtn" id="cancleBtn" onclick="goChangePW()">
					변경
					</button>
				</c:if>
				<c:if test="${requestScope.status==0 || requestScope.status==1}">
				<button type="button" class="ui-button __square-small " name="cancleBtn" id="cancleBtn" onclick="javascript:self.close()">
					<c:if test="${requestScope.status==0}">취소</c:if>
					<c:if test="${requestScope.status==1}">닫기</c:if>
					<c:if test="${requestScope.status==2}">닫기</c:if>
				</button>
				</c:if>
				
			</div>
		</div> <!-- end of container -->
	</div>
	</div>
</body>
</html>