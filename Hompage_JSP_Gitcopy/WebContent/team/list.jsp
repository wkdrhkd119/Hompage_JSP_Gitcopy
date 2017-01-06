<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>

<% 
	//--검색관렬
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("tot")) word="";
	
	
	//페이지 관련
	int nowPage = 1; //현재페이지, 변경가능
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	int recordPerpage=5; //한페이지당 보여질 레코드 갯수
	
	//DB가져올 순번
	int sno = ((nowPage-1)*recordPerpage) +1;
	int eno = nowPage*recordPerpage;
	
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);		
	map.put("sno", sno);
	map.put("eno", eno);
	
	int total = tdao.total(col,word);
	List<TeamDTO> list = tdao.list(map);
	Iterator<TeamDTO> iter = list.iterator();

	
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  	font-family: 맑은고딕; 
  	font-size: 18px; 
} 

div{
	text-align: center;
	margin-bottom: 20px;
	margin-top: 20px;
}

table{
	width: 70%;
	margin: 0 auto;
	
}

table, th, td{
	border: 1px solid black;
	border-collapse:  collapse;

}

th, td{
	padding: 2px;
	
}

th{
	text-align: center;
}
a:LINK {
	color: fuchsia;
	text-decoration: none;
}
a:VISITED {
	color: fuchsia;
	text-decoration: none;
}
a:HOVER {
	color: gray;
	text-decoration: none;
}
a:ACTIVE {
	color: buttonshadow;
	text-decoration: none;
}
.img{
	width: 90px;
	height: 90px;
	margin-left: 0;
	margin-right: auto;
	display: block;
}
</style> 

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
function del(no,oldfile) {
	if(confirm("삭제 하시겠습니까?")){
		var url = "deleteProc.jsp"
		url += "?no=" +no;
		url += "&col=<%=col%>";
		url += "&word=<%=word%>";
		url += "&nowPage=<%=nowPage%>";
		url += "&oldfile=" +oldfile;
		location.href=url;
	}
		
}
</script>

</head> 
<body> 
<jsp:include page="/templet/top.jsp"/>

<div>팀 목록</div>
<div class="search">
<form action="./list.jsp" method="post">
<select name="col">
	<option value="name"
	<%if(col.equals("name")) out.print("selected='selected'"); %>
	>이름</option>
	
	<option value="phone"
	<%if(col.equals("phone")) out.print("selected='selected'"); %>
	>전화번호</option>
	
	<option value="skill"
	<%if(col.equals("skill")) out.print("selected='selected'"); %>
	>보유기술</option>
	
	<option value="tot">전체출력</option>
	
</select>
<input type="text" name="word" value="<%=word %>"> 
<input type="submit" value="검색">
<input type="button" value="등록" onclick="location.href='./createForm.jsp'">
</form>
</div>
<table>
	<tr>
		<th>NO</th>
		<th>NAME</th>
		<th>PHONE</th>
		<th>SKILL</th>
		<th>PICTURE</th>
		<th>수정/삭제</th>
	</tr>

<% if(list.size()==0){%>
	<tr>
		<td colspan="6" align="center">등록된 정보가 없습니다</td>
	</tr>
<% }else{
	while(iter.hasNext()){
		TeamDTO dto = iter.next();
%>
	<tr>
		<td><%= dto.getNo() %></td>
		<td><a href="javascript:read('<%= dto.getNo() %>')"><%= dto.getName() %></a></td>
		<td><%= dto.getPhone() %></td>
		<td><%= dto.getSkillstr() %></td>
		<td style="width: 10px;"><img class="img" src="./storage/<%= dto.getFilename() %>"></td>
		<td>
		<a href="javascript:update('<%= dto.getNo() %>')">수정</a>/
		<a href="javascript:del('<%= dto.getNo() %>','<%= dto.getFilename() %>')">삭제</a>
		</td>
	</tr>
<% } //while-end
 } //if-end
%>

</table>
<div>
<%= Utility.paging3(total, nowPage, recordPerpage, col, word) %>
</div>
<jsp:include page="/templet/bottom.jsp"/>
</body> 
</html>

