<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%  
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");

	boolean flag = dao.updatePw(id,passwd);

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
 
<DIV class="title">패스워드 변경처리</DIV>
 
<div class="content">

<% 
	if(flag){
		out.print("변경성공 <br>");
		out.print("로그인을 해보세요. <br>");
	}else{
		out.print("변경실패");
	}

%>
</div>
  
  <DIV class='bottom'>
  <% if(flag) {%>
    <input type='button' value='로그인' onclick="location.href='./loginFor.jsp'">
    <% }else{ %>
    <input type='button' value='다시시도' onclick="history.back()">
    <% } %>
    <input type='button' value='홈' onclick="location.href='../index.jsp'">
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
