<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<html>
<head>
	<jsp:include page="/WEB-INF/jsp/cmmn/main/topheader.jsp"/>
</head>
<body>
	<div id="app">
		<div id="layout">
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
			<div style="display: flex; justify-content: space-around;">
				<div>
					<table id="gridObj"></table>
					<div id="pager"></div>
				</div>

				<div>
					<form role="form" id="dataForm" method="POST">
						<input type="hidden" id="auth_seq" name="auth_seq" class="form-control">
						
						<table>
							<tr class="h_33">
								<td class="w_30p table_t">권한 코드</td>
								<td class="w_50p center">
									<select id="auth_cd" name="auth_cd" class="form-control">
										<option value="ADMIN">Admin</option>
										<option value="USER" selected>User</option>
										<option value="VIEW" selected>View</option>
									</select>
								</td>
							</tr>
							<tr class="h_33">
								<td class="w_20p table_t">권한 명</td>
								<td class="w_30p center">
									<input type="text" id="auth_nm" name="auth_nm" class="form-control" autocomplete="off">
								</td>
							</tr>
							<tr class="h_33">
								<td class="w_20p table_t">작성자</td>
								<td class="w_30p center">
									<input type="text" id="reg_user_nm" name="reg_user_nm" class="form-control" disabled>
								</td>
							</tr>
							<tr class="h_33">
								<td class="w_20p table_t">작성 일자</td>
								<td class="w_30p center">
									<input type="text" id="reg_dt" name="reg_dt" class="form-control" disabled>
								</td>
							</tr>
						</table>
					</form>
				</div>

			</div>
		</div>
	</div>
</body>

<script>
	let authData = "";
	let selectAuth = "";
	$(document).ready(function() {
		if (selectMenu != 'auth') {
			$("#"+selectMenu).removeClass('menu-hover');
			$("#auth").addClass('menu menu-hover');
			selectMenu = 'auth';
		}
		
		authSearch();
		settingGrid();
		
		$("#saveBtn").click(function(){
			saveData();
	    });
		
		$("#delBtn").click(function() {
			saveData('D');
		});
		
		$("#addBtn").click(function() {
			clear();
		});
	});
	
	function authSearch() {
		$.ajax({
	        type: 'POST'
	        ,async: false
	        ,url: '/sys/auth/authSearch.json'
	        ,dataType: 'json'
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
	        ,success: function(data, textStatus) {
	        	authData = data.data;
	        	$("#gridObj").clearGridData();
    			$("#gridObj").setGridParam({data: authData }).trigger("reloadGrid");
    			if (auth_seq != "") {
    				$("#gridObj").jqGrid("setSelection", selectAuth);
    			}
	        }
	    });
	}
	
	function settingGrid() {
		$("#gridObj").jqGrid({
			datatype: "local",
			data: authData,
			colNames:['권한코드', '권한명', '작성자', '작성일자', 'auth_seq'],
			colModel:[
				{name:'auth_cd', index:0, width:100, align: "center"},
				{name:'auth_nm', index:1, width:200, align: "center"},
				{name:'reg_user_nm', index:2, width:200 , align: "center"},
				{name:'reg_dt', index:3, width:200, align: "center", sortable:false},
				
				{name:'auth_seq', index:4, width:0, align: "center", hidden: true}
			],
			rownumbers : true,
			multiselect:false,
			pager:'#pager',
			rowNum: 10,
			colNum: 5,
			rowList: [10, 20, 50],
			sortname: 'id',
			sortorder: 'asc',
			height: 400,
			
			cellEdit:false, //그리드 수정 가능 기능
			
			 /* row 클릭 한 직후 발생 	*/
			onSelectRow : function (rowid, status, e){
		    	if(status){
		    		let rowData = $(this).jqGrid('getRowData', rowid);
		            $("#auth_seq").val(rowData.auth_seq); 
		            $('#auth_cd').val(rowData.auth_cd).prop("selected",true);
			        $("#auth_nm").val(rowData.auth_nm);
		            $("#reg_user_nm").val(rowData.reg_user_nm);
		            $("#reg_dt").val(rowData.reg_dt);

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
		let target = $("#dataForm");
		let disabled = target.find(":disabled").removeAttr('disabled');
		let params = target.serialize() + "&login_user_seq=${login_user_seq}";
		disabled.attr('disabled', 'disabled');
		
		if (type == 'D') {
			params += '&delYn=Y';
		} else {
			params += '&delYn=';
		}
		
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
            		clear();
            		authSearch();
            	}
            }
        });
	}

	function clear(){
		$("#auth_seq").val("");
        $("#auth_nm").val("");
        $("#reg_user_nm").val("");
        $("#reg_dt").val("");
	}
	
</script>
</html>
