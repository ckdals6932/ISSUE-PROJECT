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
			<table id="gridObj"></table>
			<div id="pager"></div>
		</div>
	</div>
	
	<script>
		//로그인 상세정보 버튼 이벤트
		function OpenUserPage(){
			window.location.href = "/sys/user/user.view";
		}
		
		$("#codeBtn").click(function(){
			window.location.href = "/sys/code/code.view";
	    });
		
		$(document).ready(function() {
			if (selectMenu != 'dash') {
				$("#"+selectMenu).removeClass('menu-hover');
				$("#dash").addClass('menu menu-hover');
				selectMenu = 'dash';
			}
			settingGrid();
			
			$("#saveBtn").click(function(){
				saveData();
		    });
		});
		
		function settingGrid() {
			$("#gridObj").jqGrid({
				datatype: "local",
				data: [],
				colNames:['날짜', '아이디', '이름','상품','가격','합계'],
				colModel:[
					{name:'date', index:'date', width:90, align: "center"},
					{name:'name', index:'name', width:100 , align: "center" },
					{name:'id', index:'id', width:150, align: "center" ,sortable:false },
					{name:'product', index:'product', width:80, align: "center"},
					{name:'amount', index:'amount', width:80, align: "center"},
					{name:'total', index:'total', width:80, align: "center"}
				],
				autowidth: true,
				rownumbers : true,
				multiselect:true,
				pager:'#pager',
				rowNum: 10,
				rowList: [10, 20, 50],
				sortname: 'id',
				sortorder: 'asc',
				height: 250,
				
				cellEdit:true, //그리드 수정 가능 기능
				
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
</body>
</html>