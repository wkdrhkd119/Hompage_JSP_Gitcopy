<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>

<% 
	String upDir = "/member/storage";
	String tempDir = "/member/temp";
	
	upDir = application.getRealPath(upDir);
	tempDir = application.getRealPath(tempDir);
	
	UploadSave upload = new UploadSave(request, -1, -1, tempDir);
	
	String id = UploadSave.encode(upload.getParameter("id"));
	String email = upload.getParameter("email");
	String str = "";
	
	if(dao.duplicateId(id)){
		str="중복된 아이디";
	}else if(dao.duplicateEmail(email)){
		str="중복된 이메일";
	}else{
	//createProc.jsp로 이동
	request.setAttribute("upload", upload);
%> 
 	<jsp:forward page="/member/createProc.jsp"/>
 <%
 	return;
 	} 
 %>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: 맑은고딕; 
  font-size: 20px; 
} 
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/templet/top.jsp" flush="false"/>
<!-- *********************************************** -->
 
<DIV class="title">아이디및 이메일 중복</DIV>

<div class="content">
<form  method="post" enctype="multipart/form-data">
<%=str%>
</form>
</div>

<DIV class='bottom'>
<input type='button' value='다시시도' onclick="history.back()">
</DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
