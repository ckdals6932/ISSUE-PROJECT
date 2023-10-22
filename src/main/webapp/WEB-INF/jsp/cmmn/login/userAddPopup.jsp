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
		  			<img src="../resources/image/free-icon-user-2657939.png"/>
		  			<input type="text" class="underline" placeholder="아이디를 입력해주세요">
		  		</div>
		  		<div class="center">
		  			<img src="../resources/image/free-icon-password-7817000.png"/>
		  			<input type="text" class="underline" placeholder="비밀번호를 입력해주세요">
		  		</div>
		  		<div class="center" style="margin-top: 40px;">
		  			<img src="../resources/image/free-icon-add-user-456249.png"/>
		  			<input type="text" class="underline" placeholder="사용자 이름">
		  		</div>
		  		<div class="center">
		  			<img src="../resources/image/free-icon-add-user-456249.png"/>
		  			<input type="text" class="underline" placeholder="생년월일 (ex. 19990101)">
		  		</div>
		  		<div class="center">
		  			<img src="../resources/image/free-icon-add-user-456249.png"/>
		  			<input type="text" class="underline" placeholder="핸드폰 번호 (ex. 010-1111-1111)">
		  		</div>
	  		</div>
	  		<div class="center m_t_20">
		 		<input class="loginbtn w_30p h_45 m_10 p_10" id="loginBtn" name="loginBtn" type="button" value="요청">
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
