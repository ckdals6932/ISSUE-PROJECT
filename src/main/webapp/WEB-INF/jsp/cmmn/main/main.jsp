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
			<div style="display: flex; justify-content: space-around;">
			<div>
				<table id="gridNoticeObj"></table>
				<div id="pager"></div>
			</div>
            <div style="display: inline-block; width: 41%; height: 80%;">
               <form role="form" id="dataForm" method="POST">
                  <input type="hidden" id="board_seq" name="board_seq" class="form-control">
                  <section id="slider1" class="slider">
					  <textarea name="context_txt1" id="context_txt1"></textarea>
					  <textarea name="context_txt2" id="context_txt2"></textarea>
					  <textarea name="context_txt3" id="context_txt3"></textarea>
					  <textarea name="context_txt4" id="context_txt4"></textarea>
					  <textarea name="context_txt5" id="context_txt5"></textarea>
				  </section>
                  <table style="width: 800px;">
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
	
	<script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>
	<script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/translations/ko.js"></script>
	
	<script>
		$(document).ready(function() {
			if (selectMenu != 'dash') {
				$("#"+selectMenu).removeClass('menu-hover');
				$("#dash").addClass('menu menu-hover');
				selectMenu = 'dash';
			}
		});
		
		/* ck에디터를 id가 context_txt랑 연결  */
		ClassicEditor
		.create( document.querySelector( '#context_txt' ), {
			toolbar: [],
			language: "ko",
		})
		.then( contents => {
			editData = contents; // #contents에 있는 값을 theEditor에 넣어놓는다.
		})
		.catch( error => {
			consloe.error( error );
		}); 
		
		ClassicEditor
		.create( document.querySelector( '#context_txt1' ), {
			toolbar: [],
			language: "ko",
		})
		.then( contents => {
			editData = contents; // #contents에 있는 값을 theEditor에 넣어놓는다.
		})
		.catch( error => {
				consloe.error( error );
		}); 
		
		
		ClassicEditor
		.create( document.querySelector( '#context_txt2' ), {
			toolbar: [],
			language: "ko",
		})
		.then( contents => {
			editData = contents; // #contents에 있는 값을 theEditor에 넣어놓는다.
		})
		.catch( error => {
				consloe.error( error );
		});
		
		ClassicEditor
		.create( document.querySelector( '#context_txt3' ), {
			toolbar: [],
			language: "ko",
		})
		.then( contents => {
			editData = contents; // #contents에 있는 값을 theEditor에 넣어놓는다.
		})
		.catch( error => {
				consloe.error( error );
		});
		
		ClassicEditor
		.create( document.querySelector( '#context_txt4' ), {
			toolbar: [],
			language: "ko",
		})
		.then( contents => {
			editData = contents; // #contents에 있는 값을 theEditor에 넣어놓는다.
		})
		.catch( error => {
				consloe.error( error );
		});
		
		ClassicEditor
		.create( document.querySelector( '#context_txt5' ), {
			toolbar: [],
			language: "ko",
		})
		.then( contents => {
			editData = contents; // #contents에 있는 값을 theEditor에 넣어놓는다.
		})
		.catch( error => {
				consloe.error( error );
		});
		
	</script>
</body>
</html>	