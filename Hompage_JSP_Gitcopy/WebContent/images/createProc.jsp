<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<jsp:useBean id="dto" class="images.ImagesDTO" />
<%
	String tempDir = application.getRealPath("/images/temp");
	String upDir = application.getRealPath("/images/storage");

	UploadSave upload = new UploadSave(request, -1, -1, tempDir);

	dto.setWname(UploadSave.encode(upload.getParameter("wname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(UploadSave.encode(upload.getParameter("passwd")));

	FileItem fileItem = upload.getFileItem("fname");
	int size = (int)fileItem.getSize();
	String fname = null;
	if(size>0){
		fname = UploadSave.saveFile(fileItem, upDir);
	}else{
		fname = "member.jpg";
	}

	dto.setFname(fname);
		
	boolean flag = idao.create(dto);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head>
<!-- *********************************************** -->
<body>
<jsp:include page="/templet/top.jsp" flush="false" />
<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-picture"></span>_썸네일</h2>
<hr class="w3-round border-position">
</div> 

	<DIV class="title">사진등록</DIV>
	<div class="content">
		<%
			if (flag) {
				out.print("등록성공");
			} else {
				out.print("등록실패");
			}
		%>
	</div>

	<%
		if (flag) {
	%>
	<DIV class='bottom'>
		<input type="button" value='새로운 사진등록'
			onclick="location.href='./createForm.jsp'"> <input
			type='button' value='목록' onclick="location.href='./list.jsp'">
	</DIV>
	<%
		} else {
	%>
	<DIV class='bottom'>
		<input type="button" value='다시시도' onclick="history.back()"> <input
			type='button' value='목록' onclick="location.href='./list.jsp'">
	</DIV>
	<%
		}
	%>
	<!-- *********************************************** -->
<jsp:include page="/templet/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>
