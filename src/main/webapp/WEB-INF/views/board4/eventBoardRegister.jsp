<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<style type="text/css">

   @import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);
   @import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

   #event_body {
      font-family: "Noto Sans Kr", Nanum Gothic, "ëëęł ë", sans-serif;
   }

   #event_container {
      width : 70%;
      margin : 0 auto;
   }
   
   #event_nvar div {    
      display: inline-block;
      font-size: 14px;
      margin: 2px 12px 0;
      color : #666;
      font-weight: 400;
   }

   #event_h2 h2 {
      font-weight: 500;
      font-size: 52px;
      margin-bottom: 70px;
      letter-spacing: -3px;
      font-family: "Noto Sans Kr";
   }
   
   #notice_div {
   		padding: 20px;
    	position: relative;
    	background: #f4f4f4;
    	margin: 0 67px 20px 65px;
    	
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
   
   #event_div {
   	  margin: 50px 0;
   }
   
   #event_table {
      width : 90%;
      margin: 0 auto;
      border-top: 1px solid black;
      border-bottom: 1px solid #cccccc;
   }
   
   #event_table th {
  	 background-color: #f4f4f4; 
  	 width : 200px;
  	 height: 66px;
  	 vertical-align: middle !important;
  	 text-align: center !important;  
	 font-weight: bold;
	 padding: 15px 30px;
   } 
   
    #event_table td {
  	 width : 400px;  
  	 padding : 11px 5px 10px 5px;	
  	
   } 
   
    #event_table td input[type="text"] {
    	border: solid 1px #ccc;
    	font-size: 15px;
    	width:95%; 
    	height: 44px; 
    	margin:7px;" 
    	padding: 0 30px;
    }
    
    #eventCategory {
    	padding: 8px;
    	margin: 7px;
    	border: solid 1px #ccc;
    	width: 90%;
    	height: 48px;
    }
    
    #content {
    	width: 95%;
    	height: 500px;
    	padding: 8px;
    	margin: 7px;
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
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		/* ě¤ë§í¸ ěëí° */
		var obj = []; //ě ě­ëłě
		
		//ě¤ë§í¸ěëí° íë ěěěą
		   nhn.husky.EZCreator.createInIFrame({
		    oAppRef: obj,
		    elPlaceHolder: "content",
		    sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
		    htParams : {
		        // í´ë° ěŹěŠ ěŹëś (true:ěŹěŠ/ false:ěŹěŠíě§ ěě)
		        bUseToolbar : true,            
		        // ěë Ľě°˝ íŹę¸° ěĄ°ě ë° ěŹěŠ ěŹëś (true:ěŹěŠ/ false:ěŹěŠíě§ ěě)
		        bUseVerticalResizer : true,    
		        // ëŞ¨ë í­(Editor | HTML | TEXT) ěŹěŠ ěŹëś (true:ěŹěŠ/ false:ěŹěŠíě§ ěě)
		        bUseModeChanger : true,
		    }
		});
		
		$("#registerBtn").click(function(){
			//textareaě ěëí° ëě
			  obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); 
			
			  <%-- === ě¤ë§í¸ěëí° ęľŹí ěě ================================================================ --%>
				//ě¤ë§í¸ěëí° ěŹěŠě ëŹ´ěëŻ¸íę˛ ěę¸°ë píęˇ¸ ě ęą°
		        var contentval = $("#content").val();
			        
		        // === íě¸ěŠ ===
		        // alert(contentval); // contentě ë´ěŠě ěëŹ´ę˛ë ěë Ľěš ěęł  ě°ę¸°í  ę˛˝ě° ěěëł´ëę˛.
		        // "<p>&nbsp;</p>" ě´ëźęł  ëě¨ë¤.
		        
		        // ě¤ë§í¸ěëí° ěŹěŠě ëŹ´ěëŻ¸íę˛ ěę¸°ë píęˇ¸ ě ęą°íę¸°ě ě ë¨źě  ě í¨ěą ę˛ěŹëĽź íëëĄ íë¤.
		        // ę¸ë´ěŠ ě í¨ěą ę˛ěŹ (ě¤ë§í¸ěëí° ë˛ě )
		        /* if(contentval == "" || contentval == "<p>&nbsp;</p>") {
		        	alert("ę°ě˘ ë´ěŠě ěë Ľíě¸ě.");
		        	return;
		        } */
		        
		        // ě¤ë§í¸ěëí° ěŹěŠě ëŹ´ěëŻ¸íę˛ ěę¸°ë píęˇ¸ ě ęą°íę¸°
		        contentval = $("#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>ëĄ ëłí
		    /*    
		              ëěëŹ¸ěě´.replace(/ě°žě ëŹ¸ěě´/gi, "ëłę˛˝í  ëŹ¸ěě´");
		        ==> ěŹę¸°ě ęź­ ěěěź ë  ě ě ëëę¸°(/)íěěě ëŁë ě°žě ëŹ¸ěě´ě ë°ě´íë ěě´ěź íë¤ë ě ěëë¤. 
		                     ęˇ¸ëŚŹęł  ë¤ě gië ë¤ěě ěëŻ¸íŠëë¤.

		        	g : ě ě˛´ ëŞ¨ë  ëŹ¸ěě´ě ëłę˛˝ global
		        	i : ěëŹ¸ ëěëŹ¸ěëĽź ëŹ´ě, ëŞ¨ë ěźěšíë í¨í´ ę˛ě ignore
		    */    
		        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>ëĄ ëłí  
		        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>ëĄ ëłí
		        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> ëë </p> ëŞ¨ë ě ęą°ě
		    
		        $("#content").val(contentval);
			 <%-- === ě¤ë§í¸ěëí° ęľŹí ë =================================================================== --%> 
			 
			 func_register();
		});
		
		
		
	});

	function goCancel(){
	    var bool = confirm("ę˛ěę¸ ěěąě ěˇ¨ěíěę˛ ěľëęš?"); 
	    if(bool) {
	    	alert("ę˛ěę¸ ěěąě´ ěˇ¨ě ëěěľëë¤.");
	    	location.href='<%= request.getContextPath() %>/boardmenu.to';
	    }   
	    else {
	    	return;
	    }
	} 
	
	function func_register(){
	    var bool = confirm("ę˛ěę¸ě ëąëĄíěę˛ ěľëęš?"); 
	    if(!bool) {
	    	alert("ę˛ěę¸ě´ ëąëĄě´ ěˇ¨ěëěěľëë¤.");
	    }    
	    else {
	    		
	    	var frm = document.eventFrm;
	    	frm.method = "POST";
	    	frm.action = "<%= request.getContextPath()%>/eventBoardRegisterEnd.to";
	    	frm.submit();
	    }
	} 


