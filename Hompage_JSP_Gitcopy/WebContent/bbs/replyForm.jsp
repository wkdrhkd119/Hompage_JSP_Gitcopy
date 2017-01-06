<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi.jsp" %>
<%  
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	BbsDTO dto = bdao.readReply(bbsno);
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
            
            filename: {
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


<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">
</head> 

<body>
<jsp:include page="/templet/top.jsp" />

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-th-list"></span>_게시판</h2>
<hr class="w3-round border-position">
</div> 

<FORM name='frm' 
	  method='POST' 
	  action='./replyProc.jsp' 
	  enctype="multipart/form-data"
	  id="contactForm"
	  class="form-horizontal">

<!-- 답변을 등록하기 위해서 -->
<input type="hidden" value="<%= dto.getGrpno() %>" name="grpno">
<input type="hidden" value="<%= dto.getIndent() %>" name="indent">
<input type="hidden" value="<%= dto.getAnsnum() %>" name="ansnum">

<!-- 페이지와 검색유지를 위해서 -->
<input name="col" type="hidden" value="<%=request.getParameter("col")%>">
<input name="word" type="hidden" value="<%=request.getParameter("word")%>">
<input name="nowPage" type="hidden" value="<%=request.getParameter("nowPage")%>">

<!-- 부모글 삭제를 막기위해서 -->
<input name="bbsno" type="hidden" value="<%=bbsno%>">


	<div class="form-group">
        <label class="col-md-3 control-label">이름</label>
        <div class="col-md-6">
            <input type="text" class="form-control" name="wname">
        </div>
    </div>
    
 	<div class="form-group">
        <label class="col-md-3 control-label">제목</label>
        <div class="col-md-6">
            <input type="text" class="form-control" name="title" value="<%=dto.getTitle() %>">
        </div>
    </div>
    
    
    <div class="form-group">
        <label class="col-md-3 control-label">내용</label>
        <div class="col-md-6">
            <textarea class="form-control" name="content" rows="8"></textarea>
        </div>
    </div>
    
    <div class="form-group">
        <label class="col-md-3 control-label">비밀번호</label>
        <div class="col-md-6">
            <input type="password" class="form-control" name="passwd">
        </div>
    </div>
    
    <div class="form-group">
        <label class="col-md-3 control-label">파일</label>
        <div class="col-md-4">
            <input type="file" class="form-control buttonPadding" name="filename">
        </div> 

    </div>
    
    <!-- #messages is where the messages are placed inside -->
    <div class="form-group">
        <div class="col-md-9 col-md-offset-3">
            <div id="messages"></div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-9 col-md-offset-3">
            <button type="submit" class="btn btn-default">답변달기</button>
            <button type="button" class="btn btn-default" onclick="history.back()">취소</button>
            <button type="button" class="btn btn-default" onclick="location.href='./list.jsp'">목록</button>
        </div>
    </div>  

</FORM>
 

<jsp:include page="/templet/bottom.jsp" />
</body>

</html> 
