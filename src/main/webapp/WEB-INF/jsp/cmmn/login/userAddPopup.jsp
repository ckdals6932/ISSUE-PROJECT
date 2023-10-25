<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<html>
<head>
	<jsp:include page="/WEB-INF/jsp/cmmn/common.jsp"/>
</head>
<body>
	<div>
	  	<div>
		  	<div> 
		  		<h1 class="font_s_50 title m_t_50">회원가입</h1> 
		  	</div>
		  	<div>
		  		<div class="center">
		  			<img src="../../../resources/image/free-icon-user-2657939.png"/>
		  			<input id="userId" name="userId" type="text" class="underline" placeholder="아이디를 입력해주세요">
		  		</div>
		  		<div class="center">
		  			<img src="../../../resources/image/free-icon-password-7817000.png" style="margin-left: 30px;"/>
		  			<input id="userPw" name="userPw" type="password" class="underline" placeholder="비밀번호를 입력해주세요">
		  			<div class="help-tip">
						<p>마우스 오버시 알림메시지창이 뜹니다.<br>CSS로만 만들어졌습니다.</p>
					</div>
		  		</div>
		  		<div class="center" style="margin-top: 40px;">
		  			<img src="../../../resources/image/free-icon-add-user-456249.png"/>
		  			<input id="userNm" name="userNm" type="text" class="underline" placeholder="사용자 이름">
		  		</div>
		  		<div class="center">
		  			<img src="../../../resources/image/free-icon-add-user-456249.png"/>
		  			<input id="brithDt" name="brithDt" type="text" class="underline" maxlength='10' placeholder="생년월일 (ex. 1999.01.01)">
		  		</div>
		  		<div class="center">
		  			<img src="../../../resources/image/free-icon-add-user-456249.png"/>
		  			<input id="phone" name="phone" type="text" class="underline" maxlength='13' placeholder="핸드폰 번호 (ex. 010-1111-1111)">
		  		</div>
	  		</div>
	  		<div class="center m_t_20">
		 		<input id="saveBtn" name="saveBtn" class="loginbtn w_30p h_45 m_10 p_10" type="button" value="요청">
	 		</div>
  		</div>
	</div>
</body>

<script>
	$(document).ready(function() {
		$("#saveBtn").click(function(){
			if (validationUser()) {
				saveUser();
			}
	    });
	});
	
	function validationUser() {
		
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
		if ($("#userNm").val() == "") {
			alert("이름을 입력해주세요.");
			$("#userNm").focus();
			return;
		}
		if ($("#brithDt").val() == "") {
			alert("생년월일을 입력해주세요.");
			$("#brithDt").focus();
			return;
		} else {
				var brithData = document.getElementById('brithDt').value.split('.');
				var indexCount = [4, 2, 2];
				
				for(var i=0; i<indexCount.length; i++){
					if(brithData[i].length != indexCount[i]){
						alert("생년월일 양식을 확인해주세요.");
						$("#brithDt").focus();
						return;
					}
				}
				return;
		}
		if ($("#phone").val() == "") { 
			alert("전화번호를 입력해주세요.");
			$("#phone").focus();
			return;
		}
		else{
			var phoneData = $("#phone").val().split('.');
			return;
		}
	}
</script>
</html>
