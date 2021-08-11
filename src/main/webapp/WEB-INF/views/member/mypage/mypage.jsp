<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/mypage.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
	$(function(){
		
		var wish1 = "${wish1}";
		var wish2 = "${wish2}";
		var wish3 = "${wish3}";
		
		var wishList = new Array();
		
		if(wish1 != ""){
			wishList.push(wish1);
		}
		if(wish2 != ""){
			wishList.push(wish2);
		}
		if(wish3 != ""){
			wishList.push(wish3);
		}
		
		var checkcateArr = new Array();
		$.each($(".checkCategory"), function(){
			checkcateArr.push($(this).attr('id'));
		});
		
		var choiceArr = new Array();
		
		var checkArr = new Array();
		
		$.each(checkcateArr, function(index, item){
			$.each(wishList, function(index2, item2){
				if(item == item2){
					choiceArr.push(item);
					checkArr.push(item);
				}
			});
		});
				
		$.each(choiceArr, function(index, item){
			$("#"+item).addClass('on');
		});
		
		// 회원 정보 체크 박스 체크
		if("${sessionScope.loginuser.marketing_sms}" == "Y") {
			$("input:checkbox[id=dSms_kdh]").prop("checked", true);
		} else {
			$("input:checkbox[id=dSms_kdh]").prop("checked", false);
		}
		
		if("${sessionScope.loginuser.marketing_email}" == "Y") {
			$("input:checkbox[id=dEmail_kdh]").prop("checked", true);
		} else {
			$("input:checkbox[id=dEmail_kdh]").prop("checked", false);
		}
		
		// 관심 분야 수정 모달창
		$("#modal-btn_kdh").click(function(){
			$("#modal_kdh").css('display','block');
		});
		
		
		
		// 관심 분야 모달창
		$(".checkCategory").click(function(){
		
			var checkCategorylength = $(".on").length; 
			
			if(checkCategorylength < 3){
				$(this).toggleClass('on');
				
				var id = $(this).attr('id');
		
				for(var i=0; i<checkCategorylength+1; i++){
					if( i == checkCategorylength ){
						checkArr.push(id);						
					}
				}
				
				checkCategorylength = $(".on").length;
				
			} else {
				
				var id = $(this).attr('id');
				
				$.each(checkArr, function(index, item){
					if( item == id ){
						$("#"+id+"").removeClass('on');
					}	
				});	
			}
		}); 
		
		// 관심 분야 변경
		$("#save_kdh").click(function(){

			var onArr = new Array();
			
			$(".on").each(function(){
				var id = $(this).attr('id');
				
				onArr.push(id);
				
			});
			
			var onArr_str = onArr.join();
			
			console.log(onArr_str);	
			
			location.href = "<%= ctxPath%>/member/editWishCategory.to?onArr="+onArr_str;
			
		});
		
		// 관심 분야 모달창 닫기
		$("#cancel_kdh").click(function(){
			$("#modal_kdh").css('display','none');
			
			$.each(choiceArr, function(index, item){
				$("#"+item).addClass('on');
			});
			
		});
		
		$(".btnClose_kdh").click(function(){
			$("#modal_kdh").css('display','none');
			
			$.each(choiceArr, function(index, item){
				$("#"+item).addClass('on');
			});
			
		});
		
		// 마케팅 수신동의 변경	
		$("#editSave").click(function(){
			
			if( $("#email_kdh").is(":checked") ) {
				$("#email_kdh").val("Y");
			} else {
				$("#email_kdh").val("N");
			}
			
			if( $("#sms_kdh").is(":checked") ) {
				$("#sms_kdh").val("Y");
			} else {
				$("#sms_kdh").val("N");
			}
			
			var frm = document.marketingFrm;
			frm.method = "GET";
			frm.action = "<%=ctxPath%>/member/editMarketing.to";
			frm.submit();
			
		});
		
		$(".item").hover(function(){
			$(this).children('.num_kdh').addClass('option');
		}, function(){
			$(this).children('.num_kdh').removeClass('option');
		});
		
		
		$("#memberDrop_kdh").click(function(){
	          if (confirm("정말 탈퇴하시겠습니까??") == true){    
	             location.href = "<%= ctxPath%>/delUser.to";
	          }else{   
	              return false;
	    	  }
		});
	
	});
	
	function goEdit(){
		   window.open("<%=ctxPath%>/editMyinfo.to", "정보변경", "width=900, height=800, left=400, top=50");
		}
	
