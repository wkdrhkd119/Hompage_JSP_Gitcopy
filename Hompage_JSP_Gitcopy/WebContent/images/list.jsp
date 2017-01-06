<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<%
		
	//검색============================================
	String col = Utility.checkNull(request.getParameter("col"));
	String word = Utility.checkNull(request.getParameter("word"));

	if (col.equals("total")) {
		word = "";
	}
	//paging 관련=======================================
	int nowPage = 1;//현재 보고 있는 페이지
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	int recordPerPage = 5;//한 페이지 보여줄 갯수

	//DB에서 가져올 순번=====================================
	int sno = ((nowPage - 1) * recordPerPage) + 1;
	int eno = nowPage * recordPerPage;

	Map map = new HashMap();
	map.put("col", col);
	map.put("word", word);
	map.put("sno", sno);
	map.put("eno", eno);

	int total = idao.total(col, word);
	List<ImagesDTO> list = idao.list(map);
	Iterator<ImagesDTO> iter = list.iterator();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="<%=root%>/css/style.css" type="text/css" rel="Stylesheet">

<script type="text/javascript">
function read(no){
var url= "read.jsp";
url+= "?no="+no;
url+= "&col=<%=col%>";
url+= "&word=<%=word%>";
url+= "&nowPage=<%=nowPage%>";

location.href=url;
}

function idown(fname) {
	var url = "<%=root%>/download";
		url += "?dir=/images/storage";
		url += "&filename=" + fname;
		location.href = url
	}
</script>
<style type="text/css">
td{
	padding-top: 35px;
}

</style>

</head>

<body>
	<jsp:include page="/templet/top.jsp" />

	<div class="w3-container mainPosition" id="services">
		<h2 class="iconPosition">
			<span class="glyphicon glyphicon-picture"></span>_썸네일
		</h2>
		<hr class="w3-round border-position">
	</div>


	<div class="container">
		<div class="search serchPosition">
			<div class="col-sm-2"></div>
			<FORM method='POST' action='./list.jsp'>

				<select name="col">
					<!-- 검색할 컬럼 -->
					<option value="wname"
						<%if (col.equals("wname"))out.print("selected='selected'");%>
					>성명</option>
					<option value="title"
						<%if (col.equals("title"))out.print("selected='selected'");%>
					>제목</option>
					<option value="content"
						<%if (col.equals("cotent"))out.print("selected='selected'");%>
					>내용</option>
					
					<option value="total">전체</option>
				</select> <input type="text" name="word" value="<%=word%>"> 
				<input type='submit' class="btn btn-default" value='검색'> 
				<input type='button' class="btn btn-default" value='등록' onclick="location.href='./createForm.jsp'">

			</FORM>
		</div>
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<TABLE class="table table-hover">
					<TR>
						<TH>번호</TH>
						<TH>사진</TH>
						<TH>제목</TH>
						<TH>성명</TH>
						<TH>조회수</TH>
						<TH>등록일</TH>
						<TH>파일명</TH>
					</TR>
					<%
						if (list.size() == 0) {
					%>
					<tr>
						<td colspan="7">등록된 글이 없습니다</td>
					</tr>
					<%
						} else {
							while (iter.hasNext()) {
								ImagesDTO dto = iter.next();
					%>
					<tr>
						<Td class="images-text"><%=dto.getNo()%></Td>
						<td><img class="images-img"
							src="./storage/<%=dto.getFname()%>"></td>
						<Td class="images-text">
							<%
								for (int i = 0; i < dto.getIndent(); i++) {
											out.print("  ");
										}

										if (dto.getIndent() > 0) {
							%> <img src="./storage/re.png"> <%
 	}
 %> <a href="javascript:read('<%=dto.getNo()%>')"><%=dto.getTitle()%>
						</a> <%
 	if (Utility.compareDay(dto.getWdate().substring(0, 10))) {
 %> <img src="./storage/new.gif"> <%
 	}
 %>
						</Td>
						<Td class="images-text"><%=dto.getWname()%></Td>
						<Td class="images-text"><%=dto.getViewcnt()%></Td>
						<Td class="images-text"><%=dto.getWdate().substring(0, 10)%></Td>
						<Td class="images-text">
							<%
								if (dto.getFname() == null) {
											out.print("파일 없음");
										} else {
							%> <a href="javascript:idown('<%=dto.getFname()%>')"> <span
								class='glyphicon glyphicon-save-file'></span>
						</a> <%
 	}
 %>

						</Td>
					</tr>
					<%
						} //while 
						} //if
					%>
				</TABLE>
			</div>
		</div>
	</div>
	
	<div class="row">
	<div class="col-sm-4"></div>  
		<%=Utility.paging3(total, nowPage, recordPerPage, col, word)%>
	</DIV>


	<!-- *********************************************** -->
	<jsp:include page="/templet/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>