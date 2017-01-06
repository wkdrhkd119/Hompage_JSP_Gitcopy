<%@page import="utility.Utility"%>
<%@ page contentType="text/html; charset=UTF-8" %> 
<% 
	String root = request.getContextPath(); 
	String id = (String)session.getAttribute("id");
	String grade = (String)session.getAttribute("grade");
	String word = Utility.checkNull(request.getParameter("word"));
	
	String str = null;
	if(id!=null && grade.equals("A")){
		str = "관리자: "+id;
	}else if(id!=null && grade.equals("H")){
		str = "사용자: "+id;
	}else{
		str = "안녕하세요!";
	}
	
%>
<!DOCTYPE html>
<html>
<title>Hompage</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins">

<style>

body,h1,h2,h3,h4,h5 {font-family: "Poppins", sans-serif}
body {font-size:15px;}
.w3-half img{margin-bottom:-6px;margin-top:16px;opacity:0.8;cursor:pointer}
.w3-half img:hover{opacity:1}

/* input[type=text] {
    width: 110px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 1px;
    font-size: 13px;
    background-color: white;
    background-image: url('searchicon.png');
    background-position: 10px 6px; 
    background-repeat: no-repeat;
    padding: 8px 16px 8px 40px;
    -webkit-transition: width 0.4s ease-in-out;
    transition: width 0.4s ease-in-out;
}

input[type=text]:focus {
    width: 30%;
} */

</style>

<body>

<!-- Sidenav/menu -->
<nav class="w3-sidenav w3-deep-orange w3-collapse w3-top w3-large w3-padding" style="z-index:3;width:285px;font-weight:bold" id="mySidenav"><br>
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-padding-xlarge w3-hide-large w3-display-topleft w3-hover-white" style="width:100%">Close Menu</a>
  <div class="w3-container">
    <h3 class="w3-padding-32"><b>HomePage</b></h3>
   
	
	
    <%=str%>
  </div>
  
  <%if(id!=null && grade.equals("A")){%>
  <a href="<%=root%>/member/logout.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">로그아웃</a> 
  <a href="<%=root%>/member/list.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">회원목록</a> 
  <%}%>
  <a href="<%=root%>/index.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">홈</a> 
  <a href="<%=root%>/bbs/list.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">게시판</a> 
  <a href="<%=root%>/memo/list.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">메모</a> 
  <a href="<%=root%>/address/list.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">주소록</a> 
  <a href="<%=root%>/team/list.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">팀</a> 
  <a href="<%=root%>/images/list.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">썸네일</a> 
  <%if(id==null){%>
  <a href="<%=root%>/member/agreement.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">회원가입</a> 
  <a href="<%=root%>/member/loginForm.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">로그인</a> 
  <%}else if(id!=null && grade.equals("H")){%>
  <a href="<%=root%>/member/read.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">나의정보</a>
  <a href="<%=root%>/member/updateForm.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">회원수정</a>
  <a href="<%=root%>/member/deleteForm.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">회원탈퇴</a>
  <a href="<%=root%>/member/logout.jsp" onclick="w3_close()" class="w3-padding w3-hover-white">로그아웃</a>
  <%}%>
  
</nav>
<!-- Top menu on small screens -->
<header class="w3-container w3-top w3-hide-large w3-red w3-xlarge w3-padding">
  <a href="javascript:void(0)" class="w3-btn w3-red w3-border w3-border-white w3-margin-right" onclick="w3_open()">☰</a>
  <span>Index</span>
</header>

<!-- Overlay effect when opening sidenav on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:340px;margin-right:40px;">
	<jsp:include page="../suggest/suggest_team.jsp" flush="false"/>

  <!-- Header
  <div class="w3-container" style="margin-top:50px" id="showcase">
    <h1 class="w3-xxxlarge"><b>Index page</b></h1>
  </div> -->

  <!-- Services -->
<!--   <div class="w3-container" id="services" style="margin-top:100px">
    <hr style="width:50px; border:5px solid; border-color: #FF4500" class="w3-round">
  </div> -->