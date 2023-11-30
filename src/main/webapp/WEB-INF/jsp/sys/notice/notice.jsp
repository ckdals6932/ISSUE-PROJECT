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
		  			<img src="/resources/image/free-icon-add-image-7780327.png"/>
		  		</button>
		</div>
		<div style="display: flex; justify-content: space-around;">
			<div>
				<table id="gridNoticeObj"></table>
				<div id="pager"></div>
			</div>
            <div style="display: inline-block; width: 41%; height: 80%;">
               <form role="form" id="dataForm" method="POST">
                  <input type="hidden" id="board_seq" name="board_seq" class="form-control">
                  <table style="width: 800px;">
							<tr class="h_33">
								<td class="w_50p table_t center">제목</td>
								<td class="w_15p table_t center">작성자</td>
								<td class="w_20p table_t center">날짜</td>
								<td class="w_5p table_t center">정렬</td>
								<td class="w_10p table_t center">사용여부</td> 
							</tr>
							<tr class="h_33">
								<td class="w_50p center">
									<input type="text" id="notice_title" name="notice_title" class="form-control" autocomplete="off">
								</td>
								<td class="w_15p center">
									<input type="text" id="reg_user_nm" name="reg_user_nm" class="form-control" autocomplete="off">
								</td>
								<td class="w_20p center">
									<input type="text" id="reg_dt" name="reg_dt" class="form-control" autocomplete="off">
								</td>
								<td class="w_5p center">
									<input type="text" id="sort" name="sort" class="form-control" autocomplete="off">
								</td>
								<td class="w_10p center">
									<input type="text" id="view_yn" name="view_yn" class="form-control" autocomplete="off">
								</td>
							</tr>
							<tr>
								<td colspan='5' align = "center">
								<textarea name="context_txt" id="context_txt"></textarea>
		    					</td>
							</tr>	
					</table>	
               </form>
            </div>
         </div>
      </div> 
   </div>
</body>

<script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/translations/ko.js"></script>

<script>
	let noticeData = "";
	let selectNotice = "";
	let editData = "";
	let editTxtData = "";
	let editHtmlData = "";
	
	/* ck에디터를 id가 context_txt랑 연결  */
	ClassicEditor
	.create( document.querySelector( '#context_txt' ), {
		language: "ko",
	})
	.then( contents => {
		editData = contents; // #contents에 있는 값을 theEditor에 넣어놓는다.
	})
	.catch( error => {
		consloe.error( error );
	}); 

	$(document).ready(function() { 
		if (selectMenu != 'notice') {
			$("#"+selectMenu).removeClass('menu-hover'); 
			$("#notice").addClass('menu menu-hover');
			selectMenu = 'notice';
		}
		
		noticeSearch();
		settingGrid();
		
		$("#saveBtn").click(function(){
			editHtmlData = editData.getData();
			editTxtData = editHtmlData.replace("<p>", "").replace("</p>", "");
			console.log(editHtmlData + " " + editTxtData);
			saveData();
			
	    });
		
		$("#delBtn").click(function() {
			saveData('D');
		});
		
		$("#addBtn").click(function() {
			clear();
		});
	});  
	
	function saveData(type) {
		let target = $("#dataForm");
		let disabled = target.find(":disabled").removeAttr('disabled');
		let params = target.serialize() + "&login_user_seq=${login_user_seq}";
		disabled.attr('disabled', 'disabled');
		
		if (type == 'D') {
			params += '&delYn=Y';
		} else {
			params += '&delYn=';

		}
		
		$.ajax({
            type: 'POST'
            ,async: true
            ,url: '/sys/notice/noticeSave.json?'+params
            ,dataType: 'json'
            ,data: {
            	board_seq: $("#board_seq").val()
            	,content_txt : editTxtData
            	,content_html : editHtmlData
            }
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
            ,success: function(data, textStatus) {
            	let res = data.authInfo;
            	if (res.auth_cd_error == 'Y') {
            		alert("코드가 중복되었습니다.");
            	} else if (res.save == "Y") {
            		alert("저장되었습니다.");
            		clear();
            		noticeSearch();
            	}
            }
        }); 
	}

	function clear(){
		$("#notice_title").val("");
		$("#reg_user_nm").val("");
        $("#reg_dt").val("");
        $("#sort").val("");
        $("#view_yn").val("");
        
        /* $("#auth_cd").removeAttr("disabled"); */
	}
	
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
              if (board_seq != "") {
                 $("#gridNoticeObj").jqGrid("setSelection", selectNotice);
              }
           }
       });
   }
   
   /* notice 그리드 부분 (초기 세팅, 클릭 이벤트)  */
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
         
         /* row 클릭 한 직후 발생 	*/
		 onSelectRow : function (rowid, status, e){
	    	 if(status){
	    		 let rowData = $(this).jqGrid('getRowData', rowid);
	             $("#board_seq").val(rowData.board_seq);
	    		 $("#title").val(rowData.title);
		         $("#reg_user_seq").val(rowData.reg_user_seq);
	             $("#reg_dt").val(rowData.reg_dt);
	             $("#sort").val(rowData.sort);
	            
	             $("#board_seq").attr("disabled", "disabled");
	    		
	             selectNotice = rowData.board_seq;
	         }
         },
         
      });
      

      $(window).on('resize.jqGrid', function() {
         $("#gridNoticeObj").jqGrid('setGridWidth', $("#gridNoticeObj").parent().parent().parent().parent().parent().width());
      })
      
      $(".jarviswidget-fullscreen-btn").click(function(){
         setTimeout(function() {
            $("#gridNoticeObj").jqGrid('setGridWidth', $("#gridNoticeObj").parent().parent().parent().parent().parent().width());
         }, 100);
      });
   }
</script>
</html>