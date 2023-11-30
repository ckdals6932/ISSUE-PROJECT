<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<html>
<head>
	<jsp:include page="/WEB-INF/jsp/cmmn/common.jsp"/>
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
						<button id="delBtn" name="delBtn">
				  			<img src="/resources/image/free-icon-delete-button-5680126.png"/>
				  		</button>
						<button id="addBtn" name="addBtn">
				  			<img src="/resources/image/free-icon-add-image-7780327.png"/>
				  		</button>
					</div>
					
					<form role="form" id="dataForm" method="POST">
						<div class="col-md-12">
							<div style="margin-bottom: 0px">
								<label class="popup_subtitle2">요청자</label>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="table">
									<tr class="h_33">
										<td class="w_10p table_t">Item Code</td>
										<td class="w_23p center">
											<input type="text" id="title" name="title" class="form-control customInput" disabled>
										</td>
										<td class="w_10p table_t">상태</td>
										<td class="w_23p center">
											<input type="text" id="title" name="title" class="form-control customInput" disabled>
										</td>
										<td class="w_10p table_t">Type</td>
										<td class="w_24p center">
											<select id="issue_type" name="issue_type" class="form-control">
												<option value="ER" selected>오류</option>
												<option value="FU">기능수정</option>
												<option value="FI">기능추가</option>
												<option value="QA">질문</option>
											</select>
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_10p table_t">제목</td>
										<td class="w_23p center" colspan="3">
											<input type="text" id="title" name="title" class="form-control customInput" style="width: 97.5%">
										</td>
										<td class="w_10p table_t">메뉴</td>
										<td class="w_23p center">
											<select id="issue_menu" name="issue_menu" class="form-control">
												<option value="DASH" selected>DashBoard</option>
												<option value="NOTICE">공지사항</option>
												<option value="ISSUE">조치사항</option>
												<option value="USER">사용자관리</option>
												<option value="AUTH">권한관리</option>
											</select>
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_10p table_t">내용</td>
										<td class="w_23p center" colspan="5">
											<textarea rows="3" id="centent" name="centent" class="form-control customInput" style="width: 98.5%;"></textarea>
										</td>
									</tr>
									<tr class="h_33">
										<td class="w_10p table_t">요청자</td>
										<td class="w_23p center">
											<input type="text" id="title" name="title" class="form-control customInput" disabled>
										</td>
										<td class="w_10p table_t">처리자</td>
										<td class="w_23p center">
											<input type="text" id="title" name="title" class="form-control customInput">
										</td>
										<td class="w_10p table_t">작성일자</td>
										<td class="w_24p center">
											<input type="text" id="title" name="title" class="form-control customInput" disabled>
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
	
	$(document).ready(function() {
		if (selectMenu != 'issue') {
			$("#"+selectMenu).removeClass('menu-hover');
			$("#issue").addClass('menu menu-hover');
			selectMenu = 'issue';
		}
		
		issueSearch();
		settingGrid();
		
		$("#saveBtn").click(function(){
			saveData();
	    });
		
		$("#delBtn").click(function() {
			saveData('D');
		});
		
		$("#addBtn").click(function() {
			openIssueRegistrationPopup('');
		});
	});
	
	function issueSearch() {
		$.ajax({
	        type: 'POST'
	        ,async: false
	        ,url: '/gem/issue/issueSearch.json'
	        ,dataType: 'json'
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
	
	function settingGrid() {
		$("#gridObj").jqGrid({
			datatype: "local",
			data: issueData,
			colNames:['Issue Code', '메뉴', '제목', '내용', '요청자', '처리자', '상태', '처리 내용', 'seq'],
			colModel:[
				{name:'issue_cd', index:0, width:100, align: "center"},
				{name:'menu_nm', index:1, width:200, align: "center"},
				{name:'issue_title', index:2, width:200 , align: "center"},
				{name:'issue_content', index:3, width:200, align: "center"},
				{name:'reg_user_nm', index:2, width:200 , align: "center"},
				{name:'owner_user_nm', index:2, width:200 , align: "center"},
				{name:'status_nm', index:2, width:200 , align: "center"},
				{name:'req_content', index:2, width:200 , align: "center"},
				
				{name:'issue_seq', index:4, width:0, align: "center", hidden: true}
			],
			rownumbers : true,
			multiselect:false,
			pager:'#pager',
			rowNum: 10,
			colNum: 5,
			rowList: [10, 20, 50],
			sortname: 'issue_cd',
			sortorder: 'asc',
			height: 400,
			
			cellEdit:false, //그리드 수정 가능 기능
			
			 /* row 클릭 한 직후 발생 	*/
			onSelectRow : function (rowid, status, e){
		    	if(status){
		    		let rowData = $(this).jqGrid('getRowData', rowid);
		            $("#auth_seq").val(rowData.auth_seq);
		    		$("#auth_cd").val(rowData.auth_cd);
			        $("#auth_nm").val(rowData.auth_nm);
		            $("#reg_user_nm").val(rowData.reg_user_nm);
		            $("#reg_dt").val(rowData.reg_dt);
		            
		            $("#auth_cd").attr("disabled", "disabled");
		    		
		            selectAuth = rowData.auth_seq;
		        }
	        },
		});

		$(window).on('resize.jqGrid', function() {
			$("#gridObj").jqGrid('setGridWidth', $("#gridObj").parent().parent().parent().parent().parent().width());
		})
		
		$(".jarviswidget-fullscreen-btn").click(function(){
			setTimeout(function() {
				$("#gridObj").jqGrid('setGridWidth', $("#gridObj").parent().parent().parent().parent().parent().width());
			}, 100);
		});
	}
	
	function saveData(type) {
		$.ajax({
            type: 'POST'
            ,async: true
            ,url: '/sys/auth/authSave.json'
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
	
	function openIssueRegistrationPopup(rowId) {
		let rowData;
		if (rowId != '') {
			rowData = $("#gridCodeObj").getRowData(rowId);
		}
		
		var url = "";
		var windowTargetName = "targetName";
		var features = "scrollbars=yes,width=1000,height=800,location=no, resizable=yes";
		window.open(url, windowTargetName, features);

		// 2.POST로 데이터 전달
		myForm.action="url.do"; // 이동
		myForm.method="post";
		myForm.target=windowTargetName;
		myForm.submit();
		출처: https://baekyle.com/14 [지나간 것들 - 배카일:티스토리]
	}
	
</script>
</html>
