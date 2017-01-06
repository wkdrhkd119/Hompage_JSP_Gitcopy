<%@ page contentType="text/html; charset=UTF-8" %> 
<%  request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: 맑은고딕; 
  font-size: 16px; 
} 
</style> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 

<body>
<DIV class="title">ID 중복 확인</DIV>

<div class="content">
<FORM name='frm' method='POST' action='./id_proc.jsp'>
  ID를 입력해주세요.<br><br>
  <TABLE>
    <TR>
      <TH>아이디</TH>
      <TD><input type="text" name="id" size="20" align="center"></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='중복확인'>
    <input type='button' value='취소' onclick="window.close()">
  </DIV>
</FORM>
</div>  
</body>
</html> 
