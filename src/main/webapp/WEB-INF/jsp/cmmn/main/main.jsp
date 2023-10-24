<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<html>
<head>
	<jsp:include page="/WEB-INF/jsp/cmmn/main/topheader.jsp"/>
</head>
<body>
	<div id="app">
		<div id="layoutObj">
			<div id="toolbar">	
				<input type= button id="userBtn" name="userBtn" value="로그인 페이지" onclick="OpenUserPage()">
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
		
		$(document).ready(function() {
			settingGrid();
			
			$("#saveBtn").click(function(){
				saveData();
		    });
		});
		
		function settingGrid() {
			var mydata = [
				   {date:"2007-10-01",name:"test",id:"id1",product:"상품1",amount:"10.00",total:"210.00"},
				   {date:"2007-10-02",name:"test2",id:"id2",product:"상품1",amount:"20.00",total:"320.00"},
				   {date:"2007-09-01",name:"test3",id:"id3",product:"상품1",amount:"30.00",total:"430.00"},
				   {date:"2007-10-04",name:"test",id:"id4",product:"상품1",amount:"10.00",total:"210.00"},
				   {date:"2007-10-05",name:"test2",id:"id5",product:"상품1",amount:"20.00",total:"320.00"},
				   {date:"2007-09-06",name:"test3",id:"id6",product:"상품2",amount:"30.00",total:"430.00"},
				   {date:"2007-10-04",name:"test",id:"id7",product:"상품2",amount:"10.00",total:"210.00"},
				   {date:"2007-10-03",name:"test2",id:"id8",product:"상품2",amount:"20.00",total:"320.00"},
				   {date:"2007-09-01",name:"test3",id:"id9",product:"상품2",amount:"30.00",total:"430.00"},
				   {date:"2007-10-01",name:"test",id:"id10",product:"상품2",amount:"10.00",total:"210.00"},
				   {date:"2007-10-02",name:"test2",id:"id11",product:"상품2",amount:"20.00",total:"320.00"},
				   {date:"2007-09-01",name:"test3",id:"id12",product:"상품2",amount:"30.00",total:"430.00"},
				   {date:"2007-10-04",name:"test",id:"id13",product:"상품2",amount:"10.00",total:"210.00"},
				   {date:"2007-10-05",name:"test2",id:"id14",product:"상품2",amount:"20.00",total:"320.00"},
				   {date:"2007-09-06",name:"test3",id:"id15",product:"상품2",amount:"30.00",total:"430.00"},
				   {date:"2007-10-04",name:"test",id:"id16",product:"상품2",amount:"10.00",total:"210.00"},
				   {date:"2007-10-03",name:"test2",id:"id17",product:"상품2",amount:"20.00",total:"320.00"},
				   {date:"2007-09-01",name:"test3",id:"id18",product:"상품2",amount:"30.00",total:"430.00"},
				  {date:"2007-09-01",name:"test4",id:"id19",product:"상품2",amount:"30.00",total:"430.00"}
				];
			
			$("#gridObj").jqGrid({
				datatype: "local",
				data: mydata,
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