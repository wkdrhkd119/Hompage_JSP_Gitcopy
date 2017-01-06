<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi.jsp"%>
<%
int no = Integer.parseInt(request.getParameter("no"));
ImagesDTO dto = idao.read(no);
%>


<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8"> 
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.2.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/js/bootstrapValidator.min.js"> </script> 
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">

<script type="text/javascript">
$(document).ready(function() {
    $('#contactForm').bootstrapValidator({
        container: '#messages',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
              wname: {
                validators: {
                    notEmpty: {
                        message: '이름을 입력하세요.'
                    }
                 }
            },
              title: {
                validators: {
                    notEmpty: {
                        message: '제목을 입력하세요.'
                    },
                    stringLength: {
                        max: 20,
                        message: '제목은 20자 까지 제한 되어있습니다.'
                    }
                }
            },
            passwd: {
                validators: {
                    notEmpty: {
                        message: '비밀번호를 입력하세요.'
                    }
                }
            },
            
            fname: {
                validators: {
                    notEmpty: {
                        message: '파일을 선택해주세요.'
                    }
                }
            },
            
            content: {
                validators: {
                    notEmpty: {
                        message: '내용을 입력하세요.'
                    },
                    stringLength: {
                        max: 300,
                        message: '내용은 300자까지 제한 되어있습니다.'
                    }
                }
            }
        }
    });
});
</script>
</head>
<!-- *********************************************** -->
<body leftmargin="0" topmargin="0">
<jsp:include page="/templet/top.jsp" flush="false" />
<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-picture"></span>_썸네일</h2>
<hr class="w3-round border-position">
</div> 



<FORM name='frm' 
	  method='POST' 
	  action='./updateProc.jsp' 
	  enctype="multipart/form-data" 
	  
	  id="contactForm"
	  class="form-horizontal">
	  
<input type="hidden" name="grpno" value="<%=dto.getGrpno()%>">
<input type="hidden" name="indent" value="<%=dto.getIndent()%>">
<input type="hidden" name="ansnum" value="<%=dto.getAnsnum()%>">
<input name="no" value="<%=dto.getNo()%>" type="hidden">
<input name="col" value="<%=request.getParameter("col")%>" type="hidden">
<input name="word" value="<%=request.getParameter("word")%>" type="hidden">
<input name="nowPage" value="<%=request.getParameter("nowPage")%>" type="hidden">
<input name="oldfile" value="<%=dto.getFname()%>" type="hidden">

<div class="form-group">
        <label class="col-md-4 control-label">이름</label>
        <div class="col-md-4">
            <input type="text" class="form-control" name="wname" value="<%=dto.getWname() %>">
        </div>
    </div>
    
 	<div class="form-group">
        <label class="col-md-4 control-label">제목</label>
        <div class="col-md-4">
            <input type="text" class="form-control" name="title" value="<%=dto.getTitle() %>">
        </div>
    </div>
    
    
    <div class="form-group">
        <label class="col-md-4 control-label">내용</label>
        <div class="col-md-4">
            <textarea class="form-control" name="content" rows="8"><%=dto.getContent()%></textarea>
        </div>
    </div>
    
    <div class="form-group">
        <label class="col-md-4 control-label">비밀번호</label>
        <div class="col-md-4">
            <input type="password" class="form-control" name="passwd">
        </div>
    </div>
    
    <div class="form-group">
        <label class="col-md-4 control-label">파일</label>
        <div class="col-md-4">
            <input type="file" class="form-control buttonPadding" name="fname" value="<%=dto.getFname()%>">
        </div> 

    </div>
    
    <!-- #messages is where the messages are placed inside -->
    <div class="form-group">
        <div class="col-md-9 col-md-offset-4">
            <div id="messages"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-9 col-md-offset-4">
            <button type="submit" class="btn btn-default">수정</button>
            <button type="button" class="btn btn-default" onclick="history.back()">취소</button>
            <button type="button" class="btn btn-default" onclick="location.href='./list.jsp'">목록</button>
        </div>
    </div>  

</FORM>

<jsp:include page="/templet/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>