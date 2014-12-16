<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	if (id == null) {
		id = "";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="../../inc.jsp"></jsp:include>
<script type="text/javascript">
	var submitForm = function($dialog, $grid, $pjq) {
		if ($('form').form('validate')) {
			var url;
			if ($(':input[name="data.id"]').val().length > 0) {
				url = ez.contextPath + '/sysDict!update.action';
			} else {
				url = ez.contextPath + '/sysDict!save.action';
			}
			$('#ezAddAndUpdataform').form('submit', {
				url : url,
				onSubmit : function() {
					// do some check
					// return false to prevent submit;
					return true;
				},
				success : function(result) {
					result = $.parseJSON(result);
					$pjq.messager.alert('提示', result.msg, 'info');
					$grid.datagrid('load');
					$dialog.dialog('destroy');
				}
			});
		}
	};
	$(function() {
		if ($(':input[name="data.id"]').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});

			$.post(ez.contextPath + '/sysDict!getById.action', {
				'data.id' : $(':input[name="data.id"]').val()
			}, function(result) {
				if (result.id != undefined) {
					var data = ez.formLoadConvert(result);
					if (result.id != undefined) {
						$('#ezAddAndUpdataform').form('load', data);
					}
				}
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
</script>
</head>
<body>
	<form id="ezAddAndUpdataform" method="post" enctype="multipart/form-data" class="form">
		<fieldset>
			<legend>数据字典信息</legend>
			<table class="table" style="width: 100%;">
			
				<tr>
				<input name="data.id" type="hidden" value="<%=id%>" />
				<th>字典组</th>
				<td>
					<input name="data.location" class="easyui-textbox" data-options=""/>
				</td>
				<th>字典键</th>
				<td>
					<input name="data.value" class="easyui-textbox" data-options=""/>
				</td>
				</tr>
				<tr>
				<th>字典值</th>
				<td>
					<input name="data.text" class="easyui-textbox" data-options=""/>
				</td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>