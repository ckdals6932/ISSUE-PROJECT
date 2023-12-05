<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<html>
<head>
	<jsp:include page="/WEB-INF/jsp/cmmn/common.jsp"/>
	<style>
		#toolbar {margin-top: 20px;}
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
					</div>
					
					<form role="form" id="dataForm" method="POST">
						<div class="col-md-12">
							<div style="margin-bottom: 0px">
								<label id="item_seq" name="item_seq" hidden="true"></label>
							
								<label class="popup_subtitle2">요청자</label>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
									<tr class="h_33">
										<td class="w_20p table_t">Item Code</td>
										<td class="w_30p center">
											<input id="item_cd" name="item_cd" type="text" class="form-control customInput" disabled>
										</td>
										<td class="w_20p table_t">상태</td>
										<td class="w_30p center">
											<input id="status_cd" name="status_cd" type="text" class="form-control customInput" disabled>
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_20p table_t"><span style="color: red;">*</span> Type</td>
										<td class="w_30p center">
											<select id="issue_type" name="issue_type" class="form-control">
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
										<td class="w_10p table_t">내용</td>
										<td class="w_23p center" colspan="3">
											<textarea id="item_content" name="item_content" rows="3" class="form-control customInput" style="width: 98%;"></textarea>
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_20p table_t">처리자</td>
										<td class="w_30p center">
											<input id="owner_user_nm" name="owner_user_nm" type="text" class="form-control customInput">
										</td>
										<td class="w_20p table_t"><span style="color: red;">*</span> 처리 기한</td>
										<td class="w_30p center">
											<input id="item_liml_dt" name="item_liml_dt" type="text" class="form-control customInput">
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_20p table_t">요청자</td>
										<td class="w_30p center">
											<input id="review_user_nm" name="review_user_nm" type="text" class="form-control customInput" disabled>
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
										<td class="w_20p table_t">처리 상태</td>
										<td class="w_30p center">
											<input id="req_status_cd" name="req_status_cd" type="text" class="form-control customInput" disabled>
										</td>
										<td class="w_20p table_t">완료일자</td>
										<td class="w_30p center">
											<input id="end_dt" name="end_dt" type="text" class="form-control customInput" disabled>
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_20p table_t">처리 내용</td>
										<td class="w_80p center" colspan="3">
											<textarea id="req_content" name="req_content" rows="3" class="form-control customInput" style="width: 97.5%"></textarea>
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_20p table_t">요청자 Review</td>
										<td class="w_80p center" colspan="3">
											<textarea id="review_content" name="review_content" rows="3" class="form-control customInput" style="width: 98.5%;"></textarea>
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
	
	$(document).ready(function() {
		issueSearch();
		
		if (item_seq == '') {
			$("#review_user_nm").val("${login_user_nm}");
		}
		
		$("#saveBtn").click(function(){
			// Validation 
			// (1/1) 필수 값 체크
			if ($("#item_title").val() == "") {
				alert("제목을 입력해주세요.");
				$("#item_title").focus();
				return;
			}
			
			saveData();
	    });
	});
	
	function issueSearch() {
		$.ajax({
	        type: 'POST'
	        ,async: false
	        ,url: '/gem/issue/issueSearch.json'
	        ,dataType: 'json'
	        ,data: {
	        	item_seq: item_seq
	        }
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
	        ,success: function(data, textStatus) {
	        	issueData = data.data;
	        	$("#gridObj").clearGridData();
    			$("#gridObj").setGridParam({data: issueData }).trigger("reloadGrid");
    			$("#gridObj").jqGrid("setSelection", selectIssue);
    		}
	    });
	}
	
	function saveData() {
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
            	let res = data.authInfo;
            	if (res.auth_cd_error == 'Y') {
            		alert("코드가 중복되었습니다.");
            	} else if (res.save == "Y") {
            		alert("저장되었습니다.");
            		issueSearch();
            	}
            }
        });
	}
	
</script>
</html>
