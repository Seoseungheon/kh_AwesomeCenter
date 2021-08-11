<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %> 

<script type="text/javascript">
	if(${n==1}) {
		alert("강사 정보 수정이 완료되었습니다.");
		 location.href="<%= ctxPath%>/detailTeacherAdmin.to?teacher_seq="+teachervo.getTeacher_seq()"; 
		
	}
	else {
		alert("강사 정보 수정에 실패했습니다.");
		 location.href="<%= ctxPath%>/detailTeacherAdmin.to?teacher_seq="+teachervo.getTeacher_seq()"; 
		
	}
</script> 


  