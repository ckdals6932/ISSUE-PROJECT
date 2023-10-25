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
			</div>
			<div>
				<div style="display: inline-block; width: 53%;">
					<table id="gridObj"></table>
					<div id="pager"></div>
				</div>
				<div style="display: inline-block; width: 41%; height: 80%;">
					<table id="selectObj" name="selectObj" >
						<tbody>
							<tr>
								<td>이름</td>
								<td><input type="text"></td>
								<td>아이디</td>
								<td><input type="text"></td>
							</tr>
							<tr>
								<td>비밀번호</td>
								<td><input type="text"></td>
								<td>생년월일</td>
								<td><input type="text"></td>
							</tr>
							<tr>
								<td>핸드폰번호</td>
								<td><input type="text"></td>
								<td>생년월일</td>
								<td><input type="text"></td>
							</tr>
							<tr>
								<td>권한 명</td>
								<td><input type="text"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>

<script>
	let userData = "";
	$(document).ready(function() {
		userSearch();
		
		$("#saveBtn").click(function(){
			saveData();
	    });
	});
	
	function userSearch() {
		$.ajax({
	        type: 'POST'
	        ,async: true
	        ,url: '/sys/user/userSearch.json'
	        ,dataType: 'json'
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
	        ,success: function(data, textStatus) {
	        	console.log(data);
	        	userData = data.userInfo;
	    		settingGrid();
	        }
	    });
	}
	function settingGrid() {
		var mydata = [
			];
		$("#gridObj").jqGrid({
			datatype: "local",
			data: userData,
			colNames:['이름', '아이디', '생년원일','핸드폰','상태'],
			colModel:[
				{name:'user_nm', index:0, width:100, align: "center"},
				{name:'user_id', index:1, width:200 , align: "center"},
				{name:'birth_dt', index:2, width:200, align: "center", sortable:false},
				{name:'phone', index:3, width:150, align: "center"},
				{name:'status_cd', index:4, width:80, align: "center"}, 
			],
			//autowidth: true,
			rownumbers : true,
			multiselect:false,
			pager:'#pager',
			rowNum: 10,
			rowList: [10, 20, 50],
			sortname: 'id',
			sortorder: 'asc',
			height: 500,
			
			cellEdit:false, //그리드 수정 가능 기능
			
				/* 더블클릭시 수정 가능*/
	        ondblClickRow : function (rowid, iRow, iCol){
	          
	          const colModels = $(this).getGridParam('colModel'); 
	          const colName = colModels[iCol].name;
	         
	          /* prog_id(PK), chkbox 수정불가 */
	          if(!(colName=='prog_id'||colName=='chkbox')){
	            $(this).setColProp(colName, {editable : true}); //gridColModel의 name값을 수정가능하게 해줌 
	            $(this).editCell(iRow, iCol, true); 
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

	function saveData() {
		var param = [];
		var sel_rows = $("#gridObj").jqGrid("getGridParam", "selarrrow");
		if(sel_rows.length > 0){
			$(sel_rows).each(function(idx, val){	
				var json = {
					user_name: $("#gridObj").getCell(val, "user_name")
					, user_id: $("#gridObj").getCell(val, "user_id")
					, idx: $("#gridObj").getCell(val, "idx")
				};
				param.push(json);
				
			});
			var data = JSON.stringify(param);
			console.log(data);
	
		}else{
			console.log("리스트를 선택해주세요.");
		}
	}
</script>
</html>
