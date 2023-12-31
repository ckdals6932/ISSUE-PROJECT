<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<html>
<head>
	<jsp:include page="/WEB-INF/jsp/cmmn/main/topheader.jsp"/>
</head>
<body>
	<div id="app">
		<div id="layoutObj">
			<div id="toolbar">
				<button id="saveBtn" name="saveBtn">
		  			<img src="/resources/image/free-icon-save-file-376218.png"/>
		  		</button>
				<button id="delBtn" name="delBtn">
		  			<img src="/resources/image/free-icon-delete-button-5680126.png"/>
		  		</button>
				<button id="addBtn" name="addBtn">
		  			<img src="/resources/image/free-icon-add-user-456249.png"/>
		  		</button>
			</div>
			<divdiv style="display: flex; justify-content: space-around;">
				<div>
					<table id="gridObj"></table>
					<div id="pager"></div>
				</div>
				
				<div>
					<form role="form" id="dataForm" method="POST">
						<input type="hidden" id="user_seq" name="user_seq" class="form-control">
						
						<table>
							<tr class="h_33">
								<td class="w_20p table_t">이름</td>
								<td class="w_30p center">
									<input type="text" id="user_nm" name="user_nm" class="form-control" autocomplete="off">
								</td>
								<td class="w_20p table_t">아이디</td>
								<td class="w_30p center">
									<input type="text" id="user_id" name="user_id" class="form-control" autocomplete="off">
								</td>
							</tr>
							<tr class="h_33">
								<td class="w_20p table_t">비밀번호</td>
								<td class="w_30p center">
									<input type="text" id="user_pw" name="user_pw" class="form-control" autocomplete="off">
								</td>
								<td class="w_20p table_t">생년월일</td>
								<td class="w_30p center">
									<input type="text" id="birth_dt" name="birth_dt" class="form-control" autocomplete="off">
								</td>
							</tr>
							<tr class="h_33">
								<td class="w_20p table_t">핸드폰번호</td>
								<td class="w_30p center">
									<input type="text" id="phone" name="phone" class="form-control" autocomplete="off">
								</td>
								<td class="w_20p table_t">상태</td>
								<td class="w_30p center">
									<select id="status_cd" name="status_cd" class="form-control">
										<option value="DF">요청</option>
										<option value="IN" selected>투입</option>
									</select>
								</td>
							</tr>
							<tr class="h_33">
								<td class="w_20p table_t">권한 명</td>
								<td class="w_30p center">
									<select id="owner_auth_nm" name="owner_auth_nm" class="form-control"></select>
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
	let userData = "";
	let selectUser = "";
	$(document).ready(function() {
		if (selectMenu != 'user') {
			$("#"+selectMenu).removeClass('menu-hover');
			$("#user").addClass('menu menu-hover');
			selectMenu = 'user';
		}
		
		userSearch();
		settingGrid();
		getComboList('owner_auth_nm');
		
		$("#saveBtn").click(function(){
			saveData();
	    });
		
		$("#delBtn").click(function(){
			if (confirm("삭제하겠습니까?")) {
				saveData('D');
			}
	    });

		$("#addBtn").click(function() {
			clear();
		});
	});
	

	function clear(){
		$("#user_seq").val("");
		$("#user_nm").val("");
        $("#user_id").val("");
        $("#user_id").removeAttr("disabled");
        $("#user_pw").val("");
        $("#phone").val("");
        $("#birth_dt").val("");
	}
	
	function userSearch() {
		$.ajax({
	        type: 'POST'
	        ,async: false
	        ,url: '/sys/user/userSearch.json'
	        ,dataType: 'json'
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
	        ,success: function(data, textStatus) {
	        	console.log(data);
	        	userData = data.userInfo;
	        	$("#gridObj").clearGridData();
    			$("#gridObj").setGridParam({data: userData }).trigger("reloadGrid");
    			if (user_seq != "") {
    				$("#gridObj").jqGrid("setSelection", selectUser);
    			}
	        }
	    });
	}
	
	
	function settingGrid() {
		$("#gridObj").jqGrid({
			datatype: "local",
			data: userData,
			colNames:['seq', '이름', '아이디', '생년원일','핸드폰', '권한명', '상태','password', 'auth'],
			colModel:[
				{name:'user_seq', index:0, width:0, align: "center", hidden: true,},
				{name:'user_nm', index:1, width:100, align: "center"},
				{name:'user_id', index:2, width:160 , align: "center"},
				{name:'birth_dt', index:3, width:160, align: "center", sortable:false},
				{name:'phone', index:4, width:150, align: "center"},
				{name:'auth_nm', index:7, width:80, align: "center"},
				{name:'status_cd', index:5, width:80, align: "center"}, 
				{name:'password', index:6, width:80, align: "center", hidden:true},
				{name:'auth_seq', index:7, width:80, align: "center", hidden:true}
			],
			//autowidth: true,
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
		    		$("#user_seq").val(rowData.user_seq);
			        $("#user_nm").val(rowData.user_nm);
		            $("#user_id").val(rowData.user_id);
		            $("#user_id").attr("disabled", true);
		            $("#user_pw").val(rowData.password);
		            $("#birth_dt").val(rowData.birth_dt);
		            $("#phone").val(rowData.phone);
		            $('#status_cd').val(rowData.status_cd).prop("selected",true);
		            
		            getComboList('owner_auth_nm', rowData.auth_seq);
		            selectUser = rowData.user_seq;
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
		let params = target.serialize();
		disabled.attr('disabled', 'disabled');

		if (type == 'D') {
			params += '&delYn=Y';
		} else {
			params += '&delYn=';
		}
		
		$.ajax({
            type: 'POST'
            ,async: true
            ,url: '/sys/user/userSave.json'
            ,dataType: 'json'
            ,data: params
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
            ,success: function(data, textStatus) {
            	let res = data.userInfo;
            	if (res.save == "Y") {
            		alert("저장되었습니다.");
            		userSearch();
            	}
            }
        });
	}
	
	function getComboList(obj, value) {
		$.ajax({
            type: 'POST'
            ,async: true
            ,url: '/sys/user/getAuthList.json'
            ,dataType: 'json'
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
            ,success: function(data, textStatus) {
            	data = data.authInfo;
            	$("#"+obj).empty();
            	$("#"+obj).append('<option value="">' + '' + '</option>');
            	$(data).each(function(k, v) {
            		$("#"+obj).append('<option value="' + v.value + '" '+((v.value == value) ? 'selected' : '')+'>' + v.text + '</option>');
            	});
            }
        });
	}
	
</script>
</html>
