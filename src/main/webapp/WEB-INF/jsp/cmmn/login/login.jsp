<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

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
	<jsp:include page="/WEB-INF/jsp/cmmn/common.jsp"/>
	<title>Home</title>
</head>
<body>
	<div id = 'wrapper'>
	  	<div  id='ex1'>
		  	<div> 
		  		<span class="font_s_50 title font_s_80 t_s">ISSUE</span> 
		  	</div>
		  	
		  	<div class = "h_45 m_t_50">
		  		<img src="../../../resources/image/free-icon-user-2657939.png"/>
		  		<input class = "h_30" type="text" id="userId" name="userId" placeholder="아이디를 입력해주세요">
	  		</div> 
	  		<div>
	  			<img src="../../../resources/image/free-icon-password-7817000.png"/>
		  		<input class = "h_30" type ="text" id="userPw" name="userPw" placeholder="비밀번호를 입력해주세요" >
	  		</div>  
	  		<div class = "m_t_10">
		 		<input class="loginbtn w_30p h_45 m_10 p_10" id="loginBtn" name="loginBtn" type="button" value="LOGIN" >
	 		</div>
	 		
	  		<div class = "m_t_50">
		 		<a class="w_20p h_30 m_10 " style = "font-size:23px;" id="userAddText" href="" onclick="openUserAddPopup();">회원가입</a>
		 	</div>
  		</div>
	</div>
</body>

<script>
	$(document).ready(function() {
		$("#loginBtn").click(function(){
			loginUser();
	    });
	});
	
	// 로그인
	function loginUser() {
		// 필수 값 체크
		if ($("#userId").val() == "") {
			alert("사용자 아이디를 입력해주세요.");
			$("#userId").focus();
			return;
		}
		if ($("#userPw").val() == "") {
			alert("사용자 비밀번호를 입력해주세요.");
			$("#userPw").focus();
			return;
		}
		
		$.ajax({
            type: 'POST'
            ,async: true
            ,url: '/cmmn/login/loginUser.json'
            ,dataType: 'json'
            ,data: {
            	userId: $("#userId").val()
            	,userPw: $("#userPw").val()
            }
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
            ,success: function(data, textStatus) {
            	let res = data.loginInfo;
            	console.log(res);
            	if (res.failCntError == "Y") {
    				alert("비밀번호를 5회 이상 틀렸습니다. 관리자에게 문의해주세요.");
            	} else if (res.idError == "Y" || res.pwError == "Y") {
    				alert("다시 입력해주세요.");
            	} else {
            	    window.location.href = "/cmmn/main/main.view";
            	}
            }
        });
	}
	
	// 회원가입 팝업 호출
	function openUserAddPopup() {
		window.open("/cmmn/login/userAddPopup.view", '_blank', 'width=800, height=600');
	}
</script>
</html>
