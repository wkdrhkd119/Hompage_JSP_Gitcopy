<%@ page contentType="text/html; charset=UTF-8" %> 
<%  request.setCharacterEncoding("utf-8"); 
	String root = request.getContextPath();
%> 
 
<!DOCTYPE html> 
<html> 
<head> 

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="<%=root%>/css/style.css" rel="Stylesheet" type="text/css">

</head> 
<!-- *********************************************** -->
<body>
<jsp:include page="/templet/top.jsp" flush="false"/>

<div class="w3-container mainPosition" id="services">
<h2 class="iconPosition"><span class="glyphicon glyphicon-globe"></span>_로그인</h2>
<hr class="w3-round border-loginposition">
</div> 

<div class="container">
<div class="row">
<div class="col-sm-4"></div>
<div class="col-sm-4">
  <form method="post" action="./loginProc.jsp">
    <div class="input-group">
      <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
      <input id="email" type="text" class="form-control" name="id" placeholder="User Id">
    </div>
    <br>
    <div class="input-group">
      <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
      <input id="password" type="password" class="form-control" name="passwd" placeholder="Password">
    </div>
    
    <div class="checkbox">
      		<button type="submit" class="btn btn-default">로그인</button>
    		<button type="button" class="btn btn-default" onclick="location.href='./agreement.jsp'">회원가입</button>
       <label style="padding-left: 80px;"><input type="checkbox"> Remember me</label>
      
    </div>
    </form>
</div>
</div>
</div>
<jsp:include page="/templet/bottom.jsp" flush="false"/>
</body>

</html> 
