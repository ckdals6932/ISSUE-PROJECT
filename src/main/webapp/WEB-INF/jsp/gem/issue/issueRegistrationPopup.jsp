<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<html>
<head>
	<jsp:include page="/WEB-INF/jsp/cmmn/common.jsp"/>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js" integrity="sha512-T/tUfKSV1bihCnd+MxKD0Hm1uBBroVYBOYSk1knyvQ9VyZJpc/ALb4P0r6ubwVPSGB2GvjeoMAJJImBG12TiaQ==" referrerpolicy="no-referrer"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" integrity="sha512-mSYUmp1HYZDFaVKK//63EcZq4iFWFjxSL+Z3T/aCt4IO9Cejm03q3NKKYN6pFQzY0SBOr8h+eCIAZHPXcpZaNw==" referrerpolicy="no-referrer" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" referrerpolicy="no-referrer"></script>

	<style>
		#toolbar {margin-top: 20px;}
		#ui-datepicker-div {left: 400px !important;}
	</style>
</head>
<body>
	<div id="app" class="lyt-2 window-popup">
		<div id="app-content">
			<div class="wrap-content" id="container">
				<div class="row window-popup-panel-body window-popup-body">

					<div id="toolbar">
						<button id="saveBtn" name="saveBtn">
				  			<img src="/resources/image/free-icon-save-file-376218.png"/>
				  		</button>
				  		
						<button id="sendBtn" name="sendBtn">
				  			전송
				  		</button>
				  		
						<button id="rejectBtn" name="sendBtn">
				  			반려
				  		</button>
					</div>
					
					<form role="form" id="dataForm" method="POST">
						<div class="col-md-12">
							<div style="margin-bottom: 0px">
								<input id="item_seq" name="item_seq" type="text" hidden="true">
								<input id="req_seq" name="req_seq" type="text" hidden="true">
								<input id="step" name="step" type="text" hidden="true">
								<input id="reg_user_seq" name="reg_user_seq" type="text" hidden="true">
							
								<label class="popup_subtitle2">요청자</label>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
									<tr class="h_33">
										<td class="w_20p table_t">Item Code</td>
										<td class="w_30p center">
											<input id="item_cd" name="item_cd" type="text" class="form-control customInput" disabled>
										</td>
										<td class="w_20p table_t">상태</td>
										<td class="w_30p center">
											<select id="item_status_cd" name="item_status_cd" class="form-control" disabled>
												<option value="DF" selected>임시저장</option>
												<option value="RC">요청 확인중</option>
												<option value="DI">개발 진행중</option>
												<option value="RV">테스트 요청</option>
												<option value="CP">완료</option>
											</select>
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_20p table_t"><span style="color: red;">*</span> Type</td>
										<td class="w_30p center">
											<select id="item_type" name="item_type" class="form-control">
												<option value="ER" selected>오류</option>
												<option value="FU">기능수정</option>
												<option value="FI">기능추가</option>
												<option value="QA">질문</option>
											</select>
										</td>
										<td class="w_20p table_t"><span style="color: red;">*</span> 메뉴</td>
										<td class="w_30p center">
											<select id="item_menu" name="item_menu" class="form-control">
												<option value="DASH" selected>DashBoard</option>
												<option value="NOTICE">공지사항</option>
												<option value="ISSUE">조치사항</option>
												<option value="USER">사용자관리</option>
												<option value="AUTH">권한관리</option>
											</select>
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_20p table_t"><span style="color: red;">*</span> 제목</td>
										<td class="w_80p center" colspan="3">
											<input id="item_title" name="item_title" type="text" class="form-control customInput" style="width: 98%">
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_10p table_t">요청 내용</td>
										<td class="w_23p center" colspan="3">
											<textarea id="item_content" name="item_content" rows="3" class="form-control customInput" style="width: 98%;"></textarea>
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_20p table_t">처리자</td>
										<td class="w_30p center">
											<select id="owner_user_seq" name="owner_user_seq" class="form-control"></select>
										</td>
										<td class="w_20p table_t"><span style="color: red;">*</span> 처리 기한</td>
										<td class="w_30p center">
											<input id="item_liml_dt" name="item_liml_dt" type="text" class="form-control customInput">
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_20p table_t">요청자</td>
										<td class="w_30p center">
											<input id="reg_user_nm" name="reg_user_nm" type="text" class="form-control customInput" disabled>
										</td>
										<td class="w_20p table_t">작성일자</td>
										<td class="w_30p center">
											<input id="reg_dt" name="reg_dt" type="text" class="form-control customInput" disabled>
										</td>
									</tr>
								</table>
							</div>
						</div>
						
						
						<div class="col-md-12" style="margin-top: 30px;">
							<div style="margin-bottom: 0px">
								<label class="popup_subtitle2">처리자</label>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
									<tr class="h_33">
										<td class="w_20p table_t">처리 내용</td>
										<td class="w_80p center" colspan="3">
											<textarea id="req_content" name="req_content" rows="3" class="form-control customInput" style="width: 98%"></textarea>
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_20p table_t">요청자 Review</td>
										<td class="w_80p center" colspan="3">
											<textarea id="review_content" name="review_content" rows="3" class="form-control customInput" style="width: 98.5%;"></textarea>
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_20p table_t">완료일자</td>
										<td class="w_80p center">
											<input id="end_dt" name="end_dt" type="text" class="form-control customInput" style="width: 98%" disabled>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>

