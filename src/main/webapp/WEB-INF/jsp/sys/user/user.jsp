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
			   {name:"강창민",id:"Changmin",data:"2023-05-11",phoneNB:"01086186932",type:"신규"},
			   {name:"꼬까알콘",id:"KKoKKaalKon",data:"2023-07-26",phoneNB:"01097362306",type:"투입"},
			   {name:"고가희",id:"KoKaHee",data:"2023-07-26",phoneNB:"01023069736",type:"투입"},
			   {name:"김병재",id:"Kimbj",data:"2023-07-26",phoneNB:"01012345678",type:"신규"},
			   {name:"안성수",id:"AhnSungSu",data:"2023-10-24",phoneNB:"01012345678",type:"신규"},
			   {name:"서현민",id:"SeoHyunMin",data:"2023-04-02",phoneNB:"01012345678",type:"신규"},
			];
	
		$("#gridObj").jqGrid({
			datatype: "local",
			data: userData,
			colNames:['이름', '아이디', '생년원일','핸드폰','상태'],
			colModel:[
				{name:'user_nm', index:0, width:90, align: "center"},
				{name:'user_id', index:1, width:100 , align: "center" },
				{name:'birth_dt', index:2, width:150, align: "center" ,sortable:false },
				{name:'phone', index:3, width:80, align: "center"},
				{name:'status_cd', index:4, width:80, align: "center"}, 
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

</html>
