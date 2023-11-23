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
              
              <button id="groupSaveBtn" name="groupSaveBtn" class="m_r_10">
                 <img src="/resources/image/free-icon-save-file-376218.png"/>
              </button>
            <button id="groupAddBtn" name="groupAddBtn">
                 <img src="/resources/image/free-icon-add-user-456249.png"/>
              </button>
              
         </div>
         <div>
            <div style="display: inline-block; width: 53%;">
               <table id="gridNoticeObj"></table>
               <div id="pager"></div>
            </div>
            <div style="display: inline-block; width: 41%; height: 80%;">
               <form role="form" id="dataForm" method="POST">
                  <input type="hidden" id="user_seq" name="user_seq" class="form-control">
                  <table style="width: 800px;">
							<tr class="h_33">
								<td class="w_50p table_t center">제목</td>
								<td class="w_20p table_t center">작성자</td>
								<td class="w_20p table_t center">날짜</td>
								<td class="w_5p table_t center">정렬</td>
								<td class="w_5p table_t center">사용여부</td> 
								<td class="w_10p table_t center">조회수</td>
							</tr>
							<tr class="h_33">
								<td class="w_50p center">
									<input type="text" id="notice_title" name="notice_title" class="form-control" autocomplete="off">
								</td>
								<td class="w_20p center">
									<input type="text" id="reg_user_nm" name="reg_user_nm" class="form-control" autocomplete="off">
								</td>
								<td class="w_20p center">
									<input type="text" id="reg_dt" name="auth_nm" class="form-control" autocomplete="off">
								</td>
								<td class="w_5p center">
									<input type="text" id="reg_dt" name="auth_nm" class="form-control" autocomplete="off">
								</td>
								<td class="w_5p center">
									<input type="text" id="sort" name="auth_nm" class="form-control" autocomplete="off">
								</td>
								<td class="w_10p center">
									<input type="text" id="view_cnt" name="auth_nm" class="form-control" autocomplete="off">
								</td>
							</tr>
							<tr>
								<td colspan='5' align = "center">
								<script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>
		    					<script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/translations/ko.js"></script>
								<textarea name="content" id="editor"></textarea>
		    					<script>
		      						ClassicEditor.create( document.querySelector( '#editor' ), {
		      							language: "ko",
		      						});
		    					</script>
		    					</td>
							</tr>	
						</table>	
                  <div id="pager"></div> 
               </form>
            </div>
         </div>
      </div>
   </div>
</body>

<script>
	let noticeData = "";
	let codeData = "";
	let userData = "";
	let selectUser = "";
	$(document).ready(function() { 
		if (selectMenu != 'notice') {
			$("#"+selectMenu).removeClass('menu-hover');
			$("#notice").addClass('menu menu-hover');
			selectMenu = 'notice';
		}
	});

	   
   $(document).ready(function() {
   	  noticeSearch();
      settingGrid();
      
      	$("#groupSaveBtn").click(function(){
      		saveGroupCodeData();
       	});
      
      	$("#groupAddBtn").click(function() {
    	  var grid = $("#gridCodeObj");
    	  var newRowId = (grid.getDataIDs().length + 1); // Generate a unique row ID for the new row
    	  var data = {cd_grp_seq: '', cd_grp_cd: '', cd_grp_nm: '', desc: '', db_type:'I'};

    	  // 특정 행을 생성하고 데이터를 추가합니다
    	  grid.addRowData(newRowId, data);
    	});
   });
   
   function noticeSearch() {
      $.ajax({
           type: 'POST'
           ,async: false
           ,url: '/sys/notice/noticeSearch.json'
           ,dataType: 'json'
           ,error:function (data, textStatus) {
            alert("시스템 에러입니다."); 
           }
           ,success: function(data, textStatus) {
              console.log(data);
              noticeData = data.noticeInfo;
              $("#gridNoticeObj").clearGridData();
              $("#gridNoticeObj").setGridParam({data: noticeData }).trigger("reloadGrid");
              if (user_seq != "") {
                 $("#gridNoticeObj").jqGrid("setSelection", selectUser);
              }
           }
       });
   }
   
   function codeSearch(rowId) {
	   let rowData = $("#gridCodeObj").getRowData(rowId);
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
              if (user_seq != "") {
                 $("#gridCode").jqGrid("setSelection", selectUser);
              }
           }
       });
   }
   
   function settingGrid() {
      $("#gridNoticeObj").jqGrid({
         datatype: "local",
         data: noticeData,
         colNames:['No.', '제목', '작성자','날짜','정렬'],
         colModel:[
            {name:'board_seq', index:0, width:0, align: "center", hidden: true},
            {name:'title', index:1, width:100, align: "center"},
            {name:'reg_user_seq', index:2, width:200 , align: "center"},
            {name:'reg_dt', index:3, width:200, align: "center"},
            {name:'sort', index:4, width:200, align: "center"},
         ],
         //autowidth: true,
         rownumbers : true,
         multiselect : false,
         pager:'#pager',
         rowNum: 10,
         colNum: 5,
         rowList: [10, 20, 50],
         sortname: 'id',
         sortorder: 'asc',
         height: 500,
         
         cellEdit:false, //그리드 수정 가능 기능  
         cellsubmit : 'clientArray',
         
         //더블클릭시 수정 가능
         ondblClickRow : function (rowid, iRow, iCol){
        	 
         },
       
          /* row 클릭 한 직후 발생    */
         onSelectRow : function (rowid, status, e){
         },

         afterEditCell : function(rowid, cellname, value, iRow, iCol){
         },
         
      });
      

      $(window).on('resize.jqGrid', function() {
         $("#gridNoticeObj").jqGrid('setGridWidth', $("#gridCodeObj").parent().parent().parent().parent().parent().width());
      })
      
      $(".jarviswidget-fullscreen-btn").click(function(){
         setTimeout(function() {
            $("#gridNoticeObj").jqGrid('setGridWidth', $("#gridCodeObj").parent().parent().parent().parent().parent().width());
         }, 100);
      });
   }

   function saveGroupCodeData() {
	   let codeGroupData = $("#gridCodeObj").jqGrid("getRowData");
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