<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>

<% 

	int no = Integer.parseInt(request.getParameter("no"));
	boolean flag = adao.delete(no);
%>

<!DOCTYPE html> 
<html> 
<head> 

<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body> 
<jsp:include page="/templet/top.jsp" />

<div class="w3-container" id="services" style="margin-top:70px">
<h2 style="margin-bottom: 0px;"><span class="glyphicon glyphicon-list-alt"></span>_주소록</h2>
<hr style="width:170px; border:2px solid; margin-top: 5px; border-color: #FF4500" class="w3-round">
</div>


<div class="w3-row">
<div class="w3-col w3-center modalPosition">
<div class="container">
<%if(flag){%>
	<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">삭제 성공! 클릭해 주세요.</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">삭제 성공!</h4>
        </div>
        <div class="modal-body">
          <p>주소록 삭제를 완료했습니다.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='./createForm.jsp'">새로운 주소 등록</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='./list.jsp'">목록</button>
          <!-- <button type="button" class="btn btn-default" data-dismiss="modal" onclick="history.back()">취소</button> -->
        </div>
      </div>
     </div>
   </div>	
<%}else{%>
	<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">삭제 실패.. 클릭해 주세요.</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">삭제 실패.....</h4>
        </div>
        <div class="modal-body">
          <p>주소록 삭제를 실패 했습니다...</p>
        </div>
        <div class="modal-footer">
          <!-- <button type="submit" class="btn btn-default">삭제</button> -->
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='./list.jsp'">목록</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="history.back()">다시시도</button>
        </div>
      </div>
     </div>
   </div>		
<%}%>
</div>	
</div>	
</div>	

<jsp:include page="/templet/bottom.jsp" />
</body> 
</html> 

