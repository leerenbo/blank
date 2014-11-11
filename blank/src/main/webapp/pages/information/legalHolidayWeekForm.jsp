<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title></title>

<script type="text/javascript">
	var submitForm = function($dialog, $grid, $pjq) {
		if ($('form').form('validate')) {
			var url = datalook.contextPath + '/legalHoliday!saveWeek.action';
			
			var ids = $('#days').combobox('getValues');

			$.post(url, {
				ids : ids.join(',')
				}, function(result) {
				if (result.success) {
					$grid.datagrid('load');
					$dialog.dialog('destroy');
				} else {
					$pjq.messager.alert('提示', result.msg, 'error');
				}
			}, 'json');
		}
	};
</script>
</head>
<body>
	<form method="post" class="form">
		<fieldset>
			<legend>添加每周休息日</legend>
			    <select id="days" class="easyui-combobox" name="ids" data-options="multiple:true" >
			        <option value="1">星期天</option>
			        <option value="2">星期一</option>
			        <option value="3">星期二</option>
			        <option value="4">星期三</option>
			        <option value="5">星期四</option>
			        <option value="6">星期五</option>
			        <option value="7">星期六</option>
				</select>
		</fieldset>
	</form>
</body>
</html>