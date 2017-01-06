<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp"  %>

<% 
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	String nowPage = request.getParameter("nowPage");

	int memono = Integer.parseInt(request.getParameter("memono"));
		
	mdao.upViewcnt(memono); /*  조회수 증가  */
	
	/* 		조회		 */
	MemoDTO dto = mdao.read(memono);
	
	String content = null;
	if(dto != null){
		content = dto.getContent();
		content = content.replaceAll("\r\n", "<br>");
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
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/js/bootstrapValidator.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
function mcreate() {
	var url = "createForm.jsp";
	location.href=url;
}

function mupdate(memono) {
	var url = "updateForm.jsp";
	url += "?memono=" +memono; 
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
}
function mdelete(memono) {
	var url = "deleteForm.jsp";
	url += "?memono=" +memono; 
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
}
function mlist() {
	var url = "list.jsp";
	url += "?col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
}
</script>
</head> 
<body> 
<jsp:include page="/templet/top.jsp" />

<div class="w3-container" id="services" style="margin-top:70px">
<h2 style="margin-bottom: 0px;"><span class="glyphicon glyphicon-pencil"></span>_메모</h2>
<hr style="width:170px; border:2px solid; margin-top:5px;  border-color: #FF4500"  class="w3-round" >
</div>


<div class="container">
<div class="row">
<div class="col-sm-3"></div>
<div class="col-sm-5">
<table class="table table-hover">
	<tr>
		<th>제목</th>
		<td><%= dto.getTitle() %></td>
	</tr>
	
	<tr>
		<th>내용</th>
		<td><%= content %></td>
	</tr>
	
	<tr>
		<th>조회수</th>
		<td><%= dto.getViewcnt() %></td>
	</tr>
	
	<tr>
		<th>등록일</th>
		<td><%= dto.getWdate() %></td>
	</tr>

</table>

<div>
<input type="button" class="btn btn-default" value="등록" onclick="mcreate()">
<input type="button" class="btn btn-default" value="수정" onclick="mupdate('<%=dto.getMemono()%>')">
<input type="button" class="btn btn-default" value="삭제" onclick="mdelete('<%=dto.getMemono()%>')">
<input type="button" class="btn btn-default" value="목록" onclick="mlist()">
</div>

</div>
</div>
</div>

<jsp:include page="/templet/bottom.jsp" />
</body> 
</html> 


