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
	  flex-direction: column;
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
	  	<div  id='ex1'>
		  	<div> 
		  		<span  style="font-size:300%">Login</span> 
		  	</div>
		  	
		  	<div class = "h_45 m_t_50">
		  		<img src="../../resources/images/free-icon-user-2657939.png" width="20" height="20" alt="사용자" />
		  		<input class = "h_30" type ="text" name = "st_id" placeholder="아이디를 입력해주세요">
	  		</div>
	  		<div>
	  			<img src="../../resources/images/free-icon-user-2657939.png" width="20" height="20" alt="비밀번호" />
		  		<input class = "h_30" type ="text" name = "st_pw" placeholder="비밀번호를 입력해주세요" >
	  		</div>
	  		<div class = "m_t_10">
		 		<input class="loginbtn w_30p h_45 m_10 p_10" id="loginBtn" name="loginBtn" type="button" value="LOGIN" >
	 		</div>
	 		
  		</div>
  		<div class = "m_t_50">
		 		<a class="w_20p h_30 m_10 " style = "font-size:30px" id="userAddText" href="" onclick="openUserAddPopup();">회원가입</a>
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
