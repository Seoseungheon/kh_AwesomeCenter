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
<title>QnA 작성</title>

<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/QnAWrite.css" />
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<style type="text/css">
	
   @import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
   @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);
	
	body {
		font-family: "Noto Sans Kr", Nanum Gothic, "나눔고딕", sans-serif;
	}
   
	#notice_div {
   		padding: 20px;
    	position: relative;
    	background: #f4f4f4;
		margin: 0 0 20px 0;
		font-size: 15px;
   }
   
      #goA {
	   	position: absolute;
	    right: 30px;
	    top: 45px;
	    padding: 10px 6px;
	    background: black; 
	    color:white; 
	    font-size: 11pt; "
   }
   

</style>

<script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

$(function(){
	
	$("#tit").val('${qna.title}');
	$("#cate").val('${qna.categoryno_fk}');
	$("#dAnswer").val('${qna.answer}');
	
	var content = "${qna.content}";
	
	content = content.replace(/<br\/>/g,"\n");
	
	$("#dContent").text(content);
	
	$("#dCancel").click(function(){
		var question = confirm('취소하시겠습니까?');
		
		if(question) {
			window.history.back();
		} else {
			return false;
		}
		
	});
	
});

	function goEdit() {
		var frm = document.detailForm;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath %>/QnA/QnAEditEnd.to";
		frm.submit();		
	}
	
	function answerEdit() {
		var frm = document.detailForm;
		
		frm.method = "POST";
		frm.action = "<%= ctxPath %>/QnA/answerEdit.to";
		frm.submit();		
	}

</script>

</head>
<body>

	<div id="container_kdh">
		<div id="content_kdh">
            <div class="menu_kdh">
				<a href="#" class="material-icons atag">home</a>
				<a href="<%= ctxPath%>/member/mypage.to" class="atag">My문화센터</a>
				<a href="<%= ctxPath%>/QnA/QnAList.to" class="atag">1:1문의</a>
			</div>
			
			<div class="main_kdh">
				<h2 class="h2">Q & A</h2>

			<div id="notice_div">
        		<div style="width: 80%;">
      			<ul>
      				<li>고객서비스의 [Q&A게시판]에서 자주 질문하는 답변을 보실 수 있습니다.</li>
      				<li>1:1문의를 해주시면 빠른 시일 안에 답변을 드리겠습니다.</li>
      				<li>답변 내용은 마이페이지의 [1:1 문의]에서 확인하실 수 있습니다.</li>
      			</ul>
      		</div>
      	
      		<div style="width: 30%; float:right;">
      			<a href="#"><span id="goA">자주하는 문의보기</span></a>
      		</div>
      		</div>

				<div class="infoTable_kdh aLeft_kdh mb30_kdh">
					<form name="detailForm" class="from">
					<table class="table">
						<colgroup>
							<col style="width: 12%;">
							<col style="width: 38%;">
							<col style="width: 12%;">
							<col style="width: 38%">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="tit" class="label">제목</label></th>
								<td colspan="3"><input maxlength="60" type="text" id="tit" class="input" name="Subject" title="제목 입력" value="" readonly>
												<input type="hidden" name="no" value="${qna.no }"/>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="cate" class="label">카테고리</label></th>
								<td>
									<span class="select_kdh">
										<select title="유형 선택" id="cate" class="select option_kdh" name="TypeCode">
											<option value="1" class="option">회원가입</option>
											<option value="2" class="option">수강신청</option>
											<option value="3" class="option">강좌/강사</option>
											<option value="4" class="option">환불/취소</option>
											<option value="5" class="option">홈페이지</option>
											<option value="6" class="option">기타</option>		
										</select>
									</span>
								</td>
								<th>지점</th>
                  					<td style="padding-left:15px; vertical-align: middle;">본점</td>
								</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="3" class="tdcontent_kdh" style="height: 400px; vertical-align: top;">
									<textarea maxlength="1000" name="content" id="dContent" class="textarea textcontent_kdh" title="내용 입력"  placeholder="*놀-LAB 문의 시 강좌상세설명의 문의처로 지점을 선택하셔야 원활한 답변을 받으실 수 있습니다." cols="30" rows="10" readonly></textarea>
								</td>
							</tr> 
							<c:if test="${sessionScope.loginuser.userid == 'admin' }">
								<tr>
								<th scope="row">답변</th>
								<td colspan="3" class="tdanswer_kdh">
									<textarea maxlength="1000" name="answer" id="dAnswer" class="textarea textcontent_kdh" title="내용 입력" cols="30" rows="10"></textarea>
							</tr>
							</c:if>  
						</tbody>
					</table>
					</form>
				</div>
				<div class="btnArea_kdh">
					<div class="leftArea_kdh">
						<a href="<%= ctxPath%>/QnA/QnAList.to" class="btnType02_kdh btn_kdh btnWhite_kdh atag"><span>목록</span></a>
					</div>
					<div class="rightArea_kdh">
								<a href="#" id="dCancel"class="btnType02_kdh btn_kdh btnBlack_kdh atag"><span>취소</span></a>
								<c:if test="${sessionScope.loginuser.userid != 'admin' }">
								<a href="#" onclick="goEdit();" id="dInsert"class="btnType02_kdh btn_kdh btnRed_kdh atag"><span>등록</span></a>
								</c:if>
								<c:if test="${sessionScope.loginuser.userid == 'admin' }">
								<a href="#" onclick="answerEdit();" id="dInsert"class="btnType02_kdh btn_kdh btnRed_kdh atag"><span>등록</span></a>
								</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>