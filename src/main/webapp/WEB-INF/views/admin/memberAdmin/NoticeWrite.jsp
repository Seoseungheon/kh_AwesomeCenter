<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
   @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

   #question_body {
      font-family: "Noto Sans Kr", Nanum Gothic, "ëëęł ë", sans-serif;
   }

   #question_container {
      width : 70%;
      margin : 0 auto;
   }
   
   #question_nvar div {    
      display: inline-block;
      font-size: 14px;
      margin: 2px 12px 0;
      color : #666;
      font-weight: 400;
   }

   #question_h2 h2 {
      font-weight: 500;
      font-size: 52px;
      margin: 55px 0px 70px 0px;
      letter-spacing: -3px;
      font-family: "Noto Sans Kr";
   }
   
   #notice_div {
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
   
   #question_div {
   	  margin: 50px 0;
   }
   
   #question_table {
      width : 90%;
      margin: 0 auto;
      border-top: 1px solid black;
      border-bottom: 1px solid #cccccc;
   }
   
   #question_table th {
  	 background-color: #f4f4f4; 
  	 width : 200px;
  	 height: 66px;
  	 vertical-align: middle !important;
  	 text-align: center !important;  
	 font-weight: bold;
	 padding: 15px 30px;
   } 
   
    #question_table td {
  	 width : 400px;  
  	 padding : 11px 5px 10px 5px;	
  	
   } 
   
    #question_table td input[type="text"] {
    	border: solid 1px #ccc;
    	font-size: 15px;
    	width:95%; 
    	height: 44px; 
    	margin:10px;" 
    	padding: 0 30px;
    }
    
    #questionCategory {
    	padding: 10px;
    	margin: 15px;
    	border: solid 1px #ccc;
    	width: 90%;
    	height: 48px;
    }
    
    #Not_content {
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
    
    #registerBtn {
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
			var subjectval = $("#Not_title").val().trim();
			if(subjectval == "") {
				alert("ę¸ě ëŞŠě ěë Ľíě¸ě!!");
				return;
			}
			
			// ę¸ë´ěŠ ě í¨ěą ę˛ěŹ
			var contentval = $("#Not_content").val().trim();
			if(contentval == "") {
				alert("ę¸ë´ěŠě ěë Ľíě¸ě!!");
				return;
			}
			
			// íźě submit
			var frm = document.noticeWriteFrm;
			frm.method = "POST"; // íěźě ě˛¨ëśí  ę˛˝ě°ě´ëźëŠ´ ë°ëě POST ě´ě´ěźë§ ę°ëĽíë¤. GETě´ëźëŠ´ íěźě˛¨ëśę° ěëě´ě§ë¤.
			frm.action = "<%= ctxPath%>/NoticeWriteEnd.to";
			frm.submit();
		});
		
		
		
	}); // end of $(document).ready(function()





</script>
</head>
<body id = "question_body">
   
   <div id = "question_container" >
      
      <div id = "admin_nvar" align="right" style = "margin: 40px 180px 0 0;">   
            <div style = "border-right: 1px solid #e5e5e5; padding : 0 12px; margin : 0;" ><i class="fa fa-lock" style="font-size:15px; padding:2px 6px 0 0;"></i>ę´ëŚŹě ě ěŠ ëŠë´</div>
            <div>ęłľě§ę˛ěí</div>
   		</div>
         
      <div align="center" id = "question_h2">
         <h2>ęłľě§ę˛ěę¸ ěěą</h2>
      </div>
     
      
      <div id="notice_div">
        <div style="width: 70%;">
      	
      	</div>
      	
      	<div style="width: 30%; float:right;">
      	
      	</div>
      </div>
      
      <div id = "question_div">
      	<form name="noticeWriteFrm" enctype="multipart/form-data"> 
         <table class="table" id="question_table">
               <tr>
                  <th>ě ëŞŠ</th>    
                  <td colspan="3">
                  <input type="text" name="Not_title" id="Not_title"/>
                  </td>     
               </tr>
               <tr>      
                  <th>ě§ě </th>
                  <td colspan="3" style="padding-left:15px; vertical-align: middle;">ëł¸ě </td>
               </tr>
                <tr >       
                  <th>ë´ěŠ</th>
                  <td colspan="3">
                  	<textarea maxlength="1000" name="Not_content" id="Not_content" placeholder="ęłľě§ę˛ěíě ěěąíě¤ ë´ěŠě ěë Ľí´ěŁźě¸ě."></textarea>
                  </td>
               </tr>
              <!--   <tr>      
                  <th>ě˛¨ëśíěź</th>
                  <td colspan="3">
					 <input type="file" name="addFile" id="addFile" style="vertical-align: middle; margin:9px 0 9px 15px;"/>
				 </td>
               </tr>  -->    
         </table>
         </form>
      </div>
      
      <div id="btnArea">
      	<div id="leftArea">
      		<a href="javascript:history.back();"><button type="button" class="btns" id="listBtn">ëŞŠëĄ</button></a>
      	</div>
      	<div id="rightArea">
      		<a href="javascript:history.back();"><button type="button" class="btns" id="resetBtn">ěˇ¨ě</button></a>
      		<button type="button" class="btns" id="registerBtn" onclick="">ëąëĄ</button>
      	</div>
      </div>
      
   </div>
   
</body>
</html>