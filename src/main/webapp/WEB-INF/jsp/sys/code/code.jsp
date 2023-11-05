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
				<button id="addBtn" name="addBtn">
		  			<img src="/resources/image/free-icon-add-user-456249.png"/>
		  		</button>
			</div>
			<div>
				<div style="display: inline-block; width: 53%;">
					<table id="gridCodeObj"></table>
					<div id="pager"></div>
				</div>
				<div style="display: inline-block; width: 41%; height: 80%;">
					<form role="form" id="dataForm" method="POST">
						<input type="hidden" id="user_seq" name="user_seq" class="form-control">
						<table id="gridCode"></table>
						<div id="pager"></div>
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
		codeGroupSearch();
		settingGrid();
		
		$("#saveBtn").click(function(){
			saveData();
	    });
		
		$("#addBtn").click(function() {
			clear();
		})
	});
	
	function codeGroupSearch() {
		$.ajax({
	        type: 'POST'
	        ,async: false
	        ,url: '/sys/code/codeGroupSearch.json'
	        ,dataType: 'json'
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
	        ,success: function(data, textStatus) {
	        	console.log(data);
	        	codeData = data.codeInfo;
	        	$("#gridCodeObj").clearGridData();
    			$("#gridCodeObj").setGridParam({data: codeGroupData }).trigger("reloadGrid");
    			if (user_seq != "") {
    				$("#gridCodeObj").jqGrid("setSelection", selectUser);
    			}
	        }
	    });
	}
	
	function codeSearch() {
		$.ajax({
	        type: 'POST'
	        ,async: false
	        ,url: '/sys/code/codeSearch.json'
	        ,dataType: 'json'
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
	        ,success: function(data, textStatus) {
	        	console.log(data);
	        	codeData = data.codeInfo;
	        	$("#gridCode").clearGridData();
    			$("#gridCode").setGridParam({data: codeData }).trigger("reloadGrid");
    			if (user_seq != "") {
    				$("#gridCode").jqGrid("setSelection", selectUser);
    			}
	        }
	    });
	}
	
	function settingGrid() {
		$("#gridCodeObj").jqGrid({
			datatype: "local",
			data: codeGroupData,
			colNames:['No.', '코드 값', '코드 명','비고'],
			colModel:[
				{name:'cd_grp_seq', index:0, width:0, align: "center"},
				{name:'cd_grp_cd', index:1, width:100, align: "center"},
				{name:'cd_grp_nm', index:2, width:200 , align: "center"},
				{name:'desc', index:3, width:200, align: "center", sortable:false}
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
			height: 500,
			
			cellEdit:false, //그리드 수정 가능 기능
			
			 /* row 클릭 한 직후 발생 	*/
			onSelectRow : function (rowid, status, e){

	        },
		});
		
		$("#gridCode").jqGrid({
			datatype: "local",
			data: userData,
			colNames:['No', '코드 값', '코드 명', '정렬','사용여부','비고'],
			colModel:[
				{name:'code_seq', index:0, width:0, align: "center"},
				{name:'code_value', index:1, width:100, align: "center"},
				{name:'code_name', index:2, width:200 , align: "center"},
				{name:'code_sort', index:2, width:200 , align: "center"},
				{name:'code_using', index:2, width:200 , align: "center"},
				{name:'code_desc', index:3, width:200, align: "center", sortable:false}
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
			height: 500,
			
			cellEdit:true, //그리드 수정 가능 기능
			
			 /* row 클릭 한 직후 발생 	*/
			onSelectRow : function (rowid, status, e){

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

	function saveData() {
		let target = $("#dataForm");
		let disabled = target.find(":disabled").removeAttr('disabled');
		let params = target.serialize();
		disabled.attr('disabled', 'disabled');
		
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
	
</script>
</html>
