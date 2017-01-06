<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>

<% 
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("tot")){
		word = "";
	}
	
	int nowPage = 1;
		if(request.getParameter("nowPage")!=null){
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
	int recordPerPage=10;
	int sno = ((nowPage-1)*recordPerPage)+1;
	int eno = nowPage * recordPerPage;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);

	int total = adao.total(col,word);
	
	List<AddressDTO> list = adao.list(map);
	Iterator<AddressDTO> iter = list.iterator();
%> 

<!DOCTYPE html> 
<html> 
<head> 
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/js/bootstrapValidator.min.js"> </script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
function read(no) {
	var url = "read.jsp";
	url += "?no=" +no;
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href = url;
}
function update(no) {
	var url = "updateForm.jsp";
	url += "?no=" +no;
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href = url;
}
function del(no) {
	if(confirm("삭제 하시겠습니까?")){
		var url = "deleteProc.jsp"
		url += "?no=" +no;
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		url += "&nowPage=<%=nowPage%>";
		location.href=url;
	}
		
}
</script>
<link href="<%=root%>/css/style.css" type="text/css" rel="Stylesheet">
</head> 
<body> 
<jsp:include page="/templet/top.jsp" />

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-list-alt"></span>_주소록</h2>
<hr class="w3-round border-position">
</div>

<div class="container">
<div class="search" style="margin-bottom: 5px;">
<form action="./list.jsp" method="post">

<select name="col">

	<option value="name"
	<% if(col.equals("name"))out.print("selected='selected'");%>
	>이름</option>
	
	
	<option value="phone"
	<% if(col.equals("phone"))out.print("selected='selected'");%>
	>핸드폰</option>
	
	<option value="tot">전체출력</option>
	
</select>

<input type="text" name="word" value="<%=word %>">
<input type="submit" class="btn btn-default" value="검색">
<input type="button" class="btn btn-default" value="등록" onclick="location.href='./createForm.jsp'">
</form>
</div>
<table class="table table-hover">
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>핸드폰</th>
		<th>우편번호</th>
		<th>주소</th>
		<th>상세주소</th>
		<th>수정/삭제</th>
	</tr>

<% if(list.size() == 0){%>
	<tr>
		<td colspan="6" align="center">등록된 정보가 없습니다</td>
	</tr>
<% }else{
		while(iter.hasNext()){	
			AddressDTO dto = iter.next();
%>
	<tr>
		<td><%= dto.getNo() %></td>
		<td><a href="javascript:read('<%= dto.getNo() %>')"><%= dto.getName() %></a></td>
		<td><%= dto.getPhone() %></td>
		<td><%= dto.getZipcode() %></td>
		<td><%= dto.getAddress1() %></td>
		<td><%= dto.getAddress2() %></td>
		<td>
		<a href="javascript:update('<%= dto.getNo() %>')">수정</a>
		<a href="javascript:del('<%= dto.getNo() %>')">삭제</a>
		</td>
	</tr>
<% }
 }
%>

</table>
</div>
<div>
<%= Utility.paging3(total, nowPage, recordPerPage, col, word) %>
</div>
<jsp:include page="/templet/bottom.jsp" />
</body> 
</html>

 