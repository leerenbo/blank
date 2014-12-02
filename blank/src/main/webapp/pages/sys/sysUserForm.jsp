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
				url = ez.contextPath + '/sysUser!update.action';
			} else {
				url = ez.contextPath + '/sysUser!save.action';
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

			$.post(ez.contextPath + '/sysUser!getById.action', {
				'data.id' : $(':input[name="data.id"]').val()
			}, function(result) {
				if (result.id != undefined) {
					var data = $.parseJSON(ez.jsonToString(result));
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
		<input type="hidden" name="data.status" value="1"></input>
		<input type="hidden" name="data.password" value=""></input>
		<input type="hidden" name="data.id" value="<%=id%>" readonly="readonly" />
		<fieldset>
			<legend>用户基本信息</legend>
			<table class="table" style="width: 100%;">
				<tr>
					<th>姓名</th>
					<td><input name="data.realname" class="easyui-textbox" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
					<th>登陆帐号</th>
					<td><input name="data.username" class="easyui-textbox" data-options="required:true,validType:'length[1,16]',invalidMessage:'长度不能超过16个字符'" /></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>