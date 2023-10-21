<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>

<html>
<head>
	<jsp:include page="/WEB-INF/jsp/common.jsp"/>
</head>
<body>
	<div>
	  	<div>
		  	<div> 
		  		<h1 class="font_s_50 title m_t_50">회원가입</h1> 
		  	</div>
		  	<div>
		  		<div class="center">
		  			<input type="text" class="underline w_40p">
		  		</div>
		  		<div class="center">
		  			<input type="text" class="underline w_40p">
		  		</div>
		  		<div class="center">
		  			<input type="text" class="underline w_40p">
		  		</div>
		  		<div class="center">
		  			<input type="text" class="underline w_40p">
		  		</div>
	  		</div>
	  		<div>
		 		<input class="loginbtn w_30p h_45 m_10 p_10" id="loginBtn" name="loginBtn" type="button" value="로그인">
	 		</div>
  		</div>
	</div>
</body>

<script>
	function openUserAddPopup() {
		console.log("aa");
	}
</script>
</html>