<script>
	let issueData = "";
	let selectIssue = "";
	let item_seq = "${item_seq}";
	let auth = '';
	
	$(document).ready(function() {
		issueSearch();
		
		if (item_seq == '' || item_seq == -1) {
			$("#review_user_nm").val("${login_user_nm}");
		}
		
		$("#saveBtn").click(function(){
			// Validation 
			// (1/2) 필수 값 체크
			if ($("#item_title").val() == "") {
				alert("제목을 입력해주세요.");
				$("#item_title").focus();
				return;
			}
			// (1/2) 처리기한 체크
			if (new Date($("#item_liml_dt").val()) < new Date()) {
				alert("처리 기한이 작성일보다 작습니다.");
				$("#item_liml_dt").focus();
				return;
			}
			
			saveData('save');
	    });
		
		$("#sendBtn").click(function(){
			// Validation 
			// (1/2) 필수 값 체크
			if ($("#item_title").val() == "") {
				alert("제목을 입력해주세요.");
				$("#item_title").focus();
				return;
			}
			// (1/2) 처리기한 체크
			if (new Date($("#item_liml_dt").val()) < new Date()) {
				alert("처리 기한이 작성일보다 작습니다.");
				$("#item_liml_dt").focus();
				return;
			}
			
			saveData('send');
	    });
		
		$("#rejectBtn").click(function(){	
			// Validation 
			// (1/1) 필수 값 체크
			if ($("#review_content").val() == "") {
				alert("리뷰를 입력해주세요.");
				$("#review_content").focus();
				return;
			}
			
			saveData('reject');
	    });
		
		$('#item_liml_dt').datepicker({
	        format: "yyyy-mm-dd",
	        minViewMode: 1,
	        language: "ko",
	        autoclose: true
	    });

	});
	
	function issueSearch() {
		$.ajax({
	        type: 'POST'
	        ,async: false
	        ,url: '/gem/issue/issueSearch.json?login_user_seq=${login_user_seq}'
	        ,dataType: 'json'
	        ,data: {
	        	item_seq: item_seq
	        }
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
	        ,success: function(data, textStatus) {
	        	issueData = data.data[0];
	        	if (issueData == undefined) {
		        	getComboList('owner_user_seq', '');
	        	} else {
		        	$("#item_cd").val(issueData.item_cd);
		        	$("#item_status_cd").val(issueData.item_status_cd).prop("selected", true);
		        	$("#item_type").val(issueData.item_type).prop("selected", true);
		        	$("#item_menu").val(issueData.item_menu).prop("selected", true);
		        	$("#item_title").val(issueData.item_title);
		        	$("#item_content").val(issueData.item_content);
		        	$("#owner_user_seq").val(issueData.owner_user_seq).prop("selected", true);
		        	$("#item_liml_dt").val(issueData.item_liml_dt);
		        	$("#reg_user_nm").val(issueData.reg_user_nm);
		        	$("#reg_dt").val(issueData.reg_dt);
		        	$("#req_content").val(issueData.req_content);
		        	$("#review_content").val(issueData.review_content);
		        	$("#end_dt").val(issueData.end_dt);
		        	
		        	$("#item_seq").val(issueData.item_seq);
		        	$("#req_seq").val(issueData.req_seq);
		        	$("#step").val(issueData.step);
		        	$("#reg_user_seq").val(issueData.reg_user_seq);
		        	getComboList('owner_user_seq', issueData.owner_user_seq);
	        	}
    		}
	    });
	}
	
	function saveData(btnType) {		
		stepCheck(btnType);
		let target = $("#dataForm");
		let disabled = target.find(":disabled").removeAttr('disabled');
		let params = target.serialize() + "&login_user_seq=${login_user_seq}&item_seq="+item_seq;
		disabled.attr('disabled', 'disabled');
		$.ajax({
            type: 'POST'
            ,async: true
            ,url: '/gem/issue/issueSave.json'
            ,dataType: 'json'
            ,data: params
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
            ,success: function(data, textStatus) {
            	alert("저장되었습니다.");
            	item_seq = data.data.item_seq;
            	issueSearch();
            	window.opener.issueSearch();
            }
        });
	}
	
	function stepCheck(btnType) {
		/*
		Step = '1' : Creator 임시 저장
		Step = '2' : 요청 확인
		Step = '3' : 개발 진행
		Step = '4' : 테스트 진행
		Step = '5' : 개발 완료
		*/
		if (item_seq == '' || item_seq == -1) {
			$("#item_status_cd").val("DF");
			$("#step").val("1");
		}
		
		if (auth == 'creator') {
			if (btnType == 'send') {
				if ($("#step").val() == '1') {
					$("#item_status_cd").val("DI");
					$("#step").val("3");
				} else if ($("#step").val() == '4') {
					$("#item_status_cd").val("CP");
					$("#step").val("5");
				}
			} else if (btnType == 'reject') {
				$("#item_status_cd").val("DI");
				$("#step").val("3");
			}
			
		} else if (auth == 'owner') {
			if (btnType == 'send') {
				$("#item_status_cd").val("RV");
				$("#step").val("4");
			}
		}
	}
	function settingUI() {
		/*
		Step = '1' : Creator 임시 저장
		Step = '2' : 요청 확인
		Step = '3' : 개발 진행
		Step = '4' : 테스트 진행
		Step = '5' : 개발 완료
		*/
		if (item_seq == '' || item_seq == -1 || $("#reg_user_seq").val() == "${login_user_seq}") {
			auth = 'creator';
		} else if ($("#owner_user_seq").val() == "${login_user_seq}") {
			auth = 'owner';
		}
		
		let step = $("#step").val();
		let setFlag = false;

		$("#rejectBtn").attr('hidden', true);
		$("#sendBtn").attr('hidden', true);
		$("#saveBtn").attr('hidden', true);

		$("#item_liml_dt").attr('disabled', true);
		$("#item_type").attr('disabled', true);
		$("#item_menu").attr('disabled', true);
		$("#item_title").attr('disabled', true);
		$("#item_content").attr('disabled', true);
		$("#owner_user_seq").attr('disabled', true);
		$("#req_content").attr('disabled', true);
		$("#review_content").attr('disabled', true);
		
		if (auth == 'creator') {
			if (step == '' || step == '1' || step == '2') {	
				$("#sendBtn").attr('hidden', false);
				$("#saveBtn").attr('hidden', false);
				
				$("#item_liml_dt").attr('disabled', false);
				$("#item_type").attr('disabled', false);
				$("#item_menu").attr('disabled', false);
				$("#item_title").attr('disabled', false);
				$("#item_content").attr('disabled', false);
				$("#owner_user_seq").attr('disabled', false);
				$("#req_content").attr('disabled', false);
				$("#review_content").attr('disabled', false);
			} else if (step == '4') {
				$("#rejectBtn").attr('hidden', false);
				$("#sendBtn").attr('hidden', false);
				$("#saveBtn").attr('hidden', false);
				
				$("#review_content").attr('disabled', false);
				
				$("#sendBtn").text('완료');
			}
		} else if (auth == 'owner') {
			if (step == '3') {
				$("#sendBtn").attr('hidden', false);
				$("#saveBtn").attr('hidden', false);
				
				$("#req_content").attr('disabled', false);
			}
		}
		
		if (!setFlag) {
		}
	}
	
	function getComboList(obj, value) {
		$.ajax({
            type: 'POST'
            ,async: true
            ,url: '/gem/issue/getUserList.json'
            ,dataType: 'json'
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
            ,success: function(data, textStatus) {
            	data = data.data;
            	$(data).each(function(k, v) {
            		$("#"+obj).append('<option value="' + v.value + '" '+((v.value == value) ? 'selected' : '')+'>' + v.text + '</option>');
            	});

	        	settingUI();
            }
        });
	}
</script>
</html>
