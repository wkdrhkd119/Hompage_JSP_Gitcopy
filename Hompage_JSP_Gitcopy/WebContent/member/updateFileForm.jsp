<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%@ page import="images.*" %>
<%  request.setCharacterEncoding("utf-8"); 
		
	String id = request.getParameter("id");
	String oldfile = request.getParameter("oldfile");
	
%> 
 
<!DOCTYPE html> 
<html> 
<head> 

<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/js/bootstrapValidator.min.js"> </script>



<script type="text/javascript">
$(document).ready(function() {
    $('#contactForm').bootstrapValidator({
        container: '#messages',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        		  fname: {
                validators: {
                    notEmpty: {
                        message: '사진을 선택하세요.'
                    }
                }
            }
         }
     });
});
</script>

<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 

<body>
<jsp:include page="/templet/top.jsp" flush="false"/>

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-user"></span>_멤버</h2>
<hr class="w3-round border-position">
</div>
 
<div class="contanier">
<div class="row">
<div class="col-sm-3"></div>
<div class="col-sm-7">
 
<FORM name='frm' 
	  method='POST' 
	  action='./updateFileProc.jsp' 
	  enctype="multipart/form-data" 
	  id="contactForm"
	  class="form-horizontal">
	  
<input type="hidden" name="id" value="<%=id %>">
<input type="hidden" name="oldfile" value="<%=oldfile %>">

	<div class="form-group">
        <label class="col-md-3 control-label">원본파일</label>
        <div class="col-md-6">
            <img class="member-img" src="<%=root%>/member/storage/<%=oldfile%>">
         </div>   
    </div>
    
	<div class="form-group">
        <label class="col-md-3 control-label">원본파일명:</label>
       	<div class=" filename-Position col-md-3">
    	 <%= oldfile %>
    	 </div>
   	</div>
	
    
	<div class="form-group">
        <label class="col-md-3 control-label">변경파일</label>
        <div class="col-md-5">
            <input type="file" class="form-control buttonPadding" name="fname" accept=".png,.jpg,.gif"/>
        </div>
    </div>

    <!-- #messages is where the messages are placed inside -->
    <div class="form-group">
        <div class="col-md-9 col-md-offset-3">
            <div id="messages"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-9 col-md-offset-3">
            <button type="submit" class="btn btn-default">변경</button>
            <button type="button" class="btn btn-default" onclick="history.back()">취소</button>
        </div>
    </div> 
</FORM>
</div> 
 </div>
 </div>
<!-- *********************************************** -->
<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
