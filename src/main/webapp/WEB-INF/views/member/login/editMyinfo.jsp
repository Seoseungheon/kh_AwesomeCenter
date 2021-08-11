<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String ctxPath = request.getContextPath();
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/editMyinfo.css" />
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
/* SMS인증 변수선언:시작 */
var authSms = false;
var authTime = false; //false로 바꿔야됨
/* SMS인증 변수선언:끝*/

$(document).ready(function(){
	$("#celphone_no1").val("${sessionScope.loginuser.hp1}").prop("selected", true);
	/* 수정 */
	$(".authCodeDiv").hide();
	/* 수정 끝 */
	
	$(".row").hover(function(){
		$(this).children().children().addClass("__blacktxt");
	},function(){
		$(this).children().children().removeClass("__blacktxt");
	});
	
	$("input").focus(function(){
		$(this).addClass("inputActive");
	});
	
	$("input").blur(function(){
		$(this).removeClass("inputActive");
	});
});

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

function sendAuthCode(){
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
/* SMS인증 FUNCTION:끝 */

/* 우편번호 찾기 서비스 */
function execDaumPostcode() {
	new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
            } 

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('post_code').value = data.zonecode;
            document.getElementById("post_address1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("post_address2").focus();
        }
    }).open();
}
/* 우편번호 찾기 서비스 끝*/

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

/* 회원가입 버튼 클릭시 */
 
function goEdit(){
	var user_email    = $("#user_email").val().trim();
	var post_code     = $("#post_code").val().trim();
	var post_address1 = $("#post_address1").val().trim();
	var post_address2 = $("#post_address2").val().trim();
	var celphone_no1 = $("#celphone_no1").val();
	var celphone_no2 = $("#celphone_no2").val();
	var celphone_no3 = $("#celphone_no3").val();
	
	//휴대폰 번호가 기존번호랑 같으면 인증처리
	if(celphone_no1=="${sessionScope.loginuser.hp1}" && celphone_no2=="${sessionScope.loginuser.hp2}" && celphone_no3=="${sessionScope.loginuser.hp3}"){
		authSms = true;
	}
	if(!/^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/.test($("#user_email").val())){
		alert('이메일 형식이 올바르지 않습니다');
		$("#user_email").focus();
		return;
	}
	
	if(!authSms){
		alert('휴대폰 인증을 진행해주세요.');
		$("#celphone_no3").focus();
		return;
	}
	
	if(post_code == ""){
		alert("주소를 입력해주세요.");
		$("#post_code").focus();
		return;
	}
	
	if(post_address2 == ""){
		alert("상세주소를 입력해주세요.");
		$("#post_address2").focus();
		return;
	}

	var frm = document.registerFrm;
	frm.method = "POST";
	frm.action = "<%=ctxPath%>/editMyinfoAction.to";
	frm.submit();
	
}

