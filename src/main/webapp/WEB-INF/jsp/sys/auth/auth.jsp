<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<html>
<head>
	<jsp:include page="/WEB-INF/jsp/cmmn/main/topheader.jsp"/>
</head>
<body>
	<div id="app">
		<div id="layout" style='margin-top: 100px;'>
			<div id="toolbar">
				<button id="saveBtn" name="saveBtn">
		  			<img src="/resources/image/free-icon-save-file-376218.png"/>
		  		</button>
				<button id="addBtn" name="addBtn">
		  			<img src="/resources/image/free-icon-add-user-456249.png"/>
		  		</button>
			</div>
			<div>
				<div style="display: inline-block; width: 100%;">
					<div id="gridObj"></div>
				</div>
			</div>
		</div>
	</div>
</body>

<script>
	let userData = "";
	let selectUser = "";
	$(document).ready(function() {
		if (selectMenu != 'auth') {
			$("#"+selectMenu).removeClass('menu-hover');
			$("#auth").addClass('menu menu-hover');
			selectMenu = 'auth';
		}
		
		settingLayout();
		settingGrid();
		// settingDp();
		
		dataload();
		
		$("#saveBtn").click(function(){
			dataSave();
	    });
		
		$("#addBtn").click(function() {
			clear();
		});
	});
	
	function settingLayout() {
		layout = new dhx.Layout("layout", {
		    type: "space",
		    rows: [
		        {
		            id: "grid",
		            height: "100%"
		        }
		    ]
		});
	}
	
	function settingGrid() {
		grid = new dhx.Grid(null, {
		    columns: [
		        { id: "no", header: [{ text: "No." }], editable: false, type: "text" },
		        { id: "auth_cd", header: [{ text: "권한코드" }], type: "text" },
		        { id: "auth_nm", header: [{ text: "권한명" }], type: "text" },
		        { id: "reg_user_nm", header: [{ text: "작성자" }], type: "text" },
		        { id: "reg_dt", header: [{ text: "작성일자" }], type: "text" }
		    ],
		    editable: true,
		    autoWidth: true
		});

		layout.getCell("grid").attach(grid);
	}
	
	function settingDp() {
		dp = new dataProcessor("/sys/auth/authSave.json");
		dp.init(grid);
	}
	
	function dataload() {
		$.ajax({
	        type: 'POST'
	        ,async: false
	        ,url: '/sys/auth/authSearch.json'
	        ,dataType: 'json'
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
	        ,success: function(data, textStatus) {
			    grid.data.parse(data.data);
	        }
	    });
	}
	
	function dataSave() {
	   let rowData = [];
	   for (var i = 0; i < grid.data.getRawData().length; i++) {
		   let jsonData = JSON.stringify(grid.data.getRawData()[i]);
		   jsonData = jsonData.replaceAll('$', '');
		   rowData.push(jsonData);
	   }
		$.ajax({
	        type: 'POST'
	        ,async: true
	        ,url: '/sys/auth/authSave.json'
	        ,dataType: 'json'
	        ,data: {
	        	data: rowData
	        	,login_user_seq: "${reg_user_seq}"
	        }
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
	        ,success: function(data, textStatus) {
	        	dataload();
	        }
	    });
	}

	function clear(){
		$("#user_seq").val("");
		$("#user_nm").val("");
        $("#user_id").val("");
        $("#user_id").removeAttr("disabled");
        $("#user_pw").val("");
        $("#phone").val("");
        $("#birth_dt").val("");
	}
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
	        	console.log(data);
	        	authData = data.authInfo;
	        	$("#gridObj").clearGridData();
    			$("#gridObj").setGridParam({data: authData }).trigger("reloadGrid");
	        }
	    });
	}

	function saveData() {
		let target = $("#dataForm");
		let disabled = target.find(":disabled").removeAttr('disabled');
		let params = target.serialize();
		disabled.attr('disabled', 'disabled');
		
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
            	if (res.save == "Y") {
            		alert("저장되었습니다.");
            		authSearch();
            	}
            }
        });
	}
	
</script>
</html>
