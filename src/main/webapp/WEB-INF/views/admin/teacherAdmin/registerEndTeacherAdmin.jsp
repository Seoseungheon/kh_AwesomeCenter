<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %> 

<script type="text/javascript">
	if(${n==1}) {
		alert("강사 등록이 완료되었습니다.");
		location.href="<%= ctxPath%>/teacherListAdmin.to";
	}
	else {
		alert("강사 등록에 실패했습니다.");
		location.href="<%= ctxPath%>/teacherListAdmin.to";
	}
</script> 


  