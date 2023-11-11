<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
	function fixGridLoad(gridObj, dpObj, colData) {
		const gridHeaderDashboardStyle = 'border: 1px solid #e4e4e4; background-color: #55607c; color: #ffffff;';
		const gridHeaderStyle = 'border: 1px solid #e4e4e4; background-color: #f7f7f7; font-weight: normal; color: #484848;';
		const gridCellStyle = 'border: 1px solid #e4e4e4;';
		
		gridObj.setStyle(gridHeaderStyle, gridCellStyle);
		gridObj.enableSmartXMLParsing(true);
		gridObj.enableRowsHover(true, 'testCss');
		gridObj.enableExcelKeyMap(true);
		
		makeGridCol(gridObj, colData);
		
		gridObj.init();
		
		if (dpObj != null && dpObj != '') {
			makeDp(dpObj, gridObj); //DataProcessor 세팅
		}
	}
	
	function makeGridCol(gridObj, colData) {
		let colTyp = colData.col_typ;
		const colId = (colData.col_id).split(',');
		const mathOrd = (colData.col_math_ord).split(',');
		const formatId = (colData.col_sort_typ).split(',');
		const format = (colData.col_format).split('/');
		const filter = (colData.col_filter_typ).split(',');
		const valid = (colData.col_valid).splip('/');
		let validData = [];
		
		gridObj.setHeader(toJavaScriptString(colData.col_nm1), null, ['header: 37px']);
		
		gridObj.setColumnIds(colData.col_id.toLowerCase());
		gridObj.setInitWidths(colData.col_width);
		gridObj.setColAlign(colData.col_align.toLowerCase());
		gridObj.setColSorting(colData.col_sort_typ.toLowerCase());
		gridObj.enableTooltips('true');
		gridObj.enabledValidation('null');
		
		valid.forEach(function(x) {
			if (x.toLowerCase() == 'null') {
				validData.push(null);
			} else {
				validData.push(x);
			}
		});
		
		gridObj.setColValidators(validData);
		gridObj.setDateFormat('%Y-%m-%d');
		gridObj.setImageSize(1, 1);
		
		// 컬럼 숫자 포맷 적용
		for (var i = 0; i < format.length; i++) {
			if (format[i] != null && format[i] != '') {
				gridObj.setNumberFormat(format[i], i);
			}
		}
		
		gridObj.setColumnColor(colData.col_color);
		for (let i = o; i < formatId.length; i++) {
			if (formatId[i].toLowerCase() == 'int' && format[i] != null && format[i] != '') {
				gridObj.setNumberFormat(format[i], i);
			}
			if (colReq[i].toLowerCase() == 'true') {
				gridObj.setColumnHidden(i, true);
			}
		}
		
		gridObj.setColTypes(colTyp);
		gridObj.setAwaitedRowHeight(29);
		gridObj.enableSmartRendering(true);
		gridObj.enabledPreRendering(100);
	}
	
	function mapeDp(dpObj, gridObj) {
		dpObj.setUpdateMode('off');
		dpObj.enableDataNames(true);
		dpObj.enableDebug(true);
		dpObj.styles.deleted = 'text-decoration: line-through; text-decoration-color: red;';
		
		dpObj.attachEvent('inserted', function(response) {
			alert('저장되었습니다.');
			return true;
		});
		dpObj.attachEvent('updated', function(response) {
			alert('저장되었습니다.');
			return true;
		});
		dpObj.attachEvent('deleted', function(response) {
			alert('저장되었습니다.');
			return true;
		});
		
		dpObj.defineAction('error', function(response) {
			if (response.message != undefined) {
				alert(response.message);
			}
			return true;
		});
		
		dpObj.init(gridObj);
		
		return dpObj;
	}
	
	function toJavaScriptString(str) {
		var result = str.replace(/\\n/g, '\\n')
						.replace(/\\'/g, "\\'").replace(/\\"/g, '\\"')
	}
</script>