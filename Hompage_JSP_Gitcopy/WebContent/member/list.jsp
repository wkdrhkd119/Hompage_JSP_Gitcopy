<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%  
	//검색관련
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));
	if(col.equals("total")){
		word="";
	}
	
	//페이징 관련
	int nowPage = 1;
	int recordPerPage = 5;
	if(request.getParameter("nowPage")!=null){ //getParameter문자열로 받아온다
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	//DB에서 가져올 순번
	int sno = ((nowPage-1)*recordPerPage)+1;
	int eno = nowPage*recordPerPage;
	
	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);
	
	int total = dao.total(col,word);
	List<MemberDTO> list = dao.list(map);
	Iterator<MemberDTO> iter = list.iterator();
	
	String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<style type="text/css">
.table th{
	width:20%;	
}
.table td{
	width:60%;
}
</style>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<title></title> 
<script type="text/javascript">
function read(id) {
	var url = "read.jsp";
	url += "?id=" +id;
	url += "&nowPage=<%=nowPage%>";
	url += "&col=<%=col%>";
	url += "&word=<%=word%>";
	location.href=url;
}

</script>

<link href="<%=root%>/css/style.css" type="text/css" rel="Stylesheet">
</head> 

<body>
<jsp:include page="/templet/top.jsp" flush="false"/>

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-user"></span>_멤버</h2>
<hr class="w3-round border-position">
</div> 
 
<div class="container">
<div class="row">
<div class="col-sm-1"></div>
<div class="col-sm-10">
<FORM name='frm' method='POST' action='./list.jsp' class="form-inline" style="margin-bottom: 5px;">
<select name="col" class="form-control">
	<option value="mname"
	<%if(col.equals("mname")) out.print("selected='selected'");%>
	selected>성명</option>
	
	<option value="email" 
	<%if(col.equals("email")) out.print("selected='selected'"); %>
	>이메일</option>
	
	<option value="id"
	<%if(col.equals("id")) out.print("selected='selected'"); %>
	>아이디</option>
	
	<option value="total">전체</option>
</select>

<input type="text" name="word" value='<%= word %>' class="form-control">
<input type="submit" class="btn btn-default" value="검색">
<input type="button" class="btn btn-default" value="회원가입" onclick="location.href='./createForm.jsp'">
</FORM>


<% 
while(iter.hasNext()){
	MemberDTO dto = iter.next();		
%>
  <TABLE class="table table-hover">
    <TR>
      <th rowspan="5">
      	<img class="member-img" src='./storage/<%=dto.getFname()%>'>
      </Th>
      <th>아이디</th>
      <TD><a href="javascript:read('<%=dto.getId()%>')"><%=dto.getId()%></a></TD>
    </TR>
    
    <TR>
      <TH>성명</TH>
      <TD><%=dto.getMname() %></TD>
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
      <TH>주소</TH>
      <TD><%= dto.getAddress1() %>
      	  <%=Utility.checkNull(dto.getAddress2())%>
      </TD>
    </TR>
  </TABLE>
<% } %>
</div>
</div>
</div>


  <DIV class='bottom'>
  <%=paging%> 
  </DIV>
<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>

</html> 
