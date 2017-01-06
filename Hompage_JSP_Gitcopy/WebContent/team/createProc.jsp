
<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>

<jsp:useBean id="dto" class="team.TeamDTO"/>

<% 

	String upDir = application.getRealPath("/team/storage");
	String tempDir = application.getRealPath("/team/temp");
	
	UploadSave upload = new UploadSave(request, -1, -1, tempDir);
	
	//from의 값 가져오기
	dto.setName(UploadSave.encode(upload.getParameter("name")));
	dto.setGender(UploadSave.encode(upload.getParameter("gender")));
	dto.setPhone(upload.getParameter("phone"));
	dto.setZipcode(UploadSave.encode(upload.getParameter("zipcode")));
	dto.setAddress1(UploadSave.encode(upload.getParameter("address1")));
	dto.setAddress2(UploadSave.encode(upload.getParameter("address2")));
	dto.setHobby(UploadSave.encode(upload.getParameter("hobby")));
	dto.setSkill(upload.getParameterValues("skill"));
	
	FileItem fileItem = upload.getFileItem("filename");
	int filesize = (int)fileItem.getSize();
	String filename = null;
		if(filesize>0){
			filename = UploadSave.saveFile(fileItem, upDir);
		}else{
			filename = "member.jsp";
		}
		
	dto.setFilename(filename);	
	
	boolean flag = tdao.create(dto);
   
%> 

<!DOCTYPE html> 
<html> 
<head> 

<meta charset="UTF-8"> 
<title></title> 
<style type="text/css"> 
*{ 
  font-family: 맑은고딕; 
  font-size: 20px; 
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
	<% if(flag){
		out.print("팀정보 등록성공");
	}
	else{
		out.print("입력실패");
	}
	%><br>
	<input type="button" value="계속등록" onclick="location.href='./createForm.html'">
	<input type="button" value="목록" onclick="location.href='./list.jsp'">
</div>
<jsp:include page="/templet/bottom.jsp"/>
</body> 
</html> 

