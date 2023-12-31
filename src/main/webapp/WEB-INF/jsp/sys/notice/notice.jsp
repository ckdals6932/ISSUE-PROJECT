<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<html>
<head>
   	<jsp:include page="/WEB-INF/jsp/cmmn/main/topheader.jsp"/>
   	<style>
		input {-webkit-appearance: auto;}
		
		#dataForm > table > tbody > tr:nth-child(3) > td > div > div.ck.ck-editor__main > div {
		height: 354px !important;
		}
   	</style>
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
			<div style="margin-right: 20px;">
				<table id="gridNoticeObj"></table>
				<div id="pager"></div>
			</div>
            <div>
               <form role="form" id="dataForm" method="POST">
                  <input type="hidden" id="board_seq" name="board_seq" class="form-control">
                  <table>
						<tr class="h_33">
							<td class="w_50p table_t center">제목</td>
							<td class="w_15p table_t center">작성자</td>
							<td class="w_20p table_t center">날짜</td>
							<td class="w_5p table_t center">정렬</td>
							<td class="w_10p table_t center">사용여부</td> 
						</tr>
						<tr class="h_33">
							<td class="w_45p center">
								<input type="text" id="notice_title" name="notice_title" class="form-control" autocomplete="off">
							</td>
							<td class="w_10p center">
								<input type="text" id="reg_user_nm" name="reg_user_nm" class="form-control" autocomplete="off" disabled>
							</td>
							<td class="w_20p center">
								<input type="text" id="reg_dt" name="reg_dt" class="form-control" autocomplete="off" disabled>
							</td>
							<td class="w_10p center">
								<input type="text" id="sort" name="sort" class="form-control" autocomplete="off">
							</td>
							<td class="w_15p center">
								<input type="checkbox" id="view_yn" name="view_yn" value='Y' checked>
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
		
		if("${login_user_auth}" == "VIEW"){
			$("#saveBtn").attr('hidden', true);
			$("#delBtn").attr('hidden', true);
			$("#addBtn").attr('hidden', true);
		}
		
		noticeSearch();
		settingGrid();
		
		$("#saveBtn").click(function(){
			editHtmlData = editData.getData();
			editTxtData = editHtmlData.replace(/(<([^>]+)>)/ig,"");
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

		$('input:checkbox[name="view_yn"]').each(function() {
	    	// 값이 2인것을 체크 한다
			if(this.checked){
				params += '&view_yn=Y';
		      }else{
		        params += '&view_yn=N';
		      }
	    });
		
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
            	/* board_seq: $("#board_seq").val() */
            	content_txt : editTxtData
            	,content_html : editHtmlData
            }
	        ,error:function (data, textStatus) {
				alert("시스템 에러입니다.");
	        }
            ,success: function(data, textStatus) {
            	let res = data.noticeInfo;
            	if (res.save == "Y") {
            		alert("저장되었습니다.");
            		clear();
            		noticeSearch();
            	} else {
            		alert("에러입니다");
            	}
            }
        }); 
	}

	function clear(){
		$("#board_seq").val("");
		$("#notice_title").val("");
		$("#reg_user_nm").val("");
        $("#reg_dt").val("");
        $("#sort").val("");
        $("#view_yn").prop("checked", true);
        editData.setData("");
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
         colNames:['board_seq','내용', '제목', '작성자','날짜','정렬', 'html', 'view_yn'],
         colModel:[
            {name:'board_seq', index:0, width:0, align: "center", hidden: true},
            {name:'title', index:1, width:200, align: "center"},
            {name:'content_txt', index:2, width: 250, align: "center"},
            {name:'reg_user_nm', index:3, width:100 , align: "center"}, 
            {name:'reg_dt', index:4, width:100, align: "center"},
            {name:'sort', index:5, width:80, align: "center"},
            {name:'content_html', index:6, width:0, align: "center", hidden: true},
            {name:'view_yn', index:7, width:0, align: "center", hidden: true},
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
         height: 400,
         
         cellEdit:false, //그리드 수정 가능 기능  
         cellsubmit : 'clientArray',
         
         /* row 클릭 한 직후 발생 	*/
		 onSelectRow : function (rowid, status, e){
	    	 if(status){
	    		 let rowData = $(this).jqGrid('getRowData', rowid);
	    		 
	             $("#board_seq").val(rowData.board_seq); 
	    		 $("#notice_title").val(rowData.title);
		         $("#reg_user_nm").val(rowData.reg_user_nm);
	             $("#reg_dt").val(rowData.reg_dt);
	             $("#sort").val(rowData.sort);
	             $("#board_seq").attr("disabled", "disabled");
	             
	             editData.setData(rowData.content_html);
	             selectNotice = rowData.board_seq;
	             
	             if(rowData.view_yn == "Y"){
	            	 $("#view_yn").prop("checked", true);
	             } else {
	            	 $("#view_yn").prop("checked", false);
	             } 
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