<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/ssi/ssi.jsp" %> 

<%
 	int no = Integer.parseInt(request.getParameter("no"));
 	TeamDTO dto = tdao.read(no);
 %> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function tlist() {
	var url = "list.jsp";
	url += "?col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	location.href=url;
}

function imgUpdate() {
	var url = "updateFileForm.jsp";
	url += "?col=<%=request.getParameter("col")%>";
	url += "&word=<%=request.getParameter("word")%>";
	url += "&nowPage=<%=request.getParameter("nowPage")%>";
	url += "&no=<%=no%>";
	url += "&oldfile=<%=dto.getFilename()%>";
	location.href=url;
}
</script>
<style type="text/css"> 
*{ 
  font-family: 맑은고딕; 
  font-size: 20px; 
} 

div{
	text-align: center;
	margin-top: 20px;
	margin-bottom: 20px;
}

table{
	width: 35%;
	margin: auto;
}

table, th, td{
	border: 1px solid black;
	border-collapse: collapse;
}

th, td{
	padding: 10px;
}

img{
	width: 300px;
	height: 300px;
}

#ftd{
	text-align: center;
}
</style> 
</head> 
<body> 
<jsp:include page="/templet/top.jsp"/>
<div>조회</div>
<table>
	<tr>
		<td colspan="2" id="ftd">
		<img src='./storage/<%= dto.getFilename() %>'></td>
	</tr>
		
	<tr>
		<td>이름</td>
		<td><%=dto.getName() %></td>
	</tr>	
	
	<tr>
		<td>성별</td>
		<td><%=dto.getGender() %></td>
	</tr>	
	
	<tr>
		<td>전화번호</td>
		<td><%=dto.getPhone() %></td>
	</tr>	
	
	<tr>
		<td>주소</td>
		<td>(우편번호: <%= dto.getZipcode() %>)
				 	   	 <%= dto.getAddress1() %>
				 		 <%= dto.getAddress2() %>
		</td>
	</tr>	
	
	<tr>
		<td>보유기술</td>
		<td><%=dto.getSkillstr() %></td>
	</tr>
	
	<tr>
		<td>취미</td>
		<td><%=dto.getHobby() %></td>
	</tr>
</table>
<div>
	<input type="button"  value="생성" onclick="location.href='./createForm.jsp'">
	<input type="button"  value="목록" onclick="tlist()">
	<input type="button"  value="사진변경" onclick="imgUpdate()">
</div>
<jsp:include page="/templet/bottom.jsp"/>
</body> 
</html> 

