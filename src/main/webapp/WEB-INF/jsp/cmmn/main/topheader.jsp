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
		<div class='topMenuSetting'>
			<div id='topMenubar' class='topMenubar'>
				<ul>
					<li id='dash' class="menu menu-hover" title="DashBoard" onclick="changeView('dash')">
						<span>DashBoard</span>
					</li>
					<li id='issue' class="menu" title="조치사항" onclick="changeView('issue')">
						<span>조치사항</span>
					</li>
					<li id='code' class="menu" title="코드관리" onclick="changeView('code')">
						<span>코드관리</span>
					</li>
					<li id='user' class="menu" title="사용자관리" onclick="changeView('user')">
						<span>사용자관리</span>
					</li>
					<li id='auth' class="menu" title="권한관리" onclick="changeView('auth')">
						<span>권한관리</span>
					</li>
				</ul>
			</div>
		</div>
	</header>
	
	<script>
		let selectMenu = 'dash';
		
		$("#backBtn").click(function() {
			if (confirm("로그아웃 하겠습니까?")) {
	    	    window.location.href = "/cmmn/login/login.view";
			}
		});
		
		function changeView(type) {
			if (selectMenu != type) {
				$("#"+selectMenu).removeClass('menu-hover');
				$("#"+type).addClass('menu menu-hover');
				selectMenu = type;
			}
			
			let pageUrl = ""
			if (type == 'dash') {
				window.location.href = "/cmmn/main/main.view";
			} else if (type == 'issue') {
				window.location.href = "/sys/gem/issue.view";
			} else if (type == 'code') {
				window.location.href = "/sys/code/code.view";
			} else if (type == 'user') {
				window.location.href = "/sys/user/user.view";
			} else if (type == 'auth') {
				window.location.href = "/sys/auth/auth.view";
			}
		}
	</script>
</body>
</html>