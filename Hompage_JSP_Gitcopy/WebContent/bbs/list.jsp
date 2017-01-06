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
	int nowPage = 1; 	//현재 보고있는 페이지
		if(request.getParameter("nowPage")!=null){
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
	int recordPerPage=10;	//한페이지당 보여줄 레코드갯수
	
	
	//DB에서 가져올 순번
	int sno = ((nowPage-1)*recordPerPage) +1;
	int eno = nowPage*recordPerPage;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	
	int total=dao.total(col,word);
	
	List<BbsDTO> list = bdao.list(map);
	Iterator<BbsDTO> iter = list.iterator();
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<link href="<%=root%>/css/style.css" type="text/css" rel="Stylesheet">
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
function read(bbsno) {
	var url = "read.jsp"
	url += "?bbsno=" +bbsno;
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	url += "&nowPage=<%=nowPage%>";
	location.href = url
}

function down(filename) {
	var url = "<%=root%>/download";
	url += "?dir=/bbs/storage";
	url += "&filename="+filename;
	location.href = url;
}

</script>

</head> 

<body>
<jsp:include page="/templet/top.jsp" />

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-th-list"></span>_게시판</h2>
<hr class="w3-round border-position">
</div> 
  
<div class="container">
<div class="search serchPosition">
<form action="./list.jsp"  method="post">

<select name="col"><%-- 검색할 컬럼 --%>

	<option value="wname" 
	<% if(col.equals("wname")) out.print("selected='selected'");%>
	>성명</option>
	
	<option value="title"
	<% if(col.equals("title")) out.print("selected='selected'");%>
	>제목</option>
		
	<option value="content"
	<% if(col.equals("content")) out.print("selected='selected'");%>
	>내용</option>
	
	<option value="tot">전체출력</option>
</select>

<input type="text" name="word" value="<%= word %>"><%-- 검색어 --%>
<input type="submit" class="btn btn-default" value="검색">
<input type='button' class="btn btn-default" value='등록' onclick="location.href='./createForm.jsp'">
</form>
</div>

  <TABLE class="table table-hover">
    <TR>
  
      <TH>번호</TH>
      <TH>제목</TH>
      <TH>성명</TH>
      <TH>조회수</TH>
      <TH>등록일</TH>
      <TH>파일명</TH>
    
    </TR>
    
<% 	if(list.size()==0){ %>
	<tr>
	<td colspan="8">등록된 글이 없습니다.</td>
	</tr>

<% }else{
		while(iter.hasNext()){    
			BbsDTO dto = iter.next(); %>

     <TR>
      <TD><%= dto.getBbsno() %></TD>
      <TD align="left">
 <% 
 	for(int i=0; i<dto.getIndent(); i++){
 		out.print("&nbsp;&nbsp;&nbsp");
  	}
      
    if(dto.getIndent()>0){ 
        
    out.print("ㄴ");
 	 } %>  <!-- <img src="./img/p.jpg" width="20px" height="20px"> --> 
      <a href="javascript:read('<%=dto.getBbsno() %>')" ><%=dto.getTitle() %></a>
      <% if(Utility.compareDay(dto.getWdate().substring(0,10))){%>
      <img src="img/new.gif">
      <% } %>
      </TD>
      <TD><%= dto.getWname() %></TD>
	  <TD><%= dto.getViewcnt() %></TD>
      <TD><%= dto.getWdate().substring(0, 10) %></TD>
      <TD><% if(dto.getFilename()==null){
    	  		out.print("파일없음");
      			}else{%>
      				<a href="javascript:down('<%=dto.getFilename() %>')">
      				<span class='glyphicon glyphicon-save-file'></span>	
      				</a>
      		<%}%>
     </TD>
    </TR>
	<% } %>    
<% } %>   
    
  </TABLE>
   
<div class="row">
<div class="col-sm-4"></div>  
<%=Utility.paging3(total, nowPage, recordPerPage, col, word) %>
</div>
  

<!-- *********************************************** -->
<jsp:include page="/templet/bottom.jsp" />
</body>
<!-- *********************************************** -->
</html> 
