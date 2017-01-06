<%@ page contentType="text/html; charset=UTF-8" %> 
<%  request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
	
	String id = request.getParameter("id");
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
function inCheck(f) {
	if(f.passwd.value!=f.repasswd.value){
		alert("비밀번호 불일치");
		f.passwd.focus();
		return false;
	}
}
</script>

<script>
$(document).ready(function() {
    $('#contactForm').bootstrapValidator({
        container: '#messages',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            passwd: {
                validators: {
                    notEmpty: {
                        message: '비밀번호를 입력해주세요.'
                    },
                    stringLength: {
                        max: 20,
                        message: '최소 8자리 까지 입력해주세요.'
                    }
                }
            },      
            repasswd: {
                validators: {
                    notEmpty: {
                        message: '비밀번호를 입력해주세요.'
                    },
                    stringLength: {
                        max: 20,
                        message: '최소 8자리 까지 입력해주세요.'
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
 
 
 
<FORM name='frm' 
	  method='POST' 
	  action='./updatePwProc.jsp' 
	  onsubmit="return inCheck(this)"
	  id="contactForm"
	  class="form-horizontal">
	  
<input type="hidden" name="id" value="<%= id %>">

	<div class="container dangerWith">
	  <div class="alert alert-warning alingCenter">
	  	<strong>주의!</strong> 암호 변경시 최소 8자리 이상으로 지정해 주세요.
	  </div>
	</div>
	<br>

	 <div class="form-group" >
	   <label class="col-md-5 control-label">패스워드</label>
        <div class="col-md-2">
            <input type="password" class="form-control" name="passwd"/>        
        </div>
     </div>
	 <div class="form-group" >
	   <label class="col-md-5 control-label">패스워드 확인</label>
        <div class="col-md-2">
            <input type="password" class="form-control" name="repasswd"/>        
        </div>
     </div>
     
     
	 <div class="form-group">
        <div class="col-md-9 col-md-offset-5">
            <div id="messages"></div>
        </div>
    </div>
    
	<div class="form-group">
        <div class="col-md-9 col-md-offset-5">
            <button type="submit" class="btn btn-default">삭제</button>
            <button type="button" class="btn btn-default" onclick="history.back()">취소</button>
        </div>
  </div> 


</FORM>
<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>

</html> 