</script>

	<div id="container_kdh">
		<div id="content_kdh">
		
			<div class="menu_kdh">
				<a href="#" class="material-icons atag">home</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">My문화센터</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">마이페이지</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">회원정보변경</a>
			</div>
			
			<div class="main_kdh memberModify_kdh">
				<h2 class="name_kdh h2"><span>${sessionScope.loginuser.username}님.</span></h2>
				<p class="changeDay_kdh">최근수정일자 : ${sessionScope.loginuser.editday }</p>
				
				<!-- myInfoArea :s -->
				<div class="myInfo_kdh">
					<div class="leftArea_kdh">
						<dl>
							<dt class="myInterest_kdh"><span>나의 관심분야</span></dt>
							<dd><ul class="myInterestList_kdh olulli" id="interestCategoryList_kdh" style="list-style-type: disc;">
							<c:if test="${not empty wishcategoryList }">
								<c:forEach var="wishcategoryvo" items="${wishcategoryList }">
								<li>${wishcategoryvo.wishCategory }</li>
								</c:forEach>
							</c:if>
							<c:if test="${empty wishcategoryList }">
							<li style="color:gray;">선택한 관심 분야가 없습니다.</li>
							</c:if>
							</ul></dd>
						</dl>
						<div class="btnArea_kdh aRight_kdh">
						<a href="#" class="btn_kdh btnBlack_kdh atag" id="modal-btn_kdh"><span>관심분야 수정</span></a>
						</div>
					</div>
					<div class="rightArea_kdh">
						<ul class="myMenu_kdh olulli">
							<li class="item01_kdh olulli">
								<a href="<%= ctxPath%>/cart.to" class="atag item"><span class="txt_kdh">장바구니</span><span class="num_kdh">${cartListcnt }</span></a>
							</li>
							<li class="item02_kdh olulli">
								<a href="<%= ctxPath%>/member/lectureList.to" class="atag item"><span class="txt_kdh">수강내역</span><span class="num_kdh">${orderListcnt }</span></a>
							</li>
							<li class="item03_kdh olulli">
								<a href="<%= ctxPath%>/member/waitingList.to" class="atag item"><span class="txt_kdh">대기자조회</span><span class="num_kdh">${waitingListcnt }</span></a>
							</li>
							<li class="item04_kdh olulli">
								<a href="<%= ctxPath%>/member/review.to" class="atag item"><span class="txt_kdh">수강후기</span><span class="num_kdh">${reviewListcnt }</span></a>
							</li>
							<li class="item05_kdh olulli">
								<a href="<%= ctxPath%>/myLikeLectures.to" class="atag item"><span class="txt_kdh">좋아요</span><span class="num_kdh">${heartListcnt }</span></a>
							</li>
						</ul>
					</div>
				</div>
				<!-- myInfoArea :e -->
				
				<div id="modal_kdh" class="modal_kdh">
					<div id="modal-area_kdh">
						<div id="modal-content_kdh">
							<div class="main_kdh">
								<p class="popTit_kdh mb20_kdh">나의 관심분야</p>
								<p class="toptxt_kdh">관심분야는 <em>3개까지 선택 가능</em>합니다.</p>
								<div class="interestCategory_kdh">
									<div class="checkArea_kdh">
									<c:if test="${not empty categoryList}">
										<div class="checkRow_kdh">
										<c:forEach var="categoryvo" items="${categoryList}" begin="0" end="4">
											<a href="#" id="${categoryvo.cate_no}" class="checkCategory">${categoryvo.cate_name}</a>
										</c:forEach>
										</div>
										<div class="checkRow_kdh">
										<c:forEach var="categoryvo" items="${categoryList}" begin="5">
											<a href="#" id="${categoryvo.cate_no}" class="checkCategory">${categoryvo.cate_name}</a>
										</c:forEach>
											<a class="blank"></a>
										</div>
									</c:if>	
									</div>
								</div>
								<div class="btnArea_kdh">
									<a href="#" id="cancel_kdh" class="btn_kdh btnType03_kdh btnWhite_kdh" style="color:black; border-radius: 10px;"><span>취소</span></a>
									<a href="#" id="save_kdh" class="btn_kdh btnType03_kdh btnRed_kdh" style="border-radius: 10px;"><span>저장</span></a>
								</div>
							</div>
						</div>
						<a href="#" class="btnClose_kdh"></a>
					</div>
				</div>
				
				
				<!-- 회원정보 :s -->
				<h3 class="subtitle_kdh">회원정보</h3>
				<div class="infoTable_kdh aLeft_kdh mb15_kdh">
					<table class="table">
						<tbody>
							<tr>
							<th scope="row">성명</th>
							<td>${sessionScope.loginuser.username }</td>
							<th scope="row">생년월일</th>
							<td>${sessionScope.loginuser.birthday }</td>
							</tr>
							<tr>
							<th scope="row">휴대전화</th>
							<td>${sessionScope.loginuser.hp1 }-${sessionScope.loginuser.hp2 }-${sessionScope.loginuser.hp3 }</td>
							<th scope="row">E-mail</th>
							<td>${sessionScope.loginuser.email }</td>
							</tr>
							<tr>
							<th scope="row">주소</th>
							<td colspan="3">${sessionScope.loginuser.addr1 } ${sessionScope.loginuser.addr2 }</td>
							</tr>
							<tr>
							<th scope="row">마케팅 수신동의</th>
							<td>
								<span class="check_kdh">
									<input type="checkbox" id="dEmail_kdh" class="input" disabled>
									<label for="dEmail_kdh" class="label">E-mail</label>
								</span>
								<span class="check_kdh">
									<input type="checkbox" id="dSms_kdh" class="input" disabled>
									<label for="dSms_kdh" class="label">SMS</label>
								</span>
							</td>
							<td colspan="2"></td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="btnArea_kdh aRight_kdh">
					<a id="memberEdit_kdh" class="btn_kdh btnBlue_kdh atag"><span onclick="goEdit()" style="cursor: pointer;">회원정보 확인 및 수정</span></a>
					<a href="<%=ctxPath%>/pwdchange.to" id="changePassword_kdh" class="btn_kdh btnBlue_kdh atag"><span>비밀번호 변경</span></a>
				</div>
				<!-- 회원정보 :e -->
				
				<!-- 강좌정보 수신동의 :s -->
				<h3 class="subtitle_kdh">마케팅 수신동의 (강좌정보등)</h3>
				<div class="receiveCheckArea_kdh">
				<form name="marketingFrm">
					<div>
						<span class="check_kdh">
							<input type="checkbox" id="email_kdh" class="input" name="email_kdh">
							<label for="email_kdh" class="label">E-mail</label>
						</span>
						<span class="check_kdh">
							<input type="checkbox" id="sms_kdh" class="input" name="sms_kdh">
							<label for="sms_kdh" class="label">SMS</label>
						</span>
					</div>
				</form>	
					<p class="txt_kdh p" style="color:black;">문화센터 강좌수강 및 학습활동과 관련된 정보 및 소식을 받아보실 수 있습니다.</p>
					
					<a href="#" id="editSave" class="btn_kdh btnBlack_kdh atag"><span>저장</span></a>
					<div class="btnArea_kdh aRight_kdh">
						<p class="inTxt_kdh p" style="color:black">
							<span id="changeDate_kdh">수신동의 변경일자: 2020.01.03</span>
						</p>
					</div>	
				</div>
				<!-- 강좌정보 수신동의 :e -->
				
				<div class="mt20 btnArea_kdh aRight_kdh">
					<a href="#" id="memberDrop_kdh" class="btnDropOut_kdh atag">문화센터 탈퇴하기</a>
				</div>
				
			</div>
		</div>
	</div>
