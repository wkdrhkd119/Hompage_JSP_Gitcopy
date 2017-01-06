<%@ page contentType="text/html; charset=UTF-8" %>
<%	
	String root = request.getContextPath();
	request.setCharacterEncoding("utf-8");
	int memono = Integer.parseInt(request.getParameter("memono"));
%>

<!DOCTYPE html> 
<html> 
<head> 
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/js/bootstrapValidator.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<jsp:include page="/templet/top.jsp" />

<div class="w3-container" id="services" style="margin-top:70px">
<h2 style="margin-bottom: 0px;"><span class="glyphicon glyphicon-pencil"></span>_메모</h2>
<hr style="width:170px; border:2px solid; margin-top:5px;  border-color: #FF4500"  class="w3-round" >
</div>


<form method="post" action="deleteProc.jsp">
<input type="hidden" name="memono" value="<%=memono%>">
<input type="hidden" name="col" value="<%=request.getParameter("col")%>">
<input type="hidden" name="word" value="<%=request.getParameter("word")%>">
<input type="hidden" name="nowPage" value="<%=request.getParameter("nowPage")%>">


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
          <p>메모를 삭제 하시면 복구 될 수 없습니다. 그래도 삭제 하시겠습니까?</p>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-default">삭제</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='./list.jsp'">목록</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="history.back()">취소</button>
        </div>
      </div>
     </div>
   </div>
</div>
</div>
</div>
</form>
<jsp:include page="/templet/bottom.jsp" />
</body> 
</html> 