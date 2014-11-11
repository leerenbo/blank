<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
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
				url = datalook.contextPath + '/sysRole!update.action';
			} else {
				url = datalook.contextPath + '/sysRole!save.action';
			}
			$.post(url, sy.serializeObject($('form')), function(result) {
				if (result.success) {
					$grid.datagrid('load');
					$dialog.dialog('destroy');
				} else {
					$pjq.messager.alert('提示', result.msg, 'error');
				}
			}, 'json');
		}
	};
	$(function() {
		if ($(':input[name="data.id"]').val().length > 0) {
			parent.$.messager.progress({
				text : '数据加载中....'
			});
			$.post(datalook.contextPath + '/sysRole!getById.action', {
				id : $(':input[name="data.id"]').val()
			}, function(result) {
				if (result.id != undefined) {
					$('form').form('load', {
						'data.id' : result.id,
						'data.rolename' : result.rolename,
						'data.seq' : result.seq
					});
				}
				parent.$.messager.progress('close');
			}, 'json');
		}
	});
</script>
</head>
<body>
	<form method="post" class="form">
	<input name="data.status" type="hidden" value="1" />
		<fieldset>
			<legend>角色基本信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>编号</th>
					<td><input name="data.id" value="<%=id%>" readonly="readonly" /></td>
					<th>角色名称</th>
					<td><input name="data.rolename" class="easyui-validatebox" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
				</tr>
				<tr>
					<th>顺序</th>
					<td><input name="data.seq" class="easyui-numberspinner" data-options="required:true,min:-32767,max:32767,editable:true,missingMessage:'该输入项为必输项'" style="width: 155px;" value="0" /></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>