<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %> 

<jsp:useBean id="dto" class="team.TeamDTO"/>
<jsp:setProperty property="*" name="dto"/>
<% 
	int no = Integer.parseInt(request.getParameter("no"));
	
	boolean flag = tdao.update(dto);
	
	
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

</script>
<style type="text/css"> 
*{ 
  font-family: gulim; 
  font-size: 24px; 
} 
div{
	margin-top: 50px;
	text-align: center;
}
</style> 
</head> 
<body> 
<jsp:include page="/templet/top.jsp"/>
<div>
<% 
	if(flag){  // == if(dao.update(dto))
		out.print("수정완료");
	}
	else{
		out.print("수정실패");
	}
%>
<input type="button" value="목록" onclick="tlist()">
</div>
<jsp:include page="/templet/bottom.jsp"/>
</body> 
</html> 
