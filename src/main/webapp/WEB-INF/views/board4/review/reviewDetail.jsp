<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reviewDetail.css" />

<script type="text/javascript">

	$(function() {

		$("#rename").hide();
		
		$(".editBtn").click(function() {
			
			var frm = document.reviewnoFrm;
			
			frm.action = "<%= ctxPath %>/reviewEdit.to";
				
			frm.submit();
			
		}); // 수강 후기 수정
		
		
		$(".deleteBtn").click(function() {
			
			var bool = confirm("수강 후기를 삭제하시겠습니까?");
			
			if(bool) {

				var frm = document.reviewnoFrm;
				
				frm.action = "<%= ctxPath %>/reviewDelete.to";
					
				frm.submit();
				
			}
			
			
		}); // 수강 후기 삭제
		
		// 댓글 등록
		$("#commentBtn").click(function() {
			
			if($("#comment").val() == ""){
				
				alert("댓글을 입력해 주세요");
				
			}
			else {
				
				var frm = document.commentFrm;
				
				frm.submit();
				
			}
			
		}); // end of $("#commentBtn")
		
		// 댓글 삭제 << 자기꺼만!
		$(".deleteComm").on("click",function() {
			
			var replyno = $(this).siblings("input[name=replyno]").val();
			var groupno = $(this).siblings("input[name=groupno]").val();
			var reviewno = "${ rvo.reviewno }";
			
		//	alert("reviewno : "+reviewno);
			
			var bool = confirm("댓글을 삭제하시겠습니까?");
			
			if(bool) {
				
				$.ajax({
					
					url : "<%= ctxPath %>/deleteCom.to",
					type : "POST",
					data : {"replyno" : replyno, "groupno" : groupno, "reviewno" : reviewno },
					success : function() {
						
						alert("삭제되었습니다.");
						
						location.href='javascript:history.go(0)';
						
						
					},
					error : function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
					
				}); // end of ajax
				
			}
			
		});
		
		// 대댓글 작성
		$(".comment").on("click", function() {
			
			if($("#rerename").val() == ""){
			
				var replyno = $(this).siblings("div").children("input[name=replyno]").val();
				var groupno = $(this).siblings("div").children("input[name=groupno]").val();
				var depthno = $(this).siblings("div").children("input[name=depthno]").val(); 
				
			//	alert("replyno : "+replyno+", groupno : "+groupno+", depthno : "+depthno );
			
				var rename = $(this).siblings("div").children("span.name").text();
				
				$("#rerename").val(rename);
				$("#rename").show();
			
				$("#commentBtn").click(function() {
				
				if($("#comment").val() == ""){
						
						alert("댓글을 입력해 주세요");
						
					}
					else {
						
						var frm = document.commentFrm;
						
						frm.fk_replyno.value = replyno;
						frm.groupno.value = groupno;
						frm.depthno.value = depthno;
						
						frm.submit();
						
					} 
				});
			
			}
			else {
				
				$("#rerename").val("");
				$("#rename").hide();
				return false;
			}
			
			
		});
		
		
	});

</script>


<div id="board_body" >
	
	 <div id = "board_nvar" align="right" style = "margin: 40px 220px;">
         <div>
			<a href = "<%=ctxPath%>/main.to"><img src = "<%=ctxPath%>/resources/images/Home.png" ></a>
		</div>
		<div style = "border-right: 1px solid #e5e5e5; border-left: 1px solid #e5e5e5; padding : 0 12px; margin : 0;">
			<a href = "<%= ctxPath %>/boardmenu.to">커뮤니티</a>
		</div>
		<div>
			<a href = "<%= ctxPath %>/boardmenu4.to">수강후기</a>
		</div>
      </div>
      <div align="center" id = "board_h2">
         <h2>수강 후기</h2>
      </div>
	
	<table class="boardTbl">
	
	
		<tr>
			<th style="height: 65px; width: 130px;">
				<span id="boardTbl_cat">수강후기&nbsp;&nbsp;<span style="color:#e5e5e5;">|</span></span>
								<%-- 카테고리 분류 --%>
			</th>
			<td colspan="2">
				<span id="boardTbl_title">${ rvo.subject }</span>
			</td>
			<th>작성자명</th>
			<td>${ rvo.username }</td>
			<td style="width: 130px;">
				<span id="boardTbl_date">${ rvo.wdate }</span>
			</td>
		</tr>
		
		<tr style="height: 50px;" >
			<th>강좌명</th>
			<td>
				<a href = "<%= ctxPath%>/lectureDetail.to?class_seq=${ rvo.class_seq }"  style = "text-decoration: none;">	
				[ ${ rvo.class_semester }] ${ rvo.class_title }
				</a>
			</td>
			<th>강사명</th>
			<td>${ rvo.teacher_name }</td>
			<th>조회수</th>
			<td>${ rvo.readcount }</td>
		</tr>
		
	</table>
		
	<div class="board_contents">
		<c:if test="${ rvo.imgfilename != null }">
			<div id = "reviewImg">
				<img src="<%= ctxPath %>/resources/files/${ rvo.imgfilename }" />
			</div>
		</c:if>
		<div id="content">
			${ rvo.content }
		</div>
	</div>
	<c:if test="${ not empty commentList }">
	<ul id = "commentList">
