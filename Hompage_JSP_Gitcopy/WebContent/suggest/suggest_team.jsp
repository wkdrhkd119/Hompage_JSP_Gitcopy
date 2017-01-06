<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>서제스트</title>
<script type="text/javascript" src="../suggest/httpRequest.js"></script>
<script type="text/javascript">
    var checkFirst = false;
    var lastKeyword = '';
    var loopSendKeyword= false;
    function startSuggest(){
	if(checkFirst == false){
	//0.5초 후에 sendKeyword() 함수를 실행
	setTimeout("sendKeyword();",500);
	loopSendKeyword = true;
	}
	checkFirst = true;
	 }
	    //요청 전송
    function sendKeyword() {
        // log("키가 눌렸습니다.");
        if(loopSendKeyword == false) return;
        var keyword = document.search.keyword.value;
        if (keyword == '') {
            lastKeyword = '';
            hide('suggest');  // suggest DIV 태그 감추기
        } else if (keyword != lastKeyword) { // 새로운 키워드 입력 여부 검사
            lastKeyword = keyword; // 새로운 키를 전역변수로 저장
            // 한글이나 특수문자를 UTF-8문자셋으로 변경
            var params = "keyword="+encodeURIComponent(keyword);
            // 요청 전송, 서블릿 주소 지정
            sendRequest("<%=root%>/team", params, response, 'post');
		}
		setTimeout("sendKeyword();", 500);
	}

	// 결과 출력
	function response() {
		if (httpRequest.readyState == 4) {
			if (httpRequest.status == 200) {

				// 응답 문자열 추출
				var resultText = httpRequest.responseText;

				//  3|홍길동^010-1324-9984^java,홍길순,홍길
				var result = resultText.split('|');

				// 갯수, 문자열을 정수로 변환
				var count = parseInt(result[0]);

				var keywordList = null;

				if (count > 0) {
					// ,를 구분한 1차원 배열 생성
					keywordList = result[1].split('#');

					var html = '';
					html += "등록된 팀 목록(선택하세요.)<br>";

					//  alert('keywordList.length: ' + keywordList.length);
					for (var i = 0; i < keywordList.length; i++) {

						//log("keywordList[i]: " + keywordList[i]); 

						// 특수 문자 표현: " --> \", \ --> \\            
						html += "<a href=\"javascript:select('"+ keywordList[i] + "')\">" + keywordList[i]+ "</a><br>";
						// alert(html);
					}

					// 목록을 출력할 DIV 태그
					var listView = document.getElementById('suggestList');

					// DIV 태그 값 저장
					listView.innerHTML = html;

					// 목록을 가지고 있는 DIV 태그 출력
					show('suggest');
				} else {
					hide('suggest');
				}
			} else {
				alert("에러 발생: " + req.status);
			}
		}
	}

	//검색된 함목을 클릭하면 검색어를 keyword 태그에 출력하고
	//검색 목록은 숨겨 버립니다.
	function select(selectedKeyword) {
		document.search.keyword.value = selectedKeyword;

		loopSendKeyword = false;
		checkFirst = false;

		hide('suggest');
	}

	function frmSend(f) {
		f.submit();
	}
</script>
<style>
#view {
	border: 1px solid #999;
}
</style>
</head>
<body>
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	<!-- 디비깅 정보 출력 -->
	<div id="debugConsole"
		style="border: 1px solid #000000; color: #00ff00; background: #000000">
	</div>
	<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~ -->


	<!-- 키보드로부터 키가 눌려질때마다 "sendKeyword()" 함수가
호출이 됩니다. -->
	<form name="search" action="./suggest_proc.jsp" method="post">
		<input type="text" name="keyword" id="keyword"
			onkeydown="startSuggest()" size="70" /> <input type="button"
			value="검색" onclick="javascript:frmSend(this.form);" />


		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
		<!-- 서버로부터 검색된 목록 출력 -->
		<div id="suggest"
			style="display: none; postion: absolute; left: 0px; top: 30px; color: #000000; background: #EAEAEA; width: 500px">
			<div id="suggestList"></div>
		</div>
		<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
	</form>
</body>
</html>