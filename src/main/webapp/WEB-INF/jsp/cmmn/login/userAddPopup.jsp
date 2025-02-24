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
		  	<form role="form" id="dataForm" method="POST"> 
			  	<div>
			  		<div class="center">
			  			<img src="../../../resources/image/free-icon-user-2657939.png"/>
			  			<input id="user_id" name="user_id" type="text" class="underline h_33 w_30p" placeholder="아이디를 입력해주세요" autocomplete="off">
			  		</div>
			  		<div class="center">
			  			<img src="../../../resources/image/free-icon-password-7817000.png" style="margin-left: 30px;"/>
			  			<input id="user_pw" name="user_pw" type="password" class="underline h_33 w_30p" placeholder="비밀번호를 입력해주세요" autocomplete="off">
			  			<div class="help-tip">
							<p>비밀번호 양식할 부분 입니다.<br>비밀번호를 4자리 이상 입력해주세요.</p>
						</div>
			  		</div> 
			  		<div class="center">
			  			<img src="../../../resources/image/free-icon-add-user-456249.png"/>
			  			<input id="user_nm" name="user_nm" type="text" class="underline h_33 w_30p" placeholder="사용자 이름" autocomplete="off">
			  		</div>
			  		<div class="center" style="margin-top: 40px;">
			  			<img src="../../../resources/image/free-icon-add-user-456249.png"/>
			  			<input id="birth_dt" name="birth_dt" type="text" class="underline h_33 w_30p" maxlength='10' placeholder="생년월일 (ex. 19990101)" autocomplete="off">
			  		</div>
			  		<div class="center">
			  			<img src="../../../resources/image/free-icon-add-user-456249.png"/>
			  			<input id="phone" name="phone" type="text" class="underline h_33 w_30p" maxlength='13' placeholder="핸드폰 번호 (ex. 010-1111-1111)" autocomplete="off">
			  		</div>
		  		</div>
	  		</form>
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
				console.log("오류검증");
				saveUser();
			}
	    });
	});
	
	function validationUser() {
		// 필수 값 체크
		if ($("#user_id").val() == "") {
			alert("사용자 아이디를 입력해주세요.");
			$("#user_id").focus(); 
			return false;
		}
		if ($("#user_pw").val() == "") {
			alert("사용자 비밀번호를 입력해주세요.");
			$("#user_pw").focus();
			return false;
		} else if ($("#user_pw").val() != "" && $("#user_pw").val().length <= 3) {
			alert("비밀번호를 다시 입력해주세요.");
			$("#user_pw").focus();
		}
		if ($("#user_nm").val() == "") {
			alert("이름을 입력해주세요.");
			$("#user_nm").focus();
			return false;
		}
		if ($("#birth_dt").val() != "" && $("#birth_dt").val().length != 8) {
			alert("생년월일 양식을 확인해주세요.");
			$("#birth_dt").focus();
			return false;
		}
		if ($("#phone").val() != "") { 
			var phoneData = $("#phone").val().split('-');
			var indexCount = [3, 4, 4];
			
			for(var i=0; i<indexCount.length; i++){
				if(phoneData[i].length != indexCount[i] || phoneData.length != 3){
					alert("전화번호 양식을 확인해주세요.");
					$("#phone").focus();
					return false;
				}
			}
		}

		return true;
	}
	
	function saveUser() {
		let params = $("#dataForm").serialize();
		console.log(params);
		console.log("user_id value: " + $("#user_id").val());
		console.log("user_pw value: " + $("#user_pw").val());
		console.log("user_nm value: " + $("#user_nm").val());
		console.log("birth_dt value: " + $("#birth_dt").val());
		$.ajax({
            type: 'POST'
            ,async: true
            ,url: '/sys/user/userSave.json'
            ,dataType: 'json'
            ,data: {
            	user_seq: ""
            	,user_id: $("#user_id").val()
            	,user_pw: $("#user_pw").val()
            	,user_nm: $("#user_nm").val()
            	,birth_dt: $("#birth_dt").val()
            	,phone: $("#phone").val()
            	,status_cd: "DF"
            }
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
            ,success: function(data, textStatus) {
            	let res = data.userInfo;
            	if (res.user_id_error == "Y") {
            		alert("중복된 ID 입니다.");
            	} else {
            		alert("요청되었습니다.");
   					window.close();
            	}
            }
        });
	}
</script>
</html>
