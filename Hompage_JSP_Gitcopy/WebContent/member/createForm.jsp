<%@ page contentType="text/html; charset=UTF-8" %> 
<%  request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
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
           			 id: {
                validators: {
                    notEmpty: {
                        message: '아이디를 입력해주세요.'
                    }
                }
            },
            
            email: {
                validators: {
                    notEmpty: {
                        message: '이메일을 입력해주세요'
                    },
                }
            },
                          
            passwd: {
                validators: {
                    notEmpty: {
                        message: '패스워드를 입력해주세요.'
                    },
                    
                }
            },
            
            repasswd: {
                validators: {
                    notEmpty: {
                        message: '패스워드를 다시한번 입력해주세요.'
                    },
                    
                }
            },
            
            mname: {
                validators: {
                    notEmpty: {
                        message: '이름을 입력해주세요.'
                    },
                    
                }
            },
            
            phone: {
                validators: {
                    notEmpty: {
                        message: '핸드폰 번호를 입력해주세요.'
                    },
                    
                }
            },
            
            zipcode: {
                validators: {
                    notEmpty: {
                        message: '우편번호를 입력해주세요.'
                    },
                    stringLength: {
                        max: 7,
                    }
                }
            },
             
            job: {
                validators: {
                    notEmpty: {
                        message: '직업을 선택해주세요.'
                    },
                    
                }
            }
        }
    });
});
</script>

<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script> 

<script type="text/javascript">
function idCheck(id) {
	if(id==""){
		/* alert("아이디를 입력해주세요."); */
		document.frm.id.focus();
	}else{
		var url = "id_proc.jsp";
		url += "?id=" +id;
		wr = window.open(url,"아이디검색","width=700,height=400");
		wr.moveTo((window.screen.width-700)/2,(window.screen.height-400)/2);
	}
}

function emailCheck(email) {
	if(email==""){
		/* alert("이메일을 입력하세요.") */
		document.frm.email.focus();
	}else{
		var url = "email_proc.jsp";
		url += "?email=" +email;
		wr = window.open(url,"이메일검색","width=700,height=400");
		wr.moveTo((window.screen.width-700)/2,(window.screen.height-400)/2);
	}
}

</script>

</head> 

<body>
<jsp:include page="/templet/top.jsp" flush="false"/>

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-user"></span>_멤버</h2>
<hr class="w3-round border-position">
</div> 
 
<FORM name='frm' 
	  method='POST' 
	  action='./prcreateProc.jsp'
	  enctype="multipart/form-data"
	  onsubmit="return inputCheck(this)"
	  id="contactForm"
	  class="form-horizontal">
	  
	<div class="form-group">
        <label class="col-md-3 control-label">사진</label>
        <div class="col-md-6">
            <input type="file" class="form-control buttonPadding" name="fname"/>
        </div>
    </div>
    
    
	<div class="form-group">
        <label class="col-md-3 control-label">*아이디</label>
        <div class="col-md-4">
            <input type="text" class="form-control" name="id" size="15" placeholder="아이디"/>
        </div>
        <div class="col-md-4">
            <input type="button" size="15" class="btn btn-default" value="ID중복확인" onclick="idCheck(document.frm.id.value)"/>
        </div>    
    </div>
    
    
    <div class="form-group">
        <label class="col-md-3 control-label">*이메일</label>
        <div class="col-md-4">
            <input type="text" class="form-control" name="email" placeholder="이메일"/>
        </div>
        <div class="col-md-2">
        	<input type="button" class="btn btn-default" value="Email중복확인" onclick="emailCheck(document.frm.email.value)"/>
        </div>	
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">*패스워드</label>
        <div class="col-md-6">
            <input type="password" class="form-control" name="passwd" size="15" placeholder="패스워드"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">*패스워드확인</label>
        <div class="col-md-6">
            <input type="password" class="form-control" name="repasswd" size="15" placeholder="패스워드확인"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">*이름</label>
        <div class="col-md-6">
            <input type="text" class="form-control" name="mname" placeholder="이름"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">전화번호</label>
        <div class="col-md-6">
            <input type="text" class="form-control" name="tel" placeholder="전화번호"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">*우편번호</label>
        <div class="col-md-4">
            <input type="text" class="form-control" name="zipcode" id="sample6_postcode" placeholder="우편번호"/>
        </div>
        <div class="col-md-2">
            <input type="button" class="btn btn-default" value="우편번호찾기" onclick="sample6_execDaumPostcode()">
        </div>        
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">주소</label>
        <div class="col-md-4">
            <input type="text" class="form-control" name="address1" id="sample6_address" placeholder="주소"/>
        </div>
        <div class="col-md-2">
            <input type="text" class="form-control" name="address2" id="sample6_address2" placeholder="상세주소" />
         </div>   
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">직업</label>
        <div class="col-md-6">
           <select name="job">
	      	<option value="0">선택하세요</option>
	      	<option value="A01">회사원</option>
	      	<option value="A02" selected>전산관련직</option>
	      	<option value="A03">연구전문직</option>
	      	<option value="A04">각종학교학생</option>
	      	<option value="A05">일반자영업</option>
	      	<option value="A06">공무원</option>
	      	<option value="A07">의료인</option>
	      	<option value="A08">법조인</option>
	      	<option value="A09">종교/언론/예술인</option>
	      	<option value="A10">기타</option>     	
	      </select>
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
            <button type="submit" class="btn btn-default" >등록</button>
            <button type="button" class="btn btn-default" onclick="history.back()">취소</button>
        </div>
    </div>      	  
</FORM>
<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>

</html> 
