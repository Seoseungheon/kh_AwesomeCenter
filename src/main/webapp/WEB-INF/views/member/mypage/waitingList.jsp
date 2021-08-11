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
<title>대기자 조회</title>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/waitingList.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<style type="text/css">
</style>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

	$(function(){
	
		$("input:checkbox[id=allChk]").click(function(){
			
			var bool = $("input:checkbox[id=allChk]").is(":checked");
			
			$("input[type=checkbox]").prop("checked", bool);
		
		});
		
		$("input:checkbox[name=seq]").click(function(){
			 
			 var flag = false;
			 
			 $("input:checkbox[name=seq]").each(function() {
				 var bool = $(this).prop("checked");
				 if(!bool) {
					 $("input:checkbox[id=allChk]").prop("checked", false);
					 flag = true;
					 return false;
				 }
			 });
			 
			 if(!flag)
				 $("input:checkbox[id=allChk]").prop("checked", true); 
			 
		 });
		
		$("#cancelWait").click(function(){
			
			if( $("input:checkbox[name=seq]:checked").length == 0 ) {
				return false;
			} else {
				
				var frm = document.cancelFrm;
				frm.method = "GET";
				frm.action = "<%=ctxPath%>/member/cancelWait.to";
				frm.submit();
			
			} 
			
		});
		
		$("#payment").click(function(){
			
			var frm = document.cancelFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/payment.to";
			frm.submit();
			
		});
		
	});

</script>

</head>
<body>

	<div id="container_kdh">
        <div id="content_kdh">

            <div class="menu_kdh">
				<a href="#" class="material-icons atag">home</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">My문화센터</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">마이페이지</a>
				<a href="<%= ctxPath%>/member/waitingList.to" class="atag">대기자 조회</a>
			</div>

            <div class="main_kdh waitingList_kdh">
				<h2 class="h2">대기자 조회</h2>
				<p class="tableTxt_kdh p">기존 회원의 수강신청 취소로 접수가 가능해지면 대기순번에 따라 회원정보에 등록되어 있는 연락처로 담당자가 연락 드립니다.</p>
				<div class="infoTable_kdh">
				<form name="cancelFrm">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">
									<span class="check_kdh">
										<input type="checkbox" id="allChk" class="input" title="선택"><label for="allChk">선택</label>
									</span>
								</th>
								<th scope="col" colspan="2">강좌정보</th>
								<th scope="col">관리점</th>
								<th scope="col">강사</th>
								<th scope="col">수강료</th>
								<th scope="col">수강자명</th>
								<th scope="col">대기접수일</th>
								<th scope="col">대기순번</th>
							</tr>
						</thead>
						<tbody>	
						<c:if test="${empty waitingList}">				
						    <tr>
						    	<td colspan="8">
						    		등록된 강좌가 없습니다.
						    	</td>
						    </tr>    
						</c:if>
						<c:if test="${not empty waitingList }">
						<c:forEach var="waitingvo" items="${waitingList }" varStatus="status">
							<tr>
								<td scope="col">
									<span class="check_kdh">
										<input type="checkbox" id="${status.count }" name="seq" class="input chk" title="선택" value="${waitingvo.seq }"><label for="allChk">선택</label>
									</span>
								</td>
								<td colspan="2">${classList[status.index].class_title } </td>
								<td>본점</td>
								<td>${teacherList[status.index].teacher_name }</td>
								<td>${classList[status.index].class_fee }</td>
								<td>${sessionScope.loginuser.username }</td>
								<td>${waitingvo.reciptday }</td>
								<c:if test="${waitingvo.status eq 1 }">
								<td>${waitingvo.rnum }</td>
								</c:if>
								<c:if test="${waitingvo.status eq 0 }">
								<td>
								<a href="#" id="payment" class="atag"><span class="btn_kdh btnBlack_kdh btnType01_kdh" style="padding: 0 5px;">결제</span></a>
								<input type="hidden" name="class_seq" value="${classList[status.index].class_seq }"/>
								<input type="hidden" name="sep" value="wait"/>
								</td>
								</c:if>
							</tr>
						</c:forEach>
						</c:if>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="9">
									<div class="btnArea_kdh">
										<a href="#" id="cancelWait" class="btn_kdh btnType01_kdh btnWhite_kdh atag"><span>선택강좌 대기접수 취소</span></a>
									</div>
								</td>
							</tr>
						</tfoot>
					</table>
					</form>
				</div>
            </div>
        </div>
    </div>
</body>
</html>