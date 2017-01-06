<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%  
	String col = request.getParameter("col");
	String word = request.getParameter("word");
	String nowPage = request.getParameter("nowPage");

	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	
	bdao.upViewcnt(bbsno);
	
	BbsDTO dto = bdao.read(bbsno);
	
	String content = dto.getContent();
	content = content.replaceAll("\r\n", "<br>");
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="<%=root%>/css/style.css" type="text/css" rel="Stylesheet">
<script type="text/javascript">
function blist() {
	var url = "list.jsp";
	url += "?col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href = url;
}	

function bupdate() {
	var url = "updateForm.jsp";
	url += "?bbsno=<%=bbsno%>";
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
}

function bdelete(bbsno) {
	var url = "deleteForm.jsp";
	url += "?bbsno=<%=bbsno%>";
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	url += "&oldfile=<%=dto.getFilename()%>";
	location.href=url;
}

function breply(bbsno) {
	var url = "replyForm.jsp";
	url += "?bbsno=<%=bbsno%>";
	url += "&col=<%=col%>"
	url += "&word=<%=word%>"
	url += "&nowPage=<%=nowPage%>";
	location.href=url;
}

function down(filename) {
	var url = "<%=root%>/download";
	url += "?dir=/bbs/storage";
	url += "&filename="+filename;
	location.href = url
}

</script>


</head> 

<body>
<jsp:include page="/templet/top.jsp" />

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-th-list"></span>_게시판</h2>
<hr class="w3-round border-position">
</div> 


 
<div class="container">
<div class="row">
<div class="col-sm-3"></div>
<div class="col-sm-6">
  <TABLE class="table table-hover">
    <TR>
      <TH>제목</TH>
      <TD><%=dto.getTitle() %></TD>
    </TR>
     
     <TR>
      <TH>내용</TH>
      <TD><%=dto.getContent() %></TD>
     </TR> 
      
     <TR> 
      <TH>성명</TH>
      <TD><%=dto.getWname() %></TD>
     </TR> 
      
     <TR> 
      <TH>조회수</TH>
      <TD><%=dto.getWdate() %></TD>
     </TR> 
      
     <TR> 
      <TH>등록</TH>
      <TD><%=dto.getWdate().substring(0, 10) %></TD>
    </TR>
    
    <TR> 
      <TH>파일명</TH>
      <TD>
      <% if(dto.getFilename()==null){
    		out.print("파일없음");
      }else{%>
      	<%=dto.getFilename() %>(<%= dto.getFilesize()/1024 %>KB) 
      <a href="javascript:down('<%=dto.getFilename() %>')">
      <span class="glyphicon glyphicon-save"></span>
      </a>
      <% } %>
      </TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' class="btn btn-default" value='등록' onclick="location.href='./createForm.jsp'">
    <input type='button' class="btn btn-default" value='목록' onclick="blist()">
    <input type='button' class="btn btn-default" value='수정' onclick="bupdate()">
    <input type='button' class="btn btn-default" value='삭제' onclick="bdelete()">
    <input type='button' class="btn btn-default" value='답변' onclick="breply()">
  </DIV>
 </div>
 </div>
 </div>

 
 

<jsp:include page="/templet/bottom.jsp" />
</body>

</html> 
