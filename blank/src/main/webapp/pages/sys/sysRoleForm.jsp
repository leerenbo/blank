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
				url = ez.contextPath + '/sysRole!update.action';
			} else {
				url = ez.contextPath + '/sysRole!save.action';
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
			$.post(ez.contextPath + '/sysRole!getById.action', {
				'data.id' : $(':input[name="data.id"]').val()
			}, function(result) {
				var data = ez.formLoadConvert(result);
				if (result.id != undefined) {
					$('#ezAddAndUpdataform').form('load', data);
				}
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
</script>
</head>
<body>
	<form id="ezAddAndUpdataform" method="post" class="form">
		<input name="data.status" type="hidden" value="1" />
		<input name="data.id" type="hidden" value="<%=id%>" readonly="readonly" />
		<fieldset>
			<legend>角色基本信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>角色名称</th>
					<td><input name="data.rolename" class="easyui-textbox" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
					<th>顺序</th>
					<td><input name="data.seq" class="easyui-numberspinner" data-options="required:true,min:-32767,max:32767,editable:true,missingMessage:'该输入项为必输项'" style="width: 155px;" value="0" /></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>