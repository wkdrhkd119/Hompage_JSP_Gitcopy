<%@ page contentType="text/html; charset=UTF-8" %> 
<%  request.setCharacterEncoding("utf-8"); 
	session.invalidate();//모든세션 제거(id, grade)
	
	response.sendRedirect("../index.jsp");
%> 
 
