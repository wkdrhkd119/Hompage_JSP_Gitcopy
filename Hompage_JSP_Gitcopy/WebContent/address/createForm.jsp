<%@ page contentType="text/html; charset=UTF-8" %> 
 
<%@ include file="/ssi/ssi.jsp" %>
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
            name: {
                validators: {
                    notEmpty: {
                        message: '이름을 입력해주세요.'
                    }
                }
            },
            
            phone: {
                validators: {
                    notEmpty: {
                        message: '핸드폰 번호를 입력해주세요'
                    },
                   
                }
            },
            
            zipcode: {
                validators: {
                    notEmpty: {
                        message: '우편번호를 입력해주세요.'
                    },
                    stringLength: {
                        max: 10,
                    }
                }
            },
            
            address1: {
                validators: {
                    notEmpty: {
                        message: '주소를 입력하세요.'
                    },
                    stringLength: {
                        max: 50,
                      
                    }
                }
            },
            
            address2: {
                validators: {
                    notEmpty: {
                        message: '상세주소를 입력하세요.'
                    },
                    stringLength: {
                        max: 30,
                    }
                }
            }
        }
    });
});
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
<meta charset="UTF-8">
<link href="<%=root%>/css/style.css" type="text/css" rel="Stylesheet">
</head>
<body>
<jsp:include page="/templet/top.jsp"/>

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-list-alt"></span>_주소록</h2>
<hr class="w3-round border-position">
</div>

<FORM name='frm' 
      method='POST' 
      action='./createProc.jsp' 
      id="contactForm"
      class="form-horizontal">
      
 <div class="form-group">
        <label class="col-md-3 control-label">이름</label>
        <div class="col-md-6">
            <input type="text" class="form-control" name="name" />
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">핸드폰</label>
        <div class="col-md-6">
            <input type="text" class="form-control" name="phone" />
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">우편번호</label>
        <div class="col-md-4">
            <input type="text" class="form-control" name="zipcode" size="6" maxlength="5" id="sample6_postcode"/>
        </div>    
        <div class="col-md-2">    
            <input type="button" class="btn btn-default" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
        </div>
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">주소</label>
        <div class="col-md-6">
            <input type="text" class="form-control" name="address1" id="sample6_address" />
        </div>
      
    </div>
    <div class="form-group">
        <label class="col-md-3 control-label">상세주소</label>
        <div class="col-md-6">
            <input type="text" class="form-control" name="address2" id="sample6_address2" />
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
            <button type="submit" class="btn btn-default">등록</button>
            <button type="button" class="btn btn-default" onclick="history.back()">취소</button>
        </div>
    </div>      
</FORM> 
<jsp:include page="/templet/bottom.jsp"/>
</body>
</html>