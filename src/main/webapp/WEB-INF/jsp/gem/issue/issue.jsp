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
		
		console.log("${login_user_auth}");
		
		if("${login_user_auth}" == "VIEW"){
			$("#saveBtn").attr('hidden', true);
			$("#delBtn").attr('hidden', true);
			$("#addBtn").attr('hidden', true);
		}
			
		issueSearch();
		settingGrid();
		
		$("#delBtn").click(function() {
			let rowId = $("#gridObj").getGridParam("selrow");
			let rowData = $("#gridObj").jqGrid("getRowData", rowId);
			
			if (rowData.item_status_cd != 'DF') {
				alert("진행중인 조치건은 삭제할 수 없습니다.");
			} else {
				if (confirm("삭제하겠습니까?")) {
					delData(rowData);	
				}
			}
		});
		
		$("#addBtn").click(function() {
			openIssueRegistrationPopup('');
		});
	});
	
	function issueSearch() {
		$.ajax({
	        type: 'POST'
	        ,async: false
	        ,url: '/gem/issue/issueSearch.json?login_user_seq=${login_user_seq}'
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
			colNames:['Issue Code', '메뉴', '제목', '상태', '요청자', ' 요청 내용', '처리자', '처리 내용', 'seq', 'item_status_cd'],
			colModel:[
				{name:'item_cd', index:0, width:100, align: "center"},
				{name:'item_menu_nm', index:1, width:150, align: "center"},
				{name:'item_title', index:2, width:300 , align: "center"},
				{name:'item_status_nm', index:2, width:150 , align: "center"},
				{name:'reg_user_nm', index:2, width:100 , align: "center"},
				{name:'item_content', index:3, width:300, align: "center"},
				{name:'owner_user_nm', index:2, width:100 , align: "center"},
				{name:'req_content', index:2, width:300 , align: "center"},
				
				{name:'item_seq', index:4, width:0, align: "center", hidden: true}, 
				{name:'item_status_cd', index:4, width:0, align: "center", hidden: true}
			],
			rownumbers : true,
			multiselect:false,
			pager:'#pager',
			rowNum: 10,
			colNum: 5,
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
	        ondblClickRow: function (rowid, iRow, iCol) {
	    		openIssueRegistrationPopup(rowid);
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
	
	function delData(rowData) {
		$.ajax({
            type: 'POST'
            ,async: true
            ,url: '/gem/issue/delData.json?item_seq='+rowData.item_seq
            ,dataType: 'json'
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
            ,success: function(data, textStatus) {
				alert("삭제되었습니다.");
        		issueSearch();
            }
        });
	}
	
	function openIssueRegistrationPopup(rowId) {
		let rowData = '';
		let params = '';
		
		if (rowId == '') {
			params = 'item_seq=-1';
		} else {
    		rowData = $("#gridObj").jqGrid('getRowData', rowId);
			params = 'item_seq='+rowData.item_seq;
		}
		
		var url = "/gem/issue/issueRegistrationPopup.view?"+params;
		var windowTargetName = (rowId == '' ? 'Issue' : rowData.issue_cd);
		var features = "scrollbars=yes,width=800,height=650,location=no, resizable=yes";
		window.open(url, windowTargetName, features);
	}
	
</script>
</html>
