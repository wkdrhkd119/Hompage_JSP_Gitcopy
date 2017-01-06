<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp"%>
<% 

	
	String col=Utility.checkNull(request.getParameter("col"));
	String word=Utility.checkNull(request.getParameter("word"));
	String nowPage= request.getParameter("nowPage");
	

	int no= Integer.parseInt(request.getParameter("no"));
	ImagesDTO dto= idao.read(no);

%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="<%=root%>/css/style.css" type="text/css" rel="Stylesheet">



<script type="text/javascript">
function readGo(no){
	var url = "./read.jsp";
	url = url +"?no="+no;
	
	location.href=url;
}
function idown(fname){
	var url = "<%=root%>/download";
	url += "?dir=/images/storage";
	url += "&filename="+fname;	
	
	location.href = url;
	
}
function update(){
	var url= "updateForm.jsp";
	url+="?no=<%=no%>";
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	url+= "&nowPage=<%=nowPage%>";
	location.href=url;
}
function reply(){
	var url= "replyForm.jsp";
	url+="?no=<%=no%>";		
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	url+= "&nowPage=<%=nowPage%>";
	location.href=url;		
}
function idelete(){
	var url= "deleteForm.jsp";
	url+="?no=<%=no%>";
	url+="&col=<%=col%>";
	url+="&word=<%=word%>";
	url+= "&nowPage=<%=nowPage%>";
	url+= "&oldfile=<%=dto.getFname()%>";
	location.href=url;
}
</script>
<style type="text/css">
.imgpading{
	padding-left: 76px;
	padding-right: 9px;
}

.iconp{
	margin-left: 60px;
}
</style>

</head> 

<body>
<jsp:include page="/templet/top.jsp" />

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-picture"></span>_썸네일</h2>
<hr class="w3-round border-position">
</div> 
<div class="w3-container" style="margin-left: 20px;">
	<div class="container">
	<div class="row">
  	<div class="col-sm-4"></div>
     <table>
    <tr>			
		<td colspan="2" id="ftd">
		<img class="simage" id="img" src='<%=root %>/images/storage/<%=dto.getFname() %>'>
	    </td>
    </tr>
	
    <TR>
      <TH>제목</TH>
      <TD><%=dto.getTitle() %></TD>
    </TR>
     <TR>
      <TH>내용</TH>
      <TD><%=dto.getContent() %></TD>
    </TR>
     <TR>
      <TH>성명</TH>
      <TD><%=dto.getWname() %></TD>
    </TR>
     <TR>
      <TH>조회수</TH>
      <TD><%=dto.getViewcnt() %></TD>
    </TR>
     <TR>
      <TH>등록날짜</TH>
      <TD><%=dto.getWdate().substring(0, 10) %></TD>
    </TR>
     <TR>
      <TH>파일</TH>      
       <TD>
       <%if(dto.getFname()==null){
    	   out.print("파일없음");
       }else{ %>
       <%=dto.getFname()%>
      <a href="javascript:idown('<%=dto.getFname()%>')">
      <span class="glyphicon glyphicon-download-alt"></span>
      </a>       
       <%}%>
      
      </TD>
    </TR>
  
  </TABLE>
  </div>

  
  

 
  <TABLE>
  	<TR>
  	<%
  	List list = idao.imgRead(no);
    String[] files = (String[])list.get(0);
    int[] noArr = (int[])list.get(1);
    for(int i=0;i<5;i++){
    	if(files[i]==null){  
 	 %>
  
 	<td><img class="slistimage w3-row-padding w3-hover-opacity" src="<%=root %>/images/storage/member.jpg"><td>
  	<%
    	}else{
    		if(noArr[i]==no){
  	%> 	
  <td class="w3-row-padding"><a href="javascript:readGo('<%=noArr[i]%>')">
  <img class="slistimage w3-hover-opacity" src="<%=root %>/images/storage/<%=files[i] %>">
  </a>
  </td>
  	<%		
    		}else{
    			   		
  	%>
  <td class="w3-row-padding"><a href="javascript:readGo('<%=noArr[i]%>')">
  <img class="slistimage w3-hover-opacity" src="<%=root %>/images/storage/<%=files[i] %>">
  </a>
  </td>
  
  <%
    		}
    	 }   		
      }
  %> 
    </TR>
    </TABLE>
    </div>
   
  
<br>  


<div class="container">
 <div class="row">
 
  <div class="col-md-4 iconp"> </div>
    <input type='button' value='목록' class="btn btn-default" onclick="location.href='./list.jsp'">
    <input type='button' value='수정' class="btn btn-default" onclick ="update()">
    <input type='button' value='답변' class="btn btn-default" onclick="reply()">
    <input type='button' value='삭제' class="btn btn-default" onclick="idelete()">
 </div>
 </div>
 </div>



  
 

<jsp:include page="/templet/bottom.jsp" />
</body>

</html> 