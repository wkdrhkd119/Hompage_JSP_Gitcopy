<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%@ page import="bbs.*" %>
<%@ page import="memo.*" %>
<%@ page import="team.*" %>
<%@ page import="address.*" %>
<%@ page import="images.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>

<%@ page import="utility.*" %>
<jsp:useBean id="dao" class="member.MemberDAO"/>
<jsp:useBean id="bdao" class="bbs.BbsDAO"/>
<jsp:useBean id="tdao" class="team.TeamDAO"/>
<jsp:useBean id="mdao" class="memo.MemoDAO"/>
<jsp:useBean id="adao" class="address.AddressDAO"/>
<jsp:useBean id="idao" class="images.ImagesDAO"/>

<%  
	request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
	//--업로드용 변수 선언(폴더명)
/* 	String upDir = "/test/storage";
	String tempDir = "/test/temp";
	
	upDir = application.getRealPath(upDir);
	tempDir = application.getRealPath(tempDir); */
	
%> 
