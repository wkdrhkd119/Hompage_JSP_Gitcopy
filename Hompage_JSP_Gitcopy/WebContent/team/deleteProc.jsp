
<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>


<% 
	
	int no = Integer.parseInt(request.getParameter("no"));
	String oldfile = request.getParameter("oldfile");
	boolean flag = tdao.delete(no);
	if(flag){
		String upDir = application.getRealPath("/team/storage");
		UploadSave.deleteFile(upDir, oldfile);
	}
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
text-align: center;
margin-top: 100px;
}
</style> 
</head> 
<body> 
<jsp:include page="/templet/top.jsp"/>
<div>
	<% 
		if(flag){ 
		out.print("삭제 성공");
		}
		else{
		out.print("삭제 실패");
		}
	
	%><br><br>
	
<input type="button" value="List" onclick="tlist()">
</div>
<jsp:include page="/templet/bottom.jsp"/>
</body> 
</html> 

