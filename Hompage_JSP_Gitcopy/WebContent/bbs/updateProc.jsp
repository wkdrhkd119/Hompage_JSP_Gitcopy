<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<jsp:useBean id="dto" class="bbs.BbsDTO"/>

<%  
	String upDir = "/bbs/storage";
	String tempDir = "/bbs/temp";		
	
	upDir = application.getRealPath(upDir); //절대경로
	tempDir = application.getRealPath(tempDir); //절대경로

	UploadSave upload = new UploadSave(request, -1, -1, tempDir);
	
	
	String col = upload.getParameter("col");
	String word = UploadSave.encode(upload.getParameter("word"));
	String nowPage = upload.getParameter("nowPage");
	String oldfile =  UploadSave.encode(upload.getParameter("oldfile"));
	
	dto.setBbsno(Integer.parseInt(upload.getParameter("bbsno")));
	dto.setWname(UploadSave.encode(upload.getParameter("wname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));
	
	FileItem fileItem = upload.getFileItem("filename");
	int filesize = (int)fileItem.getSize();
	String filename = null;
	if(filesize>0){	//새로운 파일을 업로드 했다.
		UploadSave.deleteFile(upDir, oldfile);	//기존파일을 삭제
		filename = UploadSave.saveFile(fileItem, upDir);
	}
	dto.setFilename(filename);
	dto.setFilesize(filesize);

	Map map = new HashMap();
	map.put("bbsno", dto.getBbsno());
	map.put("passwd", dto.getPasswd());
	boolean pflag = bdao.passCheck(map);
	//패스워드 검증
	//수정처리
	boolean flag = false;
	if(pflag){
		flag = bdao.update(dto);
	}
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
function blist() {
	var url = "list.jsp";
	url += "?col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href = url;
}	

</script>

<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 

<body>
<jsp:include page="/templet/top.jsp" />
<div class="w3-container" id="services" style="margin-top:70px">
<h2 style="margin-bottom: 0px;"><span class="glyphicon glyphicon-th-list"></span>_게시판</h2>
<hr style="width:170px; border:2px solid; margin-top: 5px; border-color: #FF4500" class="w3-round">
</div> 

<div class="w3-row">
<div class="w3-col w3-center modalPosition">
<div class="content">
<%if(pflag==false){%>

	<div class="container">
	    <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">패스워드 불일치</button>

	  <!-- Modal -->
	  <div class="modal fade" id="myModal" role="dialog">
	    <div class="modal-dialog modal-sm">
	      <div class="modal-content">
	        <div class="modal-header">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4 class="modal-title">패스워드 불일치</h4>
	        </div>
	        <div class="modal-body">
	          <p>패스워드를 확인해 주세요.</p>
	        </div>
	        <div class="modal-footer" style="padding-right: 40px;">
	          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="blist()">목록</button>
	          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="history.go(-1)">다시시도</button>
	          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>		

		
<%}else if(flag==false){%>

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
        <div class="modal-body" style="padding-right: 40px;">
          <p>수정을 실패했습니다. 다시 시도해 주세요.</p>
        </div>
        <div class="modal-footer" style="padding-right: 40px;">
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="blist()">목록</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="history.go(-1)">다시시도</button>
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
	          <p>수정을 성공했습니다.</p>
	        </div>
	        <div class="modal-footer" style="padding-right: 40px;">
	          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="blist()">목록</button>
	          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='./createForm.jsp'">등록</button>
	          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        </div>
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
