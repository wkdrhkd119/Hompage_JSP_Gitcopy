<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%  
	String upDir = application.getRealPath("/member/storage");

	String id = request.getParameter("id");
	String oldfile = request.getParameter("oldfile");

	boolean flag = dao.delete(id);
	if(flag){
		UploadSave.deleteFile(upDir, oldfile);
		session.invalidate();//회원과 서버간의 연결을 끊는다.
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
 
<DIV class="title">탈퇴</DIV>
<div class="content">
<% 
	if(flag){
		out.print("성공");
	}else{
		out.print("실패");
	}

%>
</div>


  
  <DIV class='bottom'>
    <input type='button' value='홈' onclick="location.href='../index.jsp'">
    <input type='button' value='다시시도' onclick="history.back()">
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
