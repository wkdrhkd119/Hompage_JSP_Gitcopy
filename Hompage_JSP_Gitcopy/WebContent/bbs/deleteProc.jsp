<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%  
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));

	String col = request.getParameter("col");
	String word = request.getParameter("word");
	String nowPage = request.getParameter("nowPage");
	String passwd = request.getParameter("passwd");
	String oldfile = request.getParameter("oldfile");
		
	System.out.println("bbsno"+bbsno);
	System.out.println("passwd"+passwd);
	Map map = new HashMap();
	map.put("bbsno", bbsno);
	map.put("passwd", passwd);
	boolean pflag = bdao.passCheck(map);
	
	
	System.out.println("pflag"+pflag);
	boolean flag = false;
	if(pflag){
		flag = bdao.delete(bbsno);
	}
	if(flag){
		String upDir = application.getRealPath("bbs/storage");
		UploadSave.deleteFile(upDir, oldfile);
	}
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
function blist() {
	var url = "list.jsp"
	url += "?col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
		
	location.href = url;
}
</script>
<style type="text/css"> 
*{ 
  font-family: 맑은고딕; 
  font-size: 20px; 
} 
</style> 
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
<%if(pflag==false){%>
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
	          <p>패스워드 불일치.</p>
	        </div>
	        <div class="modal-footer" style="padding-right: 40px;">
	          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="blist()">목록</button>
	          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="history.back()">다시시도</button>
	          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>		
<%}else if(flag){%>
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
	          <p>삭제 성공!</p>
	        </div>
	        <div class="modal-footer" style="padding-right: 40px;">
	          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="blist()">목록</button>
	          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="location.href='./createForm.jsp'">글 등록</button>
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
	          <p>삭제 실패...</p>
	        </div>
	        <div class="modal-footer" style="padding-right: 40px;">
	          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="blist()">목록</button>
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


<jsp:include page="/templet/bottom.jsp" />
</body>

</html> 
