<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<html>
<head>
	<jsp:include page="/WEB-INF/jsp/cmmn/common.jsp"/>
	
	<meta charset="UTF-8">
	<title>ISSUE</title>
	<style type="text/css">
		a {text-decoration: none;}
		header {
			background-color: white;
			font-weight: bold;
			font-size: 30px;
			height: 50px;
		}
		
		#backBtn {
		    background: #ffffff00;
		    border: 0px;
		}
	</style>
</head>
<body>
	<header>
		<a class="mainIcon underline m_10" href="/cmmn/main/main.view" style="">ISSUE</a>
		<button ref="뒤로가기" id="backBtn" class="m_10 f_right">
  			<img src="/resources/image/free-icon-sign-out-7046204.png"/>
		</button>
	</header>
	
	<script>
		$("#backBtn").click(function() {
			if (confirm("로그아웃 하겠습니까?")) {
	    	    window.location.href = "/cmmn/login/login.view";
			}
		});
	</script>
</body>
</html>