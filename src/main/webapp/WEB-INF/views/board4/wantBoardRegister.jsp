<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style type="text/css">

   @import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
   @import url(//fonts.googleapis.com/earlyaccess/wishosanskr.css);

   #wish_body {
      font-family: "wisho Sans Kr", Nanum Gothic, "ëëęł ë", sans-serif;
   }

   #wish_container {
      width : 70%;
      margin : 0 auto;
   }
   
   #wish_nvar div {    
      display: inline-block;
      font-size: 14px;
      margin: 2px 12px 0;
      color : #666;
      font-weight: 400;
   }

   #wish_h2 h2 {
      font-weight: 500;
      font-size: 52px;
      margin: 55px 0px 70px 0px;
      letter-spacing: -3px;
      font-family: "wisho Sans Kr";
   }
   
   #wish_div {
    	position: relative;
    	
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
   
   #wish_div {
   	  margin: 50px 0;
   }
   
   #wish_table {
      width : 90%;
      margin: 0 auto;
      border-top: 1px solid black;
      border-bottom: 1px solid #cccccc;
   }
   
   #wish_table th {
  	 background-color: #f4f4f4; 
  	 width : 200px;
  	 height: 66px;
  	 vertical-align: middle !important;
  	 text-align: center !important;  
	 font-weight: bold;
	 padding: 15px 30px;
   } 
   
    #wish_table td {
  	 width : 400px;  
  	 padding : 11px 5px 10px 5px;	
  	
   } 
   
    #wish_table td input[type="text"] {
    	border: solid 1px #ccc;
    	font-size: 15px;
    	width:95%; 
    	height: 44px; 
    	margin:10px;" 
    	padding: 0 30px;
    }
    
    #wishCategory {
    	padding: 10px;
    	margin: 15px;
    	border: solid 1px #ccc;
    	width: 90%;
    	height: 48px;
    }
    
    #wish_content {
    	width: 95%;
    	height: 300px;
    	padding: 10px;
    	margin: 15px;
    	border: solid 1px #ccc;
    }
    
    #btnArea {
    	margin: 30px 5px 270px 61px;
    }
    
    .btns {
    	height: 66px;
    	line-height: 66px;
   	 	font-size: 20px;
   	 	min-width: 120px;
    }
    
    #listBtn {
    	background: white;
    	border : 1px solid #aaa
    }
    
    #registerBtn, #editBtn {
    	background: #eb2d2f;
    	color: white;
    	border : none;
    	
    }
    
    #resetBtn {
    	background: black;
    	color: white;
    	border : none;
    	margin-right: 8px;
    }
    
    #leftArea {	
    	float: left;
    }
    
    #rightArea {
    	 padding-right : 60px;
   		 float : right;
   		 
    }
      
	 #admin_nvar div {    
      display: inline-block;
      font-size: 14px;
      margin: 2px 12px 0;
      color : #666;
      font-weight: 400;
   } 
  
   

</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		//ě°ę¸°ë˛íź
		$("#registerBtn").click(function(){
			
			// ę¸ě ëŞŠ ě í¨ěą ę˛ěŹ
			var subjectval = $("#wish_title").val().trim();
			if(subjectval == "") {
				alert("ę¸ě ëŞŠě ěë Ľíě¸ě!!");
				return;
			}
			
			// ę¸ë´ěŠ ě í¨ěą ę˛ěŹ
			var contentval = $("#wish_content").val().trim();
			if(contentval == "") {
				alert("ę¸ë´ěŠě ěë Ľíě¸ě!!");
				return;
			}
			
			// íźě submit
			var frm = document.wishWriteFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/writewishEnd.to";
			frm.submit();
		});
		
		$("#editBtn").click(function(){
			// ę¸ě ëŞŠ ě í¨ěą ę˛ěŹ
			var subjectval = $("#wish_title").val().trim();
			if(subjectval == "") {
				alert("ę¸ě ëŞŠě ěë Ľíě¸ě!!");
				return;
			}
			
			// ę¸ë´ěŠ ě í¨ěą ę˛ěŹ
			var contentval = $("#wish_content").val().trim();
			if(contentval == "") {
				alert("ę¸ë´ěŠě ěë Ľíě¸ě!!");
				return;
			}
			
			// íźě submit
			var frm = document.wishWriteFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/updateWishEnd.to";
			frm.submit();
		});
		
	}); // end of $(document).ready(function()





</script>
</head>
<body id = "wish_body">
   
   <div id = "wish_container" >
         
      <div align="center" id = "wish_h2">
      <c:if test="${requestScope.hvo==null}">
         <h2>ę°ě¤íŹë§ ę˛ěę¸ ěěą</h2>
      </c:if>
      <c:if test="${requestScope.hvo!=null}">
         <h2>ę°ě¤íŹë§ ę˛ěę¸ ěě </h2>
      </c:if>
      </div>
     
      
      <div id="wish_div">
        <div style="width: 70%;">
      	
      	</div>
      	
      	<div style="width: 30%; float:right;">
      	
      	</div>
      </div>
      
      <div id = "wish_div">
      	<form name="wishWriteFrm"> 
         <table class="table" id="wish_table">
               <tr>
                  <th>ě ëŞŠ</th>    
                  <td colspan="3">
                  <input type="text" name="wish_title" id="wish_title" maxlength="20" value="${hvo.title}"/>
                  </td>     
               </tr>
               <tr>      
                  <th>ě§ě </th>
                  <td colspan="3" style="padding-left:15px; vertical-align: middle;">ëł¸ě </td>
               </tr>
                <tr >       
                  <th>ë´ěŠ</th>
                  <td colspan="3">
                  	<textarea maxlength="1000" name="wish_content" id="wish_content" placeholder="íŹë§íë ę°ě˘ě ë´ěŠě ěë Ľí´ěŁźě¸ě." >${hvo.content}</textarea>
                  </td>
                  
                  <input type="hidden" name="wish_no" value="${hvo.no}" />
               </tr> 
         </table>
         </form>
      </div>
      
      <div id="btnArea">
      	<div id="leftArea">
      		<a href="<%= ctxPath%>/boardmenu3.to"><button type="button" class="btns" id="listBtn">ëŞŠëĄ</button></a>
      	</div>
      	<div id="rightArea">
      		<c:if test="${requestScope.hvo==null}">
	      		<a href="javascript:history.back();"><button type="button" class="btns" id="resetBtn">ěˇ¨ě</button></a>
	      		<button type="button" class="btns" id="registerBtn" onclick="">ëąëĄ</button>
      		</c:if>
      		
      		<c:if test="${requestScope.hvo!=null}">
      			<a href="javascript:history.back();"><button type="button" class="btns" id="resetBtn">ěˇ¨ě</button></a>
	      		<button type="button" class="btns" id="editBtn" onclick="">ěě </button>
      		</c:if>
      	</div>
      </div>
      
   </div>
   
</body>
</html>