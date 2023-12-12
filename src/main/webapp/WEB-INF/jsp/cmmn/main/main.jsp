<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<html>
<head>
	<jsp:include page="/WEB-INF/jsp/cmmn/main/topheader.jsp"/>
	<style>
		#dataForm > div.ck.ck-reset.ck-editor.ck-rounded-corners > div.ck.ck-editor__main > div {height: 400px !important;}
		
		.cntObj {
		    width: 495px;
		    height: 28%;
		    vertical-align: middle;
		    text-align: center;
		    border: 1px solid #b2b2b2;
		    margin-bottom: 10px;
		    border-radius: 5%;
	    }
	</style>
</head>
<body>
	<div id="app">
		<div id="layoutObj">
			<div id="toolbar">	
			</div>
			<div style="display: flex; justify-content: space-around; height: 500px;">
			<div>
				<table id="gridNoticeObj"></table>
				<div id="pager"></div>
			</div>
            <div style="display: inline-block; width: 41%; height: 80%;">
               <form role="form" id="dataForm" method="POST">
                  <input type="hidden" id="board_seq" name="board_seq" class="form-control">
                  <table>
					<tr>
						<textarea name="context_txt" id="context_txt"></textarea>
					</tr>	
					<tr>
						<div class="center h_50">
		    				<input type="button" style="padding: 5px 30px" id="back" name="back" value="<">
		    				<input type="button" style="padding: 5px 30px" id="nextBtn" name="nextBtn" value=">">
		    			</div>
					</tr>
				</table>			
               </form>
            </div>
            	<div>
	            	<div class="cntObj">
	            		<div style="display: flex; margin-top: 10px; ">
	            			<div style="width: 50%;">
								<i class="fa-solid fa-circle-check fa-4x" style="cursor : pointer;" onclick="goMenu('cp')"></i>
	            			</div>
	            			<div style="width: 50%;">
								<i class="fa-solid fa-circle-exclamation fa-4x" style="cursor : pointer;" onclick="goMenu('in')"></i>
	            			</div>
	            		</div>
	            		<div style="display: flex; margin-top: 10px;">
							<span id="cpCnt" style="width: 50%">0 건</span>
							<span id="inCnt" style="width: 50%">0 건</span>
	            		</div>
					</div>
	            	<div>
		            	<table style="width: 500px; height: 50%">
							<tr class="h_33">
								<td class="w_30p table_t">사용자 명</td>
								<td class="w_50p center">
									<input type="text" id="user_nm" name="user_nm" class="form-control" disabled>
								</td>
							</tr>
							<tr class="h_33">
								<td class="w_20p table_t">사용자 ID</td>
								<td class="w_30p center">
									<input type="text" id="user_id" name="user_id" class="form-control" disabled>
								</td>
							</tr>
							<tr class="h_33">
								<td class="w_20p table_t">생년월일</td>
								<td class="w_30p center">
									<input type="text" id="birth_dt" name="birth_dt" class="form-control" disabled>
								</td>
							</tr>
							<tr class="h_33">
								<td class="w_20p table_t">핸드폰 번호</td>
								<td class="w_30p center">
									<input type="text" id="phone" name="phone" class="form-control" disabled>
								</td>
							</tr>
							<tr class="h_33">
								<td class="w_20p table_t">상태</td>
								<td class="w_30p center">
									<input type="text" id="status_nm" name="status_nm" class="form-control" disabled>
								</td>
							</tr>
							<tr class="h_33">
								<td class="w_20p table_t">권한명</td>
								<td class="w_30p center">
									<input type="text" id="auth_nm" name="auth_nm" class="form-control" disabled>
								</td>
							</tr>
						</table>
					</div>
				</div>
         	</div>
		</div>
	</div>
	
	<script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/translations/ko.js"></script>
	
	<script>
		let ckeditor_data = [];
		let index = 0;
		
		/* ck에디터를 id가 context_txt랑 연결  */
		ClassicEditor
		.create( document.querySelector( '#context_txt' ), {
			toolbar: [],
			language: "ko",
		})
		.then( contents => {
			editData = contents; // #contents에 있는 값을 theEditor에 넣어놓는다.
		})
		.catch( error => {
			consloe.error( error );
		}); 
		
		$(document).ready(function() {
			if (selectMenu != 'dash') {
				$("#"+selectMenu).removeClass('menu-hover');
				$("#dash").addClass('menu menu-hover');
				selectMenu = 'dash';
			}
			
			settingNotice()
			settingUser();
			settingCnt();
			
			editData.setData(ckeditor_data[0]);
			
			$("#nextBtn").click(function(){
				if(index < ckeditor_data.length - 1){
					index += 1;
					editData.setData(ckeditor_data[index]);
				} else {
					index = 0;
					editData.setData(ckeditor_data[index]);
				}
				console.log("nextBtn 실행");
		    });
			
			$("#back").click(function(){
				if(index > 0){
					index -= 1;
					editData.setData(ckeditor_data[index]);
				} else {
					index = ckeditor_data.length - 1;
					editData.setData(ckeditor_data[index]);
				}
				
				console.log("backBtn 실행");
		    });
		});
		
		function settingNotice() {
	      $.ajax({
	           type: 'POST'
	           ,async: false
	           ,url: '/cmmn/main/noticeSearch.json'
	           ,dataType: 'json'
	           ,error:function (data, textStatus) {
	            alert("시스템 에러입니다."); 
	           }
	           ,success: function(data, textStatus) {
	              console.log(data);
	              noticeData = data.noticeInfo;
	              console.log(noticeData);
	              
	              for(let i = 0; i < noticeData.length; i++){
	            	  ckeditor_data.push(noticeData[i].content_html)
	            	  console.log(noticeData[i]);
	              }
	           }
	       });
		}
		
		function settingUser() {
			let params = "&login_user_seq=${login_user_seq}";
			
			$.ajax({
		    	type: 'POST'
           		,async: false
	           	,url: '/cmmn/main/userSearch.json'
	           	,data : params
	           	,dataType: 'json'
	           	,error:function (data, textStatus) {
            		alert("시스템 에러입니다."); 
           		}
           		,success: function(data, textStatus) {
              		console.log(data);
	    			if (data.userInfo.length > 0) {
	              		userData = data.userInfo[0];
	              		$("#user_nm").val(userData.user_nm); 
	    		  		$("#user_id").val(userData.user_id);
		         		$("#birth_dt").val(userData.birth_dt);
	              		$("#phone").val(userData.phone);
	            	  	$("#status_nm").val(userData.status_nm);
	              		$("#auth_nm").val(userData.auth_nm);		
	    			}                          
           		}
			});
		}
		
		function settingCnt() {
			$.ajax({
		    	type: 'POST'
           		,async: false
	           	,url: '/cmmn/main/cntSearch.json?login_user_seq=${login_user_seq}'
	           	,dataType: 'json'
	           	,error:function (data, textStatus) {
            		alert("시스템 에러입니다."); 
           		}
           		,success: function(data, textStatus) {
              		console.log(data);
	    			if (data.cntInfo.length > 0) {
	    				for (var i = 0; i < data.cntInfo.length; i++) {
		              		cntData = data.cntInfo[i];
		              		if (cntData.item_type == 'IN') {
		              			$("#inCnt").text(cntData.cnt + ' 건');
		              		}
		              		if (cntData.item_type == 'CP') {
		              			$("#cpCnt").text(cntData.cnt + ' 건');
		              		}
	    				}		
	    			}                          
           		}
			});
		}
		
		function goMenu(type) {
			window.location.href = "/gem/issue/issue.view";
		}
	</script>
</body>
</html>	