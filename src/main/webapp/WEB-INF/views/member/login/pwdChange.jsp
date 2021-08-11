<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/pwdChange.css" />
<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);


</style>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.2.0.min.js" ></script>

<script>
$(document).ready(function(){
	
	$("#inputOldPasswd").focus();
	
	$("#inputNewPasswd2").keydown(function(event){
		if(event.keyCode == 13){
			goCheck();
		}
	});
	
});

function goCheck(){
	var inputOldPasswd = $("#inputOldPasswd").val().trim();
	var inputNewPasswd1 = $("#inputNewPasswd1").val().trim();
	var inputNewPasswd2 = $("#inputNewPasswd2").val().trim();
	
	if(inputOldPasswd == ""){
		alert("현재 비밀번호를 입력하세요");
		$("#inputOldPasswd").focus();
		return;
	}
	if(inputNewPasswd1 == ""){
		alert("새 비밀번호를 입력하세요");
		$("#inputNewPasswd1").focus();
		return;
	}

	if(inputNewPasswd2 == ""){
		alert("새 비밀번호 확인을 입력하세요");
		$("#inputNewPasswd2").focus();
		return;
	}
	if(inputNewPasswd1 != inputNewPasswd2){
		alert("비밀번호가 맞지 않습니다.");
		$("#inputNewPasswd2").val("");
		$("#inputNewPasswd2").focus();
		return;
	}
	if(!/^[a-zA-Z0-9$@$!%*#?&]{8,20}$/.test($("#inputNewPasswd1").val())){
		alert('패스워드는 숫자와 영문자 조합으로 8~20자리를 사용해야 합니다.');
		$("#inputNewPasswd1").val("");
		$("#inputNewPasswd2").val("");
		$("#inputNewPasswd1").focus();
		return;
	}
	
	else{
		var frm = document.passchangeFrm;
		
		frm.method = "POST";
		frm.action = "pwdCheck.to";
		frm.submit();
	}
}



</script>
<div id="pwdChange">
	<h1 class="hm_h1">비밀번호 변경</h1>
	<p style="text-align: center;"><img alt="이미지" src="<%=ctxPath%>/resources/hmimages/pwdChange.png" height="200px;"></p>
	<span>
	<p class="ptxt">
	저희 문화센터에서는 회원님의 소중한 개인정보를 안전하게 보호하고 있습니다. <br/>
	비밀번호는 타인에게 노출되지 않도록 주의해주세요.<br/>
	비밀번호는 8-20자리의 영문/숫자를 함께 입력해주세요.
	</p>
	<hr style="border: solid 0.5px silver;" />
	
	<form name="passchangeFrm">
		<table class="tbl">
			<tr>
				<td><span class="frmtxt">현재 비밀번호</span></td>
				<td><input class="inputPasswd" id="inputOldPasswd" type="password" name="inputOldPasswd"/></td>
				<td><input id="userNo" type="hidden" name="userNo" value="${sessionScope.loginuser.userno}"/></td>
			</tr>
			<tr>
				<td><span class="frmtxt">새 비밀번호</span></td>
				<td><input class="inputPasswd" id="inputNewPasswd1" type="password" name="inputNewPasswd1"/></td>
			</tr>
			<tr>
				<td><span class="frmtxt">새 비밀번호 확인</span></td>
				<td><input class="inputPasswd" id="inputNewPasswd2" type="password" name="inputNewPasswd2"/></td>
			</tr>
		</table>	
	</form>
	
	<hr style="border: solid 0.5px silver; margin-bottom: 40px;" />
	
	<div class="btns">
		<button type="button" class="ui-button __square-small __black" name="changeBtn" id="changeBtn" onclick="goCheck()">
				변경
		</button>
		<button type="button" class="ui-button __square-small " name="cancleBtn" id="cancleBtn" onclick="javascript:history.back()">
				취소
		</button>
	</div>
</div>

