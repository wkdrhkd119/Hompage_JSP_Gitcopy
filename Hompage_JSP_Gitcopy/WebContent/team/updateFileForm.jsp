<%@ page contentType="text/html; charset=UTF-8" %> 
<%  request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
	
	String oldfile = request.getParameter("oldfile");
	
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function a(f) {
	if(f.filename.value==""){
		alert("파일을 선택하세요");
		f.filename.focus();
		return false;
	}
}
</script>
<style type="text/css"> 
*{ 
  font-family: 맑은고딕; 
  font-size: 20px; 
} 

img{
	width: 200px;
	height: 200px;
}

table{
	margin: 0 auto;
}
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/templet/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">사진수정</DIV>
 
<FORM name='frm' method='POST' action='./updateFileProc.jsp' enctype="multipart/form-data" onsubmit="return a(this)">
<input type="hidden" name="no" value="<%= request.getParameter("no") %>">
<input type="hidden" name="col" value="<%= request.getParameter("col") %>">
<input type="hidden" name="word" value="<%= request.getParameter("word") %>">
<input type="hidden" name="nowPage" value="<%= request.getParameter("nowPage") %>">
<input type="hidden" name="oldfile" value="<%= oldfile%>">

  <TABLE>
    <TR>
      <TH>원본파일</TH>
      <TD><img src="./storage/<%=oldfile%>">원본파일명:<%=oldfile %></TD>
    </TR>
    
    <TR>
      <TH>변경파일</TH>
      <TD><input type="file" name="filename" accept=".gif,.jpg,.png"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='변경'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
