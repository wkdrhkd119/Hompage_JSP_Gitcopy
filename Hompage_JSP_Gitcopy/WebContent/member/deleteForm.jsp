<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%  
	String id = request.getParameter("id");
	if(id==null){
		id = (String)session.getAttribute("id");
	}
	String oldfile = dao.getFname(id);
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

<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 

<body>
<jsp:include page="/templet/top.jsp" flush="false"/>

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-user"></span>_회원탈퇴</h2>
<hr class="w3-round border-position">
</div> 

 
<FORM name='frm' 
	  method='POST' 
	  action='./deleteProc.jsp'>
	  
<input type="hidden" name="id" value="<%= id %>">
<input type="hidden" name="oldfile" value="<%= oldfile %>">

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
          <p>탈퇴를 하시면 더이상 컨텐트를 제공받을 수 없습니다.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='./deleteProc.jsp'">삭제하러가기</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="history.back()">취소</button>
        </div>
      </div>
     </div>
   </div>
</div>
</div>
</div>
  

</FORM>
 
 

<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>

</html> 
