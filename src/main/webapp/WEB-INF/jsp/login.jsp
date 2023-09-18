<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>

<html>
<style>
	#ex1 {
	  border-color: #000000;
	  border-style: solid; 
   	  border-width: 3px; /*상하・좌우*/
	  border-radius: 30px;
	  width: 500px;
	  height: 500px;
	  display: table-cell;
	  vertical-align: middle;
	  text-align:center;
	  background-color: #FFFFFF;
	}
	
	#wrapper {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  min-height: 100dvh; /* 위 아래  */
	  background-color: #eeeeee;
	}
	
</style>
<head>
	<jsp:include page="/WEB-INF/jsp/common.jsp"/>
	<title>Home</title>
</head>
<body>
	<h1>
		Hello world!  
	</h1>
	<div id = 'wrapper'>
	  	<div id='ex1'>
		  	<div> 
		  		<span style="font-size:300%">Login</span> 
		  	</div>
		  	<div>
		  		<input type ="text" name = "st_id">
	  		</div>
	  		<div>
		  		<input type ="text" name = "st_pw">
	  		</div>
	  		<div>
		 		<input class="loginbtn w_30p h_45 m_10 p_10" id="loginBtn" name="loginBtn" type="button" value="로그인">
	 		</div>
	 		
	  		<div>
		 		<a class="w_20p h_30 m_10" id="userAddText" href="" onclick="openUserAddPopup();">회원가입</a>
	 		</div>
  		</div>
	</div>
	<P>  The time on the server is ${serverTime}. </P>
</body>

<script>
	function openUserAddPopup() {
		window.open("/userAddPopup.view", '_blank', 'width=800, height=600');
		return false;
	}
</script>
</html>
