<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%  

	String tempDir = application.getRealPath("/member/temp");
	String upDir = application.getRealPath("/member/storage");
	UploadSave upload = new UploadSave(request,-1,-1, tempDir);
	
	String id = upload.getParameter("id");
	String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
	
	
	
	FileItem fileItem = upload.getFileItem("fname");
	int size = (int)fileItem.getSize();
	String fname = null;
	if(size>0){
		UploadSave.deleteFile(upDir, oldfile);
		fname = UploadSave.saveFile(fileItem, upDir);
	}

	boolean flag = dao.updateFile(id, fname);

%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 

<script type="text/javascript">
function read() {
	var url = "read.jsp";
	url += "?id=<%=id%>";
	location.href=url;
}


</script>
 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 

<body>
<jsp:include page="/templet/top.jsp" flush="false"/>

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-user"></span>_멤버</h2>
<hr class="w3-round border-position">
</div> 
 

<div class="w3-row">
<div class="w3-col w3-center modalPosition">
<%if(flag){%>
 		<div class="container">
    <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">결과 확인하기</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">결과</h4>
        </div>
        <div class="modal-body">
          <p>수정을 성공했습니다.</p>
        </div>
        <div class="modal-footer" align="center">
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='./list.jsp'">목록</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
</div>
 <%}else{%>
<div class="container">
    	<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">결과 확인하기</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">결과</h4>
        </div>
        <div class="modal-body">
          <p>등록을 실패했습니다. 다시 시도해 주세요.</p>
        </div>
        <div class="modal-footer" style="padding-right:40px;">
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='./list.jsp'">목록</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="history.back()">다시시도</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>
</div>
<%}%>
</div>
</div>

<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>

</html> 