</script>
<form name="registerFrm">
<div class="section __half register" id="register">
				<h3 class="subject __underline">
					정보수정
				</h3>
				
				<!-- 이름 -->
				<div class="row" id="div-cstNm">
					<div class="col-md">
						<label>이름</label><!-- 이름 -->
					</div>
					<div class="col-md">
						<div class="form-wrap">
							<div class="ui-input active infoTxt">
								<input type="hidden" id="userno" name="userno" value="${sessionScope.loginuser.userno}" disabled style="padding-left: 10px; font-weight: bold;">
								<input type="text" id="userName" name="userName" value="${sessionScope.loginuser.username}" disabled style="padding-left: 10px; font-weight: bold;">
							</div>
						</div>
					</div>
				</div>

				<!-- 아이디 -->
				<div class="row" id="div-onlId">
					<div class="col-md">
						<label>아이디</label> <!-- 아이디 -->
					</div>
					<div class="col-md">
						<div class="form-wrap">
							<div class="ui-input active">
								<input type="text" id="userid" name="userid" value="${sessionScope.loginuser.userid}" disabled style="padding-left: 10px; font-weight: bold;">
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-md">
						<label>주민번호</label>
					</div>
					<div class="col-md">
						<div class="form-wrap">
							<div class="ui-input active">
								<input type="text" maxlength="6" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" class="ResidentNum" id="ResidentNum1" name="ResidentNum1" value="${sessionScope.loginuser.rrn1}" disabled style="font-weight: bold;">
							</div>
							<span class="birthTxt">-</span>
							<div class="ui-input active">
								<input type="password" maxlength="7" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" class="ResidentNum" id="ResidentNum2" name="ResidentNum2" value="*******" disabled style="font-weight: bold;">
							</div>
						</div>
					</div>
				</div>
				
				<!-- 휴대폰 번호 -->
				<div class="row __depth" id="div-mblNo">
					<div class="col-md">
						<label>휴대폰 번호</label>  <!-- 휴대폰 번호 -->
					</div>
					<div class="col-md">
						<div class="form-wrap __mobile __telecom type1" id="celPhoneView" type="1">
							<div class="inner">
								<select title="통신사번호" id="celphone_no1" name="celphone_no1" class="ui-select" >  <!-- 통신사번호 -->
									<option value="">선택<!-- 선택 --></option>
									<option value="010" >010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								<div class="ui-input active">
									<input id="celphone_no2" name="celphone_no2" type="tel" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" style="ime-mode:disabled;" value="${sessionScope.loginuser.hp2}">  <!-- 휴대폰 번호 중간자리 -->
								</div>
								<div class="ui-input active">
									<input id="celphone_no3" name="celphone_no3" type="tel" maxlength="4" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" style="ime-mode:disabled;" value="${sessionScope.loginuser.hp3}"> <!-- 휴대폰 번호 뒷자리 -->
								</div>
								<button type="button" class="ui-button __square-small __black" id="authCodeSend" name="authCodeSend" onclick="sendAuthCode()">
									인증번호 전송
								</button>
							</div>
							<%-- 수정 --%>
							<div class="inner authCodeDiv" style="margin-top: 10px;">
								<span style="color:#000; font-size: 10pt;">인증번호가 전송되었습니다.</span>
								<span id="timer" style="color:#000; font-size: 10pt;"></span><br/>
								<div class="ui-input active authCodetxtDiv" style="width: 150px;">
									<input style="width: 150px; padding: 0;" class="inputPwd" type="text" id="authCode" placeholder="인증번호">
									<input style="width: 150px; padding: 0;" class="inputPwd" type="hidden" id="authCodehidden">
								</div>
								
								<button type="button" class="ui-button __square-small __black" id="authCodeCheckBtn" onclick="authCodeCheck()">
									확인	
								</button>
								
								<button type="button" class="ui-button __square-small __black" id="authCodeResend" name="authCodeResend" onclick="sendAuthCode()">
									재전송	
								</button>
								
							</div>
							<%-- 수정 끝--%>
						</div>
					</div>
				</div>
				<!-- 휴대폰 번호 선택 -->

				<!-- 이메일  -->
				<div class="row __depth" id="div-elcAdd">
					<div class="col-md">
						<label>이메일 주소</label>  <!-- 이메일 주소 -->
					</div>
					<div class="col-md">
						<div class="form-wrap __normal type1" id="elcAddView" type="1">
							<div class="ui-input active">
								<input class="inputPwd" type="text" id="user_email" name="user_email" value="${sessionScope.loginuser.email}">
							</div>
						</div>
					</div>
				</div>
				
				<!-- 주소 -->
				<div class="row __depth" id="div-add">
					<div class="col-md">
						<label for="post-code-home">주소</label>  <!-- 주소 -->
					</div>
					<div class="col-md">
						<div class="form-wrap __choice __post">
							<div class="postwrap type1" id="homeAddView" data-type="1">
								<div class="inner postcode">
									<div class="ui-input active">
										<input type="tel" id="post_code" name="post_code" title="우편번호" maxlength="6" readonly="readonly" value="${sessionScope.loginuser.post}"> <!-- 우편번호 -->
									</div>
									<button type="button" class="ui-button __square-small __black" name="postCall" onclick="execDaumPostcode()">
										우편번호찾기
									</button> <!-- 우편번호 -->
								</div>
								<div class="inner">
									<div class="ui-input ui-inputemail active">
										<input style="padding-left: 10px;" type="text" id="post_address1" name="post_address1" placeholder="상세주소 1" readonly="readonly" value="${sessionScope.loginuser.addr1}">  <!-- 상세주소 1 -->
									</div>
								</div>
								<div class="inner">
									<div class="ui-input ui-inputemail active">
										<input style="padding-left: 10px;" type="text" id="post_address2" name="post_address2" placeholder="상세주소 2" value="${sessionScope.loginuser.addr2}">  <!-- 상세주소 2 -->
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="description">
					<p>회원 탈퇴 시 개인 정보는 6개월간 보관 후 파기합니다.</p>
				</div>
				<div class="btns">
					<button type="button" class="ui-button __square-small __black" name="registerBtn" id="registerBtn" onclick="goEdit()">
							변경
					</button>
					<button type="button" class="ui-button __square-small " name="cancleBtn" id="cancleBtn" onclick="javascript:self.close()">
							취소
					</button>
				</div>
			</div>
</form>