<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<% 
	String id= request.getParameter("id");
	if(id==null){
		id = (String)session.getAttribute("id");
	}
	MemberDTO dto = dao.read(id);
 
%> 
 
<!DOCTYPE html> 
<html> 
<head> 

<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">

function update() {
	var url = "updateForm.jsp";
	url += "?id=<%=id%>";
	location.href=url;
}

function updatePw() {
	var url = "updatePwForm.jsp";
	url += "?id=<%=id%>";
	location.href=url;
}

function updateFile() {
	var url = "updateFileForm.jsp";
	url += "?id=<%=id%>";
	url += "&oldfile=<%=dto.getFname()%>";
	location.href=url;
}

</script>

<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
<style type="text/css">


</style>
</head> 

<body>
<jsp:include page="/templet/top.jsp" flush="false"/>

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-user"></span>_나의정보</h2>
<hr class="w3-round border-position">
</div> 

 

<div class="container">
<div class="row">
<div class="col-sm-1"></div>
<div class="col-sm-10">
  <TABLE class="table table-hover">
  	 
  	 <tr>
  	 <td rowspan="8" style="width: 20%;"><img class="member-Readimg" src="<%=root%>/member/storage/<%=dto.getFname()%>"></td>
  	 </tr>   	
  	    	
  	    	
    <TR>
      <TH >아이디</TH>
      <TD style="width: 53%;"><%= dto.getId() %></TD>
    </TR>
    
    <TR>
      <TH>성명</TH>
      <TD><%= dto.getMname()%></TD>
    </TR>
    
    <TR>
      <TH>전화번호</TH>
      <TD><%= dto.getTel() %></TD>
    </TR>
    
    <TR>
      <TH>이메일</TH>
      <TD><%= dto.getEmail() %></TD>
    </TR>
    
    <TR>
      <TH>우편번호</TH>
      <TD><%= dto.getZipcode() %></TD>
    </TR>
    
    <TR>
      <TH>주소</TH>
      <TD>
      <%= dto.getAddress1() %>
      <%= Utility.checkNull(dto.getAddress2()) %>
      </TD>
    </TR>
    
    <TR>
      <TH>직업</TH>
      <TD>직업코드:<%=dto.getJob()%>
          (<%=Utility.getCodeValue(dto.getJob())%>)		
      </TD>
    </TR>

  </TABLE>
  
  <DIV class='bottom'>
    <input type='button' class="btn btn-default" value='정보수정' onclick="update()">
    <input type='button' class="btn btn-default" value='사진수정' onclick="updateFile()">
    <input type='button' class="btn btn-default" value='패스워드수정' onclick="updatePw()">
    
  </DIV>
  </DIV>
  </DIV>
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>
<!-- *********************************************** -->
</html> 
