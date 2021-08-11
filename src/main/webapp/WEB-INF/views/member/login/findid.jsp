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
<title>아이디 찾기</title>
<link rel="stylesheet" type="text/css"
	href="<%=ctxPath%>/resources/css/findid.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		if(${requestScope.userid!=null && status=="1"}){
			window.resizeTo(610, 550);
		}
		
		$("#find-way-email").prop("checked",true);
		$("#section-find-emailid").addClass('active');
		
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
		/* 이메일로 아이디 찾기 */
		if($("#find-way-email").is(":checked")){
			var user_email = $("#find-email-user-email").val().trim();
			var user_name = $("#find-email-user-name").val().trim();
			if(user_name == ""){
				alert('이름을 입력해주세요');
				$("#find-email-user-name").focus();
				return;
			}
			
			if(!/^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/.test($("#find-email-user-email").val())){
				alert('이메일 형식이 올바르지 않습니다');
				$("#find-email-user-email").focus();
				return;
			}
		}
		
		/* 휴대폰 번호로 아이디 찾기 */
		else{
			var user_name = $("#find-hp-user-name").val().trim();
			var celphone_no1 = $("#find-hp-user-hp-1").val();
			var celphone_no2 = $("#find-hp-user-hp-2").val();
			var celphone_no3 = $("#find-hp-user-hp-3").val();
			if(user_name == ""){
				alert('이름을 입력해주세요');
				$("#find-hp-user-name").focus();
				return;
			}
			if(celphone_no1==""){
				alert('통신사 번호를 선택해주세요.');
				$("#find-hp-user-hp-1").focus();
				return;
			}
			if(celphone_no2==""){
				alert('휴대폰 번호를 입력해주세요.');
				$("#find-hp-user-hp-2").focus();
				return;
			}
			if(celphone_no3==""){
				alert('휴대폰 번호를 입력해주세요.');
				$("#find-hp-user-hp-3").focus();
				return;
			}
		}
		
		var frm = document.findFrm;
		frm.method = "POST";
		frm.action = "<%=ctxPath%>/findidAction.to";
		frm.submit();
		
		
	}
</script>
</head>
<body>
	<div id="findid">
		<div id="mast-body">
			<div class="container">
				<!-- toparea -->
				<div class="toparea">
					<h2 class="title">아이디 찾기</h2>
					<!-- 아이디 찾기 -->
					<div class="headline">
					<c:if test="${requestScope.userid==null}">
						등록된 회원정보로<br>아이디를 찾으실 수 있습니다.
					</c:if>
					<c:if test="${requestScope.userid!=null}">
						입력하신 정보와<br>일치하는 아이디 정보입니다.
					</c:if>
					</div>
				</div>
				<!-- //toparea -->

				<!-- contents -->
				<form name="findFrm">
				<div class="contents">
				<c:if test="${requestScope.userid!=null && status==1}">
					<br/>
					<span style="color: #8E8E8E;">회원님의 아이디는 [<span style="color: #000;">${requestScope.userid}</span>] 입니다.</span>
				</c:if>
				<c:if test="${status==0}">
					<span style="color: red;">회원정보와 일치하는 회원이 없습니다.</span>
				
				</c:if>
				<c:if test="${requestScope.userid==null || status==0}">
					<!-- section : 아이디찾기 -->
					<div class="section __half __find ui-radio-accodion __none"
						id="resident">
						<div class="subject __underline"></div>

						<!-- 이메일 주소로 찾기 -->
						<div class="row">
							<div class="col-md">
								<!-- 선택 -->
								<div class="ui-radio">
									<input type="radio" id="find-way-email" name="member-find-way">
									<!-- 초기 활성화 시, checked="checked" 추가 -->
									<label for="find-way-email">이메일주소로 찾기 </label>
									<!-- 이메일 주소로 찾기 -->
								</div>
								<!-- 펼침 -->
								<div id="section-find-emailid" class="inner-content">
									<!-- 이름 -->
									<div class="row">
										<div class="col-md">
											<label for="find-email-user-name">이름</label>
											<!-- 이름 -->
										</div>
										<div class="col-md">
											<div class="form-wrap __normal">
												<div class="ui-input">
													<input type="text" id="find-email-user-name" name="find-email-user-name" maxlength="20">
													<span class="placeholder">이름을 입력해주세요.</span>
												</div>
											</div>
										</div>
									</div>
									<!-- 이메일 주소 -->
									<div class="row">
										<div class="col-md">
											<label for="find-email-user-email">이메일 주소 </label>
											<!-- 이메일 주소 -->
										</div>
										<div class="col-md">
											<div class="form-wrap __normal">
												<div class="ui-input">
													<input type="email" id="find-email-user-email" name="email" maxlength="50"> 
													<span class="placeholder">이메일주소를 입력해주세요.</span>
													<!-- 이메일 주소를 입력해주세요. -->
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- //펼침 -->
							</div>
						</div>
						<!-- 휴대폰 번호로 찾기 -->
						<div class="row">
							<div class="col-md">
								<!-- 선택 -->
								<div class="ui-radio">
									<input type="radio" id="find-way-hp" name="member-find-way"> 
									<label for="find-way-hp">휴대폰 번호로 찾기 </label>
									<!-- 휴대폰 번호로 찾기 -->
								</div>
								<!-- 펼침 -->
								<div id="section-find-hp" class="inner-content">
									<!-- 이름 -->
									<div class="row">
										<div class="col-md">
											<label for="find-hp-user-name">이름</label>
											<!-- 이름 -->
										</div>
										<div class="col-md">
											<div class="form-wrap __normal">
												<div class="ui-input">
													<input type="text" id="find-hp-user-name" name="find-hp-user-name" maxlength="20"> 
													<span class="placeholder">한글 또는 영문으로 입력해주세요. </span>
													<!-- 한글 또는 영문으로 입력해주세요. -->
												</div>
											</div>
										</div>
									</div>
									<!-- 휴대폰 번호 -->
									<div class="row">
										<div class="col-md">
											<label for="find-hp-user-hp-0">휴대폰 번호</label>
											<!-- 휴대폰 번호 -->
										</div>
										<div class="col-md">
											<div class="form-wrap __phone">
												<select title="통신사번호" id="find-hp-user-hp-1" name="hp1" class="ui-select">
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
													<input type="tel" id="find-hp-user-hp-2" name="hp2"
														onkeyUp="this.value=this.value.replace(/[^0-9]/g,'')"
														style="ime-mode: disabled;" maxlength="4">
												</div>
												<div class="ui-input">
													<input type="tel" id="find-hp-user-hp-3" name="hp3"
														onkeyUp="this.value=this.value.replace(/[^0-9]/g,'')"
														style="ime-mode: disabled;" maxlength="4">
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- //펼침 -->
							</div>
						</div> <!-- 휴대폰번호로 찾기 -->
					</div>
					</c:if>
				</div> <!-- end of contents -->
				</form>
				
				<div class="btns">
				<c:if test="${requestScope.userid==null || status==0}">
					<button type="button" class="ui-button __square-small __black" name="findBtn" id="findBtn" onclick="goEdit()">
							찾기
					</button>
				</c:if>
					<button type="button" class="ui-button __square-small " name="cancleBtn" id="cancleBtn" onclick="javascript:self.close()">
					<c:if test="${requestScope.userid==null || status==0}">취소</c:if>
					<c:if test="${requestScope.userid!=null && status==1}">확인</c:if>
					</button>
				</div>
			</div> <!-- end of container -->
		</div>
	</div>
</body>
</html>