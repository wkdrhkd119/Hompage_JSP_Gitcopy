<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%  
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");
	
	boolean flag = dao.loginCheck(id, passwd);
	
	String grade = null;
	if(flag){//회원인 경우
		grade = dao.getGrade(id);	
		session.setAttribute("id", id);
		session.setAttribute("grade", grade);
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
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 

<body>
<jsp:include page="/templet/top.jsp" flush="false"/>

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-globe"></span>_로그인 결과</h2>
<hr class="w3-round border-position">
</div> 

 
<div class="w3-container" align="center">
<%if(flag){%>
  <div class="w3-panel w3-green alert" >
    <h3 align= "center">로그인 성공!</h3>
    <p align= "center">홈페이지에 오신걸 환영합니다! </p>
  </div><br>
  
  <DIV class='bottom' align="center">
    <button class="button button2" onclick="location.href='../index.jsp'">홈</button>
    <button class="button button3" onclick="location.href='./logout.jsp'">로그아웃</button>
  </DIV>  
<%}else{%>
	 <div class="w3-panel w3-red alert">
    <h3>로그인 실패...</h3>
    <p align="right">로그인에 실패했습니다.. 아이디와 패스워드를 확인해 주시거나 회원가입을 부탁드립니다.</p>
  </div><br>
    <DIV class='bottom' align="center">
    <button class="button button3" onclick="history.back()">다시시도</button>
    <button class="button button2" onclick="location.href='../index.jsp'">홈</button>
    <button class="button button1" onclick="location.href='./agreement.jsp'">회원가입</button>
  </DIV>
<%}%>
</div>
<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>

</html> 
