<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<html>
<head>
   <jsp:include page="/WEB-INF/jsp/cmmn/main/topheader.jsp"/>
</head>
<body>
   <div id="app">
      <div id="layoutObj">
         <div id="toolbar">
            <button id="saveBtn" name="saveBtn" hidden>
                 <img src="/resources/image/free-icon-save-file-376218.png"/>
              </button>
            <button id="addBtn" name="addBtn" hidden>
                 <img src="/resources/image/free-icon-add-user-456249.png"/>
              </button>
              
              <button id="groupSaveBtn" name="groupSaveBtn" class="m_r_10" hidden>
                 <img src="/resources/image/free-icon-save-file-376218.png"/>
              </button>
            <button id="groupAddBtn" name="groupAddBtn" hidden>
                 <img src="/resources/image/free-icon-add-user-456249.png"/>
              </button>
              
         </div>
         <div style="display: flex;">
            <div style="margin-right: 20px;">
               <table id="gridCodeGroup"></table>
               <div id="pagerCodeGroup"></div>
            </div>
            <div>
                 <table id="gridCode"></table>
                 <div id="pagerCode"></div>
            </div>
         </div>
      </div>
   </div>
</body>

<script>
   let codeGroupData = "";
   let codeData = "";
   let userData = "";
   let selectUser = "";
   
   $(document).ready(function() {
		if (selectMenu != 'code') {
			$("#"+selectMenu).removeClass('menu-hover');
			$("#code").addClass('menu menu-hover');
			selectMenu = 'code';
		}
		
   	  	codeGroupSearch();
      	settingGrid();
      
      	$("#groupSaveBtn").click(function(){
      		saveGroupCodeData();
       	});
      
      	$("#groupAddBtn").click(function() {
    	  var grid = $("#gridCodeGroup");
    	  var newRowId = (grid.getDataIDs().length + 1); // Generate a unique row ID for the new row
    	  var data = {cd_grp_seq: '', cd_grp_cd: '', cd_grp_nm: '', desc: '', db_type:'I'};

    	  // 특정 행을 생성하고 데이터를 추가합니다
    	  grid.addRowData(newRowId, data);
    	});
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
              codeGroupData = data.codeGroupInfo;
              $("#gridCodeGroup").clearGridData();
              $("#gridCodeGroup").setGridParam({data: codeGroupData }).trigger("reloadGrid");
           }
       });
   }
   
   function codeSearch(rowId) {
	   let rowData = $("#gridCodeGroup").getRowData(rowId);
      	$.ajax({
           type: 'POST'
           ,async: false
           ,url: '/sys/code/codeSearch.json'
           ,data: {
        	   cd_grp_seq : rowData.cd_grp_seq
           }
           ,dataType: 'json'
           ,error:function (data, textStatus) {
            alert("시스템 에러입니다.");
           }
           ,success: function(data, textStatus) {
              console.log(data);
              codeData = data.codeInfo; 	   	  
              $("#gridCode").clearGridData();
              $("#gridCode").setGridParam({data: codeData }).trigger("reloadGrid");
           }
       });
   }
   
   function settingGrid() {
      $("#gridCodeGroup").jqGrid({
         datatype: "local",
         data: codeGroupData,
         colNames:['No.', '코드 값', '코드 명','비고'],
         colModel:[
            {name:'cd_grp_seq', index:0, width:0, align: "center", hidden: true},
            {name:'cd_grp_cd', index:1, width:150, align: "center"},
            {name:'cd_grp_nm', index:2, width:250 , align: "center"},
            {name:'desc', index:3, width:300, align: "center"},
         ],
         //autowidth: true,
         rownumbers : true,
         multiselect : false,
         pager:'#pagerCodeGroup',
         rowNum: 10,
         colNum: 5,
         rowList: [10, 20, 50],
         sortname: 'id',
         sortorder: 'asc',
         height: 420,
      
         cellEdit:false, //그리드 수정 가능 기능  
         cellsubmit : 'clientArray',
         
         //더블클릭시 수정 가능
         ondblClickRow : function (rowid, iRow, iCol){
        	 
            let colModels = $(this).getGridParam('colModel'); 
            var colName = colModels[iCol].name;
            $(this).jqGrid("setGridParam", {cellEdit: true});
            
            if(!(colName=='db_type'||colName=='chkbox')){	
            	$(this).setColProp(colName, {editable : true});
                $(this).editCell(iRow, iCol, true);
              }
         },
       
          /* row 클릭 한 직후 발생    */
         onSelectRow : function (rowid, status, e){
        	 codeSearch(rowid);
         },

         afterEditCell : function(rowid, cellname, value, iRow, iCol){
        	 let rowData = $(this).jqGrid('getRowData', rowid);
        	 let colModels = $(this).getGridParam('colModel');
        	 $(this).jqGrid("setGridParam", {cellEdit: false});
        	 $(this).setColProp(colModels, {editable: false}) ;
             var rowType = rowData.db_type;
             
        	 if(rowType == ""){
       	 		rowType = 'U';
        	 }
        	 
        	// 변경된 rowType를 그리드 데이터에 반영 
             $(this).jqGrid('setCell', rowid, 'db_type', rowType);
         },
         
      });
      
      $("#gridCode").jqGrid({
         datatype: "local",
         data: codeData,
         colNames:['seq', '코드 값', '코드 명', '정렬','사용여부','비고'],
         colModel:[
            {name:'cd_seq', index:0, width:0, align: "center", hidden: true},
            {name:'cd', index:1, width:120, align: "center"},
            {name:'cd_nm', index:2, width:250 , align: "center"},
            {name:'sort', index:2, width:80 , align: "center"}, 
            {name:'use_yn', index:2, width:80 , align: "center"},
            {name:'desc', index:3, width:220, align: "center", sortable:false}
         ],
         //autowidth: true,
         rownumbers : true,
         multiselect:false,
         pager:'#pagerCode',
         rowNum: 10,
         colNum: 5,
         sortname: 'id',
         sortorder: 'asc',
         height: 420,
         
         cellEdit:true, //그리드 수정 가능 기능
      });

      $(window).on('resize.jqGrid', function() {
         $("#gridCodeGroup").jqGrid('setGridWidth', $("#gridCodeGroup").parent().parent().parent().parent().parent().width());
      })
      
      $(".jarviswidget-fullscreen-btn").click(function(){
         setTimeout(function() {
            $("#gridCodeGroup").jqGrid('setGridWidth', $("#gridCodeGroup").parent().parent().parent().parent().parent().width());
         }, 100);
      });
   }

   function saveGroupCodeData() {
	   let codeGroupData = $("#gridCodeGroup").jqGrid("getRowData");
      $.ajax({
            type: 'POST',
            async: true,
            url: '/sys/code/codeGroupSave.json',
            data: {
            	codeGroupData : codeGroupData 
            },
            dataType: 'json',
           error:function (data, textStatus, e) {
            alert("시스템 에러입니다.");
           },
            success: function(data, textStatus) {
               alert("저장되었습니다.");
               codeGroupSearch();
            },
        });
   }
   
</script>
</html>