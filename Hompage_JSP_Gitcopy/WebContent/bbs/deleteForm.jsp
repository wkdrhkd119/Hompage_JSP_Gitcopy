<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%  	
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	boolean flag = bdao.checkRefno(bbsno);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/js/bootstrapValidator.min.js"> </script> 

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
                        max: 15,
                        message: '최소 6자리 까지 입력해주세요.'
                    }
                }
            }      
        }
    });
});
</script>


<link href="<%=root%>/css/style.css" type="text/css" rel="Stylesheet">
</head> 

<body>
<jsp:include page="/templet/top.jsp" />

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-th-list"></span>_게시판</h2>
<hr class="w3-round border-position" >
</div>

<%if(flag){%> 
<div class="w3-row">
<div class="w3-col w3-center modalPosition">
	<div class="container">
   <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">클릭해 주세요.</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">글 삭제</h4>
        </div>
        <div class="modal-body">
          <p>답변있는 글이므로 삭제가 불가능 합니다.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='./list.jsp'">목록</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="history.back()">취소</button>
        </div>
      </div>
     </div>
   </div>
</div>
</div>
</div>
<%}else{ %>

<FORM name="frm" 
	  method="POST" 
	  action="./deleteProc.jsp" 
	  id="contactForm"
	  class="form-horizontal">
	  
<input type="hidden" name="bbsno" value="<%=bbsno%>">
<input name="nowPage" type="hidden" value="<%=request.getParameter("nowPage")%>">
<input name="oldfile" type="hidden" value="<%=request.getParameter("oldfile")%>">
<input name="col" type="hidden" value="<%=request.getParameter("col")%>">
<input name="word" type="hidden" value="<%=request.getParameter("word")%>">

	
	
<div class="container" style="margin-left: 270px;">
	  <div class="alert alert-danger alingCenter">
	  	<strong>경고!</strong>  삭제하시면 복구가 불가능 합니다. 그래도 삭제 하시겠습니까?
	  </div>
	</div>
	

	
	<br>

    <div class="form-group" >
	   <label class="col-md-5 control-label">패스워드</label>
        <div class="col-md-2">
            <input type="password" class="form-control" name="passwd"/>        
        </div>
        <div class="col-md-3">
            <button type="submit" class="btn btn-default">삭제</button>
            <button type="button" class="btn btn-default" onclick="history.back()">취소</button>       
        </div>
    </div>
   
    
    <!-- #messages is where the messages are placed inside -->
    
    <div class="form-group">
        <div class="col-md-9 col-md-offset-3">
            <div id="messages"></div>
        </div>
    </div>
</FORM>

<%}%>



<jsp:include page="/templet/bottom.jsp" />
</body>
</html> 