</script>

</head>
<body id = "event_body">
   
   <div id = "event_container" >
      
      <div id = "event_nvar" align="right" style = "margin: 40px 70px 0 0;">   
	         <div style = "border-right: 1px solid #e5e5e5; padding : 0 12px; margin : 0;" ><i class="fa fa-lock" style="font-size:15px; padding:2px 6px 0 0;"></i>ę´ëŚŹě ě ěŠ ëŠë´</div>
	         <div>ę´ëŚŹě ě ěŠ ëŠë´</div>
      	</div>
      	
		<div align="center" id="event_h2">
			<h2>ě´ë˛¤í¸ ëąëĄ</h2>
		</div>
     
      <div id = "event_div">
      	<form name="eventFrm"  enctype="multipart/form-data"> 
         <table class="table" id="event_table">
               <tr>
                  <th>ě ëŞŠ</th>    
                  <td colspan="3"><input type="text" name="event_title"/></td>     
               </tr>
               <tr>      
                  <th>ě í</th>
                  <td style="vertical-align: middle; padding-left:15px;">ě´ë˛¤í¸</td>
                  <th>ě§ě </th>
                  <td style="padding-left:15px; vertical-align: middle;">ëł¸ě </td>
               </tr>
               <tr>      
                  <th>ě˛¨ëśíěź</th>
                  <td colspan="3">
					  <input type="file" name="attach" id="addFile" style="vertical-align: middle; margin:9px 0 1px 10px;"/> 
				 </td>
               </tr>   
                <tr >       
                  <th>ë´ěŠ</th>
                  <td colspan="3">
                  	<textarea maxlength="1000" name="event_content" id="content" ></textarea>
                  </td>
               </tr>        
         </table>
         <input type="hidden" name="fk_userno" value="${eventvo.fk_userno}"/>
       
         </form>
      </div>
      
      <div id="btnArea">
      	<div id="leftArea">
      		<button type="button" class="btns" id="listBtn" onclick="javascript:location.href='<%= request.getContextPath() %>/boardmenu.to'">ëŞŠëĄ</button>
      	</div>
      	<div id="rightArea">
      		<button type="button" class="btns" id="resetBtn" onclick="goCancel();">ěˇ¨ě</button>
      		<button type="button" class="btns" id="registerBtn">ëąëĄ</button>
      	</div>
      </div>
      
   </div>
   
</body>
</html>