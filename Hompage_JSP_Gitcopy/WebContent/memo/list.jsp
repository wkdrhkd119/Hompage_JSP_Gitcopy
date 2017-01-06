<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>

<% 
	
	//검색
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	
	if(col.equals("tot")){
		word="";
	}
	
	//페이지관련-------------------------------
	int nowPage = 1; //현재페이지(변경가능해야함)
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	int recordePerPage = 10;	//한페이지다아 보여줄 페이지 레코드갯수
	
	//DB에서 읽어올 시작순번과 끝순번 만들기
	int sno = ((nowPage-1)*recordePerPage)+1;
	int eno = nowPage*recordePerPage;
	
	
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);

	List<MemoDTO> list = mdao.list(map);
	int total = mdao.total(col,word);
%> 

<!DOCTYPE html> 
<html> 
<head> 
<link href="<%=root%>/css/style.css" type="text/css" rel="Stylesheet">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/js/bootstrapValidator.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title></title> 

<script type="text/javascript">
function read(memono) {
 	/* alert(memono); */
	var url = "read.jsp";
	url+= "?memono=" +memono;
	url+= "&col=<%=col%>"; 
	url+= "&word=<%=word%>";
	url+= "&nowPage=<%=nowPage%>";
	location.href=url;
}
</script>


 
</head> 
<body> 
<jsp:include page="/templet/top.jsp" />

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-pencil"></span>_메모</h2>
<hr class="w3-round border-position">
</div>

<div class="container">
<div class="search serchPosition">
<form action="./list.jsp"  method="post">
<div class="col-sm-2"></div>
<select name="col"><%-- 검색할 컬럼 --%>
	
	<option value="title"
	<% if(col.equals("title")) out.print("selected='selected'");%>>제목</option>
		
	<option value="content"
	<% if(col.equals("content")) out.print("selected='selected'");%>>내용</option>
	
	<option value="tot">전체출력</option>
</select>

<input type="text" name="word" value="<%= word %>"><%-- 검색어 --%>
<input type="submit" class="btn btn-default" value="검색">
<input type='button' class="btn btn-default" value='등록' onclick="location.href='./createForm.jsp'">
</form>
</div>

<div class="row">
<div class="col-sm-2"></div>
<div class="col-sm-8">
<table class="table table-hover">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>날짜</th>
		<th>조회수</th>
	</tr>

<% if(list.size()==0) {%>
	<tr>
		<td colspan="4">등록된 메모가 없습니다.</td>
	</tr>
<%  }else{	
	for(int i=0; i<list.size(); i++){
		MemoDTO dto = list.get(i);
	%>		
	<tr>
		<td><%= dto.getMemono() %></td>
		<td><a href="javascript:read('<%= dto.getMemono() %>')"><%= dto.getTitle() %></a></td>
		<td><%= dto.getWdate() %></td>
		<td><%= dto.getViewcnt() %></td>
	</tr>
	
<% }  
}%>	
</table>
</div>
</div>
</div>


<div class="row">
<div class="col-sm-4"></div>
<%=Utility.paging3(total, nowPage, recordePerPage, col, word)%>
</div>
<jsp:include page="/templet/bottom.jsp" />
</body> 
</html> 