<!-- 	
		<li>
			<p class = "comment">댓글 입니다 댓ㅅㄱ르 댓글 댓글!! 댓글이에요~~~</p>
			<div id = "userinfo">
				<span class = "name">댓글 작성자</span>
				<span class = "date">댓글 작성일자</span>
				<span  id="deleteComm"  class="deleteComm">X</span>
			</div>	
		</li>
 -->		
		<c:forEach var = "comment" items="${ commentList }">
		
			<li>
				<c:if test="${ comment.commstatus == 1 }">
					<p class = "comment">
						<c:if test="${ comment.depthno > 0 }">
							<span style = "font-size : 20px; font-weight: bold;" >└ &nbsp; </span>
						</c:if>
						${ comment.replycontent }
					</p>
					
					<c:if test="${ comment.depthno == 0 }">
						<div id = "userinfo">
					</c:if>
					<c:if test="${ comment.depthno > 0 }">
						<div id = "userinfo" style = "margin-left: 35px;">
					</c:if> 
						<span class = "name">${ comment.name }</span>
						<span class = "date">${ comment.replyDate }</span>
						<c:if test="${ sessionScope.loginuser.userno == comment.fk_userno }">
							<span  id="deleteComm"  class="deleteComm">X</span>
						</c:if>
						<input type = "hidden" name = "replyno" value="${ comment.replyno }" />
						<input type="hidden" name = "groupno" value="${ comment.groupno }" />
						<input type="hidden" name = "depthno" value="${ comment.depthno }" /> 
					</div>
				</c:if>
				<c:if test="${ comment.commstatus == 0}">
					<div style = 'padding: 35px 30px 20px 0px; font-size : 16px;'>
						<c:if test="${ comment.depthno > 0 }">
							<span style = "font-size : 20px; font-weight: bold;" >└ &nbsp; </span>
						</c:if>
						삭제된 댓글입니다.
					</div>
				</c:if>
			</li>
		</c:forEach>
	</ul>
	</c:if>
	
	<div id = "commentDiv">
		<form name = "commentFrm" method = "POST" action = "<%= ctxPath %>/addCmt.to">
			<span id = "rename">@<input type="text" id  = "rerename" readonly /></span>
			<textarea rows="5" id = "comment" name = "comment" placeholder=" 댓글을 남겨주세요." ></textarea>
			
			<input type="hidden" name = "fk_userno" value="${sessionScope.loginuser.userno}" />
			<input type="hidden" name = "name" value="${sessionScope.loginuser.username}" />
			<input type="hidden" name = "fk_reviewno" value="${rvo.reviewno}" />
			
			<input type="hidden" name = "groupno" value="" />
			<input type="hidden" name = "fk_replyno" value="" />
			<input type="hidden" name = "depthno" value="" />
		</form>
		
		<button type="button" id = "commentBtn">댓글 등록</button>
	</div>
	
	<div id = "warring">
		<ul>
			<li>광고, 욕설, 악의적 비방, 허위사실 기재 등의 내용 등록 시 관리자에 의해 삭제 될 수 있습니다.</li>
			<li>작성하신 수강후기는 1년간 보관 됩니다.</li>
		</ul>
	</div>
	
	
	
	<div class="btn_cover" style="margin-bottom: 70px;">
		<c:if test="${ sessionScope.loginuser.userno == rvo.userno  }">
			<div align="left" style = "float: left; width : 30%;">
				<a href="<%= ctxPath %>/board.to"><span class="btn">목록</span></a>
			</div>
			
			<div align="right" style = "float: right; width : 30%;">
				<span class="btn editBtn">수정</span>
				<span class="btn deleteBtn">삭제</span>
			</div>
		</c:if>
		<c:if test="${ sessionScope.loginuser.userno != rvo.userno  }">
		<div>
			<a href="<%= ctxPath %>/boardmenu4.to"><span class="btn">목록</span></a>
		</div>
		</c:if>
	</div>
	
	<div style = "clear: both; margin-bottom: 70px;"></div>
	
	<form name="reviewnoFrm" method="POST" >
		<input type="hidden" name = "reviewno"  value="${ rvo.reviewno }" />
	</form>
	
		
</div>
