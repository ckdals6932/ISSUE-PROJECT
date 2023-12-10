<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<html>
<head>
	<jsp:include page="/WEB-INF/jsp/cmmn/main/topheader.jsp"/>
	<style>
	#dataForm > div.ck.ck-reset.ck-editor.ck-rounded-corners > div.ck.ck-editor__main > div {
		height: 400px !important;
	}
	</style>
</head>
<body>
	<div id="app">
		<div id="layoutObj">
			<div id="toolbar">	
			</div>
			<div style="display: flex; justify-content: space-around;">
			<div>
				<table id="gridNoticeObj"></table>
				<div id="pager"></div>
			</div>
            <div style="display: inline-block; width: 41%; height: 80%;">
               <form role="form" id="dataForm" method="POST">
                  <input type="hidden" id="board_seq" name="board_seq" class="form-control">
                  <table style="width: 800px; height:800px;">
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
            	<table style="width: 500px;">
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
							<input type="text" id="status_cd" name="status_cd" class="form-control" disabled>
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
	              
	              for(let i = 0; i<4; i++){
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
		              userData = data.userInfo;
			    		 
		              $("#user_nm").val(userData[0].user_nm); 
		    		  $("#user_id").val(userData[0].user_id);
			          $("#birth_dt").val(userData[0].birth_dt);
		              $("#phone").val(userData[0].phone);
		              
		              if(userData[0].status_cd == "in"){
		            	  $("#status_cd").val("투입"); 
		              } else {
		            	  $("#status_cd").val("미투입");
		              }
		              $("#auth_nm").val(userData[0].auth_nm);		                          
		           }
			});
		}
	</script>
</body>
</html>	